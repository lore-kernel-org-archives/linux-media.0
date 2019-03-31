Return-Path: <SRS0=D0s7=SC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FB7C43381
	for <linux-media@archiver.kernel.org>; Sun, 31 Mar 2019 10:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C289620882
	for <linux-media@archiver.kernel.org>; Sun, 31 Mar 2019 10:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfCaKRw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:17:52 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:34854 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbfCaKRw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 31 Mar 2019 06:17:52 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id AXX9hgpUWiLOmAXXChYVJR; Sun, 31 Mar 2019 12:17:51 +0200
Subject: Re: [PATCH 00/14] add support for stateless encoder
To:     Dafna Hirschfeld <dafna3@gmail.com>, linux-media@vger.kernel.org
Cc:     helen.koike@collabora.com
References: <20190330204311.107417-1-dafna3@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <6459cafe-dfd3-e50e-ac84-e896d1a88559@xs4all.nl>
Date:   Sun, 31 Mar 2019 12:17:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfN07UbZp/3vfQaT0P7teu5uIIh0oRUK6Hqcs6yYu9T3qN2qaWoE4UzlM6oLK7qEENBry2H+Yzxe4aYC+sPwBYRF6YEkqYD9Tj4X6hV/gaZYYFdZIup6D
 A2MYLVPWgfmwz/QDyoV02Rc1ioY8ZKddRCBgo3dJRHicjdkqI4I/p/JSww/QacZYh6vZvY6KcpxWgOXjGpkhFgfU0FZHIG9oe4EbH6daY4q3T/p6XXsyffir
 X87pUMtNJt3HX6iIs49DOA==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 3/30/19 9:42 PM, Dafna Hirschfeld wrote:
> patches 9-13 are new,
> 
> Dafna Hirschfeld (6):
>   media: vicodec: don't test if info is NULL
>   media: vicodec: add field 'dev_inst' to vicodec_ctx
>   media: vicodec: Register another node for stateless encoder
>   media: vicodec: set pixelformat V4L2_PIX_FMT_FWHT_STATELESS for
>     stateless encoder
>   media: vicodec: Add support for stateless encoder
>   prints

It looks like this series just prepares for stateless encoder support but
no actually implements it yet. Is that right?

I also see only 13 patches, not 14, so perhaps something is missing?

Regards,

	Hans

> 
> Hans Verkuil (8):
>   kernel/sysctl.c: bug fix
>   vicodec: always return a valid format.
>   vicodec: pass on enc output format to capture side
>   vicodec: add V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
>   videobuf2-v4l2: set last_buffer_dequeued in dqbuf
>   vicodec: improve handling of ENC_CMD_STOP/START
>   vicodec: restrict decoder format list when src fmt is known
>   vicodec: fix vicodec_buf_queue()
> 
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  10 +-
>  drivers/media/media-request.c                 |   3 +
>  drivers/media/platform/vicodec/codec-fwht.c   |  25 +
>  drivers/media/platform/vicodec/codec-fwht.h   |   2 +
>  .../media/platform/vicodec/codec-v4l2-fwht.c  |  63 ++-
>  drivers/media/platform/vicodec/vicodec-core.c | 497 +++++++++++++-----
>  drivers/media/v4l2-core/v4l2-ctrls.c          |  57 +-
>  kernel/sysctl.c                               |   2 +-
>  8 files changed, 507 insertions(+), 152 deletions(-)
> 

