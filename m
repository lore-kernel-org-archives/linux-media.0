Return-Path: <SRS0=mA+5=DA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771C3C4363D
	for <linux-media@archiver.kernel.org>; Wed, 23 Sep 2020 02:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B4020838
	for <linux-media@archiver.kernel.org>; Wed, 23 Sep 2020 02:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lmuTxudS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgIWCoO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Sep 2020 22:44:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53018 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgIWCoN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Sep 2020 22:44:13 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6105A9CE;
        Wed, 23 Sep 2020 04:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600829051;
        bh=Pk8DOe4Sjm9CHaYdH3XnoiMR5gzTbv6xMKNPC4hXEhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmuTxudS1Csu/yJ1vhOSbGqOJpqZrAhiRtKR/5DwVqqVBQhQn+o0Q88fzmmwOso34
         Z/fzT806Am6SGxSyjcPMDqiC5AlAmH6cK5Da0yxbHHw9yBnEWv55uvGD+vA/fOmaoi
         J6hS1tF5vmYRCQPmu23WG0qieqPs31r0SNxznroo=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dylan Yip <dylany@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
Subject: [PATCH/RFC 01/16] media: videodev2.h: Remove unneeded comment about 4CC value
Date:   Wed, 23 Sep 2020 05:43:18 +0300
Message-Id: <20200923024333.920-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923024333.920-1-laurent.pinchart@ideasonboard.com>
References: <20200923024333.920-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The V4L2_PIX_FMT_BGRA444 format has a comment that explains why its 4CC
value is GA12. This explains the development history and isn't of much
interest to readers, it should have been part of a commit message
instead. Drop the comment, anyone interested in history can turn to git.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/uapi/linux/videodev2.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index c7b70ff53bc1..e89b6c5ca799 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -529,12 +529,6 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_RGBX444 v4l2_fourcc('R', 'X', '1', '2') /* 16  rrrrgggg bbbbxxxx */
 #define V4L2_PIX_FMT_ABGR444 v4l2_fourcc('A', 'B', '1', '2') /* 16  aaaabbbb ggggrrrr */
 #define V4L2_PIX_FMT_XBGR444 v4l2_fourcc('X', 'B', '1', '2') /* 16  xxxxbbbb ggggrrrr */
-
-/*
- * Originally this had 'BA12' as fourcc, but this clashed with the older
- * V4L2_PIX_FMT_SGRBG12 which inexplicably used that same fourcc.
- * So use 'GA12' instead for V4L2_PIX_FMT_BGRA444.
- */
 #define V4L2_PIX_FMT_BGRA444 v4l2_fourcc('G', 'A', '1', '2') /* 16  bbbbgggg rrrraaaa */
 #define V4L2_PIX_FMT_BGRX444 v4l2_fourcc('B', 'X', '1', '2') /* 16  bbbbgggg rrrrxxxx */
 #define V4L2_PIX_FMT_RGB555  v4l2_fourcc('R', 'G', 'B', 'O') /* 16  RGB-5-5-5     */
-- 
Regards,

Laurent Pinchart

