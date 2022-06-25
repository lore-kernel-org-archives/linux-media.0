Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7091C43334
	for <linux-media@archiver.kernel.org>; Sat, 25 Jun 2022 18:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiFYSAL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 25 Jun 2022 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiFYSAK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 25 Jun 2022 14:00:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CAF1402B
        for <linux-media@vger.kernel.org>; Sat, 25 Jun 2022 11:00:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5608831A;
        Sat, 25 Jun 2022 20:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1656180006;
        bh=MCaBH7JYDAQAejYxz4JDDGEMpG5ffm5wgGm/4ewwNz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFrdt8dYt6fsqYYkik6Z374s94gmp8kSkrdgHxFAKn1hF6oSwjaMi3JDoJfOCax2H
         sYJMMMpUguDcMRSLGOjHkR/DJV4FZuaaJoEog03AljiXkezWvhtinpKbwT3zZOBkic
         4yyr6cIEmyUHTYRqsjdmeEOlq2wWqPn3prjHIoEY=
Date:   Sat, 25 Jun 2022 20:59:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, dafna@fastmail.com, heiko@sntech.de,
        jeanmichel.hautbois@ideasonboard.com, jacopo@jmondi.org,
        djrscally@gmail.com, helen.koike@collabora.com,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 01/55] media: rkisp1: debug: Add dump file in debugfs for
 MI buffer registers
Message-ID: <YrdNFJnkU+MLtmtk@pendragon.ideasonboard.com>
References: <20220614191127.3420492-1-paul.elder@ideasonboard.com>
 <20220614191127.3420492-2-paul.elder@ideasonboard.com>
 <YqpgMkK33+0IpxjR@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqpgMkK33+0IpxjR@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Paul,

On Thu, Jun 16, 2022 at 01:41:56AM +0300, Laurent Pinchart wrote:
> On Wed, Jun 15, 2022 at 04:10:33AM +0900, Paul Elder wrote:
> > Add a register dump file in debugfs for some of the buffer-related
> > registers in MI, for the base address, the size, and the offset. Also
> > dump the appropriate shadow registers.
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > ---
> >  .../platform/rockchip/rkisp1/rkisp1-debug.c   | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > index e76dc2b164b6..1a59c00fabdd 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> > @@ -121,6 +121,24 @@ static int rkisp1_debug_dump_rsz_regs_show(struct seq_file *m, void *p)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_rsz_regs);
> >  
> > +static int rkisp1_debug_dump_mi_mp_y_offs_cnt_show(struct seq_file *m, void *p)
> > +{
> > +	static const struct rkisp1_debug_register registers[] = {
> > +		RKISP1_DEBUG_REG(MI_MP_Y_BASE_AD_INIT),
> > +		RKISP1_DEBUG_REG(MI_MP_Y_BASE_AD_INIT2),
> > +		RKISP1_DEBUG_REG(MI_MP_Y_BASE_AD_SHD),
> > +		RKISP1_DEBUG_REG(MI_MP_Y_SIZE_INIT),
> > +		RKISP1_DEBUG_REG(MI_MP_Y_SIZE_INIT),
> > +		RKISP1_DEBUG_REG(MI_MP_Y_SIZE_SHD),
> > +		RKISP1_DEBUG_REG(MI_MP_Y_OFFS_CNT_SHD),
> > +		{ /* Sentinel */ },
> > +	};
> > +	struct rkisp1_device *rkisp1 = m->private;
> > +
> > +	return rkisp1_debug_dump_regs(rkisp1, m, 0, registers);
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_mi_mp_y_offs_cnt);
> > +
> >  #define RKISP1_DEBUG_DATA_COUNT_BINS	32
> >  #define RKISP1_DEBUG_DATA_COUNT_STEP	(4096 / RKISP1_DEBUG_DATA_COUNT_BINS)
> >  
> > @@ -214,6 +232,9 @@ void rkisp1_debug_init(struct rkisp1_device *rkisp1)
> >  	debugfs_create_file("srsz", 0444, regs_dir,
> >  			    &rkisp1->resizer_devs[RKISP1_SELFPATH],
> >  			    &rkisp1_debug_dump_rsz_regs_fops);
> > +
> > +	debugfs_create_file("mi_mp_y_bufs", 0444, regs_dir, rkisp1,
> > +			    &rkisp1_debug_dump_mi_mp_y_offs_cnt_fops);
> 
> That's a very specialized file. I wonder if we should call it just
> "mi_mp" if it needs to be extended later with other memory interface
> registers for the main path. Or maybe even just "mi", to cover the self
> path too ? The latter may be a tad too generic. What do you think ?

Ping

> >  }
> >  
> >  void rkisp1_debug_cleanup(struct rkisp1_device *rkisp1)

-- 
Regards,

Laurent Pinchart
