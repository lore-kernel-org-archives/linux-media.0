Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5888C10F03
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 08:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9E4217FA
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 08:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfDYIV3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:21:29 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:39425 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfDYIV3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 04:21:29 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JZd6hQkVMZVjxJZd9hdy27; Thu, 25 Apr 2019 10:21:26 +0200
Subject: Re: [PATCH v4 00/21] Add MPEG-2 decoding to Rockchip VPU
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
References: <20190425071242.18315-1-boris.brezillon@collabora.com>
 <20190425100628.6f8e5894@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <69d53367-f26a-a3cb-0221-7d9be02ade6e@xs4all.nl>
Date:   Thu, 25 Apr 2019 10:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190425100628.6f8e5894@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHF8j9vomTk+NgqNbGtU6BQt54uq0WyK0uEqrUWkJCYacdTYF9r+eaVgmYAAsWOJ3WeBNwKVLQNx6nJj01cWJrFJLP58f2TfhWLBsnadviNDbiPK5JRd
 iMTJUC2f5QkoC2nxDm63NpO5Ft960T1WLPnUOm9grjFxROJaIDkA5tBeRYMFyH936kyi5swCoPE7v0loXNZyeqfEDs3IqtI6tWeYSZmzurIO72iBi4W73H1h
 FacE+GAKZzOvzi7DrLdql19AlJc7mEUTEkJbZjYvlu39916pqEe0GUFav4vaBEQNyddapjz1DVoLOmqbusXhTMt8bHMmlDIyiNXcnmo9Bclkak/Y1bn/2Bn6
 3tCdvIqpJwixUl7uWbHbAkdnDNaMGqrmzGqgesz1ipdS9Ux1sRv0b5d/y6Oh2S9CWfW6olxxRmnmwvtSGh+ItVu3rwoTqA/WICnB53i7r9tQuuEfwrUZIZaP
 +qClCNVhWzkLlbc1UkA0L+k5sAOUnwVre8HAKWVDRQKx5vlwrffwTxiMJrjvYcQU4am4lpqYXHU8YQ+PBmL7qt8BTaoFn/zYmQKh5niGGzyCxHsliIk2nNDw
 MgX93TCty4DIaw8KnJ6gBFbEEX48EXdDPooKviL/7e2Oeg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/25/19 10:06 AM, Boris Brezillon wrote:
> On Thu, 25 Apr 2019 09:12:21 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
>> This series introduces the decoding infrastructure that will be
>> used to add support for other codecs such as VP8, VP9 and H.264.
>>
>> As explained in the cover letter for the v1 patchset,
>> the driver is now exposing two video device nodes.
>> The VPU encoder is exposed on /dev/video0, and the VPU decoder
>> is exposed on /dev/video1. Both devices are tied to the same
>> memory-to-memory queue, and same media device /dev/media0.
>>
>> Therefore there are two media graphs:
>>
>> ┌────────────────────────────────┐
>> │ rockchip,rk3399-vpu-enc-source │
>> │          /dev/video0           │
>> └────────────────────────────────┘
>>   ┃
>>   ┃
>>   ▼
>> ┌────────────────────────────────┐
>> │  rockchip,rk3399-vpu-enc-proc  │
>> └────────────────────────────────┘
>>   ┃
>>   ┃
>>   ▼
>> ┌────────────────────────────────┐
>> │  rockchip,rk3399-vpu-enc-sink  │
>> │          /dev/video0           │
>> └────────────────────────────────┘
>>
>> ┌────────────────────────────────┐
>> │ rockchip,rk3399-vpu-dec-source │
>> │          /dev/video1           │
>> └────────────────────────────────┘
>>   ┃
>>   ┃
>>   ▼
>> ┌────────────────────────────────┐
>> │  rockchip,rk3399-vpu-dec-proc  │
>> └────────────────────────────────┘
>>   ┃
>>   ┃
>>   ▼
>> ┌────────────────────────────────┐
>> │  rockchip,rk3399-vpu-dec-sink  │
>> │          /dev/video1           │
>> └────────────────────────────────┘
>>
>> Of course, this work has been possible thanks to Jonas Karlman, who did
>> the initial MPEG-2 decoding work and also got mpv+ffmpeg working using
>> the Request API.
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

So is this a driver FIXME, or an issue in the compliance test itself?

> 
> * "fail: v4l2-test-controls.cpp(673): try_ext_ctrls returned an error (22)":
>   default values for mpeg2 ctrls are not suitable, so doing
>   get_ext_ctrl()+try_ext_ctrl() does not work.

Hmm, this might require some changes to this test. Where does it fail in the
driver? Is that the std_validate() check in v4l2-ctrls.c?

If so, then I think it would be wise to add an initializer for V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS
to std_init() so that it creates a proper default.

I also noticed that support for these new compound types is missing in
the std_log() function in v4l2-ctrls.c. It should probably log the
type. Check with v4l2-ctl --log-status to see how it looks in the
kernel log. Obviously, this can be done in a separate patch since it's
independent of the rockchip driver.

Regards,

	Hans

> 
> I'm looking into the other failures which were not present in v3 (yes, I
> know, shame on me for not running v4l2-compliance before sending the series :-)).
> 

