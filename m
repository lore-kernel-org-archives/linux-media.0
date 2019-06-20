Return-Path: <SRS0=eAtd=UT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E9C43613
	for <linux-media@archiver.kernel.org>; Thu, 20 Jun 2019 14:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D7320679
	for <linux-media@archiver.kernel.org>; Thu, 20 Jun 2019 14:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfFTOR6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:17:58 -0400
Received: from retiisi.org.uk ([95.216.213.190]:39188 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbfFTOR5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 20 Jun 2019 10:17:57 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 05CB2634C7B;
        Thu, 20 Jun 2019 17:17:22 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH 1/1] MAINTAINERS: Add maintainers for Media Controller
Date:   Thu, 20 Jun 2019 17:17:53 +0300
Message-Id: <20190620141753.15983-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When Media Controller was merged to mainline long, long time ago, no-one
bothered to think what its MAINTAINERS entry should be. Now that Media
Controller is moved into its own directory, address this at the same time.

So tell people to mail patches to myself and Laurent Pinchart.

Note that the patches are still merged through the Media tree, just like
any other driver or framework bits that have separate "mail patches to"
entries different from the main drivers/media one.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
This patch adds a MAINTAINERS entry for the MC framework and API, as
discussed in this week's weekly meeting.

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad2bf808b02c..0a064d10a5df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9643,6 +9643,17 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/dac/cio-dac.c
 
+MEDIA CONTROLLER FRAMEWORK
+M:	Sakari Ailus <sakari.ailus@linux.intel.com>
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+L:	linux-media@vger.kernel.org
+W:	https://www.linuxtv.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Supported
+F:	drivers/media/mc/
+F:	include/media/media-*.h
+F:	include/uapi/linux/media.h
+
 MEDIA DRIVERS FOR ASCOT2E
 M:	Sergey Kozlov <serjk@netup.ru>
 M:	Abylay Ospan <aospan@netup.ru>
-- 
2.11.0

