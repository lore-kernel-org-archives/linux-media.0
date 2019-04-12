Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0290AC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9562083E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfDLI6A (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:58:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33616 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDLI6A (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 04:58:00 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9ADA4260809;
        Fri, 12 Apr 2019 09:57:58 +0100 (BST)
Date:   Fri, 12 Apr 2019 10:57:55 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>
Cc:     Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Brian Starkey <Brian.Starkey@arm.com>, kernel@collabora.com
Subject: Re: [RFC PATCH v2 3/7] media: v4l2: Add extended buffer operations
Message-ID: <20190412105755.42764170@collabora.com>
In-Reply-To: <20190404081700.30006-4-boris.brezillon@collabora.com>
References: <20190404081700.30006-1-boris.brezillon@collabora.com>
        <20190404081700.30006-4-boris.brezillon@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu,  4 Apr 2019 10:16:56 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:


> +/**
> + * struct v4l2_ext_buffer - extended video buffer info
> + * @index: id number of the buffer
> + * @type: enum v4l2_buf_type; buffer type. _MPLANE and _OVERLAY formats are
> + *	  invalid
> + * @flags: buffer informational flags
> + * @field: enum v4l2_field; field order of the image in the buffer
> + * @timestamp: frame timestamp
> + * @sequence: sequence count of this frame
> + * @memory: enum v4l2_memory; the method, in which the actual video data is
> + *          passed
> + * @planes: per-plane buffer information
> + * @num_planes: number of plane buffers
> + * @request_fd: fd of the request that this buffer should use
> + * @reserved: some extra space reserved to add future fields (like timecode).
> + *	      Must be set to 0
> + *
> + * Contains data exchanged by application and driver using one of the Streaming
> + * I/O methods.
> + */
> +struct v4l2_ext_buffer {
> +	__u32 index;
> +	__u32 type;
> +	__u32 flags;
> +	__u32 field;
> +	__u64 timestamp;
> +	__u32 sequence;
> +	__u32 memory;
> +	struct v4l2_ext_plane planes[VIDEO_MAX_PLANES];

I had a discussion with Tomasz last week, and he made me realize I was
misunderstanding the concept of V4L2 planes. I thought it was encoding
pixel-component planes, but it's actually memory planes, and sometimes
those one memory planes might contain all component planes placed next
to each others (like the V4L2_PIX_FMT_NV12 format).

So, the question is, what do we want v4l2_ext_plane to encode (memory
planes or pixel component planes)?
If we go for the pixel component plane approach (which IMHO would be a
good thing), that means we'll have to convert V4L2_PIX_FMT_NV12-like
single-memory-plane buffers into v4l2_ext_buffer containing X planes,
each pointing to the same memory object but at a different offset.

> +	__u32 num_planes;
> +	__u32 request_fd;
> +	__u32 reserved[10];
> +};
> +
>  /**
>   * v4l2_timeval_to_ns - Convert timeval to nanoseconds
>   * @ts:		pointer to the timeval variable to be converted
> @@ -1062,6 +1139,35 @@ struct v4l2_exportbuffer {
>  	__u32		reserved[11];
>  };
>  

