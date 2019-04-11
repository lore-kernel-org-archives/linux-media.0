Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E4C10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 10:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F8F2084D
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 10:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDKKgn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:36:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKKgn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 06:36:43 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A42D1281A28;
        Thu, 11 Apr 2019 11:36:39 +0100 (BST)
Date:   Thu, 11 Apr 2019 12:36:36 +0200
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
Subject: Re: [RFC PATCH v2 1/7] media: v4l2: Get rid of
 ->vidioc_enum_fmt_vid_{cap,out}_mplane
Message-ID: <20190411123636.07990b79@collabora.com>
In-Reply-To: <c13c2c30-f78e-1cf2-26d3-1554e22947c3@xs4all.nl>
References: <20190404081700.30006-1-boris.brezillon@collabora.com>
        <20190404081700.30006-2-boris.brezillon@collabora.com>
        <c13c2c30-f78e-1cf2-26d3-1554e22947c3@xs4all.nl>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 11 Apr 2019 09:59:19 +0200
Hans Verkuil <hverkuil@xs4all.nl> wrote:

> On 4/4/19 10:16 AM, Boris Brezillon wrote:
> > Support for multiplanar and singleplanar formats is mutually exclusive,
> > at least in practice. In our attempt to unify support for support for
> > mplane and !mplane in v4l, let's get rid of the  
> > ->vidioc_enum_fmt_{vid,out}_cap_mplane() hooks and call
> > ->vidioc_enum_fmt_{vid,out}_cap() instead.  
> 
> This is a good idea. This can be done separately from the other patches in
> this series and merged.

Sure, I'll send this patch separately.

> 
> One comment...
> 
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> > Changes in v2:
> > - None
> > ---
> >  drivers/media/pci/intel/ipu3/ipu3-cio2.c      |  2 +-
> >  drivers/media/platform/exynos-gsc/gsc-m2m.c   |  4 ++--
> >  .../media/platform/exynos4-is/fimc-capture.c  |  2 +-
> >  .../platform/exynos4-is/fimc-isp-video.c      |  2 +-
> >  drivers/media/platform/exynos4-is/fimc-lite.c |  2 +-
> >  drivers/media/platform/exynos4-is/fimc-m2m.c  |  4 ++--
> >  .../media/platform/mtk-jpeg/mtk_jpeg_core.c   |  4 ++--
> >  drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c  |  4 ++--
> >  .../platform/mtk-vcodec/mtk_vcodec_dec.c      |  4 ++--
> >  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  4 ++--
> >  .../media/platform/qcom/camss/camss-video.c   |  2 +-
> >  drivers/media/platform/qcom/venus/vdec.c      |  4 ++--
> >  drivers/media/platform/qcom/venus/venc.c      |  4 ++--
> >  drivers/media/platform/rcar_fdp1.c            |  4 ++--
> >  drivers/media/platform/rcar_jpu.c             |  4 ++--
> >  drivers/media/platform/renesas-ceu.c          |  2 +-
> >  drivers/media/platform/s5p-mfc/s5p_mfc_dec.c  |  4 ++--
> >  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  |  4 ++--
> >  drivers/media/platform/ti-vpe/vpe.c           |  4 ++--
> >  drivers/media/platform/vicodec/vicodec-core.c |  2 --
> >  drivers/media/platform/vivid/vivid-core.c     |  6 ++----
> >  .../media/platform/vivid/vivid-vid-common.c   | 20 ------------------
> >  .../media/platform/vivid/vivid-vid-common.h   |  2 --
> >  drivers/media/v4l2-core/v4l2-dev.c            |  2 --
> >  drivers/media/v4l2-core/v4l2-ioctl.c          | 21 ++++++++++---------
> >  drivers/staging/media/ipu3/ipu3-v4l2.c        |  4 ++--
> >  .../media/rockchip/vpu/rockchip_vpu_enc.c     |  4 ++--
> >  include/media/v4l2-ioctl.h                    | 14 ++-----------
> >  28 files changed, 51 insertions(+), 88 deletions(-)
> > 
> > diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> > index f8020ebe9f05..c3b3af3c3b2f 100644
> > --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> > +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> > @@ -1174,7 +1174,7 @@ static const struct v4l2_file_operations cio2_v4l2_fops = {
> >  
> >  static const struct v4l2_ioctl_ops cio2_v4l2_ioctl_ops = {
> >  	.vidioc_querycap = cio2_v4l2_querycap,
> > -	.vidioc_enum_fmt_vid_cap_mplane = cio2_v4l2_enum_fmt,
> > +	.vidioc_enum_fmt_vid_cap = cio2_v4l2_enum_fmt,
> >  	.vidioc_g_fmt_vid_cap_mplane = cio2_v4l2_g_fmt,
> >  	.vidioc_s_fmt_vid_cap_mplane = cio2_v4l2_s_fmt,
> >  	.vidioc_try_fmt_vid_cap_mplane = cio2_v4l2_try_fmt,
> > diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> > index c757f5d98bcc..9e2914d3d8f9 100644
> > --- a/drivers/media/platform/exynos-gsc/gsc-m2m.c
> > +++ b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> > @@ -562,8 +562,8 @@ static int gsc_m2m_s_selection(struct file *file, void *fh,
> >  
> >  static const struct v4l2_ioctl_ops gsc_m2m_ioctl_ops = {
> >  	.vidioc_querycap		= gsc_m2m_querycap,
> > -	.vidioc_enum_fmt_vid_cap_mplane	= gsc_m2m_enum_fmt_mplane,
> > -	.vidioc_enum_fmt_vid_out_mplane	= gsc_m2m_enum_fmt_mplane,
> > +	.vidioc_enum_fmt_vid_cap	= gsc_m2m_enum_fmt_mplane,
> > +	.vidioc_enum_fmt_vid_out	= gsc_m2m_enum_fmt_mplane,  
> 
> Please rename the functions as well, dropping the _mplane suffix. Here and in
> the other drivers.
> 

Okay, I'm remove those _mplane suffix.

> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > index f6d663934648..97ba365218fb 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1380,6 +1380,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> >  static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
> >  				struct file *file, void *fh, void *arg)
> >  {
> > +	struct video_device *vdev = video_devdata(file);
> >  	struct v4l2_fmtdesc *p = arg;
> >  	int ret = check_fmt(file, p->type);
> >  
> > @@ -1389,30 +1390,30 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
> >  
> >  	switch (p->type) {
> >  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> > +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> > +		if (!!(vdev->device_caps & V4L2_CAP_VIDEO_CAPTURE_MPLANE) !=  
> 
> Hmm. I am not sure if all drivers that set V4L2_CAP_VIDEO_CAPTURE_MPLANE also
> fill in vdev->device_caps. While filling in vdev->device_caps is required for
> new drivers, older drivers often don't do this.
> 
> You would have to check all drivers that set V4L2_CAP_VIDEO_CAPTURE/OUTPUT_MPLANE
> to verify that they also set vdev->device_caps. I'm fairly certain the Samsung
> drivers don't fill this in.

I'll check that and fix those that don't set the flag. Or do you have
another solution to handle that case?

