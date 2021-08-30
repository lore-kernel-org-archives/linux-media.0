Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DED3C43216
	for <linux-media@archiver.kernel.org>; Mon, 30 Aug 2021 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1C56113C
	for <linux-media@archiver.kernel.org>; Mon, 30 Aug 2021 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhH3LDf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Aug 2021 07:03:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43892 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbhH3LD3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Aug 2021 07:03:29 -0400
Received: from deskari.lan (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 540DBB9C;
        Mon, 30 Aug 2021 13:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1630321352;
        bh=0pUu/xAEYHpYQ2OvcfMdz+cb/psSCmdkXZAphq5k2vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPtyRn4FliniOHjxm1VB4ai5sDm6ORH0ETWAIX582i+80/34vgHdLGIDDi45EgfjV
         zmr25pqn6R8BxjIHw4FUUlckgzCmHngLVHJGlEsb7wDw59MkoLHTV46V3WvG13WeiF
         Gm9O2mqJpfZ+IKt1DglVRnqg4yGqDbtS/eoT1un8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v8 24/36] media: Add stream to frame descriptor
Date:   Mon, 30 Aug 2021 14:01:04 +0300
Message-Id: <20210830110116.488338-25-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830110116.488338-1-tomi.valkeinen@ideasonboard.com>
References: <20210830110116.488338-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

The stream field identifies the stream this frame descriptor applies to in
routing configuration across a multiplexed link.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 include/media/v4l2-subdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 3071d202597d..f232b9f52817 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -342,6 +342,7 @@ enum v4l2_mbus_frame_desc_flags {
  * struct v4l2_mbus_frame_desc_entry - media bus frame description structure
  *
  * @flags:	bitmask flags, as defined by &enum v4l2_mbus_frame_desc_flags.
+ * @stream:	stream in routing configuration
  * @pixelcode:	media bus pixel code, valid if @flags
  *		%FRAME_DESC_FL_BLOB is not set.
  * @length:	number of octets per frame, valid if @flags
@@ -351,6 +352,7 @@ enum v4l2_mbus_frame_desc_flags {
  */
 struct v4l2_mbus_frame_desc_entry {
 	enum v4l2_mbus_frame_desc_flags flags;
+	u32 stream;
 	u32 pixelcode;
 	u32 length;
 	union {
-- 
2.25.1

