Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C7C433EF
	for <linux-media@archiver.kernel.org>; Mon, 28 Mar 2022 20:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbiC1UCB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344213AbiC1UBz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 28 Mar 2022 16:01:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACA33A1BE;
        Mon, 28 Mar 2022 13:00:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id BF52A1F43867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497602;
        bh=HlQF5QYc2YwGYm21E6HNcjkx9wicYLtIvyiKegTR5UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2V9/AoW0YdfJtrSr0L83RDfv81sqKRWMuoCG6uFzKhVuId0g7jU0+lCWSjHFtvDt
         3wzVTlRR05iMdPpkcowX+LYBbNam7WzQ+LjM+8QGAw3nbqf7wKLL0e07ceJvgMJf8Q
         eUc16uV2Y1opzL3MKU8z58oj3mCfhCEim9J5lGrNfg/RMhRCqtGj/VNrk/HoAaSjd4
         ubhJ7Em0sfWafUoDLriWEgwNCCu8FDfDe8huEPeMlqjkMZoJQDHtxdXJICTgNGcHx+
         LsUrjfRvKShqcJhGpE4QJwQg2uUzK/0wKDS0MOB5vJuXDR82STUSF0egw3UDQfcdo0
         u5NxEVnZZY4DQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/24] media: v4l2-mem2mem: Trace on implicit un-hold
Date:   Mon, 28 Mar 2022 15:59:22 -0400
Message-Id: <20220328195936.82552-11-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If the timestamp of the src buffer differs from the timestamp of a held
dst buffer, the held buffer is implicitly removed and marked as done.
Add a trace to help debugging if someone hits that case.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 53c2332d5cbd..d3e739ef16ef 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -336,6 +336,7 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
 	if (src && dst && dst->is_held &&
 	    dst->vb2_buf.copied_timestamp &&
 	    dst->vb2_buf.timestamp != src->vb2_buf.timestamp) {
+		dprintk("src and dst timestamp mismatch, removing held capture buffer.\n");
 		dst->is_held = false;
 		v4l2_m2m_dst_buf_remove(m2m_ctx);
 		v4l2_m2m_buf_done(dst, VB2_BUF_STATE_DONE);
-- 
2.34.1

