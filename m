Return-Path: <SRS0=IKb/=4T=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4FBC3F2D2
	for <linux-media@archiver.kernel.org>; Mon,  2 Mar 2020 11:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF4C2080C
	for <linux-media@archiver.kernel.org>; Mon,  2 Mar 2020 11:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgCBLJf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:09:35 -0500
Received: from retiisi.org.uk ([95.216.213.190]:45066 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgCBLJf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 2 Mar 2020 06:09:35 -0500
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 541B3634C87
        for <linux-media@vger.kernel.org>; Mon,  2 Mar 2020 13:09:19 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 1/1] mailmap: Add entry for my @iki.fi address
Date:   Mon,  2 Mar 2020 13:07:01 +0200
Message-Id: <20200302110701.13495-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add entry for my @iki.fi e-mail address to the mailmap.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ffb8f28290c7..5e650fb097ca 100644
--- a/.mailmap
+++ b/.mailmap
@@ -243,6 +243,7 @@ Santosh Shilimkar <ssantosh@kernel.org>
 Santosh Shilimkar <santosh.shilimkar@oracle.org>
 Sascha Hauer <s.hauer@pengutronix.de>
 S.Çağlar Onur <caglar@pardus.org.tr>
+Sakari Ailus <sakari.ailus@linux.intel.com> <sakari.ailus@iki.fi>
 Sean Nyekjaer <sean@geanix.com> <sean.nyekjaer@prevas.dk>
 Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
-- 
2.20.1

