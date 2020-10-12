Return-Path: <SRS0=qt09=DT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF297C433E7
	for <linux-media@archiver.kernel.org>; Mon, 12 Oct 2020 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F21120797
	for <linux-media@archiver.kernel.org>; Mon, 12 Oct 2020 21:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgJLU7v (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbgJLU7E (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Oct 2020 16:59:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CCCC0613D8;
        Mon, 12 Oct 2020 13:59:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 62D071F44C56
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Fruehberger Peter <Peter.Fruehberger@de.bosch.com>,
        kuhanh.murugasen.krishnan@intel.com,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] media: hantro: rename h264_dec as it's not G1 specific anymore
Date:   Mon, 12 Oct 2020 23:59:55 +0300
Message-Id: <20201012205957.889185-17-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012205957.889185-1-adrian.ratiu@collabora.com>
References: <20201012205957.889185-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The h264 decoder is now capable of decoding on both G1 and VC8000 and
other HW revisions can be added in the future by extending the hantro
regmap config, so we rename it to reflect the new status.

All other core-specific files like "hantro_g1_mpeg2_dec.c" should be
renamed as well after they have been ported to the new regmap API.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 drivers/staging/media/hantro/Makefile                           | 2 +-
 .../media/hantro/{hantro_g1_h264_dec.c => hantro_h264_dec.c}    | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/staging/media/hantro/{hantro_g1_h264_dec.c => hantro_h264_dec.c} (100%)

diff --git a/drivers/staging/media/hantro/Makefile b/drivers/staging/media/hantro/Makefile
index 52bc0ee73569..94f1e454c495 100644
--- a/drivers/staging/media/hantro/Makefile
+++ b/drivers/staging/media/hantro/Makefile
@@ -7,7 +7,7 @@ hantro-vpu-y += \
 		hantro_v4l2.o \
 		hantro_postproc.o \
 		hantro_h1_jpeg_enc.o \
-		hantro_g1_h264_dec.o \
+		hantro_h264_dec.o \
 		hantro_g1_mpeg2_dec.o \
 		hantro_regmap.o \
 		hantro_g1_vp8_dec.o \
diff --git a/drivers/staging/media/hantro/hantro_g1_h264_dec.c b/drivers/staging/media/hantro/hantro_h264_dec.c
similarity index 100%
rename from drivers/staging/media/hantro/hantro_g1_h264_dec.c
rename to drivers/staging/media/hantro/hantro_h264_dec.c
-- 
2.28.0

