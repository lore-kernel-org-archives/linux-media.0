Return-Path: <SRS0=g9gv=EJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FB9C388F2
	for <linux-media@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F243321556
	for <linux-media@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgKCJzv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:55:51 -0500
Received: from verein.lst.de ([213.95.11.211]:36530 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbgKCJzv (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 3 Nov 2020 04:55:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A0C467373; Tue,  3 Nov 2020 10:55:39 +0100 (CET)
Date:   Tue, 3 Nov 2020 10:55:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: use of dma_direct_set_offset in (allwinner) drivers
Message-ID: <20201103095538.GA19136@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi all,

Linux 5.10-rc1 switched from having a single dma offset in struct device
to a set of DMA ranges, and introduced a new helper to set them,
dma_direct_set_offset.

This in fact surfaced that a bunch of drivers that violate our layering
and set the offset from drivers, which meant we had to reluctantly
export the symbol to set up the DMA range.

The drivers are:

drivers/gpu/drm/sun4i/sun4i_backend.c

  This just use dma_direct_set_offset as a fallback.  Is there any good
  reason to not just kill off the fallback?

drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c

  Same as above.

drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c

  This driver unconditionally sets the offset.  Why can't we do this
  in the device tree?

drivers/staging/media/sunxi/cedrus/cedrus_hw.c

  Same as above.

