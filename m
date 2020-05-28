Return-Path: <SRS0=cE1+=7K=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491A7C433E1
	for <linux-media@archiver.kernel.org>; Thu, 28 May 2020 10:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CAC20888
	for <linux-media@archiver.kernel.org>; Thu, 28 May 2020 10:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbgE1KzQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 May 2020 06:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbgE1KzM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 May 2020 06:55:12 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243BCC08C5C5;
        Thu, 28 May 2020 03:55:12 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id D73E2C63A8; Thu, 28 May 2020 11:55:08 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH v4 3/3] MAINTAINERS: rc core and lirc maintainership
Date:   Thu, 28 May 2020 11:55:08 +0100
Message-Id: <20200528105508.5183-4-sean@mess.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200528105508.5183-1-sean@mess.org>
References: <20200528105508.5183-1-sean@mess.org>
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

