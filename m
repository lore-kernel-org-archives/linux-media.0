Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A213C10F14
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097BE2184B
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Gn1UWlMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDKQNG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:13:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35636 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDKQNF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 12:13:05 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F5A41A4C;
        Thu, 11 Apr 2019 18:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554999181;
        bh=jdD+5Efy+UtrEF9cneBBj3cLEPhRJLTKJSbwx+BGkfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gn1UWlMXStmDGHF7vuou8VHbiCV3+DZ/oqU9rsIR+0YBZBa/hvPhiqtauHqe0jis2
         cxsmP1MPPIaCQB15U77dAlwt1Z/RFyl+uXUtymG1GxVy6/HmGWZv0aDyt9wawxvBwo
         rBZkhaOnj7O/c0vXgTeXdGpNTXYAiAxm3X/R77Ug=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v3 4/5] media: vsp1: Split out pre-filter multiplier
Date:   Thu, 11 Apr 2019 17:12:55 +0100
Message-Id: <20190411161256.19607-5-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The 'mp' value is used through many calculations in determining the scaling
factors of the UDS. Factor this out so that it can be reused in further
calculations, and also ensure that if the BLADV control is ever changed only a
single function needs to be modified.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_uds.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
index 27012af973b2..c71c24363d54 100644
--- a/drivers/media/platform/vsp1/vsp1_uds.c
+++ b/drivers/media/platform/vsp1/vsp1_uds.c
@@ -46,6 +46,18 @@ void vsp1_uds_set_alpha(struct vsp1_entity *entity, struct vsp1_dl_body *dlb,
 		       alpha << VI6_UDS_ALPVAL_VAL0_SHIFT);
 }
 
+/*
+ * Determine the pre-filter multiplication value.
+ *
+ * This calculation assumes that the BLADV control is unset.
+ */
+static unsigned int uds_multiplier(int ratio)
+{
+	unsigned int mp = ratio / 4096;
+
+	return mp < 4 ? 1 : (mp < 8 ? 2 : 4);
+}
+
 /*
  * uds_output_size - Return the output size for an input size and scaling ratio
  * @input: input size in pixels
@@ -55,10 +67,7 @@ static unsigned int uds_output_size(unsigned int input, unsigned int ratio)
 {
 	if (ratio > 4096) {
 		/* Down-scaling */
-		unsigned int mp;
-
-		mp = ratio / 4096;
-		mp = mp < 4 ? 1 : (mp < 8 ? 2 : 4);
+		unsigned int mp = uds_multiplier(ratio);
 
 		return (input - 1) / mp * mp * 4096 / ratio + 1;
 	} else {
@@ -88,10 +97,7 @@ static unsigned int uds_passband_width(unsigned int ratio)
 {
 	if (ratio >= 4096) {
 		/* Down-scaling */
-		unsigned int mp;
-
-		mp = ratio / 4096;
-		mp = mp < 4 ? 1 : (mp < 8 ? 2 : 4);
+		unsigned int mp = uds_multiplier(ratio);
 
 		return 64 * 4096 * mp / ratio;
 	} else {
-- 
2.19.1

