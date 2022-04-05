Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47382C4332F
	for <linux-media@archiver.kernel.org>; Tue,  5 Apr 2022 23:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454147AbiDEWwM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiDEVRc (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 5 Apr 2022 17:17:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4D71EF4;
        Tue,  5 Apr 2022 13:44:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id CDDEC1F441AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649191486;
        bh=fNRZoSK/0DILeV16LVHwTQzonwtkLN2LiUy6JGrnOQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Scm0UslG3tAasAhcfI7SXhZF9mnuYYeoU0WVOILSEe28u2UvPS614pAPUvn0tR8vY
         BfPfCgwdfvP98CSWqoi3ZuXN0HaOE46yLjfQSzVCGJjl9cvr5sYehn89wkAuYnOX3P
         RZU1pSatWpN6HVtOGPMxctI2uEHwsymr+gAUzWHVRwZMrduIq9uRS5Kf1O/2OuGwI0
         pRUyYvMQcjyz8FWyGKtz7Rvn1wL5U5rttLwRzY1LFnidtJ5t1BO3UtI16jP77j/1VX
         UVcPFobq6xFVoyOCx1lKjvZPLIU3uC08T1llOruD9/kBRAsn5S4LrsCk8JXe6h5sdq
         8PqocdEuYqqqw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 04/24] media: h264: Avoid wrapping long_term_frame_idx
Date:   Tue,  5 Apr 2022 16:44:05 -0400
Message-Id: <20220405204426.259074-5-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

For long term references, frame_num is set to long_term_frame_idx which
does not require wrapping. This is fixed by observation, no directly
related issue have been found yet.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/media/v4l2-core/v4l2-h264.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 5633a242520a..ac47519a9fbe 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -57,8 +57,10 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 		 * '8.2.4.1 Decoding process for picture numbers' of the spec.
 		 * TODO: This logic will have to be adjusted when we start
 		 * supporting interlaced content.
+		 * For long term references, frame_num is set to
+		 * long_term_frame_idx which requires no wrapping.
 		 */
-		if (dpb[i].frame_num > cur_frame_num)
+		if (!b->refs[i].longterm && dpb[i].frame_num > cur_frame_num)
 			b->refs[i].frame_num = (int)dpb[i].frame_num -
 					       max_frame_num;
 		else
-- 
2.34.1

