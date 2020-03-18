Return-Path: <SRS0=m313=5D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E536FC4332B
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 21:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2B120773
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 21:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgCRVbJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:31:09 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:7578 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCRVbI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 18 Mar 2020 17:31:08 -0400
X-Halon-ID: b279901d-695f-11ea-9f40-0050569116f7
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id b279901d-695f-11ea-9f40-0050569116f7;
        Wed, 18 Mar 2020 22:30:32 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [RFC 3/5] mc-device.c: If graph completes status is available report it to user-space
Date:   Wed, 18 Mar 2020 22:30:49 +0100
Message-Id: <20200318213051.3200981-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318213051.3200981-1-niklas.soderlund+renesas@ragnatech.se>
References: <20200318213051.3200981-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If the media device implements the graph_complete callback utilise it
and fill in the completes of the graph in the struct media_device_info.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/mc/mc-device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index da8088351135298a..64c786570b6df129 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -75,6 +75,10 @@ static long media_device_get_info(struct media_device *dev, void *arg)
 	info->driver_version = info->media_version;
 	info->hw_revision = dev->hw_revision;
 
+	if (dev->ops && dev->ops->graph_complete)
+		info->flags |= dev->ops->graph_complete(dev) ?
+			MEDIA_INFO_FLAG_COMPLETE : MEDIA_INFO_FLAG_INCOMPLETE;
+
 	return 0;
 }
 
-- 
2.25.1

