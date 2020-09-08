Return-Path: <SRS0=7dE9=CR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A71C43461
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 05:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05462137B
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 05:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gkiMfO5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgIHFuo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Sep 2020 01:50:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45758 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbgIHFum (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 8 Sep 2020 01:50:42 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B80C235
        for <linux-media@vger.kernel.org>; Tue,  8 Sep 2020 07:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599544240;
        bh=qFinf4sYl/0xEMkcQ85qtBqmK2rItsv4JBhn5AV6pyw=;
        h=Date:From:To:Subject:From;
        b=gkiMfO5N3vESngPEhH1eIR+GoMRZJgvhwHmC7Fopw9zP4AA2B11P7umYz7v9a1xvt
         w1yo89NAHvm9/I7Jszwl1kQhB/6iKvx7tuTqwbwXk/H4AGp+lP1CF2guwC8UfaCc9j
         It5TYrOO8p96v63mGtJZUHtZd6Om4T2yxi6/5PDM=
Date:   Tue, 8 Sep 2020 08:50:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.10] R-Car miscellaneous V4L2 patches
Message-ID: <20200908055016.GK6047@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

The following changes since commit d13ee586e026e8166231e03e5345718ebf625c02:

  Merge tag 'v5.9-rc4' into patchwork (2020-09-07 16:13:06 +0200)

are available in the Git repository at:

  git://linuxtv.org/pinchartl/media.git tags/v4l2-rcar-20200907

for you to fetch changes up to fcad4a4bb827e8e96b9bced31a0b11e45681a5b4:

  media: rcar-fcp: Drop local dma_parms (2020-09-08 08:09:56 +0300)

----------------------------------------------------------------
Miscellaneous changes to the R-Car V4L2 drivers for v5.10

----------------------------------------------------------------
Robin Murphy (1):
      media: rcar-fcp: Drop local dma_parms

 drivers/media/platform/rcar-fcp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
Regards,

Laurent Pinchart
