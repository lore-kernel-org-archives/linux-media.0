Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14493C63777
	for <linux-media@archiver.kernel.org>; Thu,  3 Dec 2020 10:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3083208FE
	for <linux-media@archiver.kernel.org>; Thu,  3 Dec 2020 10:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbgLCKuQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Dec 2020 05:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbgLCKuP (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 3 Dec 2020 05:50:15 -0500
Date:   Thu, 3 Dec 2020 11:49:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606992574;
        bh=GLyVgCREPOnpXng3xvQ091Dp35N849qmXqe6QBMqu6Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=c3Pd7Q3Kli0+PQItsPTPvDGYtG4XGDJAfPyl3iBf9b0s3K1Z+7ia3+w9vDGGd2ouu
         g93xezPARaauYhE/4X3jfnh2orJXkbkoU0NGdUwH/vX5P/VgSIWzpMy3AsuSuuEcv8
         F5rD4ozAjk0aImzIwnpBY1q2/D+qHUZB0HT+kKXodviw9M/y+C5qH6OWarg3aiG52w
         f0mpUX2hLrt+QuUjCZREahbN9XurmwhKE/diKG+c0i85NIsleiRKXdtTJAHj942VRU
         bqN5tCFNdwR5IRVcS+L1Omd+txVfomDjOYZkNQKrsi7/RIQ+SGIS22ryOfLOP9JJbF
         ZVJQusLzpvh4g==
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH 5/6] vidioc-g-ext-ctrls.rst: add missing 'struct' before
 the types
Message-ID: <20201203114928.2e21964b@coco.lan>
In-Reply-To: <20201126132717.1216907-6-hverkuil-cisco@xs4all.nl>
References: <20201126132717.1216907-1-hverkuil-cisco@xs4all.nl>
        <20201126132717.1216907-6-hverkuil-cisco@xs4all.nl>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Thu, 26 Nov 2020 14:27:16 +0100
Hans Verkuil <hverkuil-cisco@xs4all.nl> escreveu:

> Add 'struct' to clarify that these are pointers to structs.

This patch is actually wrong :-)

It is incompatible with Sphinx 3.

> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> index 726d6a97325f..5b1fc62ade0d 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
> @@ -180,31 +180,31 @@ still cause this situation.
>        - ``p_u32``
>        - A pointer to a matrix control of unsigned 32-bit values. Valid if
>  	this control is of type ``V4L2_CTRL_TYPE_U32``.
> -    * - :c:type:`v4l2_area` *
> +    * - struct :c:type:`v4l2_area` *


See, with Sphinx 3, :c:type: can only be used for typedefs and defines.

The right markup for struct is:

	:c:struct:

Actually, due to automarkup.py extension, I would just rename them to:

	struct foo

And let the automarkup code to use the right markup, as it will ensure
that the proper dialect will be used, no matter what Sphinx version 
will be used to produce the docs.

So, I'll drop this patch from the series. I'll propose a new one
instead, after testing with multiple versions of Sphinx.

Regards,
Mauro



>        - ``p_area``
>        - A pointer to a struct :c:type:`v4l2_area`. Valid if this control is
>          of type ``V4L2_CTRL_TYPE_AREA``.
> -    * - :c:type:`v4l2_ctrl_h264_sps` *
> +    * - struct :c:type:`v4l2_ctrl_h264_sps` *
>        - ``p_h264_sps``
>        - A pointer to a struct :c:type:`v4l2_ctrl_h264_sps`. Valid if this control is
>          of type ``V4L2_CTRL_TYPE_H264_SPS``.
> -    * - :c:type:`v4l2_ctrl_h264_pps` *
> +    * - struct :c:type:`v4l2_ctrl_h264_pps` *
>        - ``p_h264_pps``
>        - A pointer to a struct :c:type:`v4l2_ctrl_h264_pps`. Valid if this control is
>          of type ``V4L2_CTRL_TYPE_H264_PPS``.
> -    * - :c:type:`v4l2_ctrl_h264_scaling_matrix` *
> +    * - struct :c:type:`v4l2_ctrl_h264_scaling_matrix` *
>        - ``p_h264_scaling_matrix``
>        - A pointer to a struct :c:type:`v4l2_ctrl_h264_scaling_matrix`. Valid if this control is
>          of type ``V4L2_CTRL_TYPE_H264_SCALING_MATRIX``.
> -    * - :c:type:`v4l2_ctrl_h264_pred_weights` *
> +    * - struct :c:type:`v4l2_ctrl_h264_pred_weights` *
>        - ``p_h264_pred_weights``
>        - A pointer to a struct :c:type:`v4l2_ctrl_h264_pred_weights`. Valid if this control is
>          of type ``V4L2_CTRL_TYPE_H264_PRED_WEIGHTS``.
> -    * - :c:type:`v4l2_ctrl_h264_slice_params` *
> +    * - struct :c:type:`v4l2_ctrl_h264_slice_params` *
>        - ``p_h264_slice_params``
>        - A pointer to a struct :c:type:`v4l2_ctrl_h264_slice_params`. Valid if this control is
>          of type ``V4L2_CTRL_TYPE_H264_SLICE_PARAMS``.
> -    * - :c:type:`v4l2_ctrl_h264_decode_params` *
> +    * - struct :c:type:`v4l2_ctrl_h264_decode_params` *
>        - ``p_h264_decode_params``
>        - A pointer to a struct :c:type:`v4l2_ctrl_h264_decode_params`. Valid if this control is
>          of type ``V4L2_CTRL_TYPE_H264_DECODE_PARAMS``.



Thanks,
Mauro
