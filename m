Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EB8C6FD1F
	for <linux-media@archiver.kernel.org>; Sat, 25 Mar 2023 18:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCYStI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 25 Mar 2023 14:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYStH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 25 Mar 2023 14:49:07 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23056CA1B;
        Sat, 25 Mar 2023 11:49:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5689A89F;
        Sat, 25 Mar 2023 19:49:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679770145;
        bh=6TO2jMVoSqNavdEr1MgvppOe8Bh1r1Q4C3DHa8tQ3q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgLccTpaZjo5DQzZVlYqsm7bkOv0nR+CoheXBm71mI9IHN+Nz7Fhn85B9KrSyhB/B
         0k/cV9Em8j+DqIPWBORcMNHXINhGSjKqdREuNcivfKtvMbcw4Gs5QRYAiTxPnWDOjR
         T3WWdaQhHK3z3OCpUWzwMiyJ3kCA9YTfgkTssukg=
Date:   Sat, 25 Mar 2023 20:49:12 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH v2 2/2] media: imx: imx8mq-mipi-csi2: remove unneeded
 state variable and function
Message-ID: <20230325184912.GC9876@pendragon.ideasonboard.com>
References: <20230307150047.1486186-1-martin.kepplinger@puri.sm>
 <20230307150047.1486186-3-martin.kepplinger@puri.sm>
 <20230312133706.GJ2545@pendragon.ideasonboard.com>
 <25ed971e90324ad596353ba6aade2e14c40c7183.camel@puri.sm>
 <a0a10c7bf7fdf388b7d09ca3ba59e416d4924877.camel@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0a10c7bf7fdf388b7d09ca3ba59e416d4924877.camel@puri.sm>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Martin,

On Sat, Mar 25, 2023 at 10:59:47AM +0100, Martin Kepplinger wrote:
> Am Sonntag, dem 12.03.2023 um 15:04 +0100 schrieb Martin Kepplinger:
> > Am Sonntag, dem 12.03.2023 um 15:37 +0200 schrieb Laurent Pinchart:
> > > On Tue, Mar 07, 2023 at 04:00:47PM +0100, Martin Kepplinger wrote:
> > > > Clean up the driver a bit by inlining the
> > > > imx8mq_mipi_csi_system_enable()
> > > > function to the callsites and removing the hs_settle variable
> > > > from
> > > > the
> > > > driver state.
> > > > 
> > > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > 
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > Could I volunteer you to also drop the struct csi_state state field ?
> > > :-)
> > 
> > sure :) it can become at least a bit more tricky than this patch. I'll
> > take the time after this is merged.
> > 
> > thanks for the fast reviewing
> 
> Laurent, are these 2 patches queued up somewhere? I'm used to waiting
> until they are part of a tree that is part of linux-next before sending
> something new. Does that make sense?

I've just sent a pull request to Mauro for v6.4. You can find the patch
in my tree at

	git://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.git media-imx-next-20230325

-- 
Regards,

Laurent Pinchart
