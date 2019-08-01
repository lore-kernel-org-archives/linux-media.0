Return-Path: <SRS0=PbWc=V5=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3B0C19759
	for <linux-media@archiver.kernel.org>; Thu,  1 Aug 2019 04:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000302064A
	for <linux-media@archiver.kernel.org>; Thu,  1 Aug 2019 04:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rqy1b9wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfHAEGZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 1 Aug 2019 00:06:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36417 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfHAEGY (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 1 Aug 2019 00:06:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so72030928wrs.3
        for <linux-media@vger.kernel.org>; Wed, 31 Jul 2019 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mB42y3xmrJWhBLWeWzKTdkVYurhG+q5hPYefS8udCw=;
        b=Rqy1b9wgnbO9iiiBCq0yAP3hGF9q5tLtF+rAKGfMKigKhec6hrRDE2gbAmGB6vil2r
         3lcZJ1qyK34AcYzj1Pc4F5LaFctVd17q/tHL6sMpyVAhjhlkvj+6WFudBTwwiM77jJg2
         1pvNRrRsnFSe3u9RLO+v1a/eLfrm+Ons2lnZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mB42y3xmrJWhBLWeWzKTdkVYurhG+q5hPYefS8udCw=;
        b=hZNb8tqOp9P4ugSwAyiDVDbG67T/cwDClES5sUlpZdaNcxI6ErB6MO722ASt9+EljY
         HG9uPvAY7C2mw9x/owibFM+fMg3qysWTCqrxiiT9BZN/kmMjsoGYY8asCawqQkOaqxaC
         czVyDcswU/Bytro5Jrfc0MRsbrbgGC6XaBWOm860kVtk1pZN+AwdiMcHQ3IT1jlJPihw
         7EerSdnjEsbfI31ECTYNGHe81M+UfjWjMjZXiBz1MzOxDR5HpwTlKURToVTXQUTcDEjX
         wU5+lYM+5pqpT5NSTLifYxZykkx2ScTgVOXIg+Ouo8qqBaHfqB/jv8OTqo3jWC+vvxjH
         ZjLA==
X-Gm-Message-State: APjAAAWXIbYxh+bgeAaiop/OARcSBUip3wQ6pV671u2Htvgss0k7Adgn
        sLnPk7FaMmU1oSLIfok6I9CRwuAd3NEIRdMDY+5yqA==
X-Google-Smtp-Source: APXvYqycKy7N26liWehbx4OB6WFB2ks3ASboEt4UcIJYI8SMe0JfZCnvhCeu+F7MPJNgeMKOB0gT4IRbMod1SEgn704=
X-Received: by 2002:adf:f08f:: with SMTP id n15mr52081058wro.213.1564632382431;
 Wed, 31 Jul 2019 21:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190619121540.29320-1-boris.brezillon@collabora.com> <20190619121540.29320-8-boris.brezillon@collabora.com>
In-Reply-To: <20190619121540.29320-8-boris.brezillon@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 1 Aug 2019 13:06:10 +0900
Message-ID: <CAHD77HksotqFBTE84rRM=DuNFX=YJPs=YnsuFkaN-pWUNCtoxA@mail.gmail.com>
Subject: Re: [PATCH 7/9] media: hantro: Add core bits to support H264 decoding
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hertz Wong <hertz.wong@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Boris,

On Wed, Jun 19, 2019 at 9:15 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
[snip]
> @@ -533,10 +535,21 @@ hantro_queue_setup(struct vb2_queue *vq, unsigned int *num_buffers,
>                 return -EINVAL;
>         }
>
> +       /* The H264 decoder needs extra size on the output buffer. */
> +       if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE_RAW)
> +               extra_size0 = 128 * DIV_ROUND_UP(pixfmt->width, 16) *
> +                             DIV_ROUND_UP(pixfmt->height, 16);
> +

I wonder if this shouldn't be accounted for already in the sizeimage
returned by TRY_/S_FMT, so that the application can know the required
buffer size if it uses some external allocator and DMABUF memory type.
I know we had it like this in our downstream code, but it wasn't the
problem because we use minigbm, where we explicitly add the same
padding in the rockchip backend. Any thoughts?

Best regards,
Tomasz
