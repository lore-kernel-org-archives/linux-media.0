Return-Path: <SRS0=7WK4=XA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A2BC3A5A5
	for <linux-media@archiver.kernel.org>; Thu,  5 Sep 2019 08:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07EC20870
	for <linux-media@archiver.kernel.org>; Thu,  5 Sep 2019 08:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfIEIYV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:24:21 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:36777 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730769AbfIEIYU (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 5 Sep 2019 04:24:20 -0400
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 5n3viVmkL50xT5n3ziprsN; Thu, 05 Sep 2019 10:24:19 +0200
Subject: Re: [PATCH for v5.3] videobuf-core.c: poll_wait needs a non-NULL buf
 pointer
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
References: <f60c12ef-5015-c6e1-ed1b-e9d8ca98a593@xs4all.nl>
Message-ID: <a5c65e64-3161-8a5f-1f45-df78170b0472@xs4all.nl>
Date:   Thu, 5 Sep 2019 10:24:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f60c12ef-5015-c6e1-ed1b-e9d8ca98a593@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIXMlnI+SR/7xj6k9JpAvyJvk5HXPBDnaJASbl5owDXgnfMUZlNoPjvxuZapw5LqXyoxxpE1HeA9zz5kT1LBN8cj02QhJANMkeK9+90O6+Yl7FSWQJPh
 FixXFhtSkT252npMw6OZdxwnQT+2YRmNO2fMqWkPXYCSiXzES5LFNhlOHYko/mXIrbeGGMYojEG/2pB7wZGNQPkb/J9fu3lQAVM=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 9/4/19 11:04 AM, Hans Verkuil wrote:
> poll_wait uses &buf->done, but buf is NULL. Move the poll_wait to later
> in the function once buf is correctly set and only call it if it is
> non-NULL.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: bb436cbeb918 ("media: videobuf: fix epoll() by calling poll_wait first")
> Cc: <stable@vger.kernel.org>      # for v5.1 and up

Tested with the cx231xx driver:

Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

> ---
> diff --git a/drivers/media/v4l2-core/videobuf-core.c b/drivers/media/v4l2-core/videobuf-core.c
> index 7ef3e4d22bf6..939fc11cf080 100644
> --- a/drivers/media/v4l2-core/videobuf-core.c
> +++ b/drivers/media/v4l2-core/videobuf-core.c
> @@ -1123,7 +1123,6 @@ __poll_t videobuf_poll_stream(struct file *file,
>  	struct videobuf_buffer *buf = NULL;
>  	__poll_t rc = 0;
> 
> -	poll_wait(file, &buf->done, wait);
>  	videobuf_queue_lock(q);
>  	if (q->streaming) {
>  		if (!list_empty(&q->stream))
> @@ -1143,7 +1142,9 @@ __poll_t videobuf_poll_stream(struct file *file,
>  		}
>  		buf = q->read_buf;
>  	}
> -	if (!buf)
> +	if (buf)
> +		poll_wait(file, &buf->done, wait);
> +	else
>  		rc = EPOLLERR;
> 
>  	if (0 == rc) {
> 

