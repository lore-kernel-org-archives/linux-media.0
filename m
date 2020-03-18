Return-Path: <SRS0=m313=5D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27951C5ACDB
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 00:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD4120663
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 00:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZjKxqJdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCRAZZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:25:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59906 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgCRAZZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 Mar 2020 20:25:25 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A7F51AF4;
        Wed, 18 Mar 2020 01:25:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584491123;
        bh=F9fnX25PXHg69eh7lpuMOqNiq3h0+N0RLw+RaLbWWnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjKxqJdPkq8HYXxvfCedlI4EVGRfUM0pNK/oLY9bpqhsdnWKTDcfk6hB9zVEgZ1yq
         WBjjXrTiqN/Mjo+ciEGFFFu/vHmqw1j9sFF33pI9IEBMgTyYKfqfG1f8eYBg1kJt5b
         BSsEOio4FAaJ29iKT7r1+yomyRZocADmoOSXCR7o=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 4/4] media: v4l2-async: Don't check fwnode name to detect endpoint
Date:   Wed, 18 Mar 2020 02:25:07 +0200
Message-Id: <20200318002507.30336-5-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318002507.30336-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20200318002507.30336-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use the presence of a "remote-endpoint" property to detect if a fwnode
is an endpoint node, as checking the node name won't work on ACPI-based
implementations.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-async.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 9f393a7be455..a5f83ba502df 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -78,7 +78,6 @@ static bool match_fwnode(struct v4l2_async_notifier *notifier,
 	bool asd_fwnode_is_ep;
 	bool sd_fwnode_is_ep;
 	struct device *dev;
-	const char *name;
 
 	/*
 	 * Both the subdev and the async subdev can provide either an endpoint
@@ -92,10 +91,10 @@ static bool match_fwnode(struct v4l2_async_notifier *notifier,
 	 * Otherwise, check if the sd fwnode and the asd fwnode refer to an
 	 * endpoint or a device. If they're of the same type, there's no match.
 	 */
-	name = fwnode_get_name(sd->fwnode);
-	sd_fwnode_is_ep = name && strstarts(name, "endpoint");
-	name = fwnode_get_name(asd->match.fwnode);
-	asd_fwnode_is_ep = name && strstarts(name, "endpoint");
+	sd_fwnode_is_ep = fwnode_property_present(sd->fwnode,
+						  "remote-endpoint");
+	asd_fwnode_is_ep = fwnode_property_present(asd->match.fwnode,
+						   "remote-endpoint");
 
 	if (sd_fwnode_is_ep == asd_fwnode_is_ep)
 		return false;
-- 
Regards,

Laurent Pinchart

