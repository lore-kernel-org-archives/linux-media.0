Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA222C0032E
	for <linux-media@archiver.kernel.org>; Sat, 28 Oct 2023 08:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjJ1Im3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 28 Oct 2023 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJ1ImX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 28 Oct 2023 04:42:23 -0400
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85064121;
        Sat, 28 Oct 2023 01:42:19 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qwetd-0006mt-1Y;
        Sat, 28 Oct 2023 10:42:17 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Sat, 28 Oct 2023 10:41:48 +0200
Subject: [PATCH v3 4/4] media: i2c: imx214: Add sensor's pixel matrix size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231028-imx214-v3-4-cd4bf77f9690@apitzsch.eu>
References: <20231028-imx214-v3-0-cd4bf77f9690@apitzsch.eu>
In-Reply-To: <20231028-imx214-v3-0-cd4bf77f9690@apitzsch.eu>
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Set effective and active sensor pixel sizes as shown in product
brief[1].

[1]: https://www.mouser.com/datasheet/2/897/ProductBrief_IMX214_20150428-1289331.pdf

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/media/i2c/imx214.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 81f126a1b145..0aba28d6dc2f 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -36,6 +36,14 @@
 #define IMX214_EXPOSURE_STEP		1
 #define IMX214_EXPOSURE_DEFAULT		3184
 
+/* IMX214 native and active pixel array size */
+#define IMX214_NATIVE_WIDTH		4224U
+#define IMX214_NATIVE_HEIGHT		3136U
+#define IMX214_PIXEL_ARRAY_LEFT		8U
+#define IMX214_PIXEL_ARRAY_TOP		8U
+#define IMX214_PIXEL_ARRAY_WIDTH	4208U
+#define IMX214_PIXEL_ARRAY_HEIGHT	3120U
+
 static const char * const imx214_supply_name[] = {
 	"vdda",
 	"vddd",
@@ -634,14 +642,31 @@ static int imx214_get_selection(struct v4l2_subdev *sd,
 {
 	struct imx214 *imx214 = to_imx214(sd);
 
-	if (sel->target != V4L2_SEL_TGT_CROP)
-		return -EINVAL;
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP:
+		mutex_lock(&imx214->mutex);
+		sel->r = *__imx214_get_pad_crop(imx214, sd_state, sel->pad,
+						sel->which);
+		mutex_unlock(&imx214->mutex);
+		return 0;
 
-	mutex_lock(&imx214->mutex);
-	sel->r = *__imx214_get_pad_crop(imx214, sd_state, sel->pad,
-					sel->which);
-	mutex_unlock(&imx214->mutex);
-	return 0;
+	case V4L2_SEL_TGT_NATIVE_SIZE:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = IMX214_NATIVE_WIDTH;
+		sel->r.height = IMX214_NATIVE_HEIGHT;
+		return 0;
+
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.top = IMX214_PIXEL_ARRAY_TOP;
+		sel->r.left = IMX214_PIXEL_ARRAY_LEFT;
+		sel->r.width = IMX214_PIXEL_ARRAY_WIDTH;
+		sel->r.height = IMX214_PIXEL_ARRAY_HEIGHT;
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static int imx214_entity_init_cfg(struct v4l2_subdev *subdev,

-- 
2.42.0

