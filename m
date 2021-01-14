Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FFC43381
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 11:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA93238EC
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 11:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbhANLUC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 14 Jan 2021 06:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbhANLUB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 14 Jan 2021 06:20:01 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C3C061573
        for <linux-media@vger.kernel.org>; Thu, 14 Jan 2021 03:19:21 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d17so7581298ejy.9
        for <linux-media@vger.kernel.org>; Thu, 14 Jan 2021 03:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=llEYo4jXB4s5StOd/f3/qGTd0pYWJctVA22pcoHob7U=;
        b=lTXD1vnTxEpjj0pq3iFWAsE8bj4q3JWZYZ5ZOz4FPcTV7mDzkq/oWYq9zhCHaVyDuE
         CnE8ZTzxEySh0f9J6AYESS4YAnzcVZ/dWXHsrz9oe+jbY/NUtnNncPi6Bzc401PwkkjP
         7frYthWkE1cxlB+pDnxsKvRodWWc+wZ+HWQRZ4Ai8xz4G/YsmNPUBfF3spdM9wdR60sP
         XIQVvFyaHQlaw7Q2EHp0rLZRPr+hVQP9Dz3SH3ZN1g8EDp9sSEJY6OhahT2O7812KDg+
         BGcfM0YA6K6tm0fz/bZg8t38fuPCjC/Zg/AOKvjfdmD2TtD8h6HtrjTdkGNBnkRtlfu6
         Mnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=llEYo4jXB4s5StOd/f3/qGTd0pYWJctVA22pcoHob7U=;
        b=jIdBsy9RNsf3kCD2Dd6UkbRq0z/lQi1HEChGfPh6nk258GWaHZL3p3FAgKte1mKaP4
         7pgGb4Ov6CRHkUeQJeJUSicqdOHe6JcFeGz89Hdjr2nXv8nll2mIFgije+l1A+qGRBuI
         omUYX/I8Iu+mi5haX3QDKsOTVCaa+cc3a+ZBZc+IudiD5CyDv7ViXxH14zU9BPI0dGIH
         54fKJQ2sn25ei0U1YQRgg+ucghaAIWxZkAj3g/s/BdcVnrVSR3Z0zUIYo39YQCB8UvFK
         Xd5xKwrzXaPhn6TXNo7EINjb92BHt/F64eOZVDrxs8ROpe/5P1IFefVzG8IZgZBKQFU3
         LexA==
X-Gm-Message-State: AOAM530Ro8LXBocWpmDEK6w/2kvyMngvWwKCU/AtcjPSG2mmQ5xPyYM5
        wEHjsc/0nqv2On4GaEjTif0=
X-Google-Smtp-Source: ABdhPJzxHxW7XRSQKNw2nfC25RKrxUnmgC4sOkLV2PM7jR+jxSkqbRqJeyffm03615j5dYd4F4H83Q==
X-Received: by 2002:a17:906:7d88:: with SMTP id v8mr652692ejo.416.1610623160048;
        Thu, 14 Jan 2021 03:19:20 -0800 (PST)
Received: from kontron.lan (2001-1ae9-1e8-b200-9c26-b1f7-3f54-fb94.ip6.tmcz.cz. [2001:1ae9:1e8:b200:9c26:b1f7:3f54:fb94])
        by smtp.gmail.com with ESMTPSA id by30sm2050477edb.15.2021.01.14.03.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 03:19:19 -0800 (PST)
Subject: Re: [PATCH v2 1/6] media: mach-pxa: Register the camera sensor
 fixed-rate clock
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kernel@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Daniel Mack <zonque@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
References: <20210112194919.50176-1-ezequiel@collabora.com>
 <20210112194919.50176-2-ezequiel@collabora.com>
From:   Petr Cvek <petrcvekcz@gmail.com>
Message-ID: <6f8b32fe-3e71-f964-26c5-38bc97322e4d@gmail.com>
Date:   Thu, 14 Jan 2021 12:23:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210112194919.50176-2-ezequiel@collabora.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: cs
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Acked-by: Petr Cvek <petrcvekcz@gmail.com>

Dne 12. 01. 21 v 20:49 Ezequiel Garcia napsal(a):
> The pxa-camera capture driver currently registers a v4l2-clk
> clock, named "mclk", to represent the mt9m111 sensor clock.
> 
> Register a proper fixed-rate clock using the generic clock framework,
> which will allow to remove the v4l2-clk clock in the pxa-camera
> driver in a follow-up commit.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de> (for arch/arm/mach-*/)
> ---
> Quoting Arnd:
> """
> If there are no objections to the change itself, please take it through
> the v4l2 git tree.
> """
> 
>  arch/arm/mach-pxa/devices.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
> index 524d6093e0c7..09b8495f3fd9 100644
> --- a/arch/arm/mach-pxa/devices.c
> +++ b/arch/arm/mach-pxa/devices.c
> @@ -4,6 +4,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/spi/pxa2xx_spi.h>
> @@ -634,6 +635,13 @@ static struct platform_device pxa27x_device_camera = {
>  
>  void __init pxa_set_camera_info(struct pxacamera_platform_data *info)
>  {
> +	struct clk *mclk;
> +
> +	/* Register a fixed-rate clock for camera sensors. */
> +	mclk = clk_register_fixed_rate(NULL, "pxa_camera_clk", NULL, 0,
> +					     info->mclk_10khz * 10000);
> +	if (!IS_ERR(mclk))
> +		clkdev_create(mclk, "mclk", NULL);
>  	pxa_register_device(&pxa27x_device_camera, info);
>  }
>  
> 
