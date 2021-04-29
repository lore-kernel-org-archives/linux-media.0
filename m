Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03432C433ED
	for <linux-media@archiver.kernel.org>; Thu, 29 Apr 2021 21:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D149E6143A
	for <linux-media@archiver.kernel.org>; Thu, 29 Apr 2021 21:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhD2VB5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 29 Apr 2021 17:01:57 -0400
Received: from retiisi.eu ([95.216.213.190]:52700 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236695AbhD2VB5 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 29 Apr 2021 17:01:57 -0400
Received: from lanttu.localdomain (unknown [192.168.2.193])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 463CC634C89;
        Thu, 29 Apr 2021 23:59:07 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl
Subject: [PATCH 1/1] staging: ipu3-imgu: Document pages field
Date:   Fri, 30 Apr 2021 00:01:08 +0300
Message-Id: <20210429210108.26998-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The pages field in struct imgu_css_map was missing. Document it.

Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/staging/media/ipu3/ipu3-css-pool.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/ipu3/ipu3-css-pool.h b/drivers/staging/media/ipu3/ipu3-css-pool.h
index 35519a08c08c..3f9e32e0e9a7 100644
--- a/drivers/staging/media/ipu3/ipu3-css-pool.h
+++ b/drivers/staging/media/ipu3/ipu3-css-pool.h
@@ -15,6 +15,7 @@ struct imgu_device;
  * @size:		size of the buffer in bytes.
  * @vaddr:		kernel virtual address.
  * @daddr:		iova dma address to access IPU3.
+ * @pages:		pages mapped to this buffer
  */
 struct imgu_css_map {
 	size_t size;
-- 
2.29.2

