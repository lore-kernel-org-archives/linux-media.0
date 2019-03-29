Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69FC43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 13:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74802173C
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553867075;
	bh=+xjDhf37+qEIlTQiYPWiQoEOLfX4uQGZ7djFq2l54R4=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=2PZYCw7PKhG8u2EX9K2xiEbz9z08zPTSTpHyopdaAJSU1YCH89ixcfRkCUZUvT98F
	 zsIJN7hvJVuwYgru8lzKMOQ1OELbL3U7SI6hV1w/yyPRbxXal44cww/y4lIL7654ry
	 EmwTi+UW2ldBQUOg0wjr9M2d0CkmzPHevljOGxlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfC2Nof (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:44:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfC2Noe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 09:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RUyTiAz3YMJQ99nj5cFSwGYgwd0v+ozFq6uU6U8XllU=; b=tKbbYQ+lIzzEomQzqtF3Ny+L1
        MmUmcYgZKdNHx+o0VkUFM7GIMrPOi3NMBtkcSKrKl9QV+bmolDI//p+DBYlVRAVxS6R9rlnDy8KVu
        0M2YVmYCXdWRqhWj/klBbV+mojx4L6P5XrH7k0UpmgrMIa912c0xhNwE99nTvkPzf1cVbzna/8gzO
        X4YNAudGq0RzC2q8ypAyu6t494iFUK8WxDoGEQDKUPBZDvXqMbzq60kh04ELw/wftqEolZb3AoaC0
        B+fI35yk1RBXaD+KJNe2nmV/Rnvie0K3485IhLB8FBDlgbizGUix+k3qiBZcm+r/CEZVdAkShRkhs
        tuwudmsCQ==;
Received: from [179.183.99.176] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9roA-0007xU-9z; Fri, 29 Mar 2019 13:44:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1h9ro7-0001GY-Lo; Fri, 29 Mar 2019 09:44:31 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH] media: vim2m: Fix RGB 565 BE/LE support
Date:   Fri, 29 Mar 2019 09:44:30 -0400
Message-Id: <a7cdf8b88dadb4c71dccb0afc22409cbd7ff4fe5.1553867066.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The support for those two formats are archtecture-dependent.
Use the endianness to CPU macros to do it right.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/platform/vim2m.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/vim2m.c b/drivers/media/platform/vim2m.c
index 3c3a6a03b948..243c82b5d537 100644
--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@ -302,7 +302,7 @@ static void copy_two_pixels(struct vim2m_q_data *q_data_in,
 	switch (in->fourcc) {
 	case V4L2_PIX_FMT_RGB565: /* rrrrrggg gggbbbbb */
 		for (i = 0; i < 2; i++) {
-			u16 pix = *(u16 *)(src[i]);
+			u16 pix = le16_to_cpu(*(__le16 *)(src[i]));
 
 			*r++ = (u8)(((pix & 0xf800) >> 11) << 3) | 0x07;
 			*g++ = (u8)((((pix & 0x07e0) >> 5)) << 2) | 0x03;
@@ -311,12 +311,11 @@ static void copy_two_pixels(struct vim2m_q_data *q_data_in,
 		break;
 	case V4L2_PIX_FMT_RGB565X: /* gggbbbbb rrrrrggg */
 		for (i = 0; i < 2; i++) {
-			u16 pix = *(u16 *)(src[i]);
+			u16 pix = be16_to_cpu(*(__be16 *)(src[i]));
 
-			*r++ = (u8)(((0x00f8 & pix) >> 3) << 3) | 0x07;
-			*g++ = (u8)(((pix & 0x7) << 2) |
-				    ((pix & 0xe000) >> 5)) | 0x03;
-			*b++ = (u8)(((pix & 0x1f00) >> 8) << 3) | 0x07;
+			*r++ = (u8)(((pix & 0xf800) >> 11) << 3) | 0x07;
+			*g++ = (u8)((((pix & 0x07e0) >> 5)) << 2) | 0x03;
+			*b++ = (u8)((pix & 0x1f) << 3) | 0x07;
 		}
 		break;
 	default:
@@ -345,21 +344,26 @@ static void copy_two_pixels(struct vim2m_q_data *q_data_in,
 	switch (out->fourcc) {
 	case V4L2_PIX_FMT_RGB565: /* rrrrrggg gggbbbbb */
 		for (i = 0; i < 2; i++) {
-			u16 *pix = (u16 *)*dst;
+			u16 pix;
+			__le16 *dst_pix = (__le16 *)*dst;
 
-			*pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |
-			       (*b >> 3);
+			pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |
+			      (*b >> 3);
+
+			*dst_pix = cpu_to_le16(pix);
 
 			*dst += 2;
 		}
 		return;
 	case V4L2_PIX_FMT_RGB565X: /* gggbbbbb rrrrrggg */
 		for (i = 0; i < 2; i++) {
-			u16 *pix = (u16 *)*dst;
-			u8 green = *g++ >> 2;
+			u16 pix;
+			__be16 *dst_pix = (__be16 *)*dst;
 
-			*pix = ((green << 8) & 0xe000) | (green & 0x07) |
-			       ((*b++ << 5) & 0x1f00) | ((*r++ & 0xf8));
+			pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |
+			      (*b >> 3);
+
+			*dst_pix = cpu_to_be16(pix);
 
 			*dst += 2;
 		}
-- 
2.20.1

