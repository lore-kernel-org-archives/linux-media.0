Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB7C43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 07:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA85206BA
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 07:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfDZH6I (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:58:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35103 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZH6H (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 03:58:07 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hJvkD-00006k-QT; Fri, 26 Apr 2019 09:58:05 +0200
Message-ID: <1556265485.3664.2.camel@pengutronix.de>
Subject: Re: [PATCH 2/5] media: coda: Remove unbalanced and unneeded mutex
 unlock
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com
Date:   Fri, 26 Apr 2019 09:58:05 +0200
In-Reply-To: <20190425183546.16244-3-ezequiel@collabora.com>
References: <20190425183546.16244-1-ezequiel@collabora.com>
         <20190425183546.16244-3-ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 2019-04-25 at 15:35 -0300, Ezequiel Garcia wrote:
> The mutex unlock in the threaded interrupt handler is not paired
> with any mutex lock. Remove it.
> 
> This bug has been here for a really long time, so it applies
> to any stable repo.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/media/platform/coda/coda-bit.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
> index eaa86737fa04..bddd2f5c8c2b 100644
> --- a/drivers/media/platform/coda/coda-bit.c
> +++ b/drivers/media/platform/coda/coda-bit.c
> @@ -2308,7 +2308,6 @@ irqreturn_t coda_irq_handler(int irq, void *data)
>  	if (ctx == NULL) {
>  		v4l2_err(&dev->v4l2_dev,
>  			 "Instance released before the end of transaction\n");
> -		mutex_unlock(&dev->coda_mutex);
>  		return IRQ_HANDLED;
>  	}

I think this is right. I've never seen this message, and I'm not sure if
it is even possible to get a PIC_RUN completion interrupt with the m2m
context already released, since we reset the hardware on timeouts in
pic_run_work. Either way, the mutex is unlocked in pic_run_work after a
timeout if the completion is not triggered, so this one has to go.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
