Return-Path: <SRS0=cYqX=UL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA639C31E46
	for <linux-media@archiver.kernel.org>; Wed, 12 Jun 2019 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B8A20896
	for <linux-media@archiver.kernel.org>; Wed, 12 Jun 2019 20:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=post.cz header.i=@post.cz header.b="lMyJNskw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfFLUHz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:07:55 -0400
Received: from mxc2.seznam.cz ([77.75.77.23]:54642 "EHLO mxc2.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfFLUHy (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 12 Jun 2019 16:07:54 -0400
Received: from email.seznam.cz
        by email-smtpc14b.ng.seznam.cz (email-smtpc14b.ng.seznam.cz [10.23.14.165])
        id 0aac394ddd1780280a04278a;
        Wed, 12 Jun 2019 22:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=post.cz; s=beta;
        t=1560370064; bh=mDix+GRliULX6r9xUbILNQPdxBAYmlrqliKSR0YwRVc=;
        h=Received:From:To:Date:MIME-Version:Subject:CC:Message-ID:Priority:
         In-reply-to:References:X-mailer:Content-type:
         Content-transfer-encoding:Content-description;
        b=lMyJNskwQ4ac8bH8ejhEVLDjFeKnUcBotNPNaFKt7S/x6vvqZBJOEtL41LnSyX8H1
         1+6J9d/xbBn/w+r74SVXYOiwgCHwTrZL+3IHw+e0+aXDySUyCMxC/vIP4OM+xj8D2d
         w3J0JTvTbU9Zg5QLkfkwJr73Uxwwmq89/vgIgQdc=
Received: from [192.168.12.172] (47.94.cust.tetanet.cz [109.202.94.47])
        by email-relay10.ng.seznam.cz (Seznam SMTPD 1.3.106) with ESMTP;
        Wed, 12 Jun 2019 22:07:40 +0200 (CEST)  
From:   "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
To:     linux-media@vger.kernel.org
Date:   Wed, 12 Jun 2019 22:07:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] dvb_usb_dvbsky: Mygica T230C2 add support for T230C hw version 2
CC:     Antti Palosaari <crope@iki.fi>, JP <jp@jpvw.nl>
Message-ID: <5D015B88.14600.5E1D99A@Frantisek.Rysanek.post.cz>
In-reply-to: <8982b6eb-c9b1-2f41-ed80-c435b999333c@iki.fi>
References: <63814e94-2db2-b9b0-44c8-ba5b0511bfc2@jpvw.nl>, <8982b6eb-c9b1-2f41-ed80-c435b999333c@iki.fi>
X-mailer: Pegasus Mail for Windows (4.63)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 12 Jun 2019 at 1:28, Antti Palosaari wrote:
[...]
> 
> What is that T230C2 stick? 
JP has already explained the details, how that name was arrived at.
As previously suggested, I can call it T230C v2 in the descriptive 
texts. I'd suggest keeping T230C2 in the USB ID macro (or suggest
a more appropriate name for the macro).

Here in CZ, a company called Abacus imports and distributes consumer 
electronics gadgets under a private brand "EvolveO" - and this is how 
the "rebadged OEM Mygica" has reached me. 
  http://m.evolveo.com/cz/sigma-t2
This particular T2 dongle is "allover the place" around here, no 
other dongle is this broadly available. (Well on our modest market. 
We're a nation of 10M people.)

> Naming sounds like a DVB-C2 capable, but I 
> found only T230C model from MyGica site. 
>
The local brand's site only mentions DVB-T2.
The 2-page "brief datasheet" of the si2168 that's publically 
available only mentions DVB-C, apart from T/T2.

> And also patch should be split to two logical parts, first add manual ts 
> frequency support to si2168 and then other patch which adds device itself.
> 
I'll try to find some time and massage that approach into the code.
I have read all the past attempts (example patches) and the 
maintainer's polite objections.

> And which are tuner and demod versions/revisions used for that device?
>
That's reported in dmesg if memory serves... I'll try to find the 
answer.

Frank Rysanek
