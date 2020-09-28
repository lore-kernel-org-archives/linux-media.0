Return-Path: <SRS0=+xP7=DF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E2C4741F
	for <linux-media@archiver.kernel.org>; Mon, 28 Sep 2020 13:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658C623899
	for <linux-media@archiver.kernel.org>; Mon, 28 Sep 2020 13:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="CUluN6F9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI1N2i (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 28 Sep 2020 09:28:38 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:52309 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgI1N2i (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 28 Sep 2020 09:28:38 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id MtChk6Ptpv4gEMtCmkR60M; Mon, 28 Sep 2020 15:28:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1601299716; bh=HcJWcapH7lXXKfGAO9pOe2eWKkXLmYv/WGe7LV1vyZ0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=CUluN6F9VIESMnU7Y5KEm03PKSwYhfkXIdCLU74k+H55ChHlAif0EzM4BykGMmx5b
         H2SyTX/4eSfVmxD1BD8ULk2rmB8++6bhHJU+6vAzBk1oUBfP31fH+YqJmoA0CgsMqi
         66QJnJdCn0PudNFvnMaVsfQOP7C3DrAVrazbcHBn89BhGUfYo9jriRR6PqcKKf03rZ
         rNO5gWaz+RApcUwj8Dv3XN2j+b8YUlN4Wc7xUXbH/RKvSyS/0wDnFoRh5Ga8bHO4sd
         0c9vd1c1h8RTf+utyTzU4PhZS+V1enqU6ipyZX8XggqbXSz/s2dWxp8e502ys2kn6v
         yjE8Ym4CbwNZg==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 2/2] zoran: fix sparse warnings
Date:   Mon, 28 Sep 2020 15:28:31 +0200
Message-Id: <20200928132831.1587872-3-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928132831.1587872-1-hverkuil-cisco@xs4all.nl>
References: <20200928132831.1587872-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJmktp4LyWi5vzLvfftCWES+USSoJlNRcX/04O60GOSrmoSUIOnWWltiSLk3ZIR5YWErvcgsM/vrLgVMqB2LfI7Hmn2PnFA3P2slhP6LaebsJEylqNjs
 PZuKERRCEOIQ1YHIjVnscQg+Pu0+GIfq/Y+uVwe5XyPEXKoQ587NPj1WI46Gf0XZjUlgyoT3oHXI1FVo3Q0Ebd5HaFxwf4ZMc6mmCebV9e2Eeo7Q5RgbuoJH
 zftuVUEBcyhdKW7fDX03fg==
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The output is not fully supported yet, so some ops are
commented out. Also comment out the corresponding callbacks to prevent
these sparse warnings:

drivers/staging/media/zoran/zoran_driver.c:656:12: warning: 'zoran_s_output' defined but not used [-Wunused-function]
  656 | static int zoran_s_output(struct file *file, void *__fh, unsigned int output)
      |            ^~~~~~~~~~~~~~
drivers/staging/media/zoran/zoran_driver.c:649:12: warning: 'zoran_g_output' defined but not used [-Wunused-function]
  649 | static int zoran_g_output(struct file *file, void *__fh, unsigned int *output)
      |            ^~~~~~~~~~~~~~
drivers/staging/media/zoran/zoran_driver.c:635:12: warning: 'zoran_enum_output' defined but not used [-Wunused-function]
  635 | static int zoran_enum_output(struct file *file, void *__fh,
      |            ^~~~~~~~~~~~~~~~~
drivers/staging/media/zoran/zoran_driver.c:302:12: warning: 'zoran_enum_fmt_vid_overlay' defined but not used [-Wunused-function]
  302 | static int zoran_enum_fmt_vid_overlay(struct file *file, void *__fh,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/media/zoran/zoran_driver.c:294:12: warning: 'zoran_enum_fmt_vid_out' defined but not used [-Wunused-function]
  294 | static int zoran_enum_fmt_vid_out(struct file *file, void *__fh,
      |            ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/staging/media/zoran/zoran_driver.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index c5b2ccb00ca9..9ea8ec3ef289 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -291,6 +291,8 @@ static int zoran_enum_fmt_vid_cap(struct file *file, void *__fh,
 	return zoran_enum_fmt(zr, f, ZORAN_FORMAT_CAPTURE);
 }
 
+#if 0
+/* TODO: output does not work yet */
 static int zoran_enum_fmt_vid_out(struct file *file, void *__fh,
 				  struct v4l2_fmtdesc *f)
 {
@@ -298,14 +300,7 @@ static int zoran_enum_fmt_vid_out(struct file *file, void *__fh,
 
 	return zoran_enum_fmt(zr, f, ZORAN_FORMAT_PLAYBACK);
 }
-
-static int zoran_enum_fmt_vid_overlay(struct file *file, void *__fh,
-				      struct v4l2_fmtdesc *f)
-{
-	struct zoran *zr = video_drvdata(file);
-
-	return zoran_enum_fmt(zr, f, ZORAN_FORMAT_OVERLAY);
-}
+#endif
 
 static int zoran_g_fmt_vid_out(struct file *file, void *__fh,
 			       struct v4l2_format *fmt)
@@ -632,6 +627,8 @@ static int zoran_s_input(struct file *file, void *__fh, unsigned int input)
 	return res;
 }
 
+#if 0
+/* TODO: output does not work yet */
 static int zoran_enum_output(struct file *file, void *__fh,
 			     struct v4l2_output *outp)
 {
@@ -660,6 +657,8 @@ static int zoran_s_output(struct file *file, void *__fh, unsigned int output)
 
 	return 0;
 }
+#endif
+
 /* cropping (sub-frame capture) */
 static int zoran_g_selection(struct file *file, void *__fh, struct v4l2_selection *sel)
 {
-- 
2.28.0

