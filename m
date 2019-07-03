Return-Path: <SRS0=7UeB=VA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A1AC0650E
	for <linux-media@archiver.kernel.org>; Wed,  3 Jul 2019 20:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F2E21882
	for <linux-media@archiver.kernel.org>; Wed,  3 Jul 2019 20:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRte87sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfGCUlv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:41:51 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37683 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfGCUlv (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Jul 2019 16:41:51 -0400
Received: by mail-wm1-f44.google.com with SMTP id f17so3767012wme.2
        for <linux-media@vger.kernel.org>; Wed, 03 Jul 2019 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EgmS2m7Dn9DoDUV4l4DA/B90xf2Sw05O0JqYe2ARflg=;
        b=QRte87sDBBTpwCL9Tilc1xIE22HNd+vuDYvBSk0sW6CnfSXG8EM1L0eJZYgES3gq7o
         Tcq50YPSHf4epBZ5SeM67cuKIim13SoHbuB7mCf8WaIt0a/jC9ww66E064844xVon7Nu
         fsw+1rA7jRh+EKV8fFDLIZdGh3HkvbXhrhCeK7xG8Ev758IxdBUVJzgmUcxTfN2Q94eV
         4INFkedaIUbjh4jPmWFRSuld1hq3eQamwszJM0mFsHoCLWfzTS8aUidyt+M4Z81zsHCX
         FBcERTAaGqeD6ZXMCypBoqjykWDWiIlx71TFYX242yow7QI57RZTBo3wQVwJQmNKdsAb
         LeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EgmS2m7Dn9DoDUV4l4DA/B90xf2Sw05O0JqYe2ARflg=;
        b=fo8xQhZVcAaCTHWUCWaMflyh7bXdQNznDc53GusA07BNE2SBB9G7bNEXEmDMJOAr6R
         /19lf61/5dFwum1VkeF3uCjAIz95Wg1UANGyWrY2uJcuMr0+X5xVUMqruoflc34t4qzk
         W52eb7gvgW6SWiupbsaRSkqTldexf5Rew4nGu4yH3PMdFgjCG9bcnPieLN4FWGEa360/
         durmM59g07l8BDUlGztkH0vWTBPMFcdTAYxc46yrBGyeaar5FdRc4oqJ6NkgxprTbtsS
         L85ZmKFn+JiBZNLEaDzlhOVAzU/1F/OYKMGU8pMC67dhfUODY5NusgLbeV2/NDTiNoRC
         XL4g==
X-Gm-Message-State: APjAAAXFPNauNZq++GsXpzkE7F1w4uLirnPx+NCg82KXDRfcZBpZJYEw
        YGb0F16N39u59OqpfkWb8I2W7/XY
X-Google-Smtp-Source: APXvYqx6bOQaBtMOvL8MYquRTmwLnVf6FVQ3eDLf+hMqg815IL8TyOFxgK/7w/H/3QgXTw8eoWrv1g==
X-Received: by 2002:a05:600c:303:: with SMTP id q3mr9459612wmd.130.1562186509060;
        Wed, 03 Jul 2019 13:41:49 -0700 (PDT)
Received: from [192.168.43.227] (94.197.121.169.threembb.co.uk. [94.197.121.169])
        by smtp.gmail.com with ESMTPSA id j16sm1889906wrt.88.2019.07.03.13.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:41:48 -0700 (PDT)
Subject: Re: Keymap with duplicate entries
To:     Sean Young <sean@mess.org>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-media@vger.kernel.org
References: <7d2bf66655bfdaeeea45ef0878e7920b485bb120.camel@hadess.net>
 <2b07545f-94b6-7c12-e569-0e0a341b961a@gmail.com>
 <20190703092315.ij3dwtuxgwvkvdfz@gofer.mess.org>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <f2890b8d-1d0e-1f73-6fa0-804e393a5b96@gmail.com>
Date:   Wed, 3 Jul 2019 21:41:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190703092315.ij3dwtuxgwvkvdfz@gofer.mess.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

> On Tue, Jul 02, 2019 at 11:29:58PM +0100, Malcolm Priestley wrote:
>>> Hey Malcolm,
>>>
>>> There seems to be a problem in  the keymap you provided for inclusion
>>> in the kernel.
>>>
>>> In media/rc/keymaps/rc-it913x-v2.c, 2 keys are triggered by the same
>>> keycode:
>>>  53 ↦       { 0x866b18, KEY_VOLUMEDOWN },•
>>>  55 ↦       { 0x866b18, KEY_CHANNELDOWN },•
>> Hmm
>>
>> I don't have this remote only the first one in this file.
>>
>> I am pretty sure the values for the second type were forwarded to me by another user.
> 
> I'm pretty sure (although I have not tested this) that the second mapping
> will overwite the first, so after the keymap is loaded 0x866b18 will be
> mapped to KEY_CHANNELDOWN.
It just finds the first magic number from the scan so KEY_VOLUMEDOWN is hit first

> 
> The current toml isn't loaded able but the kernel will set the initial
> keymap.
> 
> So, do current kernels work correctly with the remote you have?

Yes, it does

I will dig deep in the mailing list but these are cheap bubble button remotes I got a feeling there was a comment at the time that two buttons were the same scan.

Regards


Malcolm
