Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2EAC433B4
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 09:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617B8613B2
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 09:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhDMJmq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:42:46 -0400
Received: from gofer.mess.org ([88.97.38.141]:43041 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhDMJmp (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 13 Apr 2021 05:42:45 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 893A0C6350; Tue, 13 Apr 2021 10:42:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1618306945; bh=8z9z4oG4jvEW3yQqi8L0K90oRkjJfTDZRA8zamwEzbM=;
        h=From:To:Subject:Date:From;
        b=gScu5C3GF3Bz4GAYTJsg+u7rG5LDzqXZ6gf91x9lFGJAH/OxIbfwU/mjzSnllyG7h
         pm4KaSxpQQOWNZzL2xrRxubjpEHP8eMtjnulsxROEvBYgeSrVaK0su+uZ6sQEH70VF
         UrYxCvBpKXPRikSbd5n/YdquPNs8v++r8qHUiFuvDf3PNcriyHyHr3B2Qu6XhBMYJV
         U7ZGpyhMzAaeSam8YbBFrLhXx3qQd3Lr6gENP6HFLPso8CBxm+Eir/MZ/uOtpveUVh
         01xYif/WzNPHPkInAxx3q0Ecv0L1IxcFvliRh7tOU6tBU1ljLpj+gCWmnK7xWawE9d
         GL8MDUArOTCHw==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH] media: lirc: remove out of date comment
Date:   Tue, 13 Apr 2021 10:42:25 +0100
Message-Id: <20210413094225.5265-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This file has been updated many times since 2010.

Signed-off-by: Sean Young <sean@mess.org>
---
 include/uapi/linux/lirc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/lirc.h b/include/uapi/linux/lirc.h
index c45a4eaea667..9919f2062b14 100644
--- a/include/uapi/linux/lirc.h
+++ b/include/uapi/linux/lirc.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * lirc.h - linux infrared remote control header file
- * last modified 2010/07/13 by Jarod Wilson
  */
 
 #ifndef _LINUX_LIRC_H
-- 
2.30.2

