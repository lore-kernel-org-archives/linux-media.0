Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61385C10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD6E20833
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDIMBQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:01:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:7973 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfDIMBQ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 9 Apr 2019 08:01:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 05:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="132735658"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008.jf.intel.com with ESMTP; 09 Apr 2019 05:01:14 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 5DA03208C6; Tue,  9 Apr 2019 15:01:13 +0300 (EEST)
Date:   Tue, 9 Apr 2019 15:01:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     linux-media@vger.kernel.org, bingbu.cao@intel.com
Subject: Re: [PATCH 1/1] ipu3-imgu: Use %u for formatting unsigned values
 (not %d)
Message-ID: <20190409120112.hyc54mi6oq2g75eb@paasikivi.fi.intel.com>
References: <20190409101810.17002-1-sakari.ailus@linux.intel.com>
 <c1660ddd-2ecb-eed1-9d95-514e30ff5465@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1660ddd-2ecb-eed1-9d95-514e30ff5465@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Bingbu,

On Tue, Apr 09, 2019 at 07:09:09PM +0800, Bingbu Cao wrote:
> 
> On 4/9/19 6:18 PM, Sakari Ailus wrote:
> > The driver used %d for formatting unsigned values. Use %u instead.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/staging/media/ipu3/ipu3-v4l2.c | 40 +++++++++++++++++-----------------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
> > index be818c29620f..3bb08af83dfe 100644
> > --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> > +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> > @@ -66,7 +66,7 @@ static int imgu_subdev_s_stream(struct v4l2_subdev *sd, int enable)
> >  	struct imgu_css_pipe *css_pipe = &imgu->css.pipes[pipe];
> >  	struct imgu_media_pipe *imgu_pipe = &imgu->imgu_pipe[pipe];
> >  
> > -	dev_dbg(dev, "%s %d for pipe %d", __func__, enable, pipe);
> > +	dev_dbg(dev, "%s %d for pipe %u", __func__, enable, pipe);
> >  	/* grab ctrl after streamon and return after off */
> >  	v4l2_ctrl_grab(imgu_sd->ctrl, enable);
> >  
> > @@ -101,7 +101,7 @@ static int imgu_subdev_s_stream(struct v4l2_subdev *sd, int enable)
> >  	else
> >  		css_pipe->pipe_id = IPU3_CSS_PIPE_ID_CAPTURE;
> >  
> > -	dev_dbg(dev, "IPU3 pipe %d pipe_id %d", pipe, css_pipe->pipe_id);
> > +	dev_dbg(dev, "IPU3 pipe %u pipe_id %u", pipe, css_pipe->pipe_id);
> >  
> >  	rects[IPU3_CSS_RECT_EFFECTIVE] = &imgu_sd->rect.eff;
> >  	rects[IPU3_CSS_RECT_BDS] = &imgu_sd->rect.bds;
> > @@ -109,7 +109,7 @@ static int imgu_subdev_s_stream(struct v4l2_subdev *sd, int enable)
> >  
> >  	r = imgu_css_fmt_set(&imgu->css, fmts, rects, pipe);
> >  	if (r) {
> > -		dev_err(dev, "failed to set initial formats pipe %d with (%d)",
> > +		dev_err(dev, "failed to set initial formats pipe %u with (%d)",
> >  			pipe, r);
> >  		return r;
> >  	}
> > @@ -157,7 +157,7 @@ static int imgu_subdev_set_fmt(struct v4l2_subdev *sd,
> >  	u32 pad = fmt->pad;
> >  	unsigned int pipe = imgu_sd->pipe;
> >  
> > -	dev_dbg(&imgu->pci_dev->dev, "set subdev %d pad %d fmt to [%dx%d]",
> > +	dev_dbg(&imgu->pci_dev->dev, "set subdev %u pad %u fmt to [%ux%u]",
> >  		pipe, pad, fmt->format.width, fmt->format.height);
> >  
> >  	imgu_pipe = &imgu->imgu_pipe[pipe];
> > @@ -233,7 +233,7 @@ static int imgu_subdev_set_selection(struct v4l2_subdev *sd,
> >  	struct v4l2_rect *rect, *try_sel;
> >  
> >  	dev_dbg(&imgu->pci_dev->dev,
> > -		 "set subdev %d sel which %d target 0x%4x rect [%dx%d]",
> > +		 "set subdev %u sel which %u target 0x%4x rect [%ux%u]",
> >  		 imgu_sd->pipe, sel->which, sel->target,
> >  		 sel->r.width, sel->r.height);
> >  
> > @@ -279,7 +279,7 @@ static int imgu_link_setup(struct media_entity *entity,
> >  
> >  	WARN_ON(pad >= IMGU_NODE_NUM);
> >  
> > -	dev_dbg(&imgu->pci_dev->dev, "pipe %d pad %d is %s", pipe, pad,
> > +	dev_dbg(&imgu->pci_dev->dev, "pipe %u pad %u is %s", pipe, pad,
> >  		 flags & MEDIA_LNK_FL_ENABLED ? "enabled" : "disabled");
> >  
> >  	imgu_pipe = &imgu->imgu_pipe[pipe];
> > @@ -294,7 +294,7 @@ static int imgu_link_setup(struct media_entity *entity,
> >  	else
> >  		__clear_bit(pipe, imgu->css.enabled_pipes);
> >  
> > -	dev_dbg(&imgu->pci_dev->dev, "pipe %d is %s", pipe,
> > +	dev_dbg(&imgu->pci_dev->dev, "pipe %u is %s", pipe,
> >  		 flags & MEDIA_LNK_FL_ENABLED ? "enabled" : "disabled");
> >  
> >  	return 0;
> > @@ -370,7 +370,7 @@ static void imgu_vb2_buf_queue(struct vb2_buffer *vb)
> >  	if (imgu->streaming)
> >  		imgu_queue_buffers(imgu, false, node->pipe);
> >  
> > -	dev_dbg(&imgu->pci_dev->dev, "%s for pipe %d node %d", __func__,
> > +	dev_dbg(&imgu->pci_dev->dev, "%s for pipe %u node %u", __func__,
> >  		node->pipe, node->id);
> >  }
> >  
> > @@ -421,7 +421,7 @@ static bool imgu_all_nodes_streaming(struct imgu_device *imgu,
> >  	pipe = except->pipe;
> >  	if (!test_bit(pipe, imgu->css.enabled_pipes)) {
> >  		dev_warn(&imgu->pci_dev->dev,
> > -			 "pipe %d link is not ready yet", pipe);
> > +			 "pipe %ulink is not ready yet", pipe);
> Hi, Sakari,
> 
> A missing space here, other looks good for me.
> Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>

I added the space when applying the patch. Thanks for the review!

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
