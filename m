Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60563C433FE
	for <linux-media@archiver.kernel.org>; Wed, 23 Feb 2022 17:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbiBWRG5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiBWRGz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Feb 2022 12:06:55 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632645A585;
        Wed, 23 Feb 2022 09:06:18 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D33A21BF203;
        Wed, 23 Feb 2022 17:06:13 +0000 (UTC)
Date:   Wed, 23 Feb 2022 18:06:11 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH v5 03/13] media: atmel: atmel-isc: remove redundant
 comments
Message-ID: <20220223170611.bv64yqmyuqrzeu2x@uno.localdomain>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
 <20220217135645.1427466-4-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217135645.1427466-4-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Eugen

On Thu, Feb 17, 2022 at 03:56:35PM +0200, Eugen Hristev wrote:
> Remove duplicate comments which are already in place before the struct
> definition.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

> ---
>  drivers/media/platform/atmel/atmel-isc.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
> index 07fa6dbf8460..f9ad7ec6bd13 100644
> --- a/drivers/media/platform/atmel/atmel-isc.h
> +++ b/drivers/media/platform/atmel/atmel-isc.h
> @@ -272,7 +272,7 @@ struct isc_device {
>  	struct video_device	video_dev;
>
>  	struct vb2_queue	vb2_vidq;
> -	spinlock_t		dma_queue_lock; /* serialize access to dma queue */
> +	spinlock_t		dma_queue_lock;
>  	struct list_head	dma_queue;
>  	struct isc_buffer	*cur_frm;
>  	unsigned int		sequence;
> @@ -289,8 +289,8 @@ struct isc_device {
>  	struct isc_ctrls	ctrls;
>  	struct work_struct	awb_work;
>
> -	struct mutex		lock; /* serialize access to file operations */
> -	spinlock_t		awb_lock; /* serialize access to DMA buffers from awb work queue */
> +	struct mutex		lock;
> +	spinlock_t		awb_lock;
>
>  	struct regmap_field	*pipeline[ISC_PIPE_LINE_NODE_NUM];
>
> --
> 2.25.1
>
