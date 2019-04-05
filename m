Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C92CC4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371CE2186A
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJJucOvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfDELaK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:30:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45972 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfDELaK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 07:30:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so7502034wra.12
        for <linux-media@vger.kernel.org>; Fri, 05 Apr 2019 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qv7GoeTW5++Jw1nk4JRH24lTKwTn99bsWg/k/UkQMac=;
        b=dJJucOvHA+7JCvm+U64dTqZaOQGOIvaloxKig+sYHEz/zFR4/c+8GstesYQC9sOIMQ
         PW03salBzqKZYyqIVd7FnDvAkAi/sT4BaO7xDLSzsEKa+Ttt1auaadyTcLlhM5VjkDiy
         XapfwamnGKR4Ibn2VytWsS9PyDBAFhkhCqw/2jb9vwDkwriWnR6SRky7o8XJ4JcC2kUd
         DPOv5y410U/7xD1+618lTdH8HJgAYQgtMV10r+u6HpGbzR+kkggMfdefLlABbWMFkB5W
         mDdCfZym3+nNj4aNNSGM669l/IJ2xpRZPLE9Kf1LlxvcfZMe55Ezp+hJyKfMmTlSBBbn
         y6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qv7GoeTW5++Jw1nk4JRH24lTKwTn99bsWg/k/UkQMac=;
        b=FcgmKwYTN2grPMmv4X3wbCqFZ4wP3cZXHJjosrU39crcPk2qRxJPWaUYDAbHSEyWKv
         8KLxg/KIpzEsbgfC6dDQvVboNJsjaoNUVO3sKwmjdhisUMqAQ945RDnFwaNT+FJSSZC2
         4Gskqvd+YctGNur5IQ64/CSGsiY3UX2UcFMxQdNzqGrUSlyB/+9vlb8qZq9atKAquUyH
         FwHnByZjLvvhGwGgb2sC58K2WC/GjIAE8ig99Yzp6kcECW//Fz1ThTutsG5cbzKL/Vzj
         ZC6ncY7V1dTuiGhGl/zbwNIhzcSYFAoR/lU2FmlN2/hu97i2jFQBA4WTVhDbHQmekJb9
         RRgQ==
X-Gm-Message-State: APjAAAXNQqEcCdwGNVq6/qFTeKKYV936PeKQ7x3Uky/yIo1/K+0lr9bz
        oaIvUR9mHxhkK/BTsDBxQV8Ssj+G
X-Google-Smtp-Source: APXvYqyyFnjxsounYBoYlg1IYxvsrmHGimnB/kZHEqrWfkgHiI8AZVcjru/3L2ogIcUU2xrRI7Nyyg==
X-Received: by 2002:a5d:6a0b:: with SMTP id m11mr7819878wru.290.1554463808685;
        Fri, 05 Apr 2019 04:30:08 -0700 (PDT)
Received: from ?IPv6:2a00:23c5:f786:ec00:1128:f7da:df35:f704? ([2a00:23c5:f786:ec00:1128:f7da:df35:f704])
        by smtp.googlemail.com with ESMTPSA id x205sm2581921wmg.9.2019.04.05.04.30.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:30:08 -0700 (PDT)
Subject: Re: [PATCH 1/9] davinci-vpif: Fix endpoint refcounting
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, niklas.soderlund@ragnatech.se,
        laurent.pinchart@ideasonboard.com
References: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
 <20190405094127.18975-3-sakari.ailus@linux.intel.com>
From:   Ian Arkver <ian.arkver.dev@gmail.com>
Message-ID: <d38e015e-0177-194b-4275-fcd7ac22ef23@gmail.com>
Date:   Fri, 5 Apr 2019 12:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405094127.18975-3-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sakari,

My mail client at least is showing two versions of patch [1/9] with 
different commit messages but (I think) the same content.

Regards,
Ian

On 05/04/2019 10:41, Sakari Ailus wrote:
> This patch addresses two problems with endpoint refcounting in parsing
> davinci-vpif endpoints:
> 
> - put endpoints on error and
> 
> - do not dereference endpoints after they have been put.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>   drivers/media/platform/davinci/vpif_capture.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
> index b5aacb0fb96b..72bdb3c10962 100644
> --- a/drivers/media/platform/davinci/vpif_capture.c
> +++ b/drivers/media/platform/davinci/vpif_capture.c
> @@ -1555,7 +1555,6 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>   		if (!rem) {
>   			dev_dbg(&pdev->dev, "Remote device at %pOF not found\n",
>   				endpoint);
> -			of_node_put(endpoint);
>   			goto done;
>   		}
>   
> @@ -1567,7 +1566,6 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>   					    GFP_KERNEL);
>   		if (!chan->inputs) {
>   			of_node_put(rem);
> -			of_node_put(endpoint);
>   			goto err_cleanup;
>   		}
>   
> @@ -1578,7 +1576,6 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>   
>   		err = v4l2_fwnode_endpoint_parse(of_fwnode_handle(endpoint),
>   						 &bus_cfg);
> -		of_node_put(endpoint);
>   		if (err) {
>   			dev_err(&pdev->dev, "Could not parse the endpoint\n");
>   			of_node_put(rem);
> @@ -1609,6 +1606,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>   	}
>   
>   done:
> +	of_node_put(endpoint);
>   	pdata->asd_sizes[0] = i;
>   	pdata->subdev_count = i;
>   	pdata->card_name = "DA850/OMAP-L138 Video Capture";
> @@ -1616,6 +1614,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>   	return pdata;
>   
>   err_cleanup:
> +	of_node_put(endpoint);
>   	v4l2_async_notifier_cleanup(&vpif_obj.notifier);
>   
>   	return NULL;
> 
