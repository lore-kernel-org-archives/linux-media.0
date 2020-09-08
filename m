Return-Path: <SRS0=7dE9=CR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CFC433E2
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 10:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4E820C09
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 10:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="NCMWQFZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgIHKdp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:33:45 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:49345 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729542AbgIHK0d (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:33 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id FapHkWzhXMeQuFapJkfd9A; Tue, 08 Sep 2020 12:26:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1599560773; bh=QcAbiD6FktTEgHd2VYDDvPco9MKZ6GT5lUvQ/sohjXg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=NCMWQFZuh4msPoThuq9OtuUq6s7oOYAuCRSRRBC4fRkuyW01sN0hER0Ka/5yb8bt2
         8TepN8RuBdfPxbBqgQzhBtWon64rPW5ltAl/94iuzvFnXhoH9WG15ptqbdgM9W63lk
         i4p09YRZkXOdZNoVqnls2mW4swrQCYiW7qYfAVXPmMR8P8I4toUugvW5yvUMQSeOeH
         HNBq9a67/VhrKxINJS2w6ejZjUUJo8BWmWV11b78r1ul4bM2ZLooOoUSXomm1o1y7g
         RiKPNWl9XKbZPMrHQCw3x1zQ+lhXSA0FeXDRktQD4c5yAThpxuA7tsE1Y5KZaICtN9
         7viRNpwTt/6sg==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 2/2] cec-adap.c: add 'unregistered' checks
Date:   Tue,  8 Sep 2020 12:26:11 +0200
Message-Id: <20200908102611.471265-3-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908102611.471265-1-hverkuil-cisco@xs4all.nl>
References: <20200908102611.471265-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBZhREe2cqDzaHjQpaHwro+ZlViMI7xIUvjQlndRhvALEs9RKg3BNiFtX7Cv1lquwlWFHZMhypTRuN82b7XYdFMxb4Zl22Z9wpsCfzJnjzEkCmJQ6pwN
 7cBnzHvUrgXOhR62FaJF5kKhX60oK/tMVtXmWPWcXRQrKELEPgwZyox7d9zapMkG/Ln/cv/jdw8BP3hd05GdG0Ms+1OZTttUcyYi6JNiKHGzL4/meXjlu+fI
 EteX321Tqmj9EtEyCmmEFBsNYpTFfdRegsaxzVC70fZ/meKg/6UkZHKC/3tWr3lH
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Make the code a bit more robust by checking if the adapter has
been unregistered at the start of cec_transmit_msg_fh() and
cec_received_msg_ts(). If it is unregistered, then just return.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/cec/core/cec-adap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 3153c401cb65..d5d5d28d0b36 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -751,6 +751,9 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	struct cec_data *data;
 	bool is_raw = msg_is_raw(msg);
 
+	if (adap->devnode.unregistered)
+		return -ENODEV;
+
 	msg->rx_ts = 0;
 	msg->tx_ts = 0;
 	msg->rx_status = 0;
@@ -1049,6 +1052,9 @@ void cec_received_msg_ts(struct cec_adapter *adap,
 	if (WARN_ON(!msg->len || msg->len > CEC_MAX_MSG_SIZE))
 		return;
 
+	if (adap->devnode.unregistered)
+		return;
+
 	/*
 	 * Some CEC adapters will receive the messages that they transmitted.
 	 * This test filters out those messages by checking if we are the
-- 
2.27.0

