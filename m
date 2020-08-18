Return-Path: <SRS0=pHRl=B4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1820FC433DF
	for <linux-media@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E515020829
	for <linux-media@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="DqsqoQz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHROhc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:37:32 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:43599 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbgHROhX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Aug 2020 10:37:23 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 82jnkV8V2uuXO82jpkcew9; Tue, 18 Aug 2020 16:37:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1597761442; bh=OLItc/6ATCTjvCKoVPDewrpsgVS2/ejTohaXC+Gu3dQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=DqsqoQz4hVBQK/O5XF2BQ99JUJIpa34oHezasDH0LFJLU/A3KRrTx2v9VX7svjAhs
         11aa4bdt47W3tb/skPFq33w75JHoBhYLbJEXSslfGbYd/vp2F1TZ8x71pbRM2hCRAz
         qqhdLjkV1o2nccmMWIEb9+mk5O1nly9+WmvQl6hhCog1173WYniGMSngOS47DegbfC
         U/ZZpr/rmlh+ZbIuUk4P6Tbck2iAl44cequibE9Tej7M/HyDIVuBgACnlCSZXT+TFb
         NPRzTb8JUF+Y/8EMDiWUWgAq7vBRUYlMoKdZzQonxA3+B2Yf5vcni1PhZyk6hz+Jx/
         tAUgrN3CKipuw==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2 10/12] vim2m: use v4l2_m2m_request_validate()
Date:   Tue, 18 Aug 2020 16:37:17 +0200
Message-Id: <20200818143719.102128-11-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200818143719.102128-1-hverkuil-cisco@xs4all.nl>
References: <20200818143719.102128-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP7+giVF2yARMvQzXdrB71WPzNzQPnB2vBNV1zfb1go6qlHWCQCw4uRfchZzAtnyfp0sjerWlDwxlnd+NRkCSGe+Ssx86NCHGizcu7rYZjJtzqBclj53
 r5W8DV3IokiHycHwkfLGx7GvawPyJu7LvgeL0v+J5Zub5V9htD1Y7Lvh9xeGR9Cd4EmXY/ZOgOaWpXOFuskI4fyg06+A9NTsUNGJHKcnAJEnkBnNbpMlquh6
 RSPY9OPI6N0AfK25Z0Ua34xg2WwfPoGnKMLfHaEK/11FnxpdlEvGGMBQWw4nEX0/ro4KOZzEG/+iGxGiB8Qu7HaGmA2IF0gVJ8N25ZZqX0btdRWZiCCj9pku
 dZHPYtPI
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use v4l2_m2m_request_validate() instead of vb2_request_validate.
The v4l2_m2m_request_validate() ensures that a control handler
request object is added if it was missing.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/test-drivers/vim2m.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index a776bb8e0e09..b73de65c0006 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -1230,6 +1230,7 @@ static int vim2m_open(struct file *file)
 		goto open_unlock;
 	}
 
+	ctx->fh.m2m_ctx->req_ctrl_handler = hdl;
 	v4l2_fh_add(&ctx->fh);
 	atomic_inc(&dev->num_inst);
 
@@ -1299,7 +1300,7 @@ static const struct v4l2_m2m_ops m2m_ops = {
 };
 
 static const struct media_device_ops m2m_media_ops = {
-	.req_validate = vb2_request_validate,
+	.req_validate = v4l2_m2m_request_validate,
 	.req_queue = v4l2_m2m_request_queue,
 };
 
-- 
2.27.0

