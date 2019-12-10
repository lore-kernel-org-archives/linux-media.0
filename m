Return-Path: <SRS0=nGM0=2A=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC63DC43603
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 02:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78DE20409
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 02:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLJCHW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:07:22 -0500
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:1517 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbfLJCHW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 9 Dec 2019 21:07:22 -0500
X-Halon-ID: b7add18d-1af1-11ea-a00b-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p54ac5865.dip0.t-ipconnect.de [84.172.88.101])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id b7add18d-1af1-11ea-a00b-005056917a89;
        Tue, 10 Dec 2019 03:07:18 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 0/2] rcar-vin: Support V4L2_FIELD_SEQ_{TB,BT}
Date:   Tue, 10 Dec 2019 03:05:57 +0100
Message-Id: <20191210020559.170594-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

This series add support for sequential filed formats to rcar-vin. The
series is based on the media-tree and tested on both R-Car Gen2 and Gen3
boards without regressions.

Patch 1/2 prepares for the new filed formats by reworking and renaming
an existing struct member while 2/2 adds support for the two new field
formats.

Niklas Söderlund (2):
  rcar-vin: Move hardware buffer tracking to own struct
  rcar-vin: Add support for V4L2_FIELD_SEQ_{TB,BT}

 drivers/media/platform/rcar-vin/rcar-dma.c  | 91 ++++++++++++++++-----
 drivers/media/platform/rcar-vin/rcar-v4l2.c |  5 ++
 drivers/media/platform/rcar-vin/rcar-vin.h  | 28 ++++++-
 3 files changed, 100 insertions(+), 24 deletions(-)

-- 
2.24.0

