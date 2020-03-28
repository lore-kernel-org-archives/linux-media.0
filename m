Return-Path: <SRS0=WWBe=5N=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC7FC43331
	for <linux-media@archiver.kernel.org>; Sat, 28 Mar 2020 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF289206CC
	for <linux-media@archiver.kernel.org>; Sat, 28 Mar 2020 07:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgC1HxF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 28 Mar 2020 03:53:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40994 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1HxF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 28 Mar 2020 03:53:05 -0400
Received: from localhost.localdomain (unknown [IPv6:2a02:810a:1140:6758:90b5:2774:1094:333f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 09E8B297D8E;
        Sat, 28 Mar 2020 07:53:04 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com
Subject: [PATCH 4/5] media: vimc: fix issues in documentation in vimc-common.h
Date:   Sat, 28 Mar 2020 08:52:53 +0100
Message-Id: <20200328075254.4616-5-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200328075254.4616-1-dafna.hirschfeld@collabora.com>
References: <20200328075254.4616-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There are some missing and extra fields and typos in
structs documentations in vimc-common.h. Fix it.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/media/platform/vimc/vimc-common.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-common.h b/drivers/media/platform/vimc/vimc-common.h
index 616d5a6b0754..40a58f1cb18f 100644
--- a/drivers/media/platform/vimc/vimc-common.h
+++ b/drivers/media/platform/vimc/vimc-common.h
@@ -63,7 +63,8 @@ do {									\
  *
  * @code:		media bus format code defined by MEDIA_BUS_FMT_* macros
  * @bbp:		number of bytes each pixel occupies
- * @pixelformat:	pixel format devined by V4L2_PIX_FMT_* macros
+ * @pixelformat:	pixel format defined by V4L2_PIX_FMT_* macros
+ * @bayer		true if this is a bayer format
  *
  * Struct which matches the MEDIA_BUS_FMT_* codes with the corresponding
  * V4L2_PIX_FMT_* fourcc pixelformat and its bytes per pixel (bpp)
@@ -90,7 +91,7 @@ struct vimc_pix_map {
  * the node it will be of an instance of v4l2_subdev or video_device struct
  * where both contains a struct media_entity.
  * Those structures should embedded the vimc_ent_device struct through
- * v4l2_set_subdevdata() and video_set_drvdata() respectivaly, allowing the
+ * v4l2_set_subdevdata() and video_set_drvdata() respectively, allowing the
  * vimc_ent_device struct to be retrieved from the corresponding struct
  * media_entity
  */
@@ -123,10 +124,8 @@ struct vimc_device {
  *				configuration for each entity
  *
  * @name			entity name
- * @ved				pointer to vimc_ent_device (a node in the
- *					topology)
  * @add				initializes and registers
- *					vim entity - called from vimc-core
+ *					vimc entity - called from vimc-core
  * @unregister			unregisters vimc entity - called from vimc-core
  * @release			releases vimc entity - called from the v4l2_dev
  *					release callback
@@ -182,7 +181,7 @@ const struct vimc_pix_map *vimc_pix_map_by_code(u32 code);
 /**
  * vimc_pix_map_by_pixelformat - get vimc_pix_map struct by v4l2 pixel format
  *
- * @pixelformat:	pixel format devined by V4L2_PIX_FMT_* macros
+ * @pixelformat:	pixel format defined by V4L2_PIX_FMT_* macros
  */
 const struct vimc_pix_map *vimc_pix_map_by_pixelformat(u32 pixelformat);
 
-- 
2.17.1

