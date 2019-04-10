Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBBBC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 10:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9797A217F4
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 10:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfDJKuf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:50:35 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:57367 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730487AbfDJKue (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 06:50:34 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud9.xs4all.net with ESMTPA
        id EAoJhXwnLiLOmEAoKh6pM0; Wed, 10 Apr 2019 12:50:32 +0200
Subject: Re: [PATCH] media: omap_vout: potential buffer overflow in
 vidioc_dqbuf()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amber Jain <amber@ti.com>
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>
References: <20190409112924.GA13643@kadam>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <eb4fe291-85b5-540b-c210-5e9fb051f2cc@xs4all.nl>
Date:   Wed, 10 Apr 2019 12:50:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190409112924.GA13643@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAhu7dBJ0TC8XHIs78KNTi3vjXjuWM9ShLnLS5bvVMIDlcJYkbsBWA0VwWaSx/seZM4J/uxIVVaxFFSsHtVscJ+82y6Q3dD8DnRoYa626eUCkQYTOzV9
 qgQenmMBAQ9dQEnwNuAv9pF6L2yfdcpPwch3fwBPbXFpjvsYujRi4zH6D2+qOW2UxBdwd+TG8PPYsUffdfhqMr99QPGRUpREJeG3OoNFgXMHZ7JFZoi3ocXr
 UcctQ2nypMHKZGSWk+0zh7k2W2kY1qyFmFSeqk2aNIN6Ms8g3BNKHThc0dn0lt6B/8wT8Mmscl4swsmjaZrAhCzXtWloN31kKxdg2Vdwtb59UNqiyrw5fmIp
 95vy7XgZpILDRz8HNAltnjUhOzw2DcqaAuBi4btHO9eA4aGyTdGwQiu7pUBsp+fBOyO0g4Le1ZSLGJSoM9A5v+dBrYPKpKKtxUvRoxhnVM8QUV4V0hdO+qDw
 L2fWL93wRHTL6WN/aneBh03AAmF3asvdZc2AkTZL6rrmXha3Gc15fMHiN0h3frJPrsMRl0rhN+NU9v1n5/YCQX0IJWp2eC96yjHW7A==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/9/19 1:29 PM, Dan Carpenter wrote:
> The "b->index" is a u32 the comes from the user in the ioctl.  It hasn't
> been checked.  We aren't supposed to use it but we're instead supposed
> to use the value that gets written to it when we call videobuf_dqbuf().
> 
> The videobuf_dqbuf() first memsets it to zero and then re-initializes it
> inside the videobuf_status() function.  It's this final value which we
> want.
> 
> Fixes: 72915e851da9 ("[media] V4L2: OMAP: VOUT: dma map and unmap v4l2 buffers in qbuf and dqbuf")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> UNTESTED!  I think I understand this code now, but I have struggled to
> read it correctly in the past.  Please review carefully.
> 
> 
>  drivers/media/platform/omap/omap_vout.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
> index 37f0d7146dfa..15e38990e85a 100644
> --- a/drivers/media/platform/omap/omap_vout.c
> +++ b/drivers/media/platform/omap/omap_vout.c
> @@ -1527,8 +1527,6 @@ static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
>  	unsigned long size;
>  	struct videobuf_buffer *vb;
>  
> -	vb = q->bufs[b->index];
> -
>  	if (!vout->streaming)
>  		return -EINVAL;
>  
> @@ -1539,6 +1537,8 @@ static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
>  		/* Call videobuf_dqbuf for  blocking mode */
>  		ret = videobuf_dqbuf(q, (struct v4l2_buffer *)b, 0);

We need a:

	if (ret)
		return ret;

here. Or alternatively, add 'if (!ret)' around the next five lines.

b->index is only valid if the videobuf_dqbuf call returned 0.

Regards,

	Hans

>  
> +	vb = q->bufs[b->index];
> +
>  	addr = (unsigned long) vout->buf_phy_addr[vb->i];
>  	size = (unsigned long) vb->size;
>  	dma_unmap_single(vout->vid_dev->v4l2_dev.dev,  addr,
> 

