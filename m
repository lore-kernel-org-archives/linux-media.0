Return-Path: <SRS0=MHKF=4F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900EBC34026
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7380920801
	for <linux-media@archiver.kernel.org>; Mon, 17 Feb 2020 15:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgBQPOL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:14:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58005 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgBQPOD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 17 Feb 2020 10:14:03 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1j3i5x-0005WC-8f; Mon, 17 Feb 2020 16:14:01 +0100
Received: from mtr by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1j3i5w-0001aG-At; Mon, 17 Feb 2020 16:14:00 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     linux-media@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 09/18] media: allegro: warn if response message has an unexpected size
Date:   Mon, 17 Feb 2020 16:13:49 +0100
Message-Id: <20200217151358.5695-10-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217151358.5695-1-m.tretter@pengutronix.de>
References: <20200217151358.5695-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The driver uses structs to parse the responses from the VCU and expects
a certain size of the responses. However, the size and format of the
mails is not stable across firmware versions. Therefore, print a warning
if the size does not match the expected size to warn the user that
strange things might happen.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/staging/media/allegro-dvt/allegro-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index c0b3a6858b27..868dd9b35400 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -1696,6 +1696,11 @@ allegro_handle_create_channel(struct allegro_dev *dev,
 	struct allegro_channel *channel;
 	int err = 0;
 
+	if (msg->header.length != sizeof(*msg) - sizeof(msg->header))
+		v4l2_warn(&dev->v4l2_dev,
+			  "received message has %d bytes, but expected %zu\n",
+			  msg->header.length, sizeof(*msg) - sizeof(msg->header));
+
 	channel = allegro_find_channel_by_user_id(dev, msg->user_id);
 	if (IS_ERR(channel)) {
 		v4l2_warn(&dev->v4l2_dev,
@@ -1789,6 +1794,11 @@ allegro_handle_encode_frame(struct allegro_dev *dev,
 {
 	struct allegro_channel *channel;
 
+	if (msg->header.length != sizeof(*msg) - sizeof(msg->header))
+		v4l2_warn(&dev->v4l2_dev,
+			  "received message has %d bytes, but expected %zu\n",
+			  msg->header.length, sizeof(*msg) - sizeof(msg->header));
+
 	channel = allegro_find_channel_by_channel_id(dev, msg->channel_id);
 	if (IS_ERR(channel)) {
 		v4l2_err(&dev->v4l2_dev,
-- 
2.20.1

