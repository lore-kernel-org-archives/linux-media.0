Return-Path: <SRS0=cH4w=7X=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA48C433E1
	for <linux-media@archiver.kernel.org>; Wed, 10 Jun 2020 23:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2328206F4
	for <linux-media@archiver.kernel.org>; Wed, 10 Jun 2020 23:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgFJXGD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:06:03 -0400
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:26526 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbgFJXGC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Jun 2020 19:06:02 -0400
X-Halon-ID: effdd561-ab6e-11ea-933e-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2eca.dip0.t-ipconnect.de [79.202.46.202])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id effdd561-ab6e-11ea-933e-005056917a89;
        Thu, 11 Jun 2020 01:05:55 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 4/5] mc-device.c: Report graph complete to user-space
Date:   Thu, 11 Jun 2020 01:05:40 +0200
Message-Id: <20200610230541.1603067-5-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200610230541.1603067-1-niklas.soderlund+renesas@ragnatech.se>
References: <20200610230541.1603067-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If the graph in the media device is complete report it to userspace by
setting the MEDIA_TOPOLOGY_FLAG_COMPLETE flag.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/mc/mc-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index c2ef5bb512a5fba0..d63792cc014279fc 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -242,7 +242,7 @@ static long media_device_get_topology(struct media_device *mdev, void *arg)
 	int ret = 0;
 
 	topo->topology_version = mdev->topology_version;
-	topo->flags = 0;
+	topo->flags = mdev->complete ? MEDIA_TOPOLOGY_FLAG_COMPLETE : 0;
 
 	/* Get entities and number of entities */
 	i = 0;
-- 
2.27.0

