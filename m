Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F69C4332F
	for <linux-media@archiver.kernel.org>; Wed,  9 Mar 2022 15:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiCIP6h (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Mar 2022 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiCIP6e (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 9 Mar 2022 10:58:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC182F01A
        for <linux-media@vger.kernel.org>; Wed,  9 Mar 2022 07:57:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79FE56164F
        for <linux-media@vger.kernel.org>; Wed,  9 Mar 2022 15:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5627FC340EF;
        Wed,  9 Mar 2022 15:57:32 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 4/6] cec.h: add cec_msg_recv_is_rx/tx_result helpers
Date:   Wed,  9 Mar 2022 16:57:24 +0100
Message-Id: <20220309155726.1258388-5-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309155726.1258388-1-hverkuil-cisco@xs4all.nl>
References: <20220309155726.1258388-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

These two helper functions return true if the received message
contains the result of a previous non-blocking transmit. Either
the tx_status result (cec_msg_recv_is_tx_result) of the transmit,
or the rx_status result (cec_msg_recv_is_rx_result) of the reply
to the original transmit.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 include/uapi/linux/cec.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index de936f5e446d..08ae52a74939 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -142,6 +142,26 @@ static inline void cec_msg_set_reply_to(struct cec_msg *msg,
 	msg->reply = msg->timeout = 0;
 }
 
+/**
+ * cec_msg_recv_is_tx_result - return true if this message contains the
+ *			       result of an earlier non-blocking transmit
+ * @msg:	the message structure from CEC_RECEIVE
+ */
+static inline bool cec_msg_recv_is_tx_result(const struct cec_msg *msg)
+{
+	return msg->sequence && msg->tx_status && !msg->rx_status;
+}
+
+/**
+ * cec_msg_recv_is_rx_result - return true if this message contains the
+ *			       reply of an earlier non-blocking transmit
+ * @msg:	the message structure from CEC_RECEIVE
+ */
+static inline bool cec_msg_recv_is_rx_result(const struct cec_msg *msg)
+{
+	return msg->sequence && !msg->tx_status && msg->rx_status;
+}
+
 /* cec_msg flags field */
 #define CEC_MSG_FL_REPLY_TO_FOLLOWERS	(1 << 0)
 #define CEC_MSG_FL_RAW			(1 << 1)
-- 
2.34.1

