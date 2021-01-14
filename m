Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A06AC433E6
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D32823A34
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 18:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbhANSF5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbhANSFv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 14 Jan 2021 13:05:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71FC061757;
        Thu, 14 Jan 2021 10:05:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 50DCB1F45C37
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, hans.verkuil@cisco.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Subject: [PATCH 1/3] media: v4l2-ioctl: print capabilities in v4l_print_create_buffers()
Date:   Thu, 14 Jan 2021 15:01:47 -0300
Message-Id: <20210114180149.1755892-2-helen.koike@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114180149.1755892-1-helen.koike@collabora.com>
References: <20210114180149.1755892-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Print capabilities field from struct v4l2_create_buffers for better
debugging.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 3198abdd538c..848286a284f6 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -518,9 +518,9 @@ static void v4l_print_create_buffers(const void *arg, bool write_only)
 {
 	const struct v4l2_create_buffers *p = arg;
 
-	pr_cont("index=%d, count=%d, memory=%s, ",
-			p->index, p->count,
-			prt_names(p->memory, v4l2_memory_names));
+	pr_cont("index=%d, count=%d, memory=%s, capabilities=0x%08x, ",
+		p->index, p->count, prt_names(p->memory, v4l2_memory_names),
+		p->capabilities);
 	v4l_print_format(&p->format, write_only);
 }
 
-- 
2.29.2

