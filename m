Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14901324B3B
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540385; cv=none; b=u90kWyrDeDc48rM/CWPFWIUiRDlYyLaoSSPnKhOVyegyG+vvlmXZ01TuhddUPybqzsLedtuH/F6gm8xGpNcUf88nZmhwk+t1VLtX4/8feXGtr9U/ftkd5d60fydhC/GkbUf6WbNj7stN777qitSIryK8dKAcweNbdJh/EivTGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540385; c=relaxed/simple;
	bh=aqXb+TP1AHAF4kvpnB6W+6ximuq9U6Mt2igRAdwhdy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXPWpX0qRzQGocbVITTUVo6i1ek2CyLHRWuht7BE9HEKaoyRuvSJg/1sHpU6Z0eYQF83q0V4Pwul5ZXfqsdOOyoP/cJUvWJ7o2XHIQ+vfds/oPnPFt9pBEl4WL4QRLDVXujQLLEys8I2TcZiYwwSrsmTfjNAEiuc0QdlrqEjKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hWXnqd5z; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hWXnqd5z"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 23A981419;
	Fri,  7 Nov 2025 19:31:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762540265;
	bh=aqXb+TP1AHAF4kvpnB6W+6ximuq9U6Mt2igRAdwhdy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWXnqd5zqKH/aDKkpS5veqFDNnjcSzy3RmO3Z48Sc5SXpB+kFrxuHpzLo62Xdqbhw
	 Kp3ZJqidjeMDsypqHSujQvusdH+ZtaJ/tghh3zIeRfhm5JD0v0x6xDGSrb7kJ5CJPb
	 h9ccw5bIs01x4H4+xKCTAWI85zR0uPGMpsvQTmRc=
Date: Fri, 7 Nov 2025 20:32:55 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.li@nxp.com>
Cc: linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 2/6] media: imx-mipi-csis: Switch to .enable_streams()
Message-ID: <20251107183255.GD5558@pendragon.ideasonboard.com>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-3-laurent.pinchart@ideasonboard.com>
 <aQ4eaPxL3n1I/95Y@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQ4eaPxL3n1I/95Y@lizhi-Precision-Tower-5810>

