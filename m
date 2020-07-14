Return-Path: <SRS0=2MZP=AZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ED5C433E8
	for <linux-media@archiver.kernel.org>; Tue, 14 Jul 2020 12:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581F422472
	for <linux-media@archiver.kernel.org>; Tue, 14 Jul 2020 12:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgGNMiu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:38:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48586 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgGNMit (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Jul 2020 08:38:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 85BCC2A1634
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
Subject: [PATCH 3/4] media: staging: rkisp1: cap: move code that manages the buffers to rkisp1_set_next_buf
Date:   Tue, 14 Jul 2020 14:38:31 +0200
Message-Id: <20200714123832.28011-4-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714123832.28011-1-dafna.hirschfeld@collabora.com>
References: <20200714123832.28011-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The function 'rkisp1_set_next_buf' configures the registers
according to 'cap->buf.next'. It is called after updating
'cap->buf.next' and 'cap->buf.curr'. This patch moves the
code that updates those fields to rkisp1_set_next_buf.
This is a preparation for later patch that change a call to
'rkisp1_handle_buffer' with a call to 'rkisp1_set_next_buf'.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-capture.c | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-capture.c b/drivers/staging/media/rkisp1/rkisp1-capture.c
index fa3eaeac2a00..7f400aefe550 100644
--- a/drivers/staging/media/rkisp1/rkisp1-capture.c
+++ b/drivers/staging/media/rkisp1/rkisp1-capture.c
@@ -575,12 +575,16 @@ static void rkisp1_dummy_buf_destroy(struct rkisp1_capture *cap)
 
 static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 {
-	/*
-	 * Use the dummy space allocated by dma_alloc_coherent to
-	 * throw data if there is no available buffer.
-	 */
-	if (cap->buf.next) {
-		u32 *buff_addr = cap->buf.next->buff_addr;
+	cap->buf.curr = cap->buf.next;
+	cap->buf.next = NULL;
+
+	if (!list_empty(&cap->buf.queue)) {
+		u32 *buff_addr;
+
+		cap->buf.next = list_first_entry(&cap->buf.queue, struct rkisp1_buffer, queue);
+		list_del(&cap->buf.next->queue);
+
+		buff_addr = cap->buf.next->buff_addr;
 
 		rkisp1_write(cap->rkisp1,
 			     buff_addr[RKISP1_PLANE_Y],
@@ -592,6 +596,10 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
 			     buff_addr[RKISP1_PLANE_CR],
 			     cap->config->mi.cr_base_ad_init);
 	} else {
+		/*
+		 * Use the dummy space allocated by dma_alloc_coherent to
+		 * throw data if there is no available buffer.
+		 */
 		rkisp1_write(cap->rkisp1,
 			     cap->buf.dummy.dma_addr,
 			     cap->config->mi.y_base_ad_init);
@@ -632,16 +640,6 @@ static void rkisp1_handle_buffer(struct rkisp1_capture *cap)
 		cap->rkisp1->debug.frame_drop[cap->id]++;
 	}
 
-	cap->buf.curr = cap->buf.next;
-	cap->buf.next = NULL;
-
-	if (!list_empty(&cap->buf.queue)) {
-		cap->buf.next = list_first_entry(&cap->buf.queue,
-						 struct rkisp1_buffer,
-						 queue);
-		list_del(&cap->buf.next->queue);
-	}
-
 	rkisp1_set_next_buf(cap);
 	spin_unlock_irqrestore(&cap->buf.lock, flags);
 }
-- 
2.17.1

