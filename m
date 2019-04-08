Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D81C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18842087F
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDHM0u (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:26:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:35621 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfDHM0t (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 08:26:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 05:26:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="133935669"
Received: from troebing-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.249.45.170])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2019 05:26:47 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 4592821E9B; Mon,  8 Apr 2019 15:26:37 +0300 (EEST)
Date:   Mon, 8 Apr 2019 15:26:37 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     bingbu.cao@intel.com
Cc:     linux-media@vger.kernel.org, tfiga@chromium.org,
        bingbu.cao@linux.intel.com, tian.shu.qiu@intel.com
Subject: Re: [PATCH resend v2] media:staging/intel-ipu3: parameter buffer
 refactoring
Message-ID: <20190408122636.jhdywjmwfrabzu4o@kekkonen.localdomain>
References: <1553253285-16023-1-git-send-email-bingbu.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553253285-16023-1-git-send-email-bingbu.cao@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Bingbu,

Thanks for the patch.

On Fri, Mar 22, 2019 at 07:14:45PM +0800, bingbu.cao@intel.com wrote:
> From: Bingbu Cao <bingbu.cao@intel.com>
> 
> Current ImgU driver processes and releases the parameter buffer
> immediately after queued from user. This does not align with other
> image buffers which are grouped in sets and used for the same frame.
> If user queues multiple parameter buffers continuously, only the last
> one will take effect.
> To make consistent buffers usage, this patch changes the parameter
> buffer handling and group parameter buffer with other image buffers
> for each frame.
> Each time driver will queue one more group of buffers when previous
> frame processed and buffers consumed by css.
> 
> Signed-off-by: Tianshu Qiu <tian.shu.qiu@intel.com>
> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> ---
> changes since v1:
> - add payload check for parameter buffer
> - queue buffer only when previous buffer consumed
> ---
>  drivers/staging/media/ipu3/ipu3-css.c  |  5 ----
>  drivers/staging/media/ipu3/ipu3-v4l2.c | 46 ++++++++++++----------------------
>  drivers/staging/media/ipu3/ipu3.c      | 30 ++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/staging/media/ipu3/ipu3-css.c b/drivers/staging/media/ipu3/ipu3-css.c
> index 15ab77e4b766..018f5a266c42 100644
> --- a/drivers/staging/media/ipu3/ipu3-css.c
> +++ b/drivers/staging/media/ipu3/ipu3-css.c
> @@ -2160,11 +2160,6 @@ int imgu_css_set_parameters(struct imgu_css *css, unsigned int pipe,
>  	obgrid_size = imgu_css_fw_obgrid_size(bi);
>  	stripes = bi->info.isp.sp.iterator.num_stripes ? : 1;
>  
> -	/*
> -	 * TODO(b/118782861): If userspace queues more than 4 buffers, the
> -	 * parameters from previous buffers will be overwritten. Fix the driver
> -	 * not to allow this.
> -	 */
>  	imgu_css_pool_get(&css_pipe->pool.parameter_set_info);
>  	param_set = imgu_css_pool_last(&css_pipe->pool.parameter_set_info,
>  				       0)->vaddr;
> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
> index 9c0352b193a7..87a7919c12f0 100644
> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> @@ -341,8 +341,10 @@ static void imgu_vb2_buf_queue(struct vb2_buffer *vb)
>  	struct imgu_video_device *node =
>  		container_of(vb->vb2_queue, struct imgu_video_device, vbq);
>  	unsigned int queue = imgu_node_to_queue(node->id);
> +	struct imgu_buffer *buf = container_of(vb, struct imgu_buffer,
> +					       vid_buf.vbb.vb2_buf);
>  	unsigned long need_bytes;
> -	unsigned int pipe = node->pipe;
> +	unsigned long payload = vb2_get_plane_payload(vb, 0);
>  
>  	if (vb->vb2_queue->type == V4L2_BUF_TYPE_META_CAPTURE ||
>  	    vb->vb2_queue->type == V4L2_BUF_TYPE_META_OUTPUT)
> @@ -350,42 +352,26 @@ static void imgu_vb2_buf_queue(struct vb2_buffer *vb)
>  	else
>  		need_bytes = node->vdev_fmt.fmt.pix_mp.plane_fmt[0].sizeimage;
>  
> -	if (queue == IPU3_CSS_QUEUE_PARAMS) {
> -		unsigned long payload = vb2_get_plane_payload(vb, 0);
> -		struct vb2_v4l2_buffer *buf =
> -			container_of(vb, struct vb2_v4l2_buffer, vb2_buf);
> -		int r = -EINVAL;
> -
> -		if (payload == 0) {
> -			payload = need_bytes;
> -			vb2_set_plane_payload(vb, 0, payload);
> -		}
> -		if (payload >= need_bytes)
> -			r = imgu_css_set_parameters(&imgu->css, pipe,
> -						    vb2_plane_vaddr(vb, 0));
> -		buf->flags = V4L2_BUF_FLAG_DONE;
> -		vb2_buffer_done(vb, r == 0 ? VB2_BUF_STATE_DONE
> -					   : VB2_BUF_STATE_ERROR);
> -
> -	} else {
> -		struct imgu_buffer *buf = container_of(vb, struct imgu_buffer,
> -						       vid_buf.vbb.vb2_buf);
> +	if (queue == IPU3_CSS_QUEUE_PARAMS && payload && payload < need_bytes) {
> +		dev_err(&imgu->pci_dev->dev, "invalid data size for params.");
> +		vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);

This would better be done in buf_prepare callback --- you can return an
error right away then. But it could well be another patch.

> +		return;
> +	}
>  
> -		mutex_lock(&imgu->lock);
> +	mutex_lock(&imgu->lock);
> +	if (queue != IPU3_CSS_QUEUE_PARAMS)
>  		imgu_css_buf_init(&buf->css_buf, queue, buf->map.daddr);
> -		list_add_tail(&buf->vid_buf.list,
> -			      &node->buffers);
> -		mutex_unlock(&imgu->lock);
>  
> -		vb2_set_plane_payload(&buf->vid_buf.vbb.vb2_buf, 0, need_bytes);
> +	list_add_tail(&buf->vid_buf.list, &node->buffers);
> +	mutex_unlock(&imgu->lock);
>  
> -		if (imgu->streaming)
> -			imgu_queue_buffers(imgu, false, pipe);
> -	}
> +	vb2_set_plane_payload(vb, 0, need_bytes);
> +
> +	if (imgu->streaming)
> +		imgu_queue_buffers(imgu, false, node->pipe);
>  
>  	dev_dbg(&imgu->pci_dev->dev, "%s for pipe %d node %d", __func__,
>  		node->pipe, node->id);
> -
>  }
>  
>  static int imgu_vb2_queue_setup(struct vb2_queue *vq,
> diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ipu3/ipu3.c
> index d575ac78c8f0..f1045072d535 100644
> --- a/drivers/staging/media/ipu3/ipu3.c
> +++ b/drivers/staging/media/ipu3/ipu3.c
> @@ -236,6 +236,11 @@ int imgu_queue_buffers(struct imgu_device *imgu, bool initial, unsigned int pipe
>  	dev_dbg(&imgu->pci_dev->dev, "Queue buffers to pipe %d", pipe);
>  	mutex_lock(&imgu->lock);
>  
> +	if (!imgu_css_pipe_queue_empty(&imgu->css, pipe)) {
> +		mutex_unlock(&imgu->lock);
> +		return 0;
> +	}
> +
>  	/* Buffer set is queued to FW only when input buffer is ready */
>  	for (node = IMGU_NODE_NUM - 1;
>  	     imgu_queue_getbuf(imgu, IMGU_NODE_IN, pipe);
> @@ -246,6 +251,31 @@ int imgu_queue_buffers(struct imgu_device *imgu, bool initial, unsigned int pipe
>  			dev_warn(&imgu->pci_dev->dev,
>  				 "Vf not enabled, ignore queue");
>  			continue;
> +		} else if (node == IMGU_NODE_PARAMS &&
> +			   imgu_pipe->nodes[node].enabled) {
> +			struct vb2_buffer *vb;
> +			struct imgu_vb2_buffer *ivb;
> +
> +			/* No parameters for this frame */
> +			if (list_empty(&imgu_pipe->nodes[node].buffers))
> +				continue;
> +
> +			ivb = list_first_entry(&imgu_pipe->nodes[node].buffers,
> +					       struct imgu_vb2_buffer, list);
> +			vb = &ivb->vbb.vb2_buf;
> +			r = imgu_css_set_parameters(&imgu->css, pipe,
> +						    vb2_plane_vaddr(vb, 0));
> +			if (r) {

Ideally the parameters should be validated earlier but I guess it'd take
significant changes to the code handling them, and there are more important
things to do. Just a note.

> +				vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
> +				dev_warn(&imgu->pci_dev->dev,
> +					 "set parameters failed.");
> +				continue;
> +			}
> +
> +			vb2_buffer_done(vb, VB2_BUF_STATE_DONE);
> +			dev_dbg(&imgu->pci_dev->dev,
> +				"queue user parameters %d to css.", vb->index);

%d -> %u.

I can fix that while applying the patch.

> +			list_del(&ivb->list);
>  		} else if (imgu_pipe->queue_enabled[node]) {
>  			struct imgu_css_buffer *buf =
>  				imgu_queue_getbuf(imgu, node, pipe);

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
