Return-Path: <SRS0=mcaz=YR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DBCA9EB9
	for <linux-media@archiver.kernel.org>; Thu, 24 Oct 2019 03:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726122173B
	for <linux-media@archiver.kernel.org>; Thu, 24 Oct 2019 03:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKhsWH7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406546AbfJXD0I (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:26:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33025 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406488AbfJXD0I (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Oct 2019 23:26:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id u23so2659352pgo.0
        for <linux-media@vger.kernel.org>; Wed, 23 Oct 2019 20:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gigPHVeMCpEepNAMt5y6G3CbjHNanqaGB3axZJWySZA=;
        b=VKhsWH7gcNcSkMZ3oG6+zQKUzxQD9srZgkFddPt2WKKX4/ezzHXONO7ZDFTd+YX6UY
         x7nygXmd1TLqWFXpCSEh6pNV4TW+drFsJhf/lgweFcTcbLNZ6KXK9dJ2qcHvmgQXbsH0
         1S3Sl1rLUKzXuFLDka2Q+65C0A7TIqMXGMlTkf8h6SipsKIv3FP0at+85gGA7uk/Icng
         NX0VwRKhyqSLEAOQlCvLjqJXUgdjpDAO60l8ngIOJ8MrxREOfes/wTD6VX3Nqr0l0zd2
         qINGWuPeBbq3+GS4G/Bx4T+jMB6gt61xfVddJLMBT1VPr+OltmD4HES6rzPBxJcxvK/W
         8z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gigPHVeMCpEepNAMt5y6G3CbjHNanqaGB3axZJWySZA=;
        b=Vxs2hRWKyeudNWD5zDEHYs6uzEDlSO10T4rxmmuEzdwzB3BGyV5AXNpnse50wClr34
         irmP372wmtkg2F0STucW6bfDZZd/unKEQsje0nPoy1LMlt6fonGqjtMF+r6xvpntGCFl
         Yx9+ZhoOv3xAWp7CMyT5cI71JAdWdVcuVOcne03qCK9UkCT7ipnoHwXXQ4ZQmocRk0Ll
         TvCRW/c0AU6zCsGsaY3WZNmPrhoXA0xR+f+UOSZ7A56X9ppeUbp8K1WScjaf2IYrjkEs
         6osyCD/IMoJd8tRPC9EIQuJYwM7A6tAXUSUJWemF5I4Kn48JZE7gdn8lhIPGv1afGfmt
         isJg==
X-Gm-Message-State: APjAAAVg1dmlH++l9ht6sKuzNxzXYMJVSpTof1kBSlSrl0Gd+radyd+Z
        qMRPYBDkpDqTO3eTy07WYKUDvZTpd/s=
X-Google-Smtp-Source: APXvYqyTlngVf8mY4QSUL3At63p6Q2Dr/HyF25ygQwgbefZJsIv0nUUG6iXukAuWr9QlmrtcNPCqNA==
X-Received: by 2002:a63:5a59:: with SMTP id k25mr13768436pgm.171.1571887567523;
        Wed, 23 Oct 2019 20:26:07 -0700 (PDT)
Received: from [192.168.1.59] (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.gmail.com with ESMTPSA id e16sm23588082pgt.68.2019.10.23.20.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:26:06 -0700 (PDT)
Subject: Re: [PATCH 7/7] media: imx: imx7-media-csi: Fix video field handling
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rui Miguel Silva <rmfrfs@gmail.com>
References: <20191024004155.32068-1-laurent.pinchart@ideasonboard.com>
 <20191024004155.32068-8-laurent.pinchart@ideasonboard.com>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <1bce458b-8e80-1ceb-2f6d-39a0f2856f87@gmail.com>
Date:   Wed, 23 Oct 2019 20:25:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024004155.32068-8-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Laurent,

On 10/23/19 5:41 PM, Laurent Pinchart wrote:
> Commit 4791bd7d6adc ("media: imx: Try colorimetry at both sink and
> source pads") reworked the way that formats are set on the sink pad of
> the CSI subdevice, and accidentally removed video field handling.
> Restore it by defaulting to V4L2_FIELD_NONE if the field value isn't
> supported, with the only two supported value being V4L2_FIELD_NONE and
> V4L2_FIELD_ALTERNATE.

I think you mean the only two supported field values being 
V4L2_FIELD_NONE and V4L2_FIELD_INTERLACED.

For this driver to support ALTERNATE, it would have to detect the 
captured field type and place that type in the returned vb2 buf->field, 
which it is not doing.

Steve

>
> Fixes: 4791bd7d6adc ("media: imx: Try colorimetry at both sink and source pads")
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>   drivers/staging/media/imx/imx7-media-csi.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> index ac07f55a63e3..0db6473caf13 100644
> --- a/drivers/staging/media/imx/imx7-media-csi.c
> +++ b/drivers/staging/media/imx/imx7-media-csi.c
> @@ -1017,6 +1017,7 @@ static int imx7_csi_try_fmt(struct imx7_csi *csi,
>   		sdformat->format.width = in_fmt->width;
>   		sdformat->format.height = in_fmt->height;
>   		sdformat->format.code = in_fmt->code;
> +		sdformat->format.field = in_fmt->field;
>   		*cc = in_cc;
>   
>   		sdformat->format.colorspace = in_fmt->colorspace;
> @@ -1031,6 +1032,9 @@ static int imx7_csi_try_fmt(struct imx7_csi *csi,
>   							 false);
>   			sdformat->format.code = (*cc)->codes[0];
>   		}
> +
> +		if (sdformat->format.field != V4L2_FIELD_INTERLACED)
> +			sdformat->format.field = V4L2_FIELD_NONE;
>   		break;
>   	default:
>   		return -EINVAL;

