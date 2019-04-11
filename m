Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ACEC10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F98C217D4
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDKIhU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:37:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57676 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKIhT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 04:37:19 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CAAA62610D8;
        Thu, 11 Apr 2019 09:37:16 +0100 (BST)
Date:   Thu, 11 Apr 2019 10:37:14 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Brian Starkey <Brian.Starkey@arm.com>, kernel@collabora.com
Subject: Re: [RFC PATCH v2 2/7] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
Message-ID: <20190411103714.22afc04d@collabora.com>
In-Reply-To: <2063c87b-6609-0168-3a70-5c32c6297dad@xs4all.nl>
References: <20190404081700.30006-1-boris.brezillon@collabora.com>
        <20190404081700.30006-3-boris.brezillon@collabora.com>
        <2063c87b-6609-0168-3a70-5c32c6297dad@xs4all.nl>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 11 Apr 2019 10:24:16 +0200
Hans Verkuil <hverkuil@xs4all.nl> wrote:


> >  static void v4l_print_framebuffer(const void *arg, bool write_only)
> >  {
> >  	const struct v4l2_framebuffer *p = arg;
> > @@ -951,11 +1027,15 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
> >  	switch (type) {
> >  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> >  		if ((is_vid || is_tch) && is_rx &&
> > -		    (ops->vidioc_g_fmt_vid_cap || ops->vidioc_g_fmt_vid_cap_mplane))
> > +		    (ops->vidioc_g_fmt_vid_cap ||
> > +		     ops->vidioc_g_ext_fmt_vid_cap ||
> > +		     ops->vidioc_g_fmt_vid_cap_mplane))
> >  			return 0;
> >  		break;
> >  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> > -		if (is_vid && is_rx && ops->vidioc_g_fmt_vid_cap_mplane)
> > +		if (is_vid && is_rx &&
> > +		    (ops->vidioc_g_fmt_vid_cap_mplane ||
> > +		     ops->vidioc_g_ext_fmt_vid_cap))  
> 
> Is this right? I thought that V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE was to be refused
> when used with the new ioctls? Perhaps check_fmt needs an extra argument that
> tells it whether it is called from the new ioctls or not.

Or maybe we should do the format conversion (or just a type conversion)
before calling check_fmt().

> 
> >  			return 0;
> >  		break;
> >  	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
> > @@ -964,11 +1044,15 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
> >  		break;
> >  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> >  		if (is_vid && is_tx &&
> > -		    (ops->vidioc_g_fmt_vid_out || ops->vidioc_g_fmt_vid_out_mplane))
> > +		    (ops->vidioc_g_fmt_vid_out ||
> > +		     ops->vidioc_g_ext_fmt_vid_out ||
> > +		     ops->vidioc_g_fmt_vid_out_mplane))
> >  			return 0;
> >  		break;
> >  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> > -		if (is_vid && is_tx && ops->vidioc_g_fmt_vid_out_mplane)
> > +		if (is_vid && is_tx &&
> > +		    (ops->vidioc_g_ext_fmt_vid_out ||
> > +		     ops->vidioc_g_fmt_vid_out_mplane))
> >  			return 0;
> >  		break;
> >  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
> > @@ -1048,6 +1132,197 @@ static void v4l_sanitize_format(struct v4l2_format *fmt)
> >  	       sizeof(fmt->fmt.pix) - offset);
> >  }


