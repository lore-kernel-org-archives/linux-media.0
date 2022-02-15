Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145D6C433FE
	for <linux-media@archiver.kernel.org>; Tue, 15 Feb 2022 11:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiBOLUy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:20:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiBOLUx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 15 Feb 2022 06:20:53 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B7107D0A
        for <linux-media@vger.kernel.org>; Tue, 15 Feb 2022 03:20:44 -0800 (PST)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8D0BC315;
        Tue, 15 Feb 2022 12:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644924042;
        bh=S7T+qCVDTK0GTeTuM//JrdYslVWMtD4Yow5kWTChj+c=;
        h=From:To:Cc:Subject:Date:From;
        b=nbUI1CKIc96elwZhacEDBlB22IfA7lf6Fi/3Im7GNca1kTxOkmwWM9UWRWXEmzhrW
         qqobS2wMS+5avypqQV0z2YcEOLac/TIZUFclnhdkYUzIpfnEVGVUAErkxXKbsIEziB
         BRxQt9fW1aqykz9Y/FGWS2HthPvkd6gXTT6r7ZB8=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] media: doc: pixfmt-rgb: Fix V4L2_PIX_FMT_BGR24 format description
Date:   Tue, 15 Feb 2022 13:20:32 +0200
Message-Id: <20220215112032.12094-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The V4L2_PIX_FMT_BGR24 format is incorrectly described, with the B and G
components swapped. Fix it.

Fixes: 2ac9280cb459 ("media: doc: pixfmt-rgb: Make 8 bits per component table more compact")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-rgb.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
index 48b0f787274c..30f51cd33f99 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -672,8 +672,8 @@ nomenclature that instead use the order of components as seen in a 24- or
       - ``V4L2_PIX_FMT_BGR24``
       - 'BGR3'
 
-      - G\ :sub:`7-0`
       - B\ :sub:`7-0`
+      - G\ :sub:`7-0`
       - R\ :sub:`7-0`
       -
     * .. _V4L2-PIX-FMT-RGB24:

base-commit: 68a99f6a0ebfe9101ea79ba5af1c407a5ad4f629
-- 
Regards,

Laurent Pinchart

