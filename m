Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43ADC47088
	for <linux-media@archiver.kernel.org>; Wed, 26 May 2021 13:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36ED6023C
	for <linux-media@archiver.kernel.org>; Wed, 26 May 2021 13:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhEZNnI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 May 2021 09:43:08 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:55337 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233304AbhEZNnI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 May 2021 09:43:08 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id ltmrlTu1XWkKbltmulDNIB; Wed, 26 May 2021 15:41:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1622036493; bh=pbfotMPo+JMAllo3pDgMOiJij6DQTsGzbfoMYCwF3Ls=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=rk7K+ueZFEkNBksOSUjoAybneO+Rq0LeHfd/xKkT/9QveiWHWlH+win0nY+rtUMtO
         XcUQMHrRdEmRkUIng94PerMBbrU8S+DSxHqBP83w74yn6pGASe1ZlbU8HbEyjCTiRw
         EfG63XxjK7HLUZ7Ig5jABucImglfCa2njldHU7OZJ3oIO91LLISEoVKu6Kxe5nMqkl
         pBF09nfw1vfUCvhdE8xX4nbYIU7DoxYFcKZ+b2pmmq/QXOIEOz2lgs7cOi/wr/IA27
         Y1u0Ak8pj+cCItaqXVi8DY31VZ1bn4Z+XT36zrJDCYlI7+ZNkHGQEY0gczA5O7N0Jc
         +VYtDNKTPVDFQ==
Subject: Re: [PATCH] media: s5p-g2d: Fix a memory leak on ctx->fh.m2m_ctx
To:     dillon.minfei@gmail.com, mchehab+huawei@kernel.org,
        a.hajda@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1620706164-28856-1-git-send-email-dillon.minfei@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <2193bb5c-89c3-cb1a-f2ef-1389ccfb7d61@xs4all.nl>
Date:   Wed, 26 May 2021 15:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1620706164-28856-1-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMxCTRiyuTgwtVFqwRQpu+18Vo3y2/UVXkddCLUmD6pyNesvtDJ5MkHefKYpjQwihlAjajaJFXuAuWwmTPkgx6KJy717o1c6d6wR4GljrlKc7jIBv7AW
 yV5M1Mv4IhpOhgFpBC1KMPJie5gl9har1+i8uRna6klut14SRKnENPzBzGXuA5gcVRT7xz5ru/2IkyDzcjzP+x0G6F4M649ysV0XQQU1r5LOhvG4LUlwIGpp
 fDaNlDjHH2R19uKC6DvtW5YajSosO9Jt5CFtmqTaO3TGIoVTGZzUXBjTMSC+MSiI1nHtNijwJXOZw1QG351SWXYGy04fu/95SByIcXfVAOz4OvRPcJelbvrE
 fqHMu3rYuEhhlgN0rYMsUQn8rfawX+27LSY7nrq4EscuJEYHheM=
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 11/05/2021 06:09, dillon.minfei@gmail.com wrote:
> From: Dillon Min <dillon.minfei@gmail.com>
> 
> The m2m_ctx resources was allocated by v4l2_m2m_ctx_init() in g2d_open()
> should be freed from g2d_release() when it's not used.
> 
> Fix it
> 
> Fixes: 918847341af0 ("[media] v4l: add G2D driver for s5p device family")
> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> ---
>  drivers/media/platform/s5p-g2d/g2d.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/s5p-g2d/g2d.c
> index 15bcb7f6e113..0818fdd3e984 100644
> --- a/drivers/media/platform/s5p-g2d/g2d.c
> +++ b/drivers/media/platform/s5p-g2d/g2d.c
> @@ -279,6 +279,9 @@ static int g2d_release(struct file *file)
>  	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
>  	v4l2_fh_del(&ctx->fh);
>  	v4l2_fh_exit(&ctx->fh);
> +	mutex_lock(&dev->mutex);
> +	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> +	mutex_unlock(&dev->mutex);

This should be moved up to just before the v4l2_ctrl_handler_free() call.

Regards,

	Hans

>  	kfree(ctx);
>  	v4l2_info(&dev->v4l2_dev, "instance closed\n");
>  	return 0;
> 

