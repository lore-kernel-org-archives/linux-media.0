Return-Path: <SRS0=aREJ=UZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB1C48BD3
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 15:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81132080C
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 15:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfFZPH3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:07:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38149 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZPH2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 Jun 2019 11:07:28 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hg9WB-0007jb-Qt; Wed, 26 Jun 2019 17:07:27 +0200
Message-ID: <1561561646.4870.9.camel@pengutronix.de>
Subject: Re: [PATCH] v4l2-ioctl: call v4l_pix_format_touch() for TRY_FMT
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Florian Echtler <floe@butterbrot.org>,
        Nick Dyer <nick@shmanahar.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Date:   Wed, 26 Jun 2019 17:07:26 +0200
In-Reply-To: <95437142-2935-0d3f-073e-333dab4e17c0@xs4all.nl>
References: <95437142-2935-0d3f-073e-333dab4e17c0@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 2019-06-26 at 11:48 +0200, Hans Verkuil wrote:
> The function v4l_pix_format_touch() is called for S_FMT to set
> v4l2_pix_format fields to default values for a v4l-touch device,
> but it wasn't called for TRY_FMT. Add this.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index b1f4b991dba6..c5c8c8ab7cf6 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1661,6 +1661,8 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>  		ret = ops->vidioc_try_fmt_vid_cap(file, fh, arg);
>  		/* just in case the driver zeroed it again */
>  		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +		if (vfd->vfl_type == VFL_TYPE_TOUCH)
> +			v4l_pix_format_touch(&p->fmt.pix);

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
