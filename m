Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B30C10F03
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BE2214AE
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfDYIPx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:15:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60952 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfDYIPx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 04:15:53 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A137E27078D;
        Thu, 25 Apr 2019 09:15:49 +0100 (BST)
Date:   Thu, 25 Apr 2019 10:15:46 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v4 00/21] Add MPEG-2 decoding to Rockchip VPU
Message-ID: <20190425101546.5f3f8044@collabora.com>
In-Reply-To: <20190425100628.6f8e5894@collabora.com>
References: <20190425071242.18315-1-boris.brezillon@collabora.com>
        <20190425100628.6f8e5894@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 25 Apr 2019 10:06:28 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Thu, 25 Apr 2019 09:12:21 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > This series introduces the decoding infrastructure that will be
> > used to add support for other codecs such as VP8, VP9 and H.264.
> > 
> > As explained in the cover letter for the v1 patchset,
> > the driver is now exposing two video device nodes.
> > The VPU encoder is exposed on /dev/video0, and the VPU decoder
> > is exposed on /dev/video1. Both devices are tied to the same
> > memory-to-memory queue, and same media device /dev/media0.
> > 
> > Therefore there are two media graphs:
> > 
> > ┌────────────────────────────────┐
> > │ rockchip,rk3399-vpu-enc-source │
> > │          /dev/video0           │
> > └────────────────────────────────┘
> >   ┃
> >   ┃
> >   ▼
> > ┌────────────────────────────────┐
> > │  rockchip,rk3399-vpu-enc-proc  │
> > └────────────────────────────────┘
> >   ┃
> >   ┃
> >   ▼
> > ┌────────────────────────────────┐
> > │  rockchip,rk3399-vpu-enc-sink  │
> > │          /dev/video0           │
> > └────────────────────────────────┘
> > 
> > ┌────────────────────────────────┐
> > │ rockchip,rk3399-vpu-dec-source │
> > │          /dev/video1           │
> > └────────────────────────────────┘
> >   ┃
> >   ┃
> >   ▼
> > ┌────────────────────────────────┐
> > │  rockchip,rk3399-vpu-dec-proc  │
> > └────────────────────────────────┘
> >   ┃
> >   ┃
> >   ▼
> > ┌────────────────────────────────┐
> > │  rockchip,rk3399-vpu-dec-sink  │
> > │          /dev/video1           │
> > └────────────────────────────────┘
> > 
> > Of course, this work has been possible thanks to Jonas Karlman, who did
> > the initial MPEG-2 decoding work and also got mpv+ffmpeg working using
> > the Request API.  
> 
> Forgot to provide the v4l2-compliance results, so here it is:
> 
> "
> v4l2-compliance SHA: 95f39aae48c6e8e5cc81e6ae6293d999f70a909b, 64 bits
> 
> Compliance test for rockchip-vpu device /dev/media0:
> 
> Media Driver Info:
> 	Driver name      : rockchip-vpu
> 	Model            : rockchip-vpu
> 	Serial           : 
> 	Bus info         : platform: rockchip-vpu
> 	Media version    : 5.1.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 5.1.0
> 
> Required ioctls:
> 	test MEDIA_IOC_DEVICE_INFO: OK
> 
> Allow for multiple opens:
> 	test second /dev/media0 open: OK
> 	test MEDIA_IOC_DEVICE_INFO: OK
> 	test for unlimited opens: OK
> 
> Media Controller ioctls:
> 	test MEDIA_IOC_G_TOPOLOGY: OK
> 	Entities: 6 Interfaces: 2 Pads: 8 Links: 8
> 	test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
> 	test MEDIA_IOC_SETUP_LINK: OK
> 
> Total for rockchip-vpu device /dev/media0: 7, Succeeded: 7, Failed: 0, Warnings: 0
> --------------------------------------------------------------------------------
> Compliance test for rockchip-vpu device /dev/video0:
> 
> Driver Info:
> 	Driver name      : rockchip-vpu
> 	Card type        : rockchip,rk3399-vpu-enc
> 	Bus info         : platform: rockchip-vpu
> 	Driver version   : 5.1.0
> 	Capabilities     : 0x84204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 	Detected JPEG Encoder
> Media Driver Info:
> 	Driver name      : rockchip-vpu
> 	Model            : rockchip-vpu
> 	Serial           : 
> 	Bus info         : platform: rockchip-vpu
> 	Media version    : 5.1.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 5.1.0
> Interface Info:
> 	ID               : 0x0300000c
> 	Type             : V4L Video
> Entity Info:
> 	ID               : 0x00000001 (1)
> 	Name             : rockchip,rk3399-vpu-enc-source
> 	Function         : V4L2 I/O
> 	Pad 0x01000002   : 0: Source
> 	  Link 0x02000008: to remote pad 0x1000005 of entity 'rockchip,rk3399-vpu-enc-proc': Data, Enabled, Immutable
> 
> Required ioctls:
> 	test MC information (see 'Media Driver Info' above): OK
> 	test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
> 	test second /dev/video0 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 2 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK (Not Supported)
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 	test VIDIOC_S_FMT: OK
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
> 		fail: v4l2-test-buffers.cpp(709): q.create_bufs(node, 1, &fmt) != EINVAL
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL
> 	test VIDIOC_EXPBUF: OK
> testRequests:1760 ret 0
> 		fail: v4l2-test-buffers.cpp(1820): !supports_requests
> 	test Requests: FAIL
> 
> Total for rockchip-vpu device /dev/video0: 45, Succeeded: 43, Failed: 2, Warnings: 0
> --------------------------------------------------------------------------------
> Compliance test for rockchip-vpu device /dev/video1:
> 
> Driver Info:
> 	Driver name      : rockchip-vpu
> 	Card type        : rockchip,rk3399-vpu-dec
> 	Bus info         : platform: rockchip-vpu
> 	Driver version   : 5.1.0
> 	Capabilities     : 0x84204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 		Device Capabilities
> 	Device Caps      : 0x04204000
> 		Video Memory-to-Memory Multiplanar
> 		Streaming
> 		Extended Pix Format
> 	Detected Stateless Decoder
> Media Driver Info:
> 	Driver name      : rockchip-vpu
> 	Model            : rockchip-vpu
> 	Serial           : 
> 	Bus info         : platform: rockchip-vpu
> 	Media version    : 5.1.0
> 	Hardware revision: 0x00000000 (0)
> 	Driver version   : 5.1.0
> Interface Info:
> 	ID               : 0x0300001a
> 	Type             : V4L Video
> Entity Info:
> 	ID               : 0x0000000f (15)
> 	Name             : rockchip,rk3399-vpu-dec-source
> 	Function         : V4L2 I/O
> 	Pad 0x01000010   : 0: Source
> 	  Link 0x02000016: to remote pad 0x1000013 of entity 'rockchip,rk3399-vpu-dec-proc': Data, Enabled, Immutable
> 
> Required ioctls:
> 	test MC information (see 'Media Driver Info' above): OK
> 	test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
> 	test second /dev/video1 open: OK
> 	test VIDIOC_QUERYCAP: OK
> 	test VIDIOC_G/S_PRIORITY: OK
> 	test for unlimited opens: OK
> 
> Debug ioctls:
> 	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> 	test VIDIOC_LOG_STATUS: OK (Not Supported)
> 
> Input ioctls:
> 	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> 	test VIDIOC_ENUMAUDIO: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDIO: OK (Not Supported)
> 	Inputs: 0 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
> 	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> 	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> 	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> 	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> 	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> 	Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
> 	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> 	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> 	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> 	test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls:
> 	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> 	test VIDIOC_QUERYCTRL: OK
> 	test VIDIOC_G/S_CTRL: OK
> 		fail: v4l2-test-controls.cpp(673): try_ext_ctrls returned an error (22)
> 	test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> 	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> 	Standard Controls: 2 Private Controls: 0
> 
> Format ioctls:
> 	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> 	test VIDIOC_G/S_PARM: OK (Not Supported)
> 	test VIDIOC_G_FBUF: OK (Not Supported)
> 	test VIDIOC_G_FMT: OK
> 	test VIDIOC_TRY_FMT: OK
> 		fail: v4l2-test-formats.cpp(806): fmt_cap.g_colorspace() != col
> 	test VIDIOC_S_FMT: FAIL
> 	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> 	test Cropping: OK (Not Supported)
> 	test Composing: OK (Not Supported)
> 	test Scaling: OK
> 
> Codec ioctls:
> 	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> 	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> 	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls:
> 		fail: v4l2-test-buffers.cpp(709): q.create_bufs(node, 1, &fmt) != EINVAL
> 	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL
> 	test VIDIOC_EXPBUF: OK
> 	test Requests: OK (Not Supported)
> 
> Total for rockchip-vpu device /dev/video1: 45, Succeeded: 42, Failed: 3, Warnings: 0
> 
> Grand Total for rockchip-vpu device /dev/media0: 97, Succeeded: 92, Failed: 5, Warnings: 0
> 
> "
> 
> 2 of those failures are expected: 
> 
> * "fail: v4l2-test-formats.cpp(806): fmt_cap.g_colorspace() != col": is caused
>   by the reset done by the driver on the non-coded end when the coded end of
>   the pipeline is modified (which follows the behavior described in stateless
>   decoder spec)
> 
> * "fail: v4l2-test-controls.cpp(673): try_ext_ctrls returned an error (22)":
>   default values for mpeg2 ctrls are not suitable, so doing
>   get_ext_ctrl()+try_ext_ctrl() does not work.
> 
> I'm looking into the other failures which were not present in v3 (yes, I
> know, shame on me for not running v4l2-compliance before sending the series :-)).

