Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31698C10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 08:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB9D2064A
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 08:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfDKIYW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:24:22 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:58887 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbfDKIYW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 04:24:22 -0400
Received: from [IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc] ([IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc])
        by smtp-cloud8.xs4all.net with ESMTPA
        id EV0KhxH10UjKfEV0LhlIba; Thu, 11 Apr 2019 10:24:18 +0200
Subject: Re: [RFC PATCH v2 2/7] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Brian Starkey <Brian.Starkey@arm.com>, kernel@collabora.com
References: <20190404081700.30006-1-boris.brezillon@collabora.com>
 <20190404081700.30006-3-boris.brezillon@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <2063c87b-6609-0168-3a70-5c32c6297dad@xs4all.nl>
Date:   Thu, 11 Apr 2019 10:24:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190404081700.30006-3-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO/kmDo8DJWVKx70tKY8uJvBgIlI1pElCrRM+b96pwszgCIEdbcSeDB+n8xNl1nBvmAgZE4QhonSjJ1gbT4sJZADvI/Kb+WLwUFHUgNImASh7isbiq2U
 rJdYh6hBJW/4N4a4UctTOIKzSde96WAle4EXjEfSXQkqULkYfIVPcSPLTjx7ECLV6jvqsOyP1ghvMFarzNzpWQJErBYttOPEnAxrAIA2BlGEnbc9Ozur536v
 ZJ/h4um4AetRLu1v1aEaNZL3EOgZGDpK9IqQ0aPNBrK9+OmaUyQZJNIDDRXd/4BHq2AYwPe+CutzHjdXw8+cgSJ94szYxYH/Fu3DkxHWrxgLl12BhaddGxvk
 iBcB34oReOqSh/sxJwMfebGbS45d+AfZkhXF/Cbc5EHFPRNGXHjtBeF9OY02PZmMYFwgvL4PTg23Zo26IIF6iIXjZbvCm2zid2kBlr5qQW+nKwWrmjPHtd1Z
 0uB4QgJE35ZhQ2eY/r/frwn9qP/ogaqPx7E+QpQag/9mSNDKXRw1xYPvvxzqib1bESIPN6VQOL64KjY1tmZyItHMeXbWU92lA9UlkWHMJN18umvLX25LysVE
 B1aX0QthxFhktcJJ30oaBGSw8Gqin6c3CP/Ak4KFwm21qA==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/4/19 10:16 AM, Boris Brezillon wrote:
