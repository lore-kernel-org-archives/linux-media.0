Return-Path: <SRS0=mj7L=BV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A33C433E1
	for <linux-media@archiver.kernel.org>; Tue, 11 Aug 2020 21:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2003220781
	for <linux-media@archiver.kernel.org>; Tue, 11 Aug 2020 21:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nEfyoBDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgHKVAB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:00:01 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34412 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHKVAA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 11 Aug 2020 17:00:00 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D952EA58;
        Tue, 11 Aug 2020 22:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597179598;
        bh=/5wHBBjqGC9/LSSvdS751wrrb4f3m8aIlkTDSBEGpMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEfyoBDVc1q+eUDJ5JnZ+jvDSRQvcrl4b72tKZ+k16BP9xw0Tz1OhC0GNDI8R6msC
         ro9IsKrkd/oxCYvcAaBLLoe2Ku1qQfa+1eFxuSOj2/2jUiMa+gQTJBBLPydO0aSlpG
         r+Me7NgJJOZetulMXyhMeUNy+8sHur2h376sPUvs=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Ramesh Shanmugasundaram <rashanmu@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steve Longerbeam <slongerbeam@gmail.com>
Subject: [PATCH 1/5] media: v4l2-async: Document asd allocation requirements
Date:   Tue, 11 Aug 2020 23:59:35 +0300
Message-Id: <20200811205939.19550-2-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200811205939.19550-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20200811205939.19550-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The v4l2_async_notifier_add_subdev() function requires the asd pointer
it receives to be allocated dynamically, but doesn't explicitly say so.
Only one driver out of 13 get its right (atmel-sama5d2-isc.c, but with
memory leaks in the error paths), clearly showing we have an issue.

Update the v4l2_async_notifier_add_subdev() documentation to clearly
state the allocation requirement. Whether this will be enough to avoid
new offending code isn't certain, but it's a good first step
nonetheless.

Fixes: 9ca465312132 ("media: v4l: fwnode: Support generic parsing of graph endpoints in a device")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 include/media/v4l2-async.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 8319284c93cb..d6e31234826f 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -154,8 +154,9 @@ void v4l2_async_notifier_init(struct v4l2_async_notifier *notifier);
  * @notifier: pointer to &struct v4l2_async_notifier
  * @asd: pointer to &struct v4l2_async_subdev
  *
- * Call this function before registering a notifier to link the
- * provided asd to the notifiers master @asd_list.
+ * Call this function before registering a notifier to link the provided @asd to
+ * the notifiers master @asd_list. The @asd must be allocated with k*alloc() as
+ * it will be freed by the framework when the notifier is destroyed.
  */
 int v4l2_async_notifier_add_subdev(struct v4l2_async_notifier *notifier,
 				   struct v4l2_async_subdev *asd);
-- 
Regards,

Laurent Pinchart

