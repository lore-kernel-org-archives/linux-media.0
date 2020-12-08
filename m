Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1242C4167B
	for <linux-media@archiver.kernel.org>; Tue,  8 Dec 2020 07:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C98123A79
	for <linux-media@archiver.kernel.org>; Tue,  8 Dec 2020 07:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgLHHG0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Dec 2020 02:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgLHHG0 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 8 Dec 2020 02:06:26 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: vidtv: fix some warnings
Date:   Tue,  8 Dec 2020 08:05:41 +0100
Message-Id: <3533a1825fce5efbd445338196f10cefcb51deca.1607411138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As reported by sparse:

	drivers/media/test-drivers/vidtv/vidtv_ts.h:47:47: warning: array of flexible structures
	drivers/media/test-drivers/vidtv/vidtv_channel.c:458:54: warning: incorrect type in argument 3 (different base types)
	drivers/media/test-drivers/vidtv/vidtv_channel.c:458:54:    expected unsigned short [usertype] service_id
	drivers/media/test-drivers/vidtv/vidtv_channel.c:458:54:    got restricted __be16 [usertype] service_id
	drivers/media/test-drivers/vidtv/vidtv_s302m.c:471 vidtv_s302m_encoder_init() warn: possible memory leak of 'e'

Address such warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.h   | 2 +-
 drivers/media/test-drivers/vidtv/vidtv_s302m.c | 4 +++-
 drivers/media/test-drivers/vidtv/vidtv_ts.h    | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.h b/drivers/media/test-drivers/vidtv/vidtv_psi.h
index 340c9fb8d583..d9c71f88ab9e 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.h
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.h
@@ -743,7 +743,7 @@ struct vidtv_psi_table_eit {
 struct vidtv_psi_table_eit
 *vidtv_psi_eit_table_init(u16 network_id,
 			  u16 transport_stream_id,
-			  u16 service_id);
+			  __be16 service_id);
 
 /**
  * struct vidtv_psi_eit_write_args - Arguments for writing an EIT section
diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
index ce7dd6cafc8b..d79b65854627 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
@@ -467,8 +467,10 @@ struct vidtv_encoder
 	e->is_video_encoder = false;
 
 	ctx = kzalloc(priv_sz, GFP_KERNEL);
-	if (!ctx)
+	if (!ctx) {
+		kfree(e);
 		return NULL;
+	}
 
 	e->ctx = ctx;
 	ctx->last_duration = 0;
diff --git a/drivers/media/test-drivers/vidtv/vidtv_ts.h b/drivers/media/test-drivers/vidtv/vidtv_ts.h
index 10838a2b8389..f5e8e1f37f05 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_ts.h
+++ b/drivers/media/test-drivers/vidtv/vidtv_ts.h
@@ -44,7 +44,7 @@ struct vidtv_mpeg_ts {
 		u8 adaptation_field:1;
 		u8 scrambling:2;
 	} __packed;
-	struct vidtv_mpeg_ts_adaption adaption[];
+	struct vidtv_mpeg_ts_adaption *adaption;
 } __packed;
 
 /**
-- 
2.28.0

