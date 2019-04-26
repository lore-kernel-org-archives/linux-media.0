Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264FEC43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 17:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60F720656
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 17:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfDZR4L (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:56:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40292 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZR4L (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 13:56:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 302CC260C9D
Message-ID: <47a776d4d5e8e169924e1c55d5be42325225f1d7.camel@collabora.com>
Subject: Re: [PATCH 3/5] media: coda: Replace the threaded interrupt with a
 hard interrupt
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com
Date:   Fri, 26 Apr 2019 14:56:03 -0300
In-Reply-To: <1556270218.3664.8.camel@pengutronix.de>
References: <20190425183546.16244-1-ezequiel@collabora.com>
         <20190425183546.16244-4-ezequiel@collabora.com>
         <1556270218.3664.8.camel@pengutronix.de>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Philipp,

Thanks for the quick review of the series.

On Fri, 2019-04-26 at 11:16 +0200, Philipp Zabel wrote:
> On Thu, 2019-04-25 at 15:35 -0300, Ezequiel Garcia wrote:
> > The current interrupt handler is doing very little, and not doing
> > any non-atomic operations. Pretty much all it does is accessing
> > a couple registers, taking a couple spinlocks and then signalling
> > a completion.
> > 
> > There is no reason this should be a threaded interrupt handler,
> > so move the handler to regular hard interrupt context.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  drivers/media/platform/coda/coda-common.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> > index 1f53ca4effd2..617d4547ec82 100644
> > --- a/drivers/media/platform/coda/coda-common.c
> > +++ b/drivers/media/platform/coda/coda-common.c
> > @@ -2789,8 +2789,8 @@ static int coda_probe(struct platform_device *pdev)
> >  		return irq;
> >  	}
> >  
> > -	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, coda_irq_handler,
> > -			IRQF_ONESHOT, dev_name(&pdev->dev), dev);
> > +	ret = devm_request_irq(&pdev->dev, irq, coda_irq_handler, 0,
> > +			       dev_name(&pdev->dev), dev);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
> >  		return ret;
> 
> There is one thing that this would complicate. For at least H.264 I
> know that we can pad the bitstream in reaction to a BIT_BUF_EMPTY
> interrupt, to make a picture run finish successfully when it is stuck in
>   buffer underrun condition. This would need to be done under the
> bitstream_mutex in a threaded handler.
> 

In this case, a top-half handler would still stand in good stead,
as it would check the interrupt status, and fire the bottom-half
threaded interrupt to handle the buffer underrun.

Thanks,
Ezequiel