Rectification, after booting the right kernel those new errors are gone,
sorry for the noise:

v4l2-compliance SHA: 95f39aae48c6e8e5cc81e6ae6293d999f70a909b, 64 bits

Compliance test for rockchip-vpu device /dev/media0:

Media Driver Info:
	Driver name      : rockchip-vpu
	Model            : rockchip-vpu
	Serial           : 
	Bus info         : platform: rockchip-vpu
	Media version    : 5.1.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 5.1.0

Required ioctls:
	test MEDIA_IOC_DEVICE_INFO: OK

Allow for multiple opens:
	test second /dev/media0 open: OK
	test MEDIA_IOC_DEVICE_INFO: OK
	test for unlimited opens: OK

Media Controller ioctls:
	test MEDIA_IOC_G_TOPOLOGY: OK
	Entities: 6 Interfaces: 2 Pads: 8 Links: 8
	test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
	test MEDIA_IOC_SETUP_LINK: OK

Total for rockchip-vpu device /dev/media0: 7, Succeeded: 7, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for rockchip-vpu device /dev/video0:

Driver Info:
	Driver name      : rockchip-vpu
	Card type        : rockchip,rk3399-vpu-enc
	Bus info         : platform: rockchip-vpu
	Driver version   : 5.1.0
	Capabilities     : 0x84204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
	Detected JPEG Encoder
