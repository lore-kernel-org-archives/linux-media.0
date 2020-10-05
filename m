Return-Path: <SRS0=4VRt=DM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B21C47095
	for <linux-media@archiver.kernel.org>; Mon,  5 Oct 2020 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109902068D
	for <linux-media@archiver.kernel.org>; Mon,  5 Oct 2020 08:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJEIBR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:01:17 -0400
Received: from retiisi.org.uk ([95.216.213.190]:36396 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEIBR (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 5 Oct 2020 04:01:17 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 4E893634C89;
        Mon,  5 Oct 2020 11:00:42 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, jacopo@jmondi.org,
        niklas.soderlund@ragnatech.se
Subject: [PATCH v2 1/5] adv748x: Zero entire struct v4l2_fwnode_endpoint
Date:   Mon,  5 Oct 2020 11:01:11 +0300
Message-Id: <20201005080115.8875-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201005080115.8875-1-sakari.ailus@linux.intel.com>
References: <20201005080115.8875-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The v4l2_fwnode_parse_endpoint() function can make use of defaults in
multiple bus types. To use this feature, all callers must zero the rest of
the fields of this struct, too. All other drivers appear to do that
already apart from this one.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/adv748x/adv748x-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-core.c b/drivers/media/i2c/adv748x/adv748x-core.c
index 1fe7f97c6d52..ae8b7ebf3830 100644
--- a/drivers/media/i2c/adv748x/adv748x-core.c
+++ b/drivers/media/i2c/adv748x/adv748x-core.c
@@ -589,14 +589,13 @@ static int adv748x_parse_csi2_lanes(struct adv748x_state *state,
 				    unsigned int port,
 				    struct device_node *ep)
 {
-	struct v4l2_fwnode_endpoint vep;
+	struct v4l2_fwnode_endpoint vep = { .bus_type = V4L2_MBUS_CSI2_DPHY };
 	unsigned int num_lanes;
 	int ret;
 
 	if (port != ADV748X_PORT_TXA && port != ADV748X_PORT_TXB)
 		return 0;
 
-	vep.bus_type = V4L2_MBUS_CSI2_DPHY;
 	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &vep);
 	if (ret)
 		return ret;
-- 
2.27.0

