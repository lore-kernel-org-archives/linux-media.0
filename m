Return-Path: <SRS0=QBGf=7J=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736B4C433DF
	for <linux-media@archiver.kernel.org>; Wed, 27 May 2020 09:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3952075A
	for <linux-media@archiver.kernel.org>; Wed, 27 May 2020 09:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgE0JlO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 27 May 2020 05:41:14 -0400
Received: from gofer.mess.org ([88.97.38.141]:50849 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbgE0JlK (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 27 May 2020 05:41:10 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id DF3E8C6405; Wed, 27 May 2020 10:41:07 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH v2 3/3] MAINTAINERS: rc core and lirc maintainership
Date:   Wed, 27 May 2020 10:41:07 +0100
Message-Id: <20200527094107.11936-4-sean@mess.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527094107.11936-1-sean@mess.org>
References: <20200527094107.11936-1-sean@mess.org>
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
index 552e82f9adc0..b9677d250f2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14180,6 +14180,19 @@ L:	linux-wireless@vger.kernel.org
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

