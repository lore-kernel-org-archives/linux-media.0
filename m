Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF96C433DB
	for <linux-media@archiver.kernel.org>; Tue, 23 Mar 2021 08:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE2361993
	for <linux-media@archiver.kernel.org>; Tue, 23 Mar 2021 08:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWIzR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Mar 2021 04:55:17 -0400
Received: from retiisi.eu ([95.216.213.190]:54586 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCWIzL (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Mar 2021 04:55:11 -0400
Received: from lanttu.localdomain (unknown [192.168.2.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 58395634C8B;
        Tue, 23 Mar 2021 10:51:38 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl
Subject: [PATCH 1/1] staging: ipu3-imgu: No need for kernel-doc comments in driver struct
Date:   Tue, 23 Mar 2021 10:55:09 +0200
Message-Id: <20210323085509.27231-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This part is rather trivial so adding more comments isn't really helpful.

Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/staging/media/ipu3/ipu3.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3.h b/drivers/staging/media/ipu3/ipu3.h
index 8cd6a0077d99..eb46b527dd23 100644
--- a/drivers/staging/media/ipu3/ipu3.h
+++ b/drivers/staging/media/ipu3/ipu3.h
@@ -63,11 +63,6 @@ struct imgu_node_mapping {
 	const char *name;
 };
 
-/**
- * struct imgu_video_device
- * each node registers as video device and maintains its
- * own vb2_queue.
- */
 struct imgu_video_device {
 	const char *name;
 	bool output;
-- 
2.29.2