On Fri, Nov 07, 2025 at 11:29:28AM -0500, Frank Li wrote:
> On Fri, Nov 07, 2025 at 03:58:09AM +0200, Laurent Pinchart wrote:
> > To prepare for multi-stream support, switch from the legacy .s_stream()
> > operation to the .enable_streams() and .disable_streams() operations.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  drivers/media/platform/nxp/imx-mipi-csis.c | 146 ++++++++++++---------
> >  1 file changed, 87 insertions(+), 59 deletions(-)
> >
> > diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> > index 42b1ec8eed96..f142e79acbcf 100644
> > --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> > +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> > @@ -350,6 +350,7 @@ struct mipi_csis_device {
> >  	struct {
> >  		struct v4l2_subdev *sd;
> >  		const struct media_pad *pad;
> > +		u64 enabled_streams;
> >  	} source;
> >
> >  	struct v4l2_mbus_config_mipi_csi2 bus;
> > @@ -1019,64 +1020,6 @@ static struct mipi_csis_device *sd_to_mipi_csis_device(struct v4l2_subdev *sdev)
> >  	return container_of(sdev, struct mipi_csis_device, sd);
> >  }
> >
> > -static int mipi_csis_s_stream(struct v4l2_subdev *sd, int enable)
> > -{
> > -	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
> > -	const struct v4l2_mbus_framefmt *format;
> > -	const struct csis_pix_format *csis_fmt;
> > -	struct v4l2_subdev_state *state;
> > -	int ret;
> > -
> > -	if (!enable) {
> > -		v4l2_subdev_disable_streams(csis->source.sd,
> > -					    csis->source.pad->index, BIT(0));
> > -
> > -		mipi_csis_stop_stream(csis);
> > -		if (csis->debug.enable)
> > -			mipi_csis_log_counters(csis, true);
> > -
> > -		pm_runtime_put(csis->dev);
> > -
> > -		return 0;
> > -	}
> > -
> > -	state = v4l2_subdev_lock_and_get_active_state(sd);
> > -
> > -	format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
> > -	csis_fmt = find_csis_format(format->code);
> > -
> > -	ret = mipi_csis_calculate_params(csis, csis_fmt);
> > -	if (ret < 0)
> > -		goto err_unlock;
> > -
> > -	mipi_csis_clear_counters(csis);
> > -
> > -	ret = pm_runtime_resume_and_get(csis->dev);
> > -	if (ret < 0)
> > -		goto err_unlock;
> > -
> > -	mipi_csis_start_stream(csis, format, csis_fmt);
> > -
> > -	ret = v4l2_subdev_enable_streams(csis->source.sd,
> > -					 csis->source.pad->index, BIT(0));
> > -	if (ret < 0)
> > -		goto err_stop;
> > -
> > -	mipi_csis_log_counters(csis, true);
> > -
> > -	v4l2_subdev_unlock_state(state);
> > -
> > -	return 0;
> > -
> > -err_stop:
> > -	mipi_csis_stop_stream(csis);
> > -	pm_runtime_put(csis->dev);
> > -err_unlock:
> > -	v4l2_subdev_unlock_state(state);
> > -
> > -	return ret;
> > -}
> > -
> >  static int mipi_csis_enum_mbus_code(struct v4l2_subdev *sd,
> >  				    struct v4l2_subdev_state *state,
> >  				    struct v4l2_subdev_mbus_code_enum *code)
> > @@ -1211,6 +1154,89 @@ static int mipi_csis_get_frame_desc(struct v4l2_subdev *sd, unsigned int pad,
> >  	return 0;
> >  }
> >
> > +static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
> > +				    struct v4l2_subdev_state *state,
> > +				    u32 pad, u64 streams_mask)
> > +{
> > +	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
> > +	u64 sink_streams;
> > +	int ret;
> > +
> > +	sink_streams = v4l2_subdev_state_xlate_streams(state, CSIS_PAD_SOURCE,
> > +						       CSIS_PAD_SINK,
> 
> Original code use hardcode BIT(0), I think keep the same logic with original
> code in this type patch to easy review.
> 
> Add bitmask enabled_streams should be following patch.

It could be moved to patch 6/6, which is where support for multiple
streams is enabled, but I've decided to instead keep it here as 6/6 is
already a bit patch. I also think it's better to handle it all here
instead of doing a partial conversion to .enable_streams(), a
self-contained feature is easier to review than a partial implementation
that then gets fixed in a separate patch.

> > +						       &streams_mask);
> > +	if (!sink_streams || !streams_mask)
> > +		return -EINVAL;
> > +
> > +	/* Start the CSIS with the first stream. */
> > +	if (!csis->source.enabled_streams) {
> > +		const struct v4l2_mbus_framefmt *format;
> > +		const struct csis_pix_format *csis_fmt;
> > +
> > +		format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
> > +		csis_fmt = find_csis_format(format->code);
> > +
> > +		ret = mipi_csis_calculate_params(csis, csis_fmt);
> > +		if (ret)
> > +			return ret;
> > +
> > +		mipi_csis_clear_counters(csis);
> > +
> > +		ret = pm_runtime_resume_and_get(csis->dev);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		mipi_csis_start_stream(csis, format, csis_fmt);
> > +	}
> > +
> > +	ret = v4l2_subdev_enable_streams(csis->source.sd,
> > +					 csis->source.pad->index, sink_streams);
> > +	if (ret) {
> > +		if (!csis->source.enabled_streams) {
> > +			mipi_csis_stop_stream(csis);
> > +			pm_runtime_put(csis->dev);
> > +		}
> > +
> > +		return ret;
> > +	}
> > +
> > +	mipi_csis_log_counters(csis, true);
> > +
> > +	csis->source.enabled_streams |= streams_mask;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mipi_csis_disable_streams(struct v4l2_subdev *sd,
> > +				     struct v4l2_subdev_state *state,
> > +				     u32 pad, u64 streams_mask)
> > +{
> > +	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
> > +	u64 sink_streams;
> > +
> > +	sink_streams = v4l2_subdev_state_xlate_streams(state, CSIS_PAD_SOURCE,
> > +						       CSIS_PAD_SINK,
> > +						       &streams_mask);
> > +	if (!sink_streams || !streams_mask)
> > +		return -EINVAL;
> > +
> > +	v4l2_subdev_disable_streams(csis->source.sd,
> > +				    csis->source.pad->index, sink_streams);
> > +`
> > +	csis->source.enabled_streams &= ~streams_mask;
> > +
> > +	/* Stop the CSIS with the last stream. */
> > +	if (!csis->source.enabled_streams) {
> > +		mipi_csis_stop_stream(csis);
> > +		pm_runtime_put(csis->dev);
> > +
> > +		if (csis->debug.enable)
> > +			mipi_csis_log_counters(csis, true);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mipi_csis_init_state(struct v4l2_subdev *sd,
> >  				struct v4l2_subdev_state *state)
> >  {
> > @@ -1263,7 +1289,7 @@ static const struct v4l2_subdev_core_ops mipi_csis_core_ops = {
> >  };
> >
> >  static const struct v4l2_subdev_video_ops mipi_csis_video_ops = {
> > -	.s_stream	= mipi_csis_s_stream,
> > +	.s_stream		= v4l2_subdev_s_stream_helper,
> >  };
> >
> >  static const struct v4l2_subdev_pad_ops mipi_csis_pad_ops = {
> > @@ -1271,6 +1297,8 @@ static const struct v4l2_subdev_pad_ops mipi_csis_pad_ops = {
> >  	.get_fmt		= v4l2_subdev_get_fmt,
> >  	.set_fmt		= mipi_csis_set_fmt,
> >  	.get_frame_desc		= mipi_csis_get_frame_desc,
> > +	.enable_streams		= mipi_csis_enable_streams,
> > +	.disable_streams	= mipi_csis_disable_streams,
> >  };
> >
> >  static const struct v4l2_subdev_ops mipi_csis_subdev_ops = {

-- 
Regards,

Laurent Pinchart
