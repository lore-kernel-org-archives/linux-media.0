Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61418C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 20:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3108B21841
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 20:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDHUzt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:55:49 -0400
Received: from gofer.mess.org ([88.97.38.141]:40391 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfDHUzt (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 16:55:49 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id C768D6023D; Mon,  8 Apr 2019 21:55:47 +0100 (BST)
Date:   Mon, 8 Apr 2019 21:55:47 +0100
From:   Sean Young <sean@mess.org>
To:     Brad Love <brad@nextdimension.cc>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH 07/13] si2157: Briefly wait for tuning operation to
 complete
Message-ID: <20190408205547.l2z5xeunwmqj5oph@gofer.mess.org>
References: <1546105882-15693-1-git-send-email-brad@nextdimension.cc>
 <1546105882-15693-8-git-send-email-brad@nextdimension.cc>
 <20190405102942.5igrs664bl46v2pg@gofer.mess.org>
 <7620f3b6-296b-411c-d082-573f783e82ac@nextdimension.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7620f3b6-296b-411c-d082-573f783e82ac@nextdimension.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Apr 08, 2019 at 01:14:08PM -0500, Brad Love wrote:
> 
> On 05/04/2019 05.29, Sean Young wrote:
> > On Sat, Dec 29, 2018 at 11:51:16AM -0600, Brad Love wrote:
> >> Some software reports no signal found on a frequency due to immediately
> >> checking for lock as soon as set_params returns. This waits up 40ms for
> >> tuning operation, then from 30-150ms (dig/analog) for signal lock before
> >> returning from set_params and set_analog_params.
> >>
> >> Tuning typically completes in 20-30ms. Digital tuning will additionally
> >> wait depending on signal characteristics. Analog tuning will wait the
> >> full timeout in case of no signal.
> > This looks like a workaround for broken userspace. Very possibly this
> > is software was tested on a different frontend which does wait for tuning
> > to complete.
> >
> > This is a change in uapi and will have to be done for all frontends, and
> > documented. However I doubt such a change is acceptable.
> >
> > What software are you refering to?
> 
> 
> Hi Sean,
> 
> I would have to check with support to find out the various software that
> expect when a tune command returns for that tuning operation to have
> actually completed. In the current state when you tune si2157 it
> immediately returns, no care of the tuning operation completion, no care
> of the pll lock success. This is correct? Not so according to Silicon
> Labs documentation, which suggests a brief wait. I just took a look at
> other drivers, sampling only those with set_analog_params, all but two
> have similar code in place to actually allow the tune operation time to
> complete (both digital and analog) before returning to userland. The
> other drivers just insert arbitrary time delays to accommodate the
> operations completion time. At least with my patch I am monitoring the
> hardware to know when the operation actually completes.
> 
> I see in tuners (not frontends):
> 
> mt2063 - waits up to 100ms for lock status and return
> r820t - sleep 100ms for pll lock status and return
> tda827x - 170-500ms wait after tune before checking status and return
> tda8290 - sleep 100ms up to 3x while checking tune status and return
> tuner-xc2028 - sleep for 110ms awaiting lock status and return
> xc4000 - 10ms sleep after tune, unless debug, then 100ms and return
> xc5000 - 20ms sleep after tune,  if pll not locked, re-tune and sleep
> again, repeat until success and return
> 
> There's also other arbitrary sleeps peppered throughout the operations.
> 
> Then you have si2157 that fires off the tuning commands and goes right
> back to userland immediately, when with instrumented testing, the
> operation takes time to complete and lock. The operation does not happen
> instantaneously. Software that expects clocks to be locked when the
> function returns determine this is an error. They query the tuner
> immediately when tune returns and they output tuning failed.
> 
> Please explain why awaiting the hardware to say the "tuning operation
> you requested is done and clocks are locked" is not ok. If it's not ok,
> fine, but then a lot of other drivers are currently "not ok" as well.

If you read the dvb userspace api, there is nothing in the DTV_TUNE
property that says it will block until a lock has been made.

https://www.kernel.org/doc/html/latest/media/uapi/dvb/fe_property_parameters.html#dtv-tune

The locking status can be queried using read status.

https://www.kernel.org/doc/html/latest/media/uapi/dvb/fe-read-status.html#fe-read-status

Using this mechanism, there is a minimum of sleeping in the kernel which helps
interactivity. (uninterruptable) sleeping in drivers something that really
should be avoided if at all possible. Userspace can't do anything during that
time.

So if you look at how dvbv5-zap finds a lock, you can see that it sets
DTV_TUNE (amongst others) and then uses the frontend read_status() to query
for locking until either timeout or a lock is found (not sure why it polls
one per second though, seems a bit overly conservative).

https://git.linuxtv.org/v4l-utils.git/tree/utils/dvb/dvbv5-zap.c#n494

Now, if other drivers have a sleep to wait for tuning lock in them and whether
they should be removed, is another question. Looking at the tda8290 driver
it needs to try various things in order to make a lock, so there is (currently)
no way to avoid this. It would be nice if it could be changed to interruptable
sleeps though, so that dvb userspace does not "hang" until a lock is made
or failed.


Thanks,

Sean
