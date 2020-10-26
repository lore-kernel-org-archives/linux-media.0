Return-Path: <SRS0=Zg/f=EC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A071C55178
	for <linux-media@archiver.kernel.org>; Tue, 27 Oct 2020 00:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF3C216FD
	for <linux-media@archiver.kernel.org>; Tue, 27 Oct 2020 00:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603757061;
	bh=sJKzSfQY8uzihmpRwVTN/EAgVg3GpFoCkG/vfM+f3PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPB8o84yRkMviZSXJzIWO/Zf8HoRXTaoude8rBXlGKErxc0bj4extSJ0NMW6TLpux
	 1Egk0DqvjcYQpWGGpu2viMUlKAHINJAoYzt85dYKenGRp0VQMw1mG7/em9315qatFq
	 xX/1bby3we3xsGHDOWmvIrbIZjQoyPrR8tOsPZOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437586AbgJ0AEE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411013AbgJZXz6 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Oct 2020 19:55:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B38272151B;
        Mon, 26 Oct 2020 23:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756557;
        bh=sJKzSfQY8uzihmpRwVTN/EAgVg3GpFoCkG/vfM+f3PY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPZv+6jUqRSM3s4GlvydfBapttMaIgDgS1aYQzGSwAg5bDb9IMrbdZrg9BCTyS2Jc
         bNK8es2jqxuffbY4jOLJ3XwnV9eq+ozH1fMEYoLnjy7VdBmtpxhi9Hd8QdEbGWamPP
         a8mYYpl3OeVduAlrBvN3yfGE4ozZWJqnc1n1hDdc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 33/80] media: uvcvideo: Fix dereference of out-of-bound list iterator
Date:   Mon, 26 Oct 2020 19:54:29 -0400
Message-Id: <20201026235516.1025100-33-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235516.1025100-1-sashal@kernel.org>
References: <20201026235516.1025100-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

[ Upstream commit f875bcc375c738bf2f599ff2e1c5b918dbd07c45 ]

Fixes the following coccinelle report:

drivers/media/usb/uvc/uvc_ctrl.c:1860:5-11:
ERROR: invalid reference to the index variable of the iterator on line 1854

by adding a boolean variable to check if the loop has found the

Found using - Coccinelle (http://coccinelle.lip6.fr)

[Replace cursor variable with bool found]

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e399b9fad7574..aed84528758f6 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1844,30 +1844,35 @@ int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 {
 	struct uvc_entity *entity;
 	struct uvc_control *ctrl;
-	unsigned int i, found = 0;
+	unsigned int i;
+	bool found;
 	u32 reqflags;
 	u16 size;
 	u8 *data = NULL;
 	int ret;
 
 	/* Find the extension unit. */
+	found = false;
 	list_for_each_entry(entity, &chain->entities, chain) {
 		if (UVC_ENTITY_TYPE(entity) == UVC_VC_EXTENSION_UNIT &&
-		    entity->id == xqry->unit)
+		    entity->id == xqry->unit) {
+			found = true;
 			break;
+		}
 	}
 
-	if (entity->id != xqry->unit) {
+	if (!found) {
 		uvc_trace(UVC_TRACE_CONTROL, "Extension unit %u not found.\n",
 			xqry->unit);
 		return -ENOENT;
 	}
 
 	/* Find the control and perform delayed initialization if needed. */
+	found = false;
 	for (i = 0; i < entity->ncontrols; ++i) {
 		ctrl = &entity->controls[i];
 		if (ctrl->index == xqry->selector - 1) {
-			found = 1;
+			found = true;
 			break;
 		}
 	}
-- 
2.25.1

