Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1D8C10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 16:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE08120850
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 16:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfDIQ5n (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:57:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39561 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfDIQ5n (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 12:57:43 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDu45-0002ip-UZ; Tue, 09 Apr 2019 18:57:41 +0200
Message-ID: <1554829061.5799.7.camel@pengutronix.de>
Subject: Re: [PATCH 10/10] media: coda: require all decoder command flags to
 be cleared
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Tue, 09 Apr 2019 18:57:41 +0200
In-Reply-To: <20190408123256.22868-10-p.zabel@pengutronix.de>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
         <20190408123256.22868-10-p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 2019-04-08 at 14:32 +0200, Philipp Zabel wrote:
> The memory-to-memory stateful video decoder interface documentation
> requires the decoder stop command initiating the drain sequence to have
> flags set to zero.
> Stop to black makes no sense as stopped memory-to-memory decoders do not
> produce any frames, and stopping immediately can be achieved by stopping
> the output video queue with VIDIOC_STREAMOFF.
> 
> The mute audio start command flag serves no purpose as the coda driver
> does not handle any audio formats, and does not support playback at
> non-standard speeds.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/media/platform/coda/coda-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> index 318f0be103bb..96798f98734a 100644
> --- a/drivers/media/platform/coda/coda-common.c
> +++ b/drivers/media/platform/coda/coda-common.c
> @@ -1050,10 +1050,10 @@ static int coda_try_decoder_cmd(struct file *file, void *fh,
>  	if (dc->cmd != V4L2_DEC_CMD_STOP)
>  		return -EINVAL;
>  
> -	if (dc->flags & V4L2_DEC_CMD_STOP_TO_BLACK)
> +	if (dc->stop.pts != 0)
>  		return -EINVAL;
>  
> -	if (!(dc->flags & V4L2_DEC_CMD_STOP_IMMEDIATELY) && (dc->stop.pts != 0))
> +	if (dc->flags != 0)
>  		return -EINVAL;

This change currently causes a v4l2-compliance failure

                fail: v4l2-test-codecs.cpp(104): ret != 0
        test VIDIOC_(TRY_)DECODER_CMD: FAIL

because it still expects V4L2_DEC_CMD_STOP_IMMEDIATELY to be supported.

regards
Philipp
