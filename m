Return-Path: <SRS0=4VRt=DM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75131C4727E
	for <linux-media@archiver.kernel.org>; Mon,  5 Oct 2020 08:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E64120756
	for <linux-media@archiver.kernel.org>; Mon,  5 Oct 2020 08:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJEIBT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:01:19 -0400
Received: from retiisi.org.uk ([95.216.213.190]:36434 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEIBS (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 5 Oct 2020 04:01:18 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 8EB00634C8F;
        Mon,  5 Oct 2020 11:00:42 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, jacopo@jmondi.org,
        niklas.soderlund@ragnatech.se
Subject: [PATCH v2 5/5] v4l2-fwnode: Say it's fine to use v4l2_fwnode_endpoint_parse
Date:   Mon,  5 Oct 2020 11:01:15 +0300
Message-Id: <20201005080115.8875-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201005080115.8875-1-sakari.ailus@linux.intel.com>
References: <20201005080115.8875-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Earlier it was expected that there would be more variable size endpoint
properties and that most if not all drivers would need them. For that
reason it was expected also that v4l2_fwnode_endpoint_parse would no
longer be needed.

What actually happened that not all drivers require "link-frequencies",
the only variable size media endpoint property without a small upper
limit. Therefore drivers that do not need that information are fine using
v4l2_fwnode_endpoint_parse. So don't tell drivers to use
v4l2_fwnode_endpoint_alloc_parse in all cases.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 include/media/v4l2-fwnode.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index 20b30d770944..be30e066c621 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -245,9 +245,9 @@ struct v4l2_fwnode_connector {
  *
  * The function does not change the V4L2 fwnode endpoint state if it fails.
  *
- * NOTE: This function does not parse properties the size of which is variable
- * without a low fixed limit. Please use v4l2_fwnode_endpoint_alloc_parse() in
- * new drivers instead.
+ * NOTE: This function does not parse "link-frequencies" property as its size is
+ * not known in advance. Please use v4l2_fwnode_endpoint_alloc_parse() if you
+ * need properties of variable size.
  *
  * Return: %0 on success or a negative error code on failure:
  *	   %-ENOMEM on memory allocation failure
-- 
2.27.0

