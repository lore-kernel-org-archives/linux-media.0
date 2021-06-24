Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE2EC49EA5
	for <linux-media@archiver.kernel.org>; Thu, 24 Jun 2021 08:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9FD613D8
	for <linux-media@archiver.kernel.org>; Thu, 24 Jun 2021 08:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFXInO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 24 Jun 2021 04:43:14 -0400
Received: from retiisi.eu ([95.216.213.190]:51506 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFXInM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 24 Jun 2021 04:43:12 -0400
Received: from lanttu.localdomain (unknown [192.168.2.193])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 36619634C8D;
        Thu, 24 Jun 2021 11:40:32 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v3 4/6] media: v4l2-fwnode: Simplify v4l2_async_nf_parse_fwnode_endpoints()
Date:   Thu, 24 Jun 2021 11:40:44 +0300
Message-Id: <20210624084046.13136-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624084046.13136-1-sakari.ailus@linux.intel.com>
References: <20210624084046.13136-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

There are only one user left of __v4l2_async_nf_parse_fwnode_ep()
since [1], v4l2_async_nf_parse_fwnode_endpoints(). The two
functions can be merged.

The merge of the two highlights a dead code block conditioned by the
argument 'has_port' that always is false and can therefor be removed.

1. commit 0ae426ebd0dcef81 ("media: v4l2-fwnode: Remove v4l2_async_notifier_parse_fwnode_endpoints_by_port()")

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
[Sakari Ailus: Aligned some lines to opening parentheses.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 31 +++++----------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index e5507501b0f3..00457e1e93f6 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -839,12 +839,11 @@ v4l2_async_nf_fwnode_parse_endpoint(struct device *dev,
 	return ret == -ENOTCONN ? 0 : ret;
 }
 
-static int
-__v4l2_async_nf_parse_fwnode_ep(struct device *dev,
-				struct v4l2_async_notifier *notifier,
-				size_t asd_struct_size, unsigned int port,
-				bool has_port,
-				parse_endpoint_func parse_endpoint)
+int
+v4l2_async_nf_parse_fwnode_endpoints(struct device *dev,
+				     struct v4l2_async_notifier *notifier,
+				     size_t asd_struct_size,
+				     parse_endpoint_func parse_endpoint)
 {
 	struct fwnode_handle *fwnode;
 	int ret = 0;
@@ -862,16 +861,6 @@ __v4l2_async_nf_parse_fwnode_ep(struct device *dev,
 		if (!is_available)
 			continue;
 
-		if (has_port) {
-			struct fwnode_endpoint ep;
-
-			ret = fwnode_graph_parse_endpoint(fwnode, &ep);
-			if (ret)
-				break;
-
-			if (ep.port != port)
-				continue;
-		}
 
 		ret = v4l2_async_nf_fwnode_parse_endpoint(dev, notifier,
 							  fwnode,
@@ -885,16 +874,6 @@ __v4l2_async_nf_parse_fwnode_ep(struct device *dev,
 
 	return ret;
 }
-
-int
-v4l2_async_nf_parse_fwnode_endpoints(struct device *dev,
-				     struct v4l2_async_notifier *notifier,
-				     size_t asd_struct_size,
-				     parse_endpoint_func parse_endpoint)
-{
-	return __v4l2_async_nf_parse_fwnode_ep(dev, notifier, asd_struct_size,
-					       0, false, parse_endpoint);
-}
 EXPORT_SYMBOL_GPL(v4l2_async_nf_parse_fwnode_endpoints);
 
 /*
-- 
2.30.2

