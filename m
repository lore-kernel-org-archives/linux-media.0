Return-Path: <SRS0=QBGf=7J=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A505C433E0
	for <linux-media@archiver.kernel.org>; Wed, 27 May 2020 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045AC207CB
	for <linux-media@archiver.kernel.org>; Wed, 27 May 2020 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbgE0PD5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 27 May 2020 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388922AbgE0PD4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 27 May 2020 11:03:56 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FA2C03E96E;
        Wed, 27 May 2020 08:03:55 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 0A69CC6405; Wed, 27 May 2020 16:03:53 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH v3 3/3] MAINTAINERS: rc core and lirc maintainership
Date:   Wed, 27 May 2020 16:03:52 +0100
Message-Id: <20200527150352.18840-4-sean@mess.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527150352.18840-1-sean@mess.org>
References: <20200527150352.18840-1-sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This has been maintained for some time, update MAINTAINERS to reflect.

Signed-off-by: Sean Young <sean@mess.org>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 791d2a862e41..73f97fea8ba8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14190,6 +14190,19 @@ L:	linux-wireless@vger.kernel.org
 S:	Orphan
 F:	drivers/net/wireless/ray*
 
+RC CORE / LIRC FRAMEWORK
+M:	Sean Young <sean@mess.org>
+L:	linux-media@vger.kernel.org
+S:	Supported
+W:	http://linuxtv.org
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/driver-api/media/rc-core.rst
+F:	Documentation/userspace-api/media/rc/
+F:	drivers/media/rc/
+F:	include/media/rc-map.h
+F:	include/media/rc-core.h
+F:	include/uapi/linux/lirc.h
+
 RCMM REMOTE CONTROLS DECODER
 M:	Patrick Lerda <patrick9876@free.fr>
 S:	Maintained
-- 
2.26.2

