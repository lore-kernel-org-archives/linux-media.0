Return-Path: <SRS0=m313=5D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2209C43333
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 21:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA0E208D5
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 21:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCRVbK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:31:10 -0400
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:53525 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726747AbgCRVbK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 18 Mar 2020 17:31:10 -0400
X-Halon-ID: b2e1d9bc-695f-11ea-9f40-0050569116f7
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id b2e1d9bc-695f-11ea-9f40-0050569116f7;
        Wed, 18 Mar 2020 22:30:33 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [RFC 4/5] rcar-vin: Report the completeness of the media graph
Date:   Wed, 18 Mar 2020 22:30:50 +0100
Message-Id: <20200318213051.3200981-5-niklas.soderlund+renesas@ragnatech.se>
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

Implement the graph_complete callback and report if the media graph is
complete or not.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 13 +++++++++++++
 drivers/media/platform/rcar-vin/rcar-vin.h  |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index 7440c8965d27e64f..21ce3de8168c3224 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -221,8 +221,16 @@ static int rvin_group_link_notify(struct media_link *link, u32 flags,
 	return ret;
 }
 
+static bool rvin_group_graph_complete(struct media_device *mdev)
+{
+	struct rvin_group *group = container_of(mdev, struct rvin_group, mdev);
+
+	return group->complete;
+}
+
 static const struct media_device_ops rvin_media_ops = {
 	.link_notify = rvin_group_link_notify,
+	.graph_complete = rvin_group_graph_complete,
 };
 
 /* -----------------------------------------------------------------------------
@@ -735,6 +743,9 @@ static int rvin_group_notify_complete(struct v4l2_async_notifier *notifier)
 			break;
 		}
 	}
+
+	vin->group->complete = true;
+
 	mutex_unlock(&vin->group->lock);
 
 	return ret;
@@ -761,6 +772,8 @@ static void rvin_group_notify_unbind(struct v4l2_async_notifier *notifier,
 		break;
 	}
 
+	vin->group->complete = false;
+
 	mutex_unlock(&vin->group->lock);
 }
 
diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
index c19d077ce1cb4f4b..ff04adbb969b07de 100644
--- a/drivers/media/platform/rcar-vin/rcar-vin.h
+++ b/drivers/media/platform/rcar-vin/rcar-vin.h
@@ -263,6 +263,8 @@ struct rvin_dev {
  * @vin:		VIN instances which are part of the group
  * @csi:		array of pairs of fwnode and subdev pointers
  *			to all CSI-2 subdevices.
+ * @complete:		True if all devices of the group are in the media graph,
+ *			false otherwise.
  */
 struct rvin_group {
 	struct kref refcount;
@@ -278,6 +280,8 @@ struct rvin_group {
 		struct fwnode_handle *fwnode;
 		struct v4l2_subdev *subdev;
 	} csi[RVIN_CSI_MAX];
+
+	bool complete;
 };
 
 int rvin_dma_register(struct rvin_dev *vin, int irq);
-- 
2.25.1

