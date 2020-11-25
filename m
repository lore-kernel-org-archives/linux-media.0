Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C67C8300F
	for <linux-media@archiver.kernel.org>; Wed, 25 Nov 2020 16:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDD020857
	for <linux-media@archiver.kernel.org>; Wed, 25 Nov 2020 16:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbgKYQpf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 Nov 2020 11:45:35 -0500
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:19279 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbgKYQpe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 Nov 2020 11:45:34 -0500
X-Halon-ID: 9fe51827-2f3d-11eb-a78a-0050569116f7
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p4fca2458.dip0.t-ipconnect.de [79.202.36.88])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id 9fe51827-2f3d-11eb-a78a-0050569116f7;
        Wed, 25 Nov 2020 17:45:29 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 3/5] rcar-vin: Use v4l2_async_subdev instead of fwnode_handle to match subdevices
Date:   Wed, 25 Nov 2020 17:44:48 +0100
Message-Id: <20201125164450.2056963-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125164450.2056963-1-niklas.soderlund+renesas@ragnatech.se>
References: <20201125164450.2056963-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In preparation of removing the usage of the old helper
v4l2_async_notifier_parse_fwnode_endpoints_by_port() use the
v4l2_async_subdev instead of fwnode_handle to match subdevices.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 8 ++++----
 drivers/media/platform/rcar-vin/rcar-vin.h  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index 396ff5531359f3f4..830ab0865967310b 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -772,7 +772,7 @@ static void rvin_group_notify_unbind(struct v4l2_async_notifier *notifier,
 	mutex_lock(&vin->group->lock);
 
 	for (i = 0; i < RVIN_CSI_MAX; i++) {
-		if (vin->group->csi[i].fwnode != asd->match.fwnode)
+		if (vin->group->csi[i].asd != asd)
 			continue;
 		vin->group->csi[i].subdev = NULL;
 		vin_dbg(vin, "Unbind CSI-2 %s from slot %u\n", subdev->name, i);
@@ -794,7 +794,7 @@ static int rvin_group_notify_bound(struct v4l2_async_notifier *notifier,
 	mutex_lock(&vin->group->lock);
 
 	for (i = 0; i < RVIN_CSI_MAX; i++) {
-		if (vin->group->csi[i].fwnode != asd->match.fwnode)
+		if (vin->group->csi[i].asd != asd)
 			continue;
 		vin->group->csi[i].subdev = subdev;
 		vin_dbg(vin, "Bound CSI-2 %s to slot %u\n", subdev->name, i);
@@ -830,14 +830,14 @@ static int rvin_mc_parse_of_endpoint(struct device *dev,
 
 	mutex_lock(&vin->group->lock);
 
-	if (vin->group->csi[vep->base.id].fwnode) {
+	if (vin->group->csi[vep->base.id].asd) {
 		vin_dbg(vin, "OF device %pOF already handled\n",
 			to_of_node(asd->match.fwnode));
 		ret = -ENOTCONN;
 		goto out;
 	}
 
-	vin->group->csi[vep->base.id].fwnode = asd->match.fwnode;
+	vin->group->csi[vep->base.id].asd = asd;
 
 	vin_dbg(vin, "Add group OF device %pOF to slot %u\n",
 		to_of_node(asd->match.fwnode), vep->base.id);
diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
index 34e3979acf931b67..0ee9d402f5aceaf5 100644
--- a/drivers/media/platform/rcar-vin/rcar-vin.h
+++ b/drivers/media/platform/rcar-vin/rcar-vin.h
@@ -280,7 +280,7 @@ struct rvin_group {
 	struct rvin_dev *vin[RCAR_VIN_NUM];
 
 	struct {
-		struct fwnode_handle *fwnode;
+		struct v4l2_async_subdev *asd;
 		struct v4l2_subdev *subdev;
 	} csi[RVIN_CSI_MAX];
 };
-- 
2.29.2

