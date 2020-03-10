Return-Path: <SRS0=PJJM=43=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C9C10F27
	for <linux-media@archiver.kernel.org>; Tue, 10 Mar 2020 16:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881E521D56
	for <linux-media@archiver.kernel.org>; Tue, 10 Mar 2020 16:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="c18a22RL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCJQGp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:06:45 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55128 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgCJQGp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 10 Mar 2020 12:06:45 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 924FBD6E;
        Tue, 10 Mar 2020 17:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583856402;
        bh=qZ8Q9n4GiSSp44StIH/iKqCX8rLCb0q0dRBrTTFIXag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c18a22RLemr90yW/kleOqWEXv64vMq7pZV7DXf8LQV0txlQ1m/vs9McNmiGlWXzZ7
         L8IZZLkuumuRSxKvAP0+RbkNTZQShwq+pvbVCWc9refkgaviygwszRHdlmQ5/ms8NV
         7Srj/9FeWZpOMoR29S7agcaikoaFSf+jI3l2aOyg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rui Miguel Silva <rmfrfs@gmail.com>
Subject: [PATCH v2 05/10] media: imx: imx7-media-csi: Remove unneeded register read
Date:   Tue, 10 Mar 2020 18:06:28 +0200
Message-Id: <20200310160633.950-6-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310160633.950-1-laurent.pinchart@ideasonboard.com>
References: <20200310160633.950-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The imx7_csi_dma_reflash() function starts by reading the unrelated
register CSI_CSICR18 to then overwrite the read value with a read from
register CSI_CSICR3. This is likely due to a bad copy&paste, and is not
needed. Remove the extraneous read from register CSI_CSICR18.

Fixes: 9e5fa4e1e5b5b ("media: imx7-media-csi: Use u32 for storing register reads")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
---
Changes since v1:

- Add Fixes: tag
---
 drivers/staging/media/imx/imx7-media-csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index db30e2c70f2f..2f665e4b8c40 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -292,7 +292,7 @@ static void imx7_csi_hw_disable(struct imx7_csi *csi)
 
 static void imx7_csi_dma_reflash(struct imx7_csi *csi)
 {
-	u32 cr3 = imx7_csi_reg_read(csi, CSI_CSICR18);
+	u32 cr3;
 
 	cr3 = imx7_csi_reg_read(csi, CSI_CSICR3);
 	cr3 |= BIT_DMA_REFLASH_RFF;
-- 
Regards,

Laurent Pinchart

