Return-Path: <SRS0=741g=XS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B50FC3A5A6
	for <linux-media@archiver.kernel.org>; Mon, 23 Sep 2019 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AAF2087C
	for <linux-media@archiver.kernel.org>; Mon, 23 Sep 2019 09:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfIWJOW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:14:22 -0400
Received: from retiisi.org.uk ([95.216.213.190]:50968 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbfIWJOW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Sep 2019 05:14:22 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 3B0A4634C87;
        Mon, 23 Sep 2019 12:13:19 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl
Subject: [PATCH 1/1] v4l: fwnode: Make v4l2_fwnode_endpoint_free() safer
Date:   Mon, 23 Sep 2019 12:11:12 +0300
Message-Id: <20190923091112.15067-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Assign vep->link_frequencies to NULL after releasing its memory. Without
this change, multiple calls to v4l2_fwnode_endpoint_free() would result in
double kfree calls.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 3bd1888787eb..192cac076761 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -512,6 +512,7 @@ void v4l2_fwnode_endpoint_free(struct v4l2_fwnode_endpoint *vep)
 		return;
 
 	kfree(vep->link_frequencies);
+	vep->link_frequencies = NULL;
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_endpoint_free);
 
-- 
2.20.1

