Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC14C63697
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C2020B80
	for <linux-media@archiver.kernel.org>; Thu, 12 Nov 2020 22:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKLWxJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:53:09 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:58867 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgKLWxJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Nov 2020 17:53:09 -0500
X-Halon-ID: 8262efbd-2539-11eb-bcc0-005056917f90
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p4fca2458.dip0.t-ipconnect.de [79.202.36.88])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id 8262efbd-2539-11eb-bcc0-005056917f90;
        Thu, 12 Nov 2020 23:50:49 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/4] rcar-vin: Route events to correct video device
Date:   Thu, 12 Nov 2020 23:51:45 +0100
Message-Id: <20201112225147.1672622-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112225147.1672622-1-niklas.soderlund+renesas@ragnatech.se>
References: <20201112225147.1672622-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The event route for VIN running with a media controller (Gen3) is
incorrect as all events are only routed to the video device that are
used to register the async notifier.

Remedy this be examining which subdevice generated the event and route
it to all VIN(s) that are connected to that subdevice.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 44 ++++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
index 3e7a3ae2a6b97045..dca3ab1656a66cef 100644
--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -966,18 +966,50 @@ void rvin_v4l2_unregister(struct rvin_dev *vin)
 	video_unregister_device(&vin->vdev);
 }
 
+static void rvin_notify_video_device(struct rvin_dev *vin,
+				     unsigned int notification, void *arg)
+{
+	switch (notification) {
+	case V4L2_DEVICE_NOTIFY_EVENT:
+		v4l2_event_queue(&vin->vdev, arg);
+		break;
+	default:
+		break;
+	}
+}
+
 static void rvin_notify(struct v4l2_subdev *sd,
 			unsigned int notification, void *arg)
 {
+	struct v4l2_subdev *remote;
+	struct rvin_group *group;
+	struct media_pad *pad;
 	struct rvin_dev *vin =
 		container_of(sd->v4l2_dev, struct rvin_dev, v4l2_dev);
+	unsigned int i;
 
-	switch (notification) {
-	case V4L2_DEVICE_NOTIFY_EVENT:
-		v4l2_event_queue(&vin->vdev, arg);
-		break;
-	default:
-		break;
+	/* If no media controller, no need to route the event. */
+	if (!vin->info->use_mc) {
+		rvin_notify_video_device(vin, notification, arg);
+		return;
+	}
+
+	group = vin->group;
+
+	for (i = 0; i < RCAR_VIN_NUM; i++) {
+		vin = group->vin[i];
+		if (!vin)
+			continue;
+
+		pad = media_entity_remote_pad(&vin->pad);
+		if (!pad)
+			continue;
+
+		remote = media_entity_to_v4l2_subdev(pad->entity);
+		if (remote != sd)
+			continue;
+
+		rvin_notify_video_device(vin, notification, arg);
 	}
 }
 
-- 
2.29.2

