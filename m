Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CFFC10F0F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9206721738
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 09:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfDEJlc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:41:32 -0400
Received: from retiisi.org.uk ([95.216.213.190]:40196 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730567AbfDEJlb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 5 Apr 2019 05:41:31 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 001EB634C89;
        Fri,  5 Apr 2019 12:40:45 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, niklas.soderlund@ragnatech.se,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH 6/9] v4l2-async: Safely clean up an uninitialised notifier
Date:   Fri,  5 Apr 2019 12:41:24 +0300
Message-Id: <20190405094127.18975-8-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
References: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Make the V4L2 async framework a bit more robust by allowing to clean up an
uninitialised notifier. Otherwise the result would be a (close to) NULL
pointer dereference.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 2ea8afbcbf8f..9107776b4550 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -537,7 +537,7 @@ static void __v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier)
 {
 	struct v4l2_async_subdev *asd, *tmp;
 
-	if (!notifier)
+	if (!notifier || !notifier->asd_list.next)
 		return;
 
 	list_for_each_entry_safe(asd, tmp, &notifier->asd_list, asd_list) {
-- 
2.11.0

