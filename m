Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC2AC54EAA
	for <linux-media@archiver.kernel.org>; Thu, 26 Jan 2023 23:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjAZX2M (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Jan 2023 18:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjAZX2M (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Jan 2023 18:28:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576FC36474;
        Thu, 26 Jan 2023 15:28:11 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CD63CDB;
        Fri, 27 Jan 2023 00:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674775689;
        bh=85GVWImqabLaQOCHxWsKf6TcbxMX/QaYIdYeLIfaCmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jR+URH5KqirXEN1bdS/bwqV5ZiQWPoMn7MmH2vwcJtLOLQBAzr6lVqIQ5f5aEDaWb
         mxRqlKT7o81ByhdPGIDdL97oCrfpMhOtJt0wR1x0Ydd61cLrpf0N1tn0Ui9eRsnREW
         SSpRzF7bk4FfyLeBq3bkdJEz4l1UrcZglgSLDlKE=
Date:   Fri, 27 Jan 2023 01:28:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dafna Hirschfeld <dafna@fastmail.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: rkisp1: Make local immutable array
 variables static const
Message-ID: <Y9MMhSVrWujmfgCR@pendragon.ideasonboard.com>
References: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
 <20221117084217.3892680-3-paul.elder@ideasonboard.com>
 <Y3lYcRySWnrLKpWe@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3lYcRySWnrLKpWe@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dafna,

On Sun, Nov 20, 2022 at 12:28:01AM +0200, Laurent Pinchart wrote:
> Hi Dafna,
> 
> Are you fine with this patch, can I include it in my next pull request
> along with the other ones from the series ?

Ping.

> On Thu, Nov 17, 2022 at 05:42:16PM +0900, Paul Elder wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > The max_widths and max_heights variables in rkisp1_try_fmt() are
> > immutable and don't need to be allocated on the stack every time the
> > function is called. Make them static.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
> > ---
> >  .../media/platform/rockchip/rkisp1/rkisp1-capture.c  | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > index 7695ef134908..91e685fdbbe9 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > @@ -1150,13 +1150,17 @@ static void rkisp1_try_fmt(const struct rkisp1_capture *cap,
> >  			   const struct rkisp1_capture_fmt_cfg **fmt_cfg,
> >  			   const struct v4l2_format_info **fmt_info)
> >  {
> > +	static const unsigned int max_widths[] = {
> > +		RKISP1_RSZ_MP_SRC_MAX_WIDTH,
> > +		RKISP1_RSZ_SP_SRC_MAX_WIDTH,
> > +	};
> > +	static const unsigned int max_heights[] = {
> > +		RKISP1_RSZ_MP_SRC_MAX_HEIGHT,
> > +		RKISP1_RSZ_SP_SRC_MAX_HEIGHT,
> > +	};
> >  	const struct rkisp1_capture_config *config = cap->config;
> >  	const struct rkisp1_capture_fmt_cfg *fmt;
> >  	const struct v4l2_format_info *info;
> > -	const unsigned int max_widths[] = { RKISP1_RSZ_MP_SRC_MAX_WIDTH,
> > -					    RKISP1_RSZ_SP_SRC_MAX_WIDTH };
> > -	const unsigned int max_heights[] = { RKISP1_RSZ_MP_SRC_MAX_HEIGHT,
> > -					     RKISP1_RSZ_SP_SRC_MAX_HEIGHT};
> >  
> >  	fmt = rkisp1_find_fmt_cfg(cap, pixm->pixelformat);
> >  	if (!fmt) {

-- 
Regards,

Laurent Pinchart
