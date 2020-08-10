Return-Path: <SRS0=Qguu=BU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DDEC433DF
	for <linux-media@archiver.kernel.org>; Mon, 10 Aug 2020 19:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016372080C
	for <linux-media@archiver.kernel.org>; Mon, 10 Aug 2020 19:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgHJTRM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:17:12 -0400
Received: from iodev.co.uk ([193.29.56.124]:47820 "EHLO iodev.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbgHJTRK (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 10 Aug 2020 15:17:10 -0400
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     linux-media@vger.kernel.org
Cc:     Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] MAINTAINERS: Remove broken bluecherry.net email
Date:   Mon, 10 Aug 2020 21:17:55 +0200
Message-Id: <20200810191755.25883-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f77df02e4121..c3db4b4819fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15997,7 +15997,6 @@ F:	include/uapi/rdma/rdma_user_rxe.h
 SOFTLOGIC 6x10 MPEG CODEC
 M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
 M:	Anton Sviridenko <anton@corp.bluecherry.net>
-M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
 M:	Andrey Utkin <andrey_utkin@fastmail.com>
 M:	Ismael Luceno <ismael@iodev.co.uk>
 L:	linux-media@vger.kernel.org
-- 
2.28.0

