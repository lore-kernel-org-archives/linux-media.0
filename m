Return-Path: <SRS0=4VRt=DM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C991C4363A
	for <linux-media@archiver.kernel.org>; Mon,  5 Oct 2020 08:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1D52068D
	for <linux-media@archiver.kernel.org>; Mon,  5 Oct 2020 08:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJEIBS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:01:18 -0400
Received: from retiisi.org.uk ([95.216.213.190]:36416 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEIBR (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 5 Oct 2020 04:01:17 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 74D70634C8D;
        Mon,  5 Oct 2020 11:00:42 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, jacopo@jmondi.org,
        niklas.soderlund@ragnatech.se
Subject: [PATCH v2 3/5] v4l2-fwnode: Don't zero parts of struct v4l2_fwnode_endpoint anymore
Date:   Mon,  5 Oct 2020 11:01:13 +0300
Message-Id: <20201005080115.8875-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201005080115.8875-1-sakari.ailus@linux.intel.com>
References: <20201005080115.8875-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Don't zero parts of the vep argument to v4l2_fwnode_endpoint_parse()
anymore as this can no longer be done while still supporting defaults on
multiple bus types.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index dfc53d11053f..44dd04b05e29 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -416,20 +416,8 @@ static int __v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwnode,
 	enum v4l2_mbus_type mbus_type;
 	int rval;
 
-	if (vep->bus_type == V4L2_MBUS_UNKNOWN) {
-		/* Zero fields from bus union to until the end */
-		memset(&vep->bus, 0,
-		       sizeof(*vep) - offsetof(typeof(*vep), bus));
-	}
-
 	pr_debug("===== begin parsing endpoint %pfw\n", fwnode);
 
-	/*
-	 * Zero the fwnode graph endpoint memory in case we don't end up parsing
-	 * the endpoint.
-	 */
-	memset(&vep->base, 0, sizeof(vep->base));
-
 	fwnode_property_read_u32(fwnode, "bus-type", &bus_type);
 	pr_debug("fwnode video bus type %s (%u), mbus type %s (%u)\n",
 		 v4l2_fwnode_bus_type_to_string(bus_type), bus_type,
-- 
2.27.0

