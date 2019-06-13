Return-Path: <SRS0=gKyG=UM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B24DC31E49
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC092054F
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbfFMPSj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:18:39 -0400
Received: from retiisi.org.uk ([95.216.213.190]:51208 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732149AbfFMNEJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 13 Jun 2019 09:04:09 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 95FB7634C7D;
        Thu, 13 Jun 2019 16:04:03 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl
Subject: [PATCH 1/2] v4l2-fwnode: Avoid using PTR_ERR(NULL)
Date:   Thu, 13 Jun 2019 16:03:59 +0300
Message-Id: <20190613130400.6388-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190613130400.6388-1-sakari.ailus@linux.intel.com>
References: <20190613130400.6388-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

PTR_ERR(NULL) yields 0 which is commonly used to denote success. This is
the case here, and PTR_ERR(NULL) is apparently shunned upon. Fix this by
explicitly returning 0 if fwnode == NULL.

Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index dea8917fd912..fed71943983a 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -1098,11 +1098,7 @@ v4l2_fwnode_reference_parse_int_props(struct device *dev,
 		}
 	}
 
-	return PTR_ERR(fwnode) == -ENOENT ? 0 : PTR_ERR(fwnode);
-
-error:
-	fwnode_handle_put(fwnode);
-	return ret;
+	return !fwnode || PTR_ERR(fwnode) == -ENOENT ? 0 : PTR_ERR(fwnode);
 }
 
 int v4l2_async_notifier_parse_fwnode_sensor_common(struct device *dev,
-- 
2.11.0

