Return-Path: <SRS0=KMyM=EB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD9C2D0A3
	for <linux-media@archiver.kernel.org>; Mon, 26 Oct 2020 23:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36372224E
	for <linux-media@archiver.kernel.org>; Mon, 26 Oct 2020 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603756399;
	bh=sJKzSfQY8uzihmpRwVTN/EAgVg3GpFoCkG/vfM+f3PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UNvHAauPbbKhqvA29HrERFxO/KH2GdPpl7YbLH8/PJuI76evV6VMMgARhmEzS8ZUE
	 8nhmifjc0JtVVBWfiRro1fZjPvl3TdJ4X/8G0KqEc48exOIYPfZ5sntFCMHssDBQ45
	 z0xH7GG19S5ESnEEEYyTSBahaqiuMfKSBGwAK358=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410031AbgJZXxS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410019AbgJZXxR (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Oct 2020 19:53:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C9020770;
        Mon, 26 Oct 2020 23:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756396;
        bh=sJKzSfQY8uzihmpRwVTN/EAgVg3GpFoCkG/vfM+f3PY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xbWSfZyKJo6NREr6QmFYZDQsmXnVwnFq6LJyCpMMKDKdLa0zXp+Q8gMn27qH/fXwR
         hjC++SEMySPZzA+wbhRvjIjzu1V8R7O0mA6dWrJCzNuK5EgsnyOfsTJb6ruFpfUL1T
         0OAgOF+29yx9hInqvzqy2+V0hgPwpO8NMkYo5ptw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 057/132] media: uvcvideo: Fix dereference of out-of-bound list iterator
Date:   Mon, 26 Oct 2020 19:50:49 -0400
Message-Id: <20201026235205.1023962-57-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235205.1023962-1-sashal@kernel.org>
References: <20201026235205.1023962-1-sashal@kernel.org>
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

