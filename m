Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076342248A8;
	Tue,  3 Feb 2026 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155392; cv=none; b=Nw9eSl27NxeGuMvQBwD9VQEe9Zng1zRJK+A7ZoxJBGVwpTPCcqqhiLgn8RNj6PUvvhgbwkrA2D6V/4TEqSD2Ke9zvR/nMqyL2TtQhNxMHT/C/Q0PGW3j3XlhDTUd6Ljvz99e0IJtZOjLlkCPa/NGaMraTdYZQ7BMJEaOJcJF1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155392; c=relaxed/simple;
	bh=vD1zxLgAabWQHbeuPBzsULAz9TNwxWyZwXi+eq9QzW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIJt4zVGPtEfXuPVSm6wYhYMc0k3C06eGCB+6PbkFHg65cTRU+YmsX4BLWJsUWUERSozRzBhl6gXLQHxPaTJirqr4moLc4A815FuQBNAzqwH7bKsDsAGcMfmc9XNOWmlj2CJWDP1vPPaznc8HzLmvBxHtSnourYI+vNVeYbReJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XN+KRGGy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XN+KRGGy"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 98286673;
	Tue,  3 Feb 2026 22:49:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770155347;
	bh=vD1zxLgAabWQHbeuPBzsULAz9TNwxWyZwXi+eq9QzW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XN+KRGGyHqGPLexS58AFbgipNPkpOBPM2Rwm3u5GaL/NLPbJV+z0NI203To47JTG1
	 QPSIFINn8rZtR5YX2xniFh1pM0aANzBNV2jGVyGvE3SGqzlLKCnRTACi1EDbRVvu+L
	 mttpVJqqwzLAnL5CAEMcZAqKuIwuyejHiCLr7LP8=
Date: Tue, 3 Feb 2026 23:49:47 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Gergo Koteles <soyer@irl.hu>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>, linux-media@vger.kernel.org,
	jani.nikula@linux.intel.com, anisse@astier.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: Re: [RFC PATCH] media: Virtual camera driver
Message-ID: <20260203214947.GA133801@killaraus>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <20260203145341.GB33304@killaraus>
 <20260203203648.GA56480@killaraus>
 <6235268.lOV4Wx5bFT@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6235268.lOV4Wx5bFT@natalenko.name>

On Tue, Feb 03, 2026 at 10:39:41PM +0100, Oleksandr Natalenko wrote:
> On úterý 3. února 2026 21:36:48, středoevropský standardní čas Laurent Pinchart wrote:
> > On Tue, Feb 03, 2026 at 04:53:41PM +0200, Laurent Pinchart wrote:
> > > On Tue, Feb 03, 2026 at 03:38:06PM +0100, Oleksandr Natalenko wrote:
> > > > 
> > > > Just to share my current state of affairs:
> > > > 
> > > > * sender:
> > > > 
> > > > $ gst-launch-1.0 pipewiresrc path=<webcam_id> ! video/x-h264, width=1280, height=720, framerate=24/1 ! rtph264pay ! rtpstreampay ! udpsink host=<receiver_host> port=<receiver_port>
> > > > 
> > > > * receiver:
> > > > 
> > > > $ gst-launch-1.0 udpsrc address=<receiver_host> port=<receiver_port> ! queue ! application/x-rtp-stream,encoding-name=H264 ! rtpstreamdepay ! application/x-rtp,encoding-name=H264 ! rtph264depay ! h264parse ! openh264dec ! pipewiresink mode=provide stream-properties="properties,media.class=Video/Source,media.role=Camera" client-name=VirtualCam
> > > > 
> > > > I chose H.264 because of much lower (tenfold) traffic comparing to
> > > > MJPEG, wrapped this into RTP, opted in for OpenH264 decoder because I
> > > > read it was handling low latency streams better than avdec_h264, and
> > > > tested this setup with both Firefox and Chromium, and it actually
> > > > worked pretty reliably, so I'm impressed now.
> > > 
> > > Thank you for the update. I'll give this a try.
> > 
> > I've tried those, but as soon as Firefox is connecting, I get
> > 
> > 0:00:03.569028999 131465 0x7f85cc002030 DEBUG           pipewiresink gstpipewiresink.c:692:on_state_changed:<pipewiresink0> got stream state "error" (-1)
> > 0:00:03.569060959 131465 0x7f85cc002030 DEBUG           pipewiresink gstpipewiresink.c:692:on_state_changed:<pipewiresink0> got stream state "error" (-1)
> > 0:00:03.569070767 131465 0x7f85cc002030 WARN            pipewiresink gstpipewiresink.c:710:on_state_changed:<pipewiresink0> error: stream error: no more input formats
> > ERROR: from element /GstPipeline:pipeline0/GstPipeWireSink:pipewiresink0: stream error: no more input formats
> > Additional debug info:
> > ../pipewire-1.4.9/src/gst/gstpipewiresink.c(710): on_state_changed (): /GstPipeline:pipeline0/GstPipeWireSink:pipewiresink0
> > 
> > Maybe I should try the pipewire master branch.
> 
> I'd be glad to help, but my understanding of this "stream error: no
> more input formats" boils down only to the absence of caps identifiers
> (like those "application/x-rtp-stream"blahblah), which is not the case
> here. Also, Firefox behaves differently from Chrome when using sites
> like webcamtests, and also when using google meet. I may speculate
> Firefox more eagerly closes link to a pipewire node, but I have no
> knowledge of this at all.

No worries. I'll try to find time to investigate.

> That said, "pretty reliably" doesn't mean without issues whatsoever,
> and I manage to crash both Chrome and Firefox from time to time while
> experimenting with pipelines. Probably because I occasionally
> unintentionally feed some crap into the pipewire sink.

I wouldn't dare claiming it's perfect :-) But the projects are actively
developed, so I have good hopes issues will be fixed quickly (as long as
they're reported of course).

> FWIW, I'm using 1:1.4.10-2 pipewire packages from Arch.

I'm running 1.4.9 from Gentoo, I think I should upgrade.

-- 
Regards,

Laurent Pinchart
