Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7008C47089
	for <linux-media@archiver.kernel.org>; Wed, 26 May 2021 23:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8997C613D9
	for <linux-media@archiver.kernel.org>; Wed, 26 May 2021 23:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhEZXji (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 May 2021 19:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhEZXjh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 May 2021 19:39:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A28C061574;
        Wed, 26 May 2021 16:38:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j10so3522166edw.8;
        Wed, 26 May 2021 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=msqRgqFp5nTxCgVxwFT3u/oYhUS3myZ12JA80hALidA=;
        b=Af/o3nP3riejK6SjwqE/sz95Jrpry8tSeySDzbJUA+HVhyx0nS7wRUUM8uOrU94K0j
         YnnAOwAwXALkSgAUQqRxu5ey+r09rcndtYLZ7m7+iFc3DBL+2CkA0ApArCt/stAN8RgC
         gjXL2jgY0HrJEVf7upgZ5zUUDRmE4QAVySGuktu3BgyZftI/wLN0NC1naULCApB4WhyJ
         Q4pXjoolk84cipsvSRRHFSN9h0UWpFzIn1CNMOspEV75mvEn43n5LqkBc30NCJDfVz4u
         floZhk7XybJjeHJ/8l3Ru+swuvyh/zjxMHeiomdLjB+rGXygtmikMN9lQIEpvBNoiB01
         PDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=msqRgqFp5nTxCgVxwFT3u/oYhUS3myZ12JA80hALidA=;
        b=Abc1onSUjsa4JIEDZORoqfIkNQ+e692nnztlmJp9qJO5bDr2dZvBDOSCx6VYmS7Gll
         q8zVTvVQQvEUEmAaijwXAr/tDnS6rhyqor1s1Ss0K3QfHzzr8tQJkabtqzJZc2aJ+9sT
         t0ysrtnYrxBjYuiogWF6Q/r1OZdsP2eIVs7ebdZoM7gxbxRAe8gR/8J0rcVB9dvlM2sb
         g8cSpgNadFOaktfKpQkVofpXq6lcNsD1hVks22v37YFp/9tIjMEj5oME++pgY31jAM/0
         geWT4Lvsq5NILqVKFVyfOnAUSsl2pfRthIAUHxWbiHMFeMFRW4Ll3pINuC8HcWx6zkaI
         HUmQ==
X-Gm-Message-State: AOAM531qJzqrYHbuX3zXH9nLyY/N2mPPEfyxx7CJDiHixJjxqNrby3cv
        zNbxK0Ez8A1MKeNOSMumJQ==
X-Google-Smtp-Source: ABdhPJxBEO3pN9mWH42KxreaxywnAA9WNgga47+nXNKMT1SoL9FvuXfoHtJ6EnXrLvwaG5Yckb9dAw==
X-Received: by 2002:a50:ed13:: with SMTP id j19mr781442eds.190.1622072283316;
        Wed, 26 May 2021 16:38:03 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:e00:bdfb:c34e:3af8:76da? ([2a02:810b:f40:e00:bdfb:c34e:3af8:76da])
        by smtp.gmail.com with ESMTPSA id rn2sm207346ejb.45.2021.05.26.16.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 16:38:02 -0700 (PDT)
Subject: Re: [PATCH 00/10] Add support for older Rockchip SoCs to V4L2 hantro
 and rkvdec drivers
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20210525152225.154302-1-knaerzche@gmail.com>
 <38327082.10thIPus4b@diego>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <bef97a10-bbc3-c23e-0f0a-bf3ec81293ec@gmail.com>
Date:   Thu, 27 May 2021 01:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <38327082.10thIPus4b@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Heiko, Ezequiel, Rob and List,

thanks for your feedback.

Am 26.05.21 um 01:01 schrieb Heiko Stübner:
> Hi Alex,
>
> Am Dienstag, 25. Mai 2021, 17:22:15 CEST schrieb Alex Bee:
>> Hi list,
>>
>> this series adds support for older Rockchip SoCs (RK3036, RK3066, RK3188
>> and RK322x) to the existing V4L2 video decoder/-encoder drivers - namely
>> hantro and rkvdec.
>> They can be used as-is or with very little modifications.
>>
>> In preparation to that patches 1-3 add power-controller support for RK3036
>> and RK322x, since both drivers rely on pm. The drivers for them exist
>> already in the common Rockchip pm driver, they just haven't be added to
>> the device trees yet.
> on first glance, looks good. Just a small ordering nit, if you need to resend
> the series for other reasons:
>
> Please try to order patches like:
> (1) dt-binding - compatible addition
> (2) driver patches
> (3) devicetree node patches
>
> That makes it way easier to keep track of dependencies when glancing at
> the series. Like for patches 1+2, I need to wait for Lee to apply (or Ack) the
> binding addition in patch 3.
>
> Same for the hantro devicetree additions, that need to wait for both
> bindings (and driver) changes to get applied to the media tree.
>
> Thanks
> Heiko
>
>
>> Thanks for your feedback,
>> Alex.
>>
>> Alex Bee (10):
>>    ARM: dts: rockchip: add power controller for RK322x
>>    ARM: dts: rockchip: add power controller for RK3036
>>    dt-bindings: mfd: syscon: add Rockchip RK3036/RK3228 qos compatibles
>>    media: hantro: add support for Rockchip RK3066
>>    media: hantro: add support for Rockchip RK3036
>>    ARM: dts: rockchip: add vpu nodes for RK3066 and RK3188
>>    ARM: dts: rockchip: add vpu node for RK322x
>>    media: dt-bindings: media: rockchip-vpu: add new compatibles
>>    ARM: dts: rockchip: add vdec node for RK322x
>>    media: dt-bindings: media: rockchip-vdec: add RK3228 compatible
>>
>>   .../bindings/media/rockchip,vdec.yaml         |  10 +-
>>   .../bindings/media/rockchip-vpu.yaml          |  33 +++-
>>   .../devicetree/bindings/mfd/syscon.yaml       |   2 +
>>   arch/arm/boot/dts/rk3036.dtsi                 |  51 ++++++
>>   arch/arm/boot/dts/rk3066a.dtsi                |   4 +
>>   arch/arm/boot/dts/rk3188.dtsi                 |   5 +
>>   arch/arm/boot/dts/rk322x.dtsi                 | 139 ++++++++++++++-
>>   arch/arm/boot/dts/rk3xxx.dtsi                 |  12 ++
>>   drivers/staging/media/hantro/hantro_drv.c     |   2 +
>>   drivers/staging/media/hantro/hantro_hw.h      |   2 +
>>   drivers/staging/media/hantro/rk3288_vpu_hw.c  | 165 ++++++++++++++++++
>>   11 files changed, 414 insertions(+), 11 deletions(-)
>>
>>
>> base-commit: 5d765451c2409e63563fa6a3e8005bd03ab9e82f
>>
>
>
>
I'll address your comments in v2 - see individual patches for specific 
replies (if any).

Thanks,

Alex

