Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA61CC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 08:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BA42083E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 08:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDLIZb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:25:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33462 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfDLIZb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 04:25:31 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9AAAD260614;
        Fri, 12 Apr 2019 09:25:29 +0100 (BST)
Date:   Fri, 12 Apr 2019 10:25:26 +0200
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
Message-ID: <20190412102526.53de44ee@collabora.com>
In-Reply-To: <6f8ec61c-1f36-accb-cc00-984d1041aa28@xs4all.nl>
References: <20190404081700.30006-1-boris.brezillon@collabora.com>
        <20190404081700.30006-2-boris.brezillon@collabora.com>
        <c13c2c30-f78e-1cf2-26d3-1554e22947c3@xs4all.nl>
        <20190411123636.07990b79@collabora.com>
        <6f8ec61c-1f36-accb-cc00-984d1041aa28@xs4all.nl>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 11 Apr 2019 12:38:06 +0200
Hans Verkuil <hverkuil@xs4all.nl> wrote:

> >>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> >>> index f6d663934648..97ba365218fb 100644
> >>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >>> @@ -1380,6 +1380,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> >>>  static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
> >>>  				struct file *file, void *fh, void *arg)
> >>>  {
> >>> +	struct video_device *vdev = video_devdata(file);
> >>>  	struct v4l2_fmtdesc *p = arg;
> >>>  	int ret = check_fmt(file, p->type);
> >>>  
> >>> @@ -1389,30 +1390,30 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
> >>>  
> >>>  	switch (p->type) {
> >>>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> >>> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> >>> +		if (!!(vdev->device_caps & V4L2_CAP_VIDEO_CAPTURE_MPLANE) !=    
> >>
> >> Hmm. I am not sure if all drivers that set V4L2_CAP_VIDEO_CAPTURE_MPLANE also
> >> fill in vdev->device_caps. While filling in vdev->device_caps is required for
> >> new drivers, older drivers often don't do this.
> >>
> >> You would have to check all drivers that set V4L2_CAP_VIDEO_CAPTURE/OUTPUT_MPLANE
> >> to verify that they also set vdev->device_caps. I'm fairly certain the Samsung
> >> drivers don't fill this in.  
> > 
> > I'll check that and fix those that don't set the flag. Or do you have
> > another solution to handle that case?
> >   
> 
> There might be other solutions as well, but regardless of that it would be a very
> good idea for other reasons as well if all MPLANE drivers would fill in vdev->device_caps.

Looks like all drivers except fimc-isp-video.c have the _MPLANE caps
properly set/reported.
