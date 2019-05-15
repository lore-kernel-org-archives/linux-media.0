Return-Path: <SRS0=tlKj=TP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A23EC04E84
	for <linux-media@archiver.kernel.org>; Wed, 15 May 2019 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB4620843
	for <linux-media@archiver.kernel.org>; Wed, 15 May 2019 07:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfEOH6c (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 15 May 2019 03:58:32 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:53207 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbfEOH6c (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 15 May 2019 03:58:32 -0400
Received: from tschai.fritz.box ([46.9.252.75])
        by smtp-cloud9.xs4all.net with ESMTPA
        id QonyhZzGqsDWyQoo2hrxaV; Wed, 15 May 2019 09:58:30 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 1/6] cec: cec_transmit_msg_fh: do sanity checks first
Date:   Wed, 15 May 2019 09:58:21 +0200
Message-Id: <20190515075826.18073-2-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515075826.18073-1-hverkuil-cisco@xs4all.nl>
References: <20190515075826.18073-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfODe+GFDI/2Xjp3U8qugp5DdvyZTCgABHgdc17PVFeMJnr0zXVY/rKYZDalZltvlHLzNMWhsGcRlAesbzQBirxfhP8gvJmj3JQIoUFCIDJ156vTwUc8K
 zLYYy0GHqKEFYeb1lxv7Y7BMZpJ5vXNOoWoyFaiP1ongiGiVVHh34613VYuzfVxnQp6ql00B7x8Dr0PbzNapszwKPy6/hZM9+c8+qOAYXbImVQ0BTzxxHg9e
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The code that fills in the CEC_MSG_CDC_MESSAGE physical address
is now done after the sanity checks. It also only does this if the
message length is >= 4 (i.e. there is room for the physical address).

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/cec/cec-adap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/cec/cec-adap.c b/drivers/media/cec/cec-adap.c
index f1261cc2b6fa..b6102510e203 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -740,11 +740,6 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	else
 		msg->flags = 0;
 
-	if (msg->len > 1 && msg->msg[1] == CEC_MSG_CDC_MESSAGE) {
-		msg->msg[2] = adap->phys_addr >> 8;
-		msg->msg[3] = adap->phys_addr & 0xff;
-	}
-
 	/* Sanity checks */
 	if (msg->len == 0 || msg->len > CEC_MAX_MSG_SIZE) {
 		dprintk(1, "%s: invalid length %d\n", __func__, msg->len);
@@ -765,6 +760,12 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 		dprintk(1, "%s: can't reply to poll msg\n", __func__);
 		return -EINVAL;
 	}
+
+	if (msg->len >= 4 && msg->msg[1] == CEC_MSG_CDC_MESSAGE) {
+		msg->msg[2] = adap->phys_addr >> 8;
+		msg->msg[3] = adap->phys_addr & 0xff;
+	}
+
 	if (msg->len == 1) {
 		if (cec_msg_destination(msg) == 0xf) {
 			dprintk(1, "%s: invalid poll message\n", __func__);
-- 
2.20.1