Media Driver Info:
	Driver name      : rockchip-vpu
	Model            : rockchip-vpu
	Serial           : 
	Bus info         : platform: rockchip-vpu
	Media version    : 5.1.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 5.1.0
Interface Info:
	ID               : 0x0300000c
	Type             : V4L Video
Entity Info:
	ID               : 0x00000001 (1)
	Name             : rockchip,rk3399-vpu-enc-source
	Function         : V4L2 I/O
	Pad 0x01000002   : 0: Source
	  Link 0x02000008: to remote pad 0x1000005 of entity 'rockchip,rk3399-vpu-enc-proc': Data, Enabled, Immutable

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_QUERYCAP: OK

Allow for multiple opens:
	test second /dev/video0 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
	test VIDIOC_QUERYCTRL: OK
	test VIDIOC_G/S_CTRL: OK
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 2 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK
testRequests:1760 ret 0
	test Requests: OK

Total for rockchip-vpu device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for rockchip-vpu device /dev/video1:

Driver Info:
	Driver name      : rockchip-vpu
	Card type        : rockchip,rk3399-vpu-dec
	Bus info         : platform: rockchip-vpu
	Driver version   : 5.1.0
	Capabilities     : 0x84204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
	Detected Stateless Decoder
Media Driver Info:
	Driver name      : rockchip-vpu
	Model            : rockchip-vpu
	Serial           : 
	Bus info         : platform: rockchip-vpu
	Media version    : 5.1.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 5.1.0
Interface Info:
	ID               : 0x0300001a
	Type             : V4L Video
Entity Info:
	ID               : 0x0000000f (15)
	Name             : rockchip,rk3399-vpu-dec-source
	Function         : V4L2 I/O
	Pad 0x01000010   : 0: Source
	  Link 0x02000016: to remote pad 0x1000013 of entity 'rockchip,rk3399-vpu-dec-proc': Data, Enabled, Immutable

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_QUERYCAP: OK

Allow for multiple opens:
	test second /dev/video1 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
	test VIDIOC_QUERYCTRL: OK
	test VIDIOC_G/S_CTRL: OK
		fail: v4l2-test-controls.cpp(673): try_ext_ctrls returned an error (22)
	test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 2 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
		fail: v4l2-test-formats.cpp(806): fmt_cap.g_colorspace() != col
	test VIDIOC_S_FMT: FAIL
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK

Total for rockchip-vpu device /dev/video1: 45, Succeeded: 43, Failed: 2, Warnings: 0

Grand Total for rockchip-vpu device /dev/media0: 97, Succeeded: 95, Failed: 2, Warnings: 0