> This is part of the multiplanar and singleplanar unification process.
> v4l2_ext_pix_format is supposed to work for both cases.
> 
> We also add the concept of modifiers already employed in DRM to expose
> HW-specific formats (like tiled or compressed formats) and allow
> exchanging this information with the DRM subsystem in a consistent way.
> 
> Note that V4L2_BUF_TYPE_VIDEO[_OUTPUT]_OVERLAY and
> V4L2_BUF_TYPE_VIDEO_{CAPTURE,OUTPUT}_MPLANE types are no longer accepted
> in v4l2_ext_format and will be rejected if you use the {G,S,TRY}EXT_FMT
> ioctls. V4L2_BUF_TYPE_VIDEO_{CAPTURE,OUTPUT}_MPLANE is dropped as part
> of the multiplanar/singleplanar unification.
> V4L2_BUF_TYPE_VIDEO[_OUTPUT]_OVERLAY seems to be used mostly on old
> drivers and supporting it would require some extra rework.
> 
> New hooks have been added to v4l2_ioctl_ops to support those new ioctls
> in drivers, but, in the meantime, the core takes care of converting
> {S,G,TRY}_EXT_FMT requests into {S,G,TRY}_FMT so that old drivers can
> still work if the userspace app/lib uses the new ioctls.
> The conversion is also done the other around to allow userspace
> apps/libs using {S,G,TRY}_FMT to work with drivers implementing the
> _ext_ hooks.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Changes in v2:
> - Move the modifier in v4l2_ext_format (was formerly placed in
>   v4l2_ext_plane)
> - Fix a few bugs in the converters and add a strict parameter to
>   allow conversion of uninitialized/mis-initialized objects
> ---
>  drivers/media/v4l2-core/v4l2-dev.c   |  24 +-
>  drivers/media/v4l2-core/v4l2-ioctl.c | 692 ++++++++++++++++++++++++---
>  include/media/v4l2-ioctl.h           |  33 ++
>  include/uapi/linux/videodev2.h       |  81 ++++
>  4 files changed, 749 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index 29946a2b2752..a233e0924ed3 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -599,32 +599,44 @@ static void determine_valid_ioctls(struct video_device *vdev)
>  			       ops->vidioc_enum_fmt_meta_out)))
>  			set_bit(_IOC_NR(VIDIOC_ENUM_FMT), valid_ioctls);
>  		if ((is_rx && (ops->vidioc_g_fmt_vid_cap ||
> +			       ops->vidioc_g_ext_fmt_vid_cap ||
>  			       ops->vidioc_g_fmt_vid_cap_mplane ||
>  			       ops->vidioc_g_fmt_vid_overlay ||
>  			       ops->vidioc_g_fmt_meta_cap)) ||
>  		    (is_tx && (ops->vidioc_g_fmt_vid_out ||
> +			       ops->vidioc_g_ext_fmt_vid_out ||
>  			       ops->vidioc_g_fmt_vid_out_mplane ||
>  			       ops->vidioc_g_fmt_vid_out_overlay ||
> -			       ops->vidioc_g_fmt_meta_out)))
> -			 set_bit(_IOC_NR(VIDIOC_G_FMT), valid_ioctls);
> +			       ops->vidioc_g_fmt_meta_out))) {
> +			set_bit(_IOC_NR(VIDIOC_G_FMT), valid_ioctls);
> +			set_bit(_IOC_NR(VIDIOC_G_EXT_FMT), valid_ioctls);
> +		}
>  		if ((is_rx && (ops->vidioc_s_fmt_vid_cap ||
> +			       ops->vidioc_s_ext_fmt_vid_cap ||
>  			       ops->vidioc_s_fmt_vid_cap_mplane ||
>  			       ops->vidioc_s_fmt_vid_overlay ||
>  			       ops->vidioc_s_fmt_meta_cap)) ||
>  		    (is_tx && (ops->vidioc_s_fmt_vid_out ||
> +			       ops->vidioc_s_ext_fmt_vid_out ||
>  			       ops->vidioc_s_fmt_vid_out_mplane ||
>  			       ops->vidioc_s_fmt_vid_out_overlay ||
> -			       ops->vidioc_s_fmt_meta_out)))
> -			 set_bit(_IOC_NR(VIDIOC_S_FMT), valid_ioctls);
> +			       ops->vidioc_s_fmt_meta_out))) {
> +			set_bit(_IOC_NR(VIDIOC_S_FMT), valid_ioctls);
> +			set_bit(_IOC_NR(VIDIOC_S_EXT_FMT), valid_ioctls);
> +		}
>  		if ((is_rx && (ops->vidioc_try_fmt_vid_cap ||
> +			       ops->vidioc_try_ext_fmt_vid_cap ||
>  			       ops->vidioc_try_fmt_vid_cap_mplane ||
>  			       ops->vidioc_try_fmt_vid_overlay ||
>  			       ops->vidioc_try_fmt_meta_cap)) ||
>  		    (is_tx && (ops->vidioc_try_fmt_vid_out ||
> +			       ops->vidioc_try_ext_fmt_vid_out ||
>  			       ops->vidioc_try_fmt_vid_out_mplane ||
>  			       ops->vidioc_try_fmt_vid_out_overlay ||
> -			       ops->vidioc_try_fmt_meta_out)))
> -			 set_bit(_IOC_NR(VIDIOC_TRY_FMT), valid_ioctls);
> +			       ops->vidioc_try_fmt_meta_out))) {
> +			set_bit(_IOC_NR(VIDIOC_TRY_FMT), valid_ioctls);
> +			set_bit(_IOC_NR(VIDIOC_TRY_EXT_FMT), valid_ioctls);
> +		}
>  		SET_VALID_IOCTL(ops, VIDIOC_OVERLAY, vidioc_overlay);
>  		SET_VALID_IOCTL(ops, VIDIOC_G_FBUF, vidioc_g_fbuf);
>  		SET_VALID_IOCTL(ops, VIDIOC_S_FBUF, vidioc_s_fbuf);
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 97ba365218fb..f9001efa0aa5 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -381,6 +381,82 @@ static void v4l_print_format(const void *arg, bool write_only)
>  	}
>  }
>  
> +static void v4l_print_ext_format(const void *arg, bool write_only)
> +{
> +	const struct v4l2_ext_format *p = arg;
> +	const struct v4l2_ext_pix_format *pix;
> +	const struct v4l2_vbi_format *vbi;
> +	const struct v4l2_sliced_vbi_format *sliced;
> +	const struct v4l2_sdr_format *sdr;
> +	const struct v4l2_meta_format *meta;
> +	unsigned int i;
> +	u32 planes;
> +
> +	pr_cont("type=%s", prt_names(p->type, v4l2_type_names));
> +	switch (p->type) {
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +		pix = &p->fmt.pix;
> +		pr_cont(", width=%u, height=%u, format=%c%c%c%c, modifier %llx, field=%s, colorspace=%d, num_planes=%u, flags=0x%x, ycbcr_enc=%u, quantization=%u, xfer_func=%u\n",
> +			pix->width, pix->height,
> +			(pix->pixelformat & 0xff),
> +			(pix->pixelformat >>  8) & 0xff,
> +			(pix->pixelformat >> 16) & 0xff,
> +			(pix->pixelformat >> 24) & 0xff,
> +			pix->modifier, prt_names(pix->field, v4l2_field_names),
> +			pix->colorspace, pix->num_planes, pix->flags,
> +			pix->ycbcr_enc, pix->quantization, pix->xfer_func);
> +		planes = min_t(u32, pix->num_planes, VIDEO_MAX_PLANES);
> +		for (i = 0; i < planes; i++)
> +			pr_debug("plane %u: bytesperline=%u sizeimage=%u\n",
> +				 i, pix->plane_fmt[i].bytesperline,
> +				 pix->plane_fmt[i].sizeimage);
> +		break;
> +	case V4L2_BUF_TYPE_VBI_CAPTURE:
> +	case V4L2_BUF_TYPE_VBI_OUTPUT:
> +		vbi = &p->fmt.vbi;
> +		pr_cont(", sampling_rate=%u, offset=%u, samples_per_line=%u, sample_format=%c%c%c%c, start=%u,%u, count=%u,%u\n",
> +			vbi->sampling_rate, vbi->offset,
> +			vbi->samples_per_line,
> +			(vbi->sample_format & 0xff),
> +			(vbi->sample_format >>  8) & 0xff,
> +			(vbi->sample_format >> 16) & 0xff,
> +			(vbi->sample_format >> 24) & 0xff,
> +			vbi->start[0], vbi->start[1],
> +			vbi->count[0], vbi->count[1]);
> +		break;
> +	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
> +	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
> +		sliced = &p->fmt.sliced;
> +		pr_cont(", service_set=0x%08x, io_size=%d\n",
> +			sliced->service_set, sliced->io_size);
> +		for (i = 0; i < 24; i++)
> +			pr_debug("line[%02u]=0x%04x, 0x%04x\n", i,
> +				 sliced->service_lines[0][i],
> +				 sliced->service_lines[1][i]);
> +		break;
> +	case V4L2_BUF_TYPE_SDR_CAPTURE:
> +	case V4L2_BUF_TYPE_SDR_OUTPUT:
> +		sdr = &p->fmt.sdr;
> +		pr_cont(", pixelformat=%c%c%c%c\n",
> +			(sdr->pixelformat >>  0) & 0xff,
> +			(sdr->pixelformat >>  8) & 0xff,
> +			(sdr->pixelformat >> 16) & 0xff,
> +			(sdr->pixelformat >> 24) & 0xff);
> +		break;
> +	case V4L2_BUF_TYPE_META_CAPTURE:
> +	case V4L2_BUF_TYPE_META_OUTPUT:
> +		meta = &p->fmt.meta;
> +		pr_cont(", dataformat=%c%c%c%c, buffersize=%u\n",
> +			(meta->dataformat >>  0) & 0xff,
> +			(meta->dataformat >>  8) & 0xff,
> +			(meta->dataformat >> 16) & 0xff,
> +			(meta->dataformat >> 24) & 0xff,
> +			meta->buffersize);
> +		break;
> +	}
> +}
> +
>  static void v4l_print_framebuffer(const void *arg, bool write_only)
>  {
>  	const struct v4l2_framebuffer *p = arg;
> @@ -951,11 +1027,15 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
>  	switch (type) {
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>  		if ((is_vid || is_tch) && is_rx &&
> -		    (ops->vidioc_g_fmt_vid_cap || ops->vidioc_g_fmt_vid_cap_mplane))
> +		    (ops->vidioc_g_fmt_vid_cap ||
> +		     ops->vidioc_g_ext_fmt_vid_cap ||
> +		     ops->vidioc_g_fmt_vid_cap_mplane))
>  			return 0;
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> -		if (is_vid && is_rx && ops->vidioc_g_fmt_vid_cap_mplane)
> +		if (is_vid && is_rx &&
> +		    (ops->vidioc_g_fmt_vid_cap_mplane ||
> +		     ops->vidioc_g_ext_fmt_vid_cap))

Is this right? I thought that V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE was to be refused
when used with the new ioctls? Perhaps check_fmt needs an extra argument that
tells it whether it is called from the new ioctls or not.

>  			return 0;
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
> @@ -964,11 +1044,15 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>  		if (is_vid && is_tx &&
> -		    (ops->vidioc_g_fmt_vid_out || ops->vidioc_g_fmt_vid_out_mplane))
> +		    (ops->vidioc_g_fmt_vid_out ||
> +		     ops->vidioc_g_ext_fmt_vid_out ||
> +		     ops->vidioc_g_fmt_vid_out_mplane))
>  			return 0;
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> -		if (is_vid && is_tx && ops->vidioc_g_fmt_vid_out_mplane)
> +		if (is_vid && is_tx &&
> +		    (ops->vidioc_g_ext_fmt_vid_out ||
> +		     ops->vidioc_g_fmt_vid_out_mplane))
>  			return 0;
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
> @@ -1048,6 +1132,197 @@ static void v4l_sanitize_format(struct v4l2_format *fmt)
>  	       sizeof(fmt->fmt.pix) - offset);
>  }
>  
> +int v4l2_ext_format_to_format(const struct v4l2_ext_format *e,
> +			      struct v4l2_format *f, bool mplane_cap,
> +			      bool strict)
> +{
> +	const struct v4l2_plane_ext_pix_format *pe;
> +	struct v4l2_plane_pix_format *p;
> +	unsigned int i;
> +
> +	memset(f, 0, sizeof(*f));
> +
> +	switch (e->type) {
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +		/*
> +		 * Make sure no modifier is required before doing the
> +		 * conversion.
> +		 */
> +		if (e->fmt.pix.modifier && strict)
> +			return -EINVAL;
> +
> +		if ((e->fmt.pix.num_planes > VIDEO_MAX_PLANES ||
> +		     !e->fmt.pix.num_planes) && strict)
> +			return -EINVAL;
> +
> +		if (e->fmt.pix.num_planes > 1 && !mplane_cap && strict)
> +			return -EINVAL;
> +
> +		if (!mplane_cap) {
> +			f->fmt.pix.width = e->fmt.pix.width;
> +			f->fmt.pix.height = e->fmt.pix.height;
> +			f->fmt.pix.pixelformat = e->fmt.pix.pixelformat;
> +			f->fmt.pix.field = e->fmt.pix.field;
> +			f->fmt.pix.colorspace = e->fmt.pix.colorspace;
> +			f->fmt.pix.flags = e->fmt.pix.flags;
> +			f->fmt.pix.ycbcr_enc = e->fmt.pix.ycbcr_enc;
> +			f->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +			f->fmt.pix.quantization = e->fmt.pix.quantization;
> +			pe = &e->fmt.pix.plane_fmt[0];
> +			f->fmt.pix.bytesperline = pe->bytesperline;
> +			f->fmt.pix.sizeimage = pe->sizeimage;
> +			f->type = e->type;
> +			break;
> +		}
> +
> +		f->fmt.pix_mp.width = e->fmt.pix.width;
> +		f->fmt.pix_mp.height = e->fmt.pix.height;
> +		f->fmt.pix_mp.pixelformat = e->fmt.pix.pixelformat;
> +		f->fmt.pix_mp.field = e->fmt.pix.field;
> +		f->fmt.pix_mp.colorspace = e->fmt.pix.colorspace;
> +		f->fmt.pix_mp.flags = e->fmt.pix.flags;
> +		f->fmt.pix_mp.ycbcr_enc = e->fmt.pix.ycbcr_enc;
> +		f->fmt.pix_mp.quantization = e->fmt.pix.quantization;
> +		if (e->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +			f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +		else
> +			f->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> +
> +		for (i = 0; i < VIDEO_MAX_PLANES; i++) {
> +			pe = &e->fmt.pix.plane_fmt[i];
> +			p = &f->fmt.pix_mp.plane_fmt[i];
> +			p->bytesperline = pe->bytesperline;
> +			p->sizeimage = pe->sizeimage;
> +		}
> +		break;
> +
> +	case V4L2_BUF_TYPE_VBI_CAPTURE:
> +	case V4L2_BUF_TYPE_VBI_OUTPUT:
> +		f->type = e->type;
> +		f->fmt.vbi = e->fmt.vbi;
> +		break;
> +
> +	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
> +	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
> +		f->type = e->type;
> +		f->fmt.sliced = e->fmt.sliced;
> +		break;
> +
> +	case V4L2_BUF_TYPE_SDR_CAPTURE:
> +	case V4L2_BUF_TYPE_SDR_OUTPUT:
> +		f->type = e->type;
> +		f->fmt.sdr = e->fmt.sdr;
> +		break;
> +
> +	case V4L2_BUF_TYPE_META_CAPTURE:
> +	case V4L2_BUF_TYPE_META_OUTPUT:
> +		f->type = e->type;
> +		f->fmt.meta = e->fmt.meta;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(v4l2_ext_format_to_format);
> +
> +int v4l2_format_to_ext_format(const struct v4l2_format *f,
> +			      struct v4l2_ext_format *e, bool strict)
> +{
> +	const struct v4l2_plane_pix_format *p;
> +	struct v4l2_plane_ext_pix_format *pe;
> +	unsigned int i;
> +
> +	memset(e, 0, sizeof(*e));
> +
> +	switch (f->type) {
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +		e->fmt.pix.width = f->fmt.pix.width;
> +		e->fmt.pix.height = f->fmt.pix.height;
> +		e->fmt.pix.pixelformat = f->fmt.pix.pixelformat;
> +		e->fmt.pix.field = f->fmt.pix.field;
> +		e->fmt.pix.colorspace = f->fmt.pix.colorspace;
> +		e->fmt.pix.flags = f->fmt.pix.flags;
> +		e->fmt.pix.ycbcr_enc = f->fmt.pix.ycbcr_enc;
> +		e->fmt.pix.quantization = f->fmt.pix.quantization;
> +		e->fmt.pix.num_planes = 1;
> +		e->fmt.pix.plane_fmt[0].bytesperline = f->fmt.pix.bytesperline;
> +		e->fmt.pix.plane_fmt[0].sizeimage = f->fmt.pix.sizeimage;
> +		e->type = f->type;
> +		break;
> +
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> +		if ((f->fmt.pix_mp.num_planes > VIDEO_MAX_PLANES ||
> +		     !f->fmt.pix_mp.num_planes) && strict)
> +			return -EINVAL;
> +
> +		e->fmt.pix.width = f->fmt.pix_mp.width;
> +		e->fmt.pix.height = f->fmt.pix_mp.height;
> +		e->fmt.pix.pixelformat = f->fmt.pix_mp.pixelformat;
> +		e->fmt.pix.field = f->fmt.pix_mp.field;
> +		e->fmt.pix.colorspace = f->fmt.pix_mp.colorspace;
> +		e->fmt.pix.flags = f->fmt.pix_mp.flags;
> +		e->fmt.pix.ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
> +		e->fmt.pix.quantization = f->fmt.pix_mp.quantization;
> +		e->fmt.pix.num_planes = f->fmt.pix_mp.num_planes;
> +		if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +			e->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +		else
> +			e->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
> +
> +		for (i = 0; i < VIDEO_MAX_PLANES; i++) {
> +			pe = &e->fmt.pix.plane_fmt[i];
> +			p = &f->fmt.pix_mp.plane_fmt[i];
> +			pe->bytesperline = p->bytesperline;
> +			pe->sizeimage = p->sizeimage;
> +		}
> +		break;
> +
> +	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
> +		/*
> +		 * OVERLAY formats are not supported by the _EXT_FMT
> +		 * ioctl()s.
> +		 */
> +		return -EINVAL;
> +
> +	case V4L2_BUF_TYPE_VBI_CAPTURE:
> +	case V4L2_BUF_TYPE_VBI_OUTPUT:
> +		e->type = f->type;
> +		e->fmt.vbi = f->fmt.vbi;
> +		break;
> +
> +	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
> +	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
> +		e->type = f->type;
> +		e->fmt.sliced = f->fmt.sliced;
> +		break;
> +
> +	case V4L2_BUF_TYPE_SDR_CAPTURE:
> +	case V4L2_BUF_TYPE_SDR_OUTPUT:
> +		e->type = f->type;
> +		e->fmt.sdr = f->fmt.sdr;
> +		break;
> +
> +	case V4L2_BUF_TYPE_META_CAPTURE:
> +	case V4L2_BUF_TYPE_META_OUTPUT:
> +		e->type = f->type;
> +		e->fmt.meta = f->fmt.meta;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(v4l2_format_to_ext_format);
> +
>  static int v4l_querycap(const struct v4l2_ioctl_ops *ops,
>  				struct file *file, void *fh, void *arg)
>  {
> @@ -1440,6 +1715,38 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
>  	return ret;
>  }
>  
> +static int v4l_g_fmt_ext_pix(const struct v4l2_ioctl_ops *ops,
> +			     struct file *file, void *fh,
> +			     struct v4l2_format *f)
> +{
> +	struct v4l2_ext_format ef = {
> +		.type = f->type,
> +	};
> +	int ret;
> +
> +	switch (f->type) {
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> +		ret = ops->vidioc_g_ext_fmt_vid_cap(file, fh, &ef.fmt.pix);

This will call vidioc_g_ext_fmt_vid_cap with type _MPLANE, which we said we
wouldn't support for the extended ioctls.

> +		break;
> +
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> +		ret = ops->vidioc_g_ext_fmt_vid_out(file, fh, &ef.fmt.pix);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	return v4l2_ext_format_to_format(&ef, f,
> +					 V4L2_TYPE_IS_MULTIPLANAR(f->type),
> +					 true);
> +}
> +
>  static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>  				struct file *file, void *fh, void *arg)
>  {
> @@ -1475,15 +1782,22 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>  
>  	switch (p->type) {
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> -		if (unlikely(!ops->vidioc_g_fmt_vid_cap))
> -			break;
> -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> -		ret = ops->vidioc_g_fmt_vid_cap(file, fh, arg);
> -		/* just in case the driver zeroed it again */
> -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> -		return ret;
> +		if (ops->vidioc_g_fmt_vid_cap) {
> +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +			ret = ops->vidioc_g_fmt_vid_cap(file, fh, arg);
> +			/* just in case the driver zeroed it again */
> +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +			return ret;
> +		} else if (ops->vidioc_g_ext_fmt_vid_cap) {
> +			return v4l_g_fmt_ext_pix(ops, file, fh, p);

Test for the extended op first. Same elsewhere below. E.g.:

		if (ops->vidioc_g_ext_fmt_vid_cap)
			return v4l_g_fmt_ext_pix(ops, file, fh, p);
		if (unlikely(!ops->vidioc_g_fmt_vid_cap))
			break;
		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
		...

> +		}
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> -		return ops->vidioc_g_fmt_vid_cap_mplane(file, fh, arg);
> +		if (ops->vidioc_g_fmt_vid_cap_mplane)
> +			return ops->vidioc_g_fmt_vid_cap_mplane(file, fh, arg);
> +		else if (ops->vidioc_g_ext_fmt_vid_cap)
> +			return v4l_g_fmt_ext_pix(ops, file, fh, p);
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>  		return ops->vidioc_g_fmt_vid_overlay(file, fh, arg);
>  	case V4L2_BUF_TYPE_VBI_CAPTURE:
> @@ -1491,15 +1805,22 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>  	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
>  		return ops->vidioc_g_fmt_sliced_vbi_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> -		if (unlikely(!ops->vidioc_g_fmt_vid_out))
> -			break;
> -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> -		ret = ops->vidioc_g_fmt_vid_out(file, fh, arg);
> -		/* just in case the driver zeroed it again */
> -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> -		return ret;
> +		if (ops->vidioc_g_fmt_vid_out) {
> +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +			ret = ops->vidioc_g_fmt_vid_out(file, fh, arg);
> +			/* just in case the driver zeroed it again */
> +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +			return ret;
> +		} else if (ops->vidioc_g_ext_fmt_vid_out) {
> +			return v4l_g_fmt_ext_pix(ops, file, fh, p);
> +		}
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> -		return ops->vidioc_g_fmt_vid_out_mplane(file, fh, arg);
> +		if (ops->vidioc_g_fmt_vid_out_mplane)
> +			return ops->vidioc_g_fmt_vid_out_mplane(file, fh, arg);
> +		else if (ops->vidioc_g_ext_fmt_vid_out)
> +			return v4l_g_fmt_ext_pix(ops, file, fh, p);
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>  		return ops->vidioc_g_fmt_vid_out_overlay(file, fh, arg);
>  	case V4L2_BUF_TYPE_VBI_OUTPUT:
> @@ -1518,6 +1839,43 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>  	return -EINVAL;
>  }
>  
> +static int v4l_g_ext_fmt(const struct v4l2_ioctl_ops *ops,
> +			 struct file *file, void *fh, void *arg)
> +{
> +	struct v4l2_ext_format *ef = arg;
> +	struct v4l2_format f = {
> +		.type = ef->type,
> +	};
> +	int ret;
> +
> +	ret = check_fmt(file, ef->type);
> +	if (ret)
> +		return ret;
> +
> +	memset(&ef->fmt, 0, sizeof(ef->fmt));
> +
> +	switch (ef->type) {
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +		if (ops->vidioc_g_ext_fmt_vid_cap)
> +			return ops->vidioc_g_ext_fmt_vid_cap(file, fh,
> +							     &ef->fmt.pix);
> +		break;
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +		if (ops->vidioc_g_ext_fmt_vid_out)
> +			return ops->vidioc_g_ext_fmt_vid_out(file, fh,
> +							     &ef->fmt.pix);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	ret = v4l_g_fmt(ops, file, fh, &f);
> +	if (ret)
> +		return ret;
> +
> +	return v4l2_format_to_ext_format(&f, ef, true);
> +}
> +
>  static void v4l_pix_format_touch(struct v4l2_pix_format *p)
>  {
>  	/*
> @@ -1533,6 +1891,40 @@ static void v4l_pix_format_touch(struct v4l2_pix_format *p)
>  	p->xfer_func = 0;
>  }
>  
> +static int v4l_s_fmt_ext_pix(const struct v4l2_ioctl_ops *ops,
> +			     struct file *file, void *fh,
> +			     struct v4l2_format *f)
> +{
> +	struct v4l2_ext_format ef;
> +	int ret;
> +
> +	ret = v4l2_format_to_ext_format(f, &ef, false);
> +	if (ret)
> +		return ret;
> +
> +	switch (f->type) {
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> +		ret = ops->vidioc_s_ext_fmt_vid_cap(file, fh, &ef.fmt.pix);
> +		break;
> +
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> +		ret = ops->vidioc_s_ext_fmt_vid_out(file, fh, &ef.fmt.pix);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	return v4l2_ext_format_to_format(&ef, f,
> +					 V4L2_TYPE_IS_MULTIPLANAR(f->type),
> +					 true);
> +}
> +
>  static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>  				struct file *file, void *fh, void *arg)
>  {
> @@ -1551,23 +1943,31 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>  
>  	switch (p->type) {
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> -		if (unlikely(!ops->vidioc_s_fmt_vid_cap))
> -			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix);
> -		ret = ops->vidioc_s_fmt_vid_cap(file, fh, arg);
> -		/* just in case the driver zeroed it again */
> -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +		if (ops->vidioc_s_fmt_vid_cap) {
> +			CLEAR_AFTER_FIELD(p, fmt.pix);
> +			ret = ops->vidioc_s_fmt_vid_cap(file, fh, arg);
> +			/* just in case the driver zeroed it again */
> +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +		} else if (ops->vidioc_s_ext_fmt_vid_cap) {
> +			ret = v4l_s_fmt_ext_pix(ops, file, fh, arg);

The helper functions v4l_[g/s/try]_fmt_ext_pix are confusingly named.
How about: v4l_[g/s/try]_fmt_using_ext_fmt.

> +		} else {
> +			ret = -EINVAL;
> +		}
> +
>  		if (vfd->vfl_type == VFL_TYPE_TOUCH)
>  			v4l_pix_format_touch(&p->fmt.pix);
>  		return ret;
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> -		if (unlikely(!ops->vidioc_s_fmt_vid_cap_mplane))
> -			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> -		for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> -			CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> -					  bytesperline);
> -		return ops->vidioc_s_fmt_vid_cap_mplane(file, fh, arg);
> +		if (ops->vidioc_s_fmt_vid_cap_mplane) {
> +			CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> +			for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> +				CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> +						  bytesperline);
> +			return ops->vidioc_s_fmt_vid_cap_mplane(file, fh, arg);
> +		} else if (ops->vidioc_s_ext_fmt_vid_cap) {
> +			return v4l_s_fmt_ext_pix(ops, file, fh, arg);
> +		}
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>  		if (unlikely(!ops->vidioc_s_fmt_vid_overlay))
>  			break;
> @@ -1584,21 +1984,27 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>  		CLEAR_AFTER_FIELD(p, fmt.sliced);
>  		return ops->vidioc_s_fmt_sliced_vbi_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> -		if (unlikely(!ops->vidioc_s_fmt_vid_out))
> -			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix);
> -		ret = ops->vidioc_s_fmt_vid_out(file, fh, arg);
> -		/* just in case the driver zeroed it again */
> -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> -		return ret;
> +		if (ops->vidioc_s_fmt_vid_out) {
> +			CLEAR_AFTER_FIELD(p, fmt.pix);
> +			ret = ops->vidioc_s_fmt_vid_out(file, fh, arg);
> +			/* just in case the driver zeroed it again */
> +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +			return ret;
> +		} else if (ops->vidioc_s_ext_fmt_vid_out) {
> +			return v4l_s_fmt_ext_pix(ops, file, fh, arg);
> +		}
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> -		if (unlikely(!ops->vidioc_s_fmt_vid_out_mplane))
> -			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> -		for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> -			CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> -					  bytesperline);
> -		return ops->vidioc_s_fmt_vid_out_mplane(file, fh, arg);
> +		if (ops->vidioc_s_fmt_vid_out_mplane) {
> +			CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> +			for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> +				CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> +						  bytesperline);
> +			return ops->vidioc_s_fmt_vid_out_mplane(file, fh, arg);
> +		} else if (ops->vidioc_s_ext_fmt_vid_out) {
> +			return v4l_s_fmt_ext_pix(ops, file, fh, arg);
> +		}
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>  		if (unlikely(!ops->vidioc_s_fmt_vid_out_overlay))
>  			break;
> @@ -1638,6 +2044,84 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>  	return -EINVAL;
>  }
>  
> +static int v4l_s_ext_fmt(const struct v4l2_ioctl_ops *ops,
> +			 struct file *file, void *fh, void *arg)
> +{
> +	struct video_device *vfd = video_devdata(file);
> +	struct v4l2_ext_format *ef = arg;
> +	struct v4l2_format f;
> +	int ret;
> +
> +	ret = check_fmt(file, ef->type);
> +	if (ret)
> +		return ret;
> +
> +	switch (ef->type) {
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +		if (ops->vidioc_s_ext_fmt_vid_cap)
> +			return ops->vidioc_s_ext_fmt_vid_cap(file, fh,
> +							     &ef->fmt.pix);
> +		break;
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +		if (ops->vidioc_s_ext_fmt_vid_out)
> +			return ops->vidioc_s_ext_fmt_vid_out(file, fh,
> +							     &ef->fmt.pix);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	ret = v4l2_ext_format_to_format(ef, &f,
> +					vfd->device_caps &
> +					(V4L2_CAP_VIDEO_CAPTURE_MPLANE |
> +					 V4L2_CAP_VIDEO_OUTPUT_MPLANE |
> +					 V4L2_CAP_VIDEO_M2M_MPLANE),
> +					false);
> +	if (ret)
> +		return ret;
> +
> +	ret = v4l_s_fmt(ops, file, fh, &f);
> +	if (ret)
> +		return ret;
> +
> +	return v4l2_format_to_ext_format(&f, ef, true);
> +}
> +
> +static int v4l_try_fmt_ext_pix(const struct v4l2_ioctl_ops *ops,
> +			       struct file *file, void *fh,
> +			       struct v4l2_format *f)
> +{
> +	struct v4l2_ext_format ef;
> +	int ret;
> +
> +	ret = v4l2_format_to_ext_format(f, &ef, false);
> +	if (ret)
> +		return ret;
> +
> +	switch (f->type) {
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> +		ret = ops->vidioc_try_ext_fmt_vid_cap(file, fh, &ef.fmt.pix);
> +		break;
> +
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> +		ret = ops->vidioc_try_ext_fmt_vid_out(file, fh, &ef.fmt.pix);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	return v4l2_ext_format_to_format(&ef, f,
> +					 V4L2_TYPE_IS_MULTIPLANAR(f->type),
> +					 true);
> +
> +}
> +
>  static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>  				struct file *file, void *fh, void *arg)
>  {
> @@ -1652,21 +2136,27 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>  
>  	switch (p->type) {
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> -		if (unlikely(!ops->vidioc_try_fmt_vid_cap))
> -			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix);
> -		ret = ops->vidioc_try_fmt_vid_cap(file, fh, arg);
> -		/* just in case the driver zeroed it again */
> -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> -		return ret;
> +		if (ops->vidioc_try_fmt_vid_cap) {
> +			CLEAR_AFTER_FIELD(p, fmt.pix);
> +			ret = ops->vidioc_try_fmt_vid_cap(file, fh, arg);
> +			/* just in case the driver zeroed it again */
> +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +			return ret;
> +		} else if (ops->vidioc_try_ext_fmt_vid_cap) {
> +			return v4l_try_fmt_ext_pix(ops, file, fh, p);
> +		}
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> -		if (unlikely(!ops->vidioc_try_fmt_vid_cap_mplane))
> -			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> -		for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> -			CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> -					  bytesperline);
> -		return ops->vidioc_try_fmt_vid_cap_mplane(file, fh, arg);
> +		if (ops->vidioc_try_fmt_vid_cap_mplane) {
> +			CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> +			for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> +				CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> +						  bytesperline);
> +			return ops->vidioc_try_fmt_vid_cap_mplane(file, fh, arg);
> +		} else if (ops->vidioc_try_ext_fmt_vid_cap) {
> +			return v4l_try_fmt_ext_pix(ops, file, fh, p);
> +		}
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>  		if (unlikely(!ops->vidioc_try_fmt_vid_overlay))
>  			break;
> @@ -1683,21 +2173,27 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>  		CLEAR_AFTER_FIELD(p, fmt.sliced);
>  		return ops->vidioc_try_fmt_sliced_vbi_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> -		if (unlikely(!ops->vidioc_try_fmt_vid_out))
> -			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix);
> -		ret = ops->vidioc_try_fmt_vid_out(file, fh, arg);
> -		/* just in case the driver zeroed it again */
> -		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> -		return ret;
> +		if (ops->vidioc_try_fmt_vid_out) {
> +			CLEAR_AFTER_FIELD(p, fmt.pix);
> +			ret = ops->vidioc_try_fmt_vid_out(file, fh, arg);
> +			/* just in case the driver zeroed it again */
> +			p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
> +			return ret;
> +		} else if (ops->vidioc_try_ext_fmt_vid_cap) {
> +			return v4l_try_fmt_ext_pix(ops, file, fh, p);
> +		}
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> -		if (unlikely(!ops->vidioc_try_fmt_vid_out_mplane))
> -			break;
> -		CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> -		for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> -			CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> -					  bytesperline);
> -		return ops->vidioc_try_fmt_vid_out_mplane(file, fh, arg);
> +		if (ops->vidioc_try_fmt_vid_out_mplane) {
> +			CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
> +			for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
> +				CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
> +						  bytesperline);
> +			return ops->vidioc_try_fmt_vid_out_mplane(file, fh, arg);
> +		} else if (ops->vidioc_try_ext_fmt_vid_cap) {
> +			return v4l_try_fmt_ext_pix(ops, file, fh, p);
> +		}
> +		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>  		if (unlikely(!ops->vidioc_try_fmt_vid_out_overlay))
>  			break;
> @@ -1737,6 +2233,49 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>  	return -EINVAL;
>  }
>  
> +static int v4l_try_ext_fmt(const struct v4l2_ioctl_ops *ops,
> +			   struct file *file, void *fh, void *arg)
> +{
> +	struct video_device *vfd = video_devdata(file);
> +	struct v4l2_ext_format *ef = arg;
> +	struct v4l2_format f;
> +	int ret;
> +
> +	ret = check_fmt(file, ef->type);
> +	if (ret)
> +		return ret;
> +
> +	switch (ef->type) {
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +		if (ops->vidioc_try_ext_fmt_vid_cap)
> +			return ops->vidioc_try_ext_fmt_vid_cap(file, fh,
> +							       &ef->fmt.pix);
> +		break;
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +		if (ops->vidioc_try_ext_fmt_vid_out)
> +			return ops->vidioc_try_ext_fmt_vid_out(file, fh,
> +							       &ef->fmt.pix);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	ret = v4l2_ext_format_to_format(ef, &f,
> +					vfd->device_caps &
> +					(V4L2_CAP_VIDEO_CAPTURE_MPLANE |
> +					 V4L2_CAP_VIDEO_OUTPUT_MPLANE |
> +					 V4L2_CAP_VIDEO_M2M_MPLANE),
> +					false);
> +	if (ret)
> +		return ret;
> +
> +	ret = v4l_try_fmt(ops, file, fh, &f);
> +	if (ret)
> +		return ret;
> +
> +	return v4l2_format_to_ext_format(&f, ef, true);
> +}
> +
>  static int v4l_streamon(const struct v4l2_ioctl_ops *ops,
>  				struct file *file, void *fh, void *arg)
>  {
> @@ -2655,7 +3194,9 @@ static const struct v4l2_ioctl_info v4l2_ioctls[] = {
>  	IOCTL_INFO(VIDIOC_QUERYCAP, v4l_querycap, v4l_print_querycap, 0),
>  	IOCTL_INFO(VIDIOC_ENUM_FMT, v4l_enum_fmt, v4l_print_fmtdesc, INFO_FL_CLEAR(v4l2_fmtdesc, type)),
>  	IOCTL_INFO(VIDIOC_G_FMT, v4l_g_fmt, v4l_print_format, 0),
> +	IOCTL_INFO(VIDIOC_G_EXT_FMT, v4l_g_ext_fmt, v4l_print_ext_format, 0),
>  	IOCTL_INFO(VIDIOC_S_FMT, v4l_s_fmt, v4l_print_format, INFO_FL_PRIO),
> +	IOCTL_INFO(VIDIOC_S_EXT_FMT, v4l_s_ext_fmt, v4l_print_ext_format, INFO_FL_PRIO),
>  	IOCTL_INFO(VIDIOC_REQBUFS, v4l_reqbufs, v4l_print_requestbuffers, INFO_FL_PRIO | INFO_FL_QUEUE),
>  	IOCTL_INFO(VIDIOC_QUERYBUF, v4l_querybuf, v4l_print_buffer, INFO_FL_QUEUE | INFO_FL_CLEAR(v4l2_buffer, length)),
>  	IOCTL_INFO(VIDIOC_G_FBUF, v4l_stub_g_fbuf, v4l_print_framebuffer, 0),
> @@ -2702,6 +3243,7 @@ static const struct v4l2_ioctl_info v4l2_ioctls[] = {
>  	IOCTL_INFO(VIDIOC_S_JPEGCOMP, v4l_stub_s_jpegcomp, v4l_print_jpegcompression, INFO_FL_PRIO),
>  	IOCTL_INFO(VIDIOC_QUERYSTD, v4l_querystd, v4l_print_std, 0),
>  	IOCTL_INFO(VIDIOC_TRY_FMT, v4l_try_fmt, v4l_print_format, 0),
> +	IOCTL_INFO(VIDIOC_TRY_EXT_FMT, v4l_try_ext_fmt, v4l_print_ext_format, 0),
>  	IOCTL_INFO(VIDIOC_ENUMAUDIO, v4l_stub_enumaudio, v4l_print_audio, INFO_FL_CLEAR(v4l2_audio, index)),
>  	IOCTL_INFO(VIDIOC_ENUMAUDOUT, v4l_stub_enumaudout, v4l_print_audioout, INFO_FL_CLEAR(v4l2_audioout, index)),
>  	IOCTL_INFO(VIDIOC_G_PRIORITY, v4l_g_priority, v4l_print_u32, 0),
> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
> index 400f2e46c108..a1fb5eac144b 100644
> --- a/include/media/v4l2-ioctl.h
> +++ b/include/media/v4l2-ioctl.h
> @@ -48,11 +48,16 @@ struct v4l2_fh;
>   * @vidioc_g_fmt_vid_cap: pointer to the function that implements
>   *	:ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video capture
>   *	in single plane mode
> + * @vidioc_g_ext_fmt_vid_cap: pointer to the function that implements
> + *	:ref:`VIDIOC_G_EXT_FMT <vidioc_g_ext_fmt>` ioctl logic for video
> + *	capture
>   * @vidioc_g_fmt_vid_overlay: pointer to the function that implements
>   *	:ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>   * @vidioc_g_fmt_vid_out: pointer to the function that implements
>   *	:ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video out
>   *	in single plane mode
> + * @vidioc_g_ext_fmt_vid_out: pointer to the function that implements
> + *	:ref:`VIDIOC_G_EXT_FMT <vidioc_g_ext_fmt>` ioctl logic for video out
>   * @vidioc_g_fmt_vid_out_overlay: pointer to the function that implements
>   *	:ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video overlay output
>   * @vidioc_g_fmt_vbi_cap: pointer to the function that implements
> @@ -82,11 +87,16 @@ struct v4l2_fh;
>   * @vidioc_s_fmt_vid_cap: pointer to the function that implements
>   *	:ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video capture
>   *	in single plane mode
> + * @vidioc_s_ext_fmt_vid_cap: pointer to the function that implements
> + *	:ref:`VIDIOC_S_EXT_FMT <vidioc_s_ext_fmt>` ioctl logic for video
> + *	capture
>   * @vidioc_s_fmt_vid_overlay: pointer to the function that implements
>   *	:ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>   * @vidioc_s_fmt_vid_out: pointer to the function that implements
>   *	:ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video out
>   *	in single plane mode
> + * @vidioc_s_ext_fmt_vid_out: pointer to the function that implements
> + *	:ref:`VIDIOC_S_EXT_FMT <vidioc_g_fmt>` ioctl logic for video out
>   * @vidioc_s_fmt_vid_out_overlay: pointer to the function that implements
>   *	:ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video overlay output
>   * @vidioc_s_fmt_vbi_cap: pointer to the function that implements
> @@ -116,11 +126,16 @@ struct v4l2_fh;
>   * @vidioc_try_fmt_vid_cap: pointer to the function that implements
>   *	:ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video capture
>   *	in single plane mode
> + * @vidioc_try_ext_fmt_vid_cap: pointer to the function that implements
> + *	:ref:`VIDIOC_TRY_EXT_FMT <vidioc_try_ext_fmt>` ioctl logic for video
> +	capture
>   * @vidioc_try_fmt_vid_overlay: pointer to the function that implements
>   *	:ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>   * @vidioc_try_fmt_vid_out: pointer to the function that implements
>   *	:ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video out
>   *	in single plane mode
> + * @vidioc_try_ext_fmt_vid_out: pointer to the function that implements
> + *	:ref:`VIDIOC_TRY_EXT_FMT <vidioc_g_fmt>` ioctl logic for video out
>   * @vidioc_try_fmt_vid_out_overlay: pointer to the function that implements
>   *	:ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>   *	output
> @@ -319,10 +334,14 @@ struct v4l2_ioctl_ops {
>  	/* VIDIOC_G_FMT handlers */
>  	int (*vidioc_g_fmt_vid_cap)(struct file *file, void *fh,
>  				    struct v4l2_format *f);
> +	int (*vidioc_g_ext_fmt_vid_cap)(struct file *file, void *fh,
> +					struct v4l2_ext_pix_format *f);
>  	int (*vidioc_g_fmt_vid_overlay)(struct file *file, void *fh,
>  					struct v4l2_format *f);
>  	int (*vidioc_g_fmt_vid_out)(struct file *file, void *fh,
>  				    struct v4l2_format *f);
> +	int (*vidioc_g_ext_fmt_vid_out)(struct file *file, void *fh,
> +					struct v4l2_ext_pix_format *f);
>  	int (*vidioc_g_fmt_vid_out_overlay)(struct file *file, void *fh,
>  					    struct v4l2_format *f);
>  	int (*vidioc_g_fmt_vbi_cap)(struct file *file, void *fh,
> @@ -349,10 +368,14 @@ struct v4l2_ioctl_ops {
>  	/* VIDIOC_S_FMT handlers */
>  	int (*vidioc_s_fmt_vid_cap)(struct file *file, void *fh,
>  				    struct v4l2_format *f);
> +	int (*vidioc_s_ext_fmt_vid_cap)(struct file *file, void *fh,
> +					struct v4l2_ext_pix_format *f);
>  	int (*vidioc_s_fmt_vid_overlay)(struct file *file, void *fh,
>  					struct v4l2_format *f);
>  	int (*vidioc_s_fmt_vid_out)(struct file *file, void *fh,
>  				    struct v4l2_format *f);
> +	int (*vidioc_s_ext_fmt_vid_out)(struct file *file, void *fh,
> +					struct v4l2_ext_pix_format *f);
>  	int (*vidioc_s_fmt_vid_out_overlay)(struct file *file, void *fh,
>  					    struct v4l2_format *f);
>  	int (*vidioc_s_fmt_vbi_cap)(struct file *file, void *fh,
> @@ -379,10 +402,14 @@ struct v4l2_ioctl_ops {
>  	/* VIDIOC_TRY_FMT handlers */
>  	int (*vidioc_try_fmt_vid_cap)(struct file *file, void *fh,
>  				      struct v4l2_format *f);
> +	int (*vidioc_try_ext_fmt_vid_cap)(struct file *file, void *fh,
> +					  struct v4l2_ext_pix_format *f);
>  	int (*vidioc_try_fmt_vid_overlay)(struct file *file, void *fh,
>  					  struct v4l2_format *f);
>  	int (*vidioc_try_fmt_vid_out)(struct file *file, void *fh,
>  				      struct v4l2_format *f);
> +	int (*vidioc_try_ext_fmt_vid_out)(struct file *file, void *fh,
> +					  struct v4l2_ext_pix_format *f);
>  	int (*vidioc_try_fmt_vid_out_overlay)(struct file *file, void *fh,
>  					     struct v4l2_format *f);
>  	int (*vidioc_try_fmt_vbi_cap)(struct file *file, void *fh,
> @@ -722,4 +749,10 @@ long int video_usercopy(struct file *file, unsigned int cmd,
>  long int video_ioctl2(struct file *file,
>  		      unsigned int cmd, unsigned long int arg);
>  
> +int v4l2_format_to_ext_format(const struct v4l2_format *f,
> +			      struct v4l2_ext_format *e, bool strict);
> +int v4l2_ext_format_to_format(const struct v4l2_ext_format *e,
> +			      struct v4l2_format *f,
> +			      bool mplane_cap, bool strict);
> +
>  #endif /* _V4L2_IOCTL_H */
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 1db220da3bcc..b32c4a10c46f 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -2171,6 +2171,55 @@ struct v4l2_pix_format_mplane {
>  	__u8				reserved[7];
>  } __attribute__ ((packed));
>  
> +/**
> + * struct v4l2_plane_ext_pix_format - additional, per-plane format definition
> + * @sizeimage:		maximum size in bytes required for data, for which
> + *			this plane will be used
> + * @bytesperline:	distance in bytes between the leftmost pixels in two
> + *			adjacent lines
> + */
> +struct v4l2_plane_ext_pix_format {
> +	__u32 sizeimage;
> +	__u32 bytesperline;
> +};
> +
> +/**
> + * struct v4l2_ext_pix_format - extended single/multiplanar format definition
> + * @width: image width in pixels
> + * @height: image height in pixels
> + * @field: enum v4l2_field; field order (for interlaced video)
> + * @pixelformat: little endian four character code (fourcc)
> + * @modifier: modifier applied to the format (used for tiled formats and other
> + *	      kind of HW-specific formats, like compressed formats)
> + * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
> + * @num_planes: number of planes for this format. Should be equal to 1
> + *		for single-planar formats and greater than 1 for
> + *		multiplanar ones
> + * @plane_fmt: per-plane information
> + * @flags: format flags (V4L2_PIX_FMT_FLAG_*)
> + * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
> + * @hsv_enc: enum v4l2_hsv_encoding, HSV encoding
> + * @quantization: enum v4l2_quantization, colorspace quantization
> + * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
> + */
> +struct v4l2_ext_pix_format {
> +	__u32 width;
> +	__u32 height;
> +	__u32 field;
> +	__u32 pixelformat;
> +	__u64 modifier;
> +	__u32 colorspace;
> +	__u32 num_planes;
> +	struct v4l2_plane_ext_pix_format plane_fmt[VIDEO_MAX_PLANES];
> +	__u8 flags;
> +	union {
> +		__u8 ycbcr_enc;
> +		__u8 hsv_enc;
> +	};
> +	__u8 quantization;
> +	__u8 xfer_func;
> +};
> +
>  /**
>   * struct v4l2_sdr_format - SDR format definition
>   * @pixelformat:	little endian four character code (fourcc)
> @@ -2216,6 +2265,35 @@ struct v4l2_format {
>  	} fmt;
>  };
>  
> +/**
> + * struct v4l2_ext_format - extended stream data format
> + * @type: enum v4l2_buf_type; type of the data stream.
> + *	  V4L2_BUF_TYPE_VIDEO[_OUTPUT]_OVERLAY and
> + *	  V4L2_BUF_TYPE_VIDEO_{CAPTURE,OUTPUT}_MPLANE are not supported
> + * @pix: definition of an image format. Used for
> + *	 V4L2_BUF_TYPE_VIDEO_{CAPTURE,OUTPUT} types
> + * @vbi: raw VBI capture or output parameters. Used for
> + *	 V4L2_BUF_TYPE_VBI_{CAPTURE,OUTPUT} types
> + * @sliced: sliced VBI capture or output parameters. Used for
> + *	    V4L2_BUF_TYPE_SLICED_VBI_{CAPTURE,OUTPUT} types.
> + * @sdr: SDR capture or output parameters. Used for
> + *	 V4L2_BUF_TYPE_SDR_{CAPTURE,OUTPUT} types
> + * @meta: meta capture or output parameters. Used for
> + *	  V4L2_BUF_TYPE_META_{CAPTURE,OUTPUT} types
> + * @raw_data: placeholder for future extensions and custom formats
> + */
> +struct v4l2_ext_format {
> +	__u32 type;
> +	union {
> +		struct v4l2_ext_pix_format pix;
> +		struct v4l2_vbi_format vbi;
> +		struct v4l2_sliced_vbi_format sliced;
> +		struct v4l2_sdr_format sdr;
> +		struct v4l2_meta_format meta;
> +		__u8 raw_data[200];
> +	} fmt;
> +};
> +
>  /*	Stream type-dependent parameters
>   */
>  struct v4l2_streamparm {
> @@ -2480,6 +2558,9 @@ struct v4l2_create_buffers {
>  
>  #define VIDIOC_QUERY_EXT_CTRL	_IOWR('V', 103, struct v4l2_query_ext_ctrl)
>  
> +#define VIDIOC_G_EXT_FMT	_IOWR('V', 104, struct v4l2_ext_format)
> +#define VIDIOC_S_EXT_FMT	_IOWR('V', 105, struct v4l2_ext_format)
> +#define VIDIOC_TRY_EXT_FMT	_IOWR('V', 106, struct v4l2_ext_format)
>  /* Reminder: when adding new ioctls please add support for them to
>     drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>  
> 

Regards,

	Hans
