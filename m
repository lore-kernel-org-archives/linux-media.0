Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4029EC10F09
	for <linux-media@archiver.kernel.org>; Tue, 26 Jan 2021 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CFE23101
	for <linux-media@archiver.kernel.org>; Tue, 26 Jan 2021 19:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbhAZFp2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:45:28 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55132 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbhAYORe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 25 Jan 2021 09:17:34 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4346B331;
        Mon, 25 Jan 2021 15:15:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611584136;
        bh=JgPs6f9hCrtjm0ZgJDLYxgtV0kXtWZhAud13sZqCi2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pqb5FGh8FGVpVjLFjpk4dWBxemBh5bJCk54xcoBvEraHt8d0Njr5IO/lhSI0VdvDx
         Wk/aNdS0hML5zQ+PTWbje3UFK2jPF5FuWZdo4TOFatWtP0iEbQqSWpYW0DNB3bivv1
         UJx2w8fd91ZsOaHB3hUu2zyRRQHjX9LAkHhNVYA4=
Date:   Mon, 25 Jan 2021 16:15:17 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-media@vger.kernel.org, hverkuil@xs4all.nl,
        hans.verkuil@cisco.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: doc: pixfmt-yuv: Fix 4:4:4 subsampling info
Message-ID: <YA7SdYmQrw/BsPJp@pendragon.ideasonboard.com>
References: <20210125141029.16481-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125141029.16481-1-helen.koike@collabora.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Helen,

Thank you for the patch.

On Mon, Jan 25, 2021 at 11:10:29AM -0300, Helen Koike wrote:
> YUV 4:4:4 is not subsampled, fix this in the docs.
> 
> Fixes: da785536e007 ("media: doc: pixfmt-yuv: Move all semi-planar YUV formats to common file")
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes in v2:
> 
> - s/No sub-sampling/The chroma plane is not subsampled/ (Laurent)
> - Fixed description regarding the number of bytes (Laurent)
> ---
>  Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 7d4d39201a3f..1e0db602cc1b 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -396,9 +396,9 @@ number of lines as the luma plane.
>  NV24 and NV42
>  -------------
>  
> -Semi-planar YUV 4:4:4 formats. The chroma plane is subsampled by 2 in the
> -horizontal direction. Chroma lines contain half the number of pixels and the
> -same number of bytes as luma lines, and the chroma plane contains the same
> +Semi-planar YUV 4:4:4 formats. The chroma plane is not subsampled.
> +Chroma lines contain the same number of pixels and twice the
> +number of bytes as luma lines, and the chroma plane contains the same
>  number of lines as the luma plane.
>  
>  .. flat-table:: Sample 4x4 NV24 Image

-- 
Regards,

Laurent Pinchart
