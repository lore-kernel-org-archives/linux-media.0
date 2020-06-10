Return-Path: <SRS0=cH4w=7X=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B621BC433E2
	for <linux-media@archiver.kernel.org>; Wed, 10 Jun 2020 23:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93ACF2078D
	for <linux-media@archiver.kernel.org>; Wed, 10 Jun 2020 23:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFJXGA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:06:00 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:13267 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbgFJXGA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Jun 2020 19:06:00 -0400
X-Halon-ID: eed6ab18-ab6e-11ea-933e-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2eca.dip0.t-ipconnect.de [79.202.46.202])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id eed6ab18-ab6e-11ea-933e-005056917a89;
        Thu, 11 Jun 2020 01:05:53 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/5] uapi/linux/media.h: add flags field to struct media_v2_topology
Date:   Thu, 11 Jun 2020 01:05:37 +0200
Message-Id: <20200610230541.1603067-2-niklas.soderlund+renesas@ragnatech.se>
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

Add a flags field to the media_v2_topology structure by taking one
of the reserved u32 fields. Also define a flag to carry information
about if the graph is complete. The use-case is to have a way to report
to user-space if the media graph contains all subdevices.

The other bits in the flags field are unused for now, but could be
claimed to carry other type of information in the future.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/mc/mc-device.c | 2 +-
 include/uapi/linux/media.h   | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index da8088351135298a..c2ef5bb512a5fba0 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -242,6 +242,7 @@ static long media_device_get_topology(struct media_device *mdev, void *arg)
 	int ret = 0;
 
 	topo->topology_version = mdev->topology_version;
+	topo->flags = 0;
 
 	/* Get entities and number of entities */
 	i = 0;
@@ -269,7 +270,6 @@ static long media_device_get_topology(struct media_device *mdev, void *arg)
 		uentity++;
 	}
 	topo->num_entities = i;
-	topo->reserved1 = 0;
 
 	/* Get interfaces and number of interfaces */
 	i = 0;
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 383ac7b7d8f07eca..7c07b9939252c768 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -351,7 +351,7 @@ struct media_v2_topology {
 	__u64 topology_version;
 
 	__u32 num_entities;
-	__u32 reserved1;
+	__u32 flags;
 	__u64 ptr_entities;
 
 	__u32 num_interfaces;
@@ -367,6 +367,8 @@ struct media_v2_topology {
 	__u64 ptr_links;
 } __attribute__ ((packed));
 
+#define MEDIA_TOPOLOGY_FLAG_COMPLETE	(1 << 0)
+
 /* ioctls */
 
 #define MEDIA_IOC_DEVICE_INFO	_IOWR('|', 0x00, struct media_device_info)
-- 
2.27.0

