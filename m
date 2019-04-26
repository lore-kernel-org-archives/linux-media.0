Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E2C43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7093C206BA
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 07:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfDZH7D (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:59:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51811 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfDZH7C (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 03:59:02 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hJvl6-00008h-TK; Fri, 26 Apr 2019 09:59:00 +0200
Message-ID: <1556265540.3664.3.camel@pengutronix.de>
Subject: Re: [PATCH 3/5] media: coda: Replace the threaded interrupt with a
 hard interrupt
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com
Date:   Fri, 26 Apr 2019 09:59:00 +0200
In-Reply-To: <20190425183546.16244-4-ezequiel@collabora.com>
References: <20190425183546.16244-1-ezequiel@collabora.com>
         <20190425183546.16244-4-ezequiel@collabora.com>
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
> The current interrupt handler is doing very little, and not doing
> any non-atomic operations. Pretty much all it does is accessing
> a couple registers, taking a couple spinlocks and then signalling
> a completion.
> 
> There is no reason this should be a threaded interrupt handler,
> so move the handler to regular hard interrupt context.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/media/platform/coda/coda-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> index 1f53ca4effd2..617d4547ec82 100644
> --- a/drivers/media/platform/coda/coda-common.c
> +++ b/drivers/media/platform/coda/coda-common.c
> @@ -2789,8 +2789,8 @@ static int coda_probe(struct platform_device *pdev)
>  		return irq;
>  	}
>  
> -	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, coda_irq_handler,
> -			IRQF_ONESHOT, dev_name(&pdev->dev), dev);
> +	ret = devm_request_irq(&pdev->dev, irq, coda_irq_handler, 0,
> +			       dev_name(&pdev->dev), dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
>  		return ret;

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
