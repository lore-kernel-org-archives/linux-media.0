Return-Path: <SRS0=P/UY=YH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19950C4360C
	for <linux-media@archiver.kernel.org>; Mon, 14 Oct 2019 00:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E780F20659
	for <linux-media@archiver.kernel.org>; Mon, 14 Oct 2019 00:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfJNAQ0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:16:26 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:8582 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728691AbfJNAQ0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 13 Oct 2019 20:16:26 -0400
X-Halon-ID: ab2a3763-ee17-11e9-837a-0050569116f7
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (unknown [84.172.88.101])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id ab2a3763-ee17-11e9-837a-0050569116f7;
        Mon, 14 Oct 2019 02:15:07 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 0/2] rcar-vin: Add support for outputting NV12
Date:   Mon, 14 Oct 2019 02:16:13 +0200
Message-Id: <20191014001615.2865301-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

This series adds support for storing captures in NV12 pixel format on
most Gen3 SoCs. It is based on top of latest media-tree and tested on
Gen2 and Gen3 with out any regressions.

Patch 1/2 prepares for the admonition of NV12 support by defining which
Gen3 SoCs supports the output format. While patch 2/2 is the real change
adding the format and register writes to deliver NV12.

Niklas Söderlund (2):
  rcar-vin: Define which hardware supports NV12
  rcar-vin: Add support for outputting NV12

 drivers/media/platform/rcar-vin/rcar-core.c |  6 ++++
 drivers/media/platform/rcar-vin/rcar-dma.c  |  5 ++-
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 39 +++++++++++++++++----
 drivers/media/platform/rcar-vin/rcar-vin.h  |  2 ++
 4 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.23.0

