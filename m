Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E0C10F14
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F47217F4
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PPmV+6Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDKQNE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:13:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35636 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDKQNE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 12:13:04 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8E4321A46;
        Thu, 11 Apr 2019 18:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554999180;
        bh=pVzxBQdOfPpjj22762q0So46LY7O1Lzn7r+Vt27ALNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPmV+6FziHhLgeVRKtakQT2tbs3t848G7mxfXXtbOX2e5MLmEUGsPHbX2RJBfaaYp
         4sMRTD+JIYm/EKmWV6xRaEqkiGU/nKI3IG2imRwddLK+q0/h6JF3jb821woomHMmJx
         HxXp5WcYl4bmyhu3vE+YIV4mA8yuZozqeQOTgQUw=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v3 2/5] media: vsp1: Initialise partition windows
Date:   Thu, 11 Apr 2019 17:12:53 +0100
Message-Id: <20190411161256.19607-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Ensure that the partition window is correctly initialised before being
utilised.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index ee2fb8261a6a..563f9a02c373 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -189,7 +189,7 @@ static void vsp1_video_calculate_partition(struct vsp1_pipeline *pipe,
 					   unsigned int index)
 {
 	const struct v4l2_mbus_framefmt *format;
-	struct vsp1_partition_window window;
+	struct vsp1_partition_window window = { 0, };
 	unsigned int modulus;
 
 	/*
-- 
2.19.1