> > +static int v4l_g_fmt_ext_pix(const struct v4l2_ioctl_ops *ops,
> > +			     struct file *file, void *fh,
> > +			     struct v4l2_format *f)
> > +{
> > +	struct v4l2_ext_format ef = {
> > +		.type = f->type,
> > +	};
> > +	int ret;
> > +
> > +	switch (f->type) {
> > +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> > +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> > +		ret = ops->vidioc_g_ext_fmt_vid_cap(file, fh, &ef.fmt.pix);  
> 
> This will call vidioc_g_ext_fmt_vid_cap with type _MPLANE, which we said we
> wouldn't support for the extended ioctls.

That's okay because we don't pass ef around just the ef.fmt.pix
which does not contain the format type. This being said, we should
definitely have

		ef.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;

for the v4l2_ext_format_to_format() conversion that happens at the end
of the function.

> 
> > +		break;
> > +
> > +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> > +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:

Same here:

		ef.type = V4L2_BUF_TYPE_VIDEO_OUTPUT;

> > +		ret = ops->vidioc_g_ext_fmt_vid_out(file, fh, &ef.fmt.pix);
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return v4l2_ext_format_to_format(&ef, f,
> > +					 V4L2_TYPE_IS_MULTIPLANAR(f->type),
> > +					 true);
> > +}
> > +
> >  static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
> >  				struct file *file, void *fh, void *arg)
> >  {
> > @@ -1475,15 +1782,22 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
> >  
> >  	switch (p->type) {
> >  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> > -		if (unlikely(!ops->vidioc_g_fmt_vid_cap))
> > -			break;
> > -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > -		ret = ops->vidioc_g_fmt_vid_cap(file, fh, arg);
> > -		/* just in case the driver zeroed it again */
> > -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > -		return ret;
> > +		if (ops->vidioc_g_fmt_vid_cap) {
> > +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > +			ret = ops->vidioc_g_fmt_vid_cap(file, fh, arg);
> > +			/* just in case the driver zeroed it again */
> > +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > +			return ret;
> > +		} else if (ops->vidioc_g_ext_fmt_vid_cap) {
> > +			return v4l_g_fmt_ext_pix(ops, file, fh, p);  
> 
> Test for the extended op first. Same elsewhere below. E.g.:
> 
> 		if (ops->vidioc_g_ext_fmt_vid_cap)
> 			return v4l_g_fmt_ext_pix(ops, file, fh, p);
> 		if (unlikely(!ops->vidioc_g_fmt_vid_cap))
> 			break;
> 		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> 		...

Sure, I'll change the order.

> 
> > +		}
> > +		break;
> >  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> > -		return ops->vidioc_g_fmt_vid_cap_mplane(file, fh, arg);
> > +		if (ops->vidioc_g_fmt_vid_cap_mplane)
> > +			return ops->vidioc_g_fmt_vid_cap_mplane(file, fh, arg);
> > +		else if (ops->vidioc_g_ext_fmt_vid_cap)
> > +			return v4l_g_fmt_ext_pix(ops, file, fh, p);
> > +		break;
> >  	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
> >  		return ops->vidioc_g_fmt_vid_overlay(file, fh, arg);
> >  	case V4L2_BUF_TYPE_VBI_CAPTURE:
> > @@ -1491,15 +1805,22 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
> >  	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
> >  		return ops->vidioc_g_fmt_sliced_vbi_cap(file, fh, arg);
> >  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> > -		if (unlikely(!ops->vidioc_g_fmt_vid_out))
> > -			break;
> > -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > -		ret = ops->vidioc_g_fmt_vid_out(file, fh, arg);
> > -		/* just in case the driver zeroed it again */
> > -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > -		return ret;
> > +		if (ops->vidioc_g_fmt_vid_out) {
> > +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > +			ret = ops->vidioc_g_fmt_vid_out(file, fh, arg);
> > +			/* just in case the driver zeroed it again */
> > +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > +			return ret;
> > +		} else if (ops->vidioc_g_ext_fmt_vid_out) {
> > +			return v4l_g_fmt_ext_pix(ops, file, fh, p);
> > +		}
> > +		break;
> >  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> > -		return ops->vidioc_g_fmt_vid_out_mplane(file, fh, arg);
> > +		if (ops->vidioc_g_fmt_vid_out_mplane)
> > +			return ops->vidioc_g_fmt_vid_out_mplane(file, fh, arg);
> > +		else if (ops->vidioc_g_ext_fmt_vid_out)
> > +			return v4l_g_fmt_ext_pix(ops, file, fh, p);
> > +		break;
> >  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
> >  		return ops->vidioc_g_fmt_vid_out_overlay(file, fh, arg);
> >  	case V4L2_BUF_TYPE_VBI_OUTPUT:


> >  static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
> >  				struct file *file, void *fh, void *arg)
> >  {
> > @@ -1551,23 +1943,31 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
> >  
> >  	switch (p->type) {
> >  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> > -		if (unlikely(!ops->vidioc_s_fmt_vid_cap))
> > -			break;
> > -		CLEAR_AFTER_FIELD(p, fmt.pix);
> > -		ret = ops->vidioc_s_fmt_vid_cap(file, fh, arg);
> > -		/* just in case the driver zeroed it again */
> > -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > +		if (ops->vidioc_s_fmt_vid_cap) {
> > +			CLEAR_AFTER_FIELD(p, fmt.pix);
> > +			ret = ops->vidioc_s_fmt_vid_cap(file, fh, arg);
> > +			/* just in case the driver zeroed it again */
> > +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> > +		} else if (ops->vidioc_s_ext_fmt_vid_cap) {
> > +			ret = v4l_s_fmt_ext_pix(ops, file, fh, arg);  
> 
> The helper functions v4l_[g/s/try]_fmt_ext_pix are confusingly named.
> How about: v4l_[g/s/try]_fmt_using_ext_fmt.

Yep, that's definitely a better name.
