Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C2DEB64DA
	for <linux-media@archiver.kernel.org>; Thu, 20 Jul 2023 05:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGTFhM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 20 Jul 2023 01:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTFhL (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 20 Jul 2023 01:37:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B221710
        for <linux-media@vger.kernel.org>; Wed, 19 Jul 2023 22:37:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e742a787so230262f8f.1
        for <linux-media@vger.kernel.org>; Wed, 19 Jul 2023 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831428; x=1690436228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=prBKU4P9K5Vnrw3K61gdTnAtHxfWsqw2YOPhkHzhRo8=;
        b=MTKdFpWrOPbvoqRrtB2WF6CuCvdPunNmcaInrU+iSi57NGxkFN+xLVroy51LpmAlEu
         cFgZbWX70EMqbH2bPZgJnnpctD6jtNrDMuEJkJ/tkKcvA5wKICX2gFsJP9cVtTsufQid
         mm+rdjcHVMDsKZ6rvG201LjEXr+caApYg9xmOlScNf2AmBMmPWxC1v7N1xwT3ZAA51zk
         qxsz1pCv9+FSY7CxlgFOaKUrvKrjKfXfSbXRWQaemW5wCnS6+YqzETU1WqLMM3KUYbO1
         Tj9wLn1MS8NEHlKnYTnMt1X4Nmhlr2xUgwYcPasMbal8cy7Q54S54YyuuzbKRUF9jhA2
         ss8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831428; x=1690436228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prBKU4P9K5Vnrw3K61gdTnAtHxfWsqw2YOPhkHzhRo8=;
        b=YZ+DoCaoGQ8IvmlduPmSJ+KkE+d6Qwq94s5GBUsCIhkYoYqWcaGslq0aFgOWOfwQ9s
         TjGMtFZKElmekNQqpWXPoeAdxtyebV/ABxXN5oX7GdgMsYriNbooDN+479Rvz2kjy42z
         Hy6AQTaGVFIsBDay2N8VjN3FjdybAvWbtzglVBYT1VmccHR7tNmZj3sW2ZI1n74YLvBV
         /DINDlq/1EjLYyR5YkiIhSxPqfR97bh5KPCJyK76bjcRYV5jX2B+3j/zKwdfYHB+jU9R
         iom1S0PX4BtuSHpLcfRtKFE0MPJ/Gu/ahUIbMO9aveTC49N+90+AoODuhI8fnAwrlnnY
         Mmuw==
X-Gm-Message-State: ABy/qLYaSY3LfMK84C5w8H1l4ajnntEjrwzODxsgeAv3zsBDsVdtmMu+
        qbXqZctTnPwMX1zXqFD83jqtnA==
X-Google-Smtp-Source: APBJJlHeGcYPzHF6itqem5hwKM5eAFLK2SDkFj5Zv+rK8xwF3m3obxBYz6B74SB3B9T8n9YD++ZDjg==
X-Received: by 2002:a5d:62d1:0:b0:313:f75b:c552 with SMTP id o17-20020a5d62d1000000b00313f75bc552mr1533061wrv.15.1689831428389;
        Wed, 19 Jul 2023 22:37:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d58e6000000b00313f9085119sm149792wrd.113.2023.07.19.22.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:37:06 -0700 (PDT)
Date:   Thu, 20 Jul 2023 08:37:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v9 2/5] staging: vc04_services: vchiq_arm: Register
 vchiq_bus_type
Message-ID: <8cd787ae-85ae-4187-9009-d3596b120186@kadam.mountain>
References: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
 <20230719164427.1383646-3-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719164427.1383646-3-umang.jain@ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Jul 19, 2023 at 10:14:24PM +0530, Umang Jain wrote:
> @@ -1870,6 +1872,12 @@ static int __init vchiq_driver_init(void)
>  {
>  	int ret;
>  
> +	ret = bus_register(&vchiq_bus_type);
> +	if (ret) {
> +		pr_err("Failed to register %s\n", vchiq_bus_type.name);
> +		return ret;
> +	}
> +
>  	ret = platform_driver_register(&vchiq_driver);
>  	if (ret)
>  		pr_err("Failed to register vchiq driver\n");

Call bus_unregister() if platform_driver_register() fails.  Otherwise
it probably leads to a use after free or something bad.

> @@ -1880,6 +1888,7 @@ module_init(vchiq_driver_init);

regards,
dan carpenter

