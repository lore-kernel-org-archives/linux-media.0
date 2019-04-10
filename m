Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118E8C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB87720818
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nextdimension.cc header.i=@nextdimension.cc header.b="ClEiOC4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfDJOsa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:48:30 -0400
Received: from goldenrod.birch.relay.mailchannels.net ([23.83.209.74]:59298
        "EHLO goldenrod.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728729AbfDJOs3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 10:48:29 -0400
X-Sender-Id: dreamhost|x-authsender|brad@b-rad.cc
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E1D63125A19;
        Wed, 10 Apr 2019 14:48:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a62.g.dreamhost.com (unknown [100.96.39.118])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 49D6B125B71;
        Wed, 10 Apr 2019 14:48:25 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|brad@b-rad.cc
Received: from pdx1-sub0-mail-a62.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Wed, 10 Apr 2019 14:48:25 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|brad@b-rad.cc
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Troubled: 1708af183809aa7f_1554907705585_1339572883
X-MC-Loop-Signature: 1554907705585:2422085282
X-MC-Ingress-Time: 1554907705585
Received: from pdx1-sub0-mail-a62.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a62.g.dreamhost.com (Postfix) with ESMTP id BC3A580672;
        Wed, 10 Apr 2019 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=nextdimension.cc; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        nextdimension.cc; bh=FawAtHfNjzOK3eJy+kPFlwljuwA=; b=ClEiOC4giGF
        c5L2IRcwJX5E/S7CIGq2/EG4eSNtUSJTY2+Vb0rJ+f2rXBOtj1sQBHHYGoKONiGH
        zw5quFPDnHi+4kJgUk71pa7Q4RJ3PaHJ2MpbKiImo4lKtGjSNW+zoREX7Hv+z2+J
        FsQ8ET7jIxdCrT27FjieyKt1MIiwpzuQ=
Received: from [192.168.0.21] (66-90-189-166.dyn.grandenetworks.net [66.90.189.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: brad@b-rad.cc)
        by pdx1-sub0-mail-a62.g.dreamhost.com (Postfix) with ESMTPSA id 70F7480670;
        Wed, 10 Apr 2019 07:48:23 -0700 (PDT)
Subject: Re: [PATCH 07/13] si2157: Briefly wait for tuning operation to
 complete
To:     Brad Love <brad@nextdimension.cc>, Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org
References: <1546105882-15693-1-git-send-email-brad@nextdimension.cc>
 <1546105882-15693-8-git-send-email-brad@nextdimension.cc>
 <20190405102942.5igrs664bl46v2pg@gofer.mess.org>
 <7620f3b6-296b-411c-d082-573f783e82ac@nextdimension.cc>
 <20190408205547.l2z5xeunwmqj5oph@gofer.mess.org>
 <af0663f0-e0ba-a468-1b17-8ba73d8d779c@nextdimension.cc>
X-DH-BACKEND: pdx1-sub0-mail-a62
From:   Brad Love <brad@nextdimension.cc>
Openpgp: preference=signencrypt
Autocrypt: addr=brad@nextdimension.cc; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a745fca5-0591-a2c7-c26d-39312de88da8@nextdimension.cc>
Date:   Wed, 10 Apr 2019 09:48:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <af0663f0-e0ba-a468-1b17-8ba73d8d779c@nextdimension.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -85
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudejgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdduhedmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepuehrrgguucfnohhvvgcuoegsrhgrugesnhgvgihtughimhgvnhhsihhonhdrtggtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlihhnuhigthhvrdhorhhgnecukfhppeeiiedrledtrddukeelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopegludelvddrudeikedrtddrvddungdpihhnvghtpeeiiedrledtrddukeelrdduieeipdhrvghtuhhrnhdqphgrthhhpeeurhgrugcunfhovhgvuceosghrrggusehnvgigthguihhmvghnshhiohhnrdgttgeqpdhmrghilhhfrhhomhepsghrrggusehnvgigthguihhmvghnshhiohhnrdgttgdpnhhrtghpthhtohepsghrrggusehnvgigthguihhmvghnshhiohhnrdgttgenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sean,


On 08/04/2019 16.37, Brad Love wrote:
> Hi Sean,
>
>
> On 08/04/2019 15.55, Sean Young wrote:
>> On Mon, Apr 08, 2019 at 01:14:08PM -0500, Brad Love wrote:
>>> On 05/04/2019 05.29, Sean Young wrote:
>>>> On Sat, Dec 29, 2018 at 11:51:16AM -0600, Brad Love wrote:
>>>>> Some software reports no signal found on a frequency due to immedia=
tely
>>>>> checking for lock as soon as set_params returns. This waits up 40ms=
 for
>>>>> tuning operation, then from 30-150ms (dig/analog) for signal lock b=
efore
>>>>> returning from set_params and set_analog_params.
>>>>>
>>>>> Tuning typically completes in 20-30ms. Digital tuning will addition=
ally
>>>>> wait depending on signal characteristics. Analog tuning will wait t=
he
>>>>> full timeout in case of no signal.
>>>> This looks like a workaround for broken userspace. Very possibly thi=
s
>>>> is software was tested on a different frontend which does wait for t=
uning
>>>> to complete.
>>>>
>>>> This is a change in uapi and will have to be done for all frontends,=
 and
>>>> documented. However I doubt such a change is acceptable.
>>>>
>>>> What software are you refering to?
>>> Hi Sean,
>>>
>>> I would have to check with support to find out the various software t=
hat
>>> expect when a tune command returns for that tuning operation to have
>>> actually completed. In the current state when you tune si2157 it
>>> immediately returns, no care of the tuning operation completion, no c=
are
>>> of the pll lock success. This is correct? Not so according to Silicon
>>> Labs documentation, which suggests a brief wait. I just took a look a=
t
>>> other drivers, sampling only those with set_analog_params, all but tw=
o
>>> have similar code in place to actually allow the tune operation time =
to
>>> complete (both digital and analog) before returning to userland. The
>>> other drivers just insert arbitrary time delays to accommodate the
>>> operations completion time. At least with my patch I am monitoring th=
e
>>> hardware to know when the operation actually completes.
>>>
>>> I see in tuners (not frontends):
>>>
>>> mt2063 - waits up to 100ms for lock status and return
>>> r820t - sleep 100ms for pll lock status and return
>>> tda827x - 170-500ms wait after tune before checking status and return
>>> tda8290 - sleep 100ms up to 3x while checking tune status and return
>>> tuner-xc2028 - sleep for 110ms awaiting lock status and return
>>> xc4000 - 10ms sleep after tune, unless debug, then 100ms and return
>>> xc5000 - 20ms sleep after tune,=C2=A0 if pll not locked, re-tune and =
sleep
>>> again, repeat until success and return
>>>
>>> There's also other arbitrary sleeps peppered throughout the operation=
s.
>>>
>>> Then you have si2157 that fires off the tuning commands and goes righ=
t
>>> back to userland immediately, when with instrumented testing, the
>>> operation takes time to complete and lock. The operation does not hap=
pen
>>> instantaneously. Software that expects clocks to be locked when the
>>> function returns determine this is an error. They query the tuner
>>> immediately when tune returns and they output tuning failed.
>>>
>>> Please explain why awaiting the hardware to say the "tuning operation
>>> you requested is done and clocks are locked" is not ok. If it's not o=
k,
>>> fine, but then a lot of other drivers are currently "not ok" as well.
>> If you read the dvb userspace api, there is nothing in the DTV_TUNE
>> property that says it will block until a lock has been made.
>>
>> https://www.kernel.org/doc/html/latest/media/uapi/dvb/fe_property_para=
meters.html#dtv-tune
>>
>> The locking status can be queried using read status.
>>
>> https://www.kernel.org/doc/html/latest/media/uapi/dvb/fe-read-status.h=
tml#fe-read-status
>>
>> Using this mechanism, there is a minimum of sleeping in the kernel whi=
ch helps
>> interactivity. (uninterruptable) sleeping in drivers something that re=
ally
>> should be avoided if at all possible. Userspace can't do anything duri=
ng that
>> time.
>
> This is not dealing with signal lock. As far as I understand the
> documentation I have, this is hardware tuning completion, aka the pll's
> and whatever else are properly configured and the tuning operation
> itself is finished successfully. The byte read is looking for
> TUNINT/ATVINT/DTVINT bits set, meaning the operation is complete. Right
> now I ignore errors, which probably should be returned to userland, as
> if a tune fails the userland has no way to determine this fact. This
> process comes directly from a flowchart in the SL guide.
>
> Signal lock is determined later, using the methods you describe. No
> property registers are being queried here, the success of the previous
> (tuning) operation is.


Hi Sean,

Just noticing now that my commit message does not agree with what I'm
saying. I will need to do some testing to see which is correct. I've
been basing my statements here off the SL reference I have, but I wrote
the commit message over a year ago probably. I'll need to do some
testing, I seem to recall the timing being consistent whether a signal
is found or not. I might have mis-wrote the message long ago when I was
splitting this up.

Regards,

Brad




>
>
>> So if you look at how dvbv5-zap finds a lock, you can see that it sets
>> DTV_TUNE (amongst others) and then uses the frontend read_status() to =
query
>> for locking until either timeout or a lock is found (not sure why it p=
olls
>> one per second though, seems a bit overly conservative).
>>
>> https://git.linuxtv.org/v4l-utils.git/tree/utils/dvb/dvbv5-zap.c#n494
>>
>> Now, if other drivers have a sleep to wait for tuning lock in them and=
 whether
>> they should be removed, is another question. Looking at the tda8290 dr=
iver
>> it needs to try various things in order to make a lock, so there is (c=
urrently)
>> no way to avoid this. It would be nice if it could be changed to inter=
ruptable
>> sleeps though, so that dvb userspace does not "hang" until a lock is m=
ade
>> or failed.
>
> I indeed noticed none of the other drivers use usleep_range, which is
> interruptible, correct?
>
> Regards,
>
> Brad
>
>
>>
>> Thanks,
>>
>> Sean
