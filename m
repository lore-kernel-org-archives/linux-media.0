Return-Path: <SRS0=JGZI=TN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8CAC04AAA
	for <linux-media@archiver.kernel.org>; Mon, 13 May 2019 20:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66EA2085A
	for <linux-media@archiver.kernel.org>; Mon, 13 May 2019 20:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VLAtzp12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfEMUOL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 May 2019 16:14:11 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41532 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfEMUOK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 May 2019 16:14:10 -0400
Received: from localhost.localdomain (unknown [IPv6:2a02:c7f:1887:5d00:8d7a:f2f4:69ff:77c4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 65FD49EA;
        Mon, 13 May 2019 22:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1557778446;
        bh=VhYMAMNya2BcUHT8XUw07XkTzU8eX9LnYwnhuQCBdnA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VLAtzp120oyaLiI6HeJd09Md3rl8LOVcGWGFm0Mj0MRr0+ADhXH2xvsmKU/KkO4Zk
         LcQksIQtmwEnylRUeUl4NIe0HJMrXygeVHwYk6QYF9quh0oVry33IuIsftxYZYbv2a
         y+UQ69D/h/YddN+kwCbte+DHGByG3Euriyet7nMc=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v4 3/4] media: vsp1: Split out pre-filter calculation
Date:   Mon, 13 May 2019 21:13:54 +0100
Message-Id: <20190513201355.994-4-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513201355.994-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190513201355.994-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The 'mp' value is used through several calculations in determining the
scaling factors of the UDS. This determines the pre-scaling filter
binning value. Factor this out so that it can be reused in further
calculations, and also ensure that if the BLADV control is ever changed
only a single function needs to be modified.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_uds.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
index 27012af973b2..effebfc0c862 100644
--- a/drivers/media/platform/vsp1/vsp1_uds.c
+++ b/drivers/media/platform/vsp1/vsp1_uds.c
@@ -46,6 +46,22 @@ void vsp1_uds_set_alpha(struct vsp1_entity *entity, struct vsp1_dl_body *dlb,
 		       alpha << VI6_UDS_ALPVAL_VAL0_SHIFT);
 }
 
+/*
+ * Determine the pre-filter binning divider.
+ *
+ * The UDS uses a two stage filter scaler process. This determines the
+ * rate at which pixels are reduced for large down-scaling ratios before
+ * being fed into the bicubic filter.
+ *
+ * This calculation assumes that the BLADV bit is unset.
+ */
+static unsigned int uds_pre_scaling_divisor(int ratio)
+{
+	unsigned int mp = ratio / 4096;
+
+	return mp < 4 ? 1 : (mp < 8 ? 2 : 4);
+}
+
 /*
  * uds_output_size - Return the output size for an input size and scaling ratio
  * @input: input size in pixels
@@ -55,10 +71,7 @@ static unsigned int uds_output_size(unsigned int input, unsigned int ratio)
 {
 	if (ratio > 4096) {
 		/* Down-scaling */
-		unsigned int mp;
-
-		mp = ratio / 4096;
-		mp = mp < 4 ? 1 : (mp < 8 ? 2 : 4);
+		unsigned int mp = uds_pre_scaling_divisor(ratio);
 
 		return (input - 1) / mp * mp * 4096 / ratio + 1;
 	} else {
@@ -88,10 +101,7 @@ static unsigned int uds_passband_width(unsigned int ratio)
 {
 	if (ratio >= 4096) {
 		/* Down-scaling */
-		unsigned int mp;
-
-		mp = ratio / 4096;
-		mp = mp < 4 ? 1 : (mp < 8 ? 2 : 4);
+		unsigned int mp = uds_pre_scaling_divisor(ratio);
 
 		return 64 * 4096 * mp / ratio;
 	} else {
-- 
2.20.1

