Return-Path: <SRS0=WnEk=WS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF3C3A59D
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 03:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98FC22CE3
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 03:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="HgNP6hWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfHVDyw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 21 Aug 2019 23:54:52 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:59767 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbfHVDyv (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 21 Aug 2019 23:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UH6w55kZnU/JfUUsix0jZkXmvKLqfp5FBzbJNdc2gFE=; b=HgNP6hWLByCU32pWp4eToK5St/
        sEUV7rSJsoy+zxpo/cOwG5UN8ZSPDbY+W584pAB90BRpb+9S2/Gowgvdd1HiYvEyeg8XGsUPeh8Vw
        cocZseSNjtI4EN0V6Kl/09+bduPtV9xl29uGEAEz6I64FgvtfjlOwlkwNXPoeh8TZLtcIxO8z69Bg
        eS4ILcbPO4E7pU7vMB/FtCFehb9uJXSXkM9h0hxkqz/xb3Duc9fNWdsqysnvDLEBuUwNXuGLcnCjh
        xUzh86Mqvq7vbH9SwpIEfA0VSjU8u927tZBLDu0jkM7hPBTv0u3kVr4Ow/MpkRWY6RP4LQK6ilcmi
        RdrTK5ow==;
Received: from dvbz8cyyyyyyyyyyyy5hy-3.rev.dnainternet.fi ([2001:14ba:8869:c100::64c] helo=localhost.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <crope@iki.fi>)
        id 1i0eBW-0001Zu-3Y; Thu, 22 Aug 2019 06:54:50 +0300
Subject: Re: [PATCH] dvb-usb-v2/gl861: fix wrong memcpy
To:     Akihiro TSUKADA <tskd08@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sean Young <sean@mess.org>
References: <98cb0a1c-0db8-951b-80e1-12756678db9a@xs4all.nl>
 <6c2806fe-f104-84bf-21b8-21df9b3112cf@gmail.com>
 <20190815220811.6ba32749@coco.lan>
 <df8060a6-9666-3dd1-e041-620891970e7c@gmail.com>
 <fe4da71a-c562-e58e-9b1c-acb6853d9005@iki.fi>
 <ea96de1a-0f40-c044-ef2b-63de77da0412@gmail.com>
From:   Antti Palosaari <crope@iki.fi>
Message-ID: <78159b3f-16f0-cf89-a5b3-9ce48b54550a@iki.fi>
Date:   Thu, 22 Aug 2019 06:54:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ea96de1a-0f40-c044-ef2b-63de77da0412@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:14ba:8869:c100::64c
X-SA-Exim-Mail-From: crope@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 8/22/19 5:00 AM, Akihiro TSUKADA wrote:
> Hi,
> 
>> I suspect all whole friio_reset() function is not needed as it has
>> worked even I/O has been broken.
> 
> It worked because the old driver
> (that I rmmod'ed before installing the testing driver)
> properly init'ed the device.
> If I re-plug it (or reboot), it does not work.
> So it is needed.
> 
>> Also tuner I2C adapter is implemented wrong (I think I mentioned that
>> earlier). As tuner sits behind demod I2C-adapter/gate that whole logic
>> should be on demod driver.
> 
> But according to USB packet capture logs of the windows version,
> it makes eccentric use of USB messages ('bRequest' field),
> that (I believe) necessitates the current implementation,
> as I mentioned in the past thread.

That is because it has 2 i2c write methods - one using only 
usb_control_msg() header and other header + payload data. When 1 or 2 
byte long i2c message is send it is wise to use only "header" to reduce 
IO as it could carry needed data.

Anyhow, I will send patch soon which adds needed logic to i2c adapter. 
Then it is easier to understand.

regards
Antti


-- 
http://palosaari.fi/
