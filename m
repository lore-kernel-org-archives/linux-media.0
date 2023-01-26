Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB043C05027
	for <linux-media@archiver.kernel.org>; Thu, 26 Jan 2023 15:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjAZPHo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Jan 2023 10:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjAZPH3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Jan 2023 10:07:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498156D358
        for <linux-media@vger.kernel.org>; Thu, 26 Jan 2023 07:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BE7AB81E14
        for <linux-media@vger.kernel.org>; Thu, 26 Jan 2023 15:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3B5C433D2;
        Thu, 26 Jan 2023 15:07:19 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 17/17] media: dvb-frontends: mb86a16.c: always use the same error path
Date:   Thu, 26 Jan 2023 16:06:57 +0100
Message-Id: <20230126150657.367921-18-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126150657.367921-1-hverkuil-cisco@xs4all.nl>
References: <20230126150657.367921-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If the message length was wrong, the dprintk() after the 'err' label
was bypassed. Fix that, and fix a smatch warning at the same time:

mb86a16.c:1514 mb86a16_send_diseqc_msg() warn: missing unwind goto?

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/dvb-frontends/mb86a16.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/mb86a16.c b/drivers/media/dvb-frontends/mb86a16.c
index 2505f1e5794e..d3e29937cf4c 100644
--- a/drivers/media/dvb-frontends/mb86a16.c
+++ b/drivers/media/dvb-frontends/mb86a16.c
@@ -1498,6 +1498,7 @@ static int mb86a16_send_diseqc_msg(struct dvb_frontend *fe,
 				   struct dvb_diseqc_master_cmd *cmd)
 {
 	struct mb86a16_state *state = fe->demodulator_priv;
+	int ret = -EREMOTEIO;
 	int i;
 	u8 regs;
 
@@ -1510,8 +1511,10 @@ static int mb86a16_send_diseqc_msg(struct dvb_frontend *fe,
 
 	regs = 0x18;
 
-	if (cmd->msg_len > 5 || cmd->msg_len < 4)
-		return -EINVAL;
+	if (cmd->msg_len > 5 || cmd->msg_len < 4) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	for (i = 0; i < cmd->msg_len; i++) {
 		if (mb86a16_write(state, regs, cmd->msg[i]) < 0)
@@ -1532,7 +1535,7 @@ static int mb86a16_send_diseqc_msg(struct dvb_frontend *fe,
 
 err:
 	dprintk(verbose, MB86A16_ERROR, 1, "I2C transfer error");
-	return -EREMOTEIO;
+	return ret;
 }
 
 static int mb86a16_send_diseqc_burst(struct dvb_frontend *fe,
-- 
2.39.0

