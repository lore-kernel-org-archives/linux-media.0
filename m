Return-Path: <SRS0=s/rb=VV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF2C7618B
	for <linux-media@archiver.kernel.org>; Wed, 24 Jul 2019 11:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E6C2190F
	for <linux-media@archiver.kernel.org>; Wed, 24 Jul 2019 11:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfGXLK2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:10:28 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:55449 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfGXLK2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Jul 2019 07:10:28 -0400
Received: from tschai.fritz.box ([46.9.232.237])
        by smtp-cloud7.xs4all.net with ESMTPA
        id qFA7h3isaLqASqFAAhNG0x; Wed, 24 Jul 2019 13:10:26 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 01/14] v4l2-ioctl.c: OR flags in v4l_fill_fmtdesc(), not don't overwrite
Date:   Wed, 24 Jul 2019 13:10:10 +0200
Message-Id: <20190724111023.29499-2-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724111023.29499-1-hverkuil-cisco@xs4all.nl>
References: <20190724111023.29499-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCuKa/CUu4X8lGfynrLrXPKocxLUr6sWOnTpygRUeWTn5mBR4mNfC7YP9Z/sxDUjvBXUThO7Y+h8Lc7aIdbT+kZC412gSP/gvNQgRyEScf8vaktubJgJ
 Gps9UzkQYfWHDFNlQjJWpbsjYFoLSXiWOPEOPEo0ioAy1MVwlGotW5xPpXF69CX1ppHILtA/ofuhY3VQIh/vpnWEyZxoNenl2VmJodK3U2WpwWwQinkTPgJV
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If a driver sets a FMT flag in the enum_fmt op, then that will be
ignored since v4l_fill_fmtdesc() overwrites it again.

v4l_fill_fmtdesc() should OR its flag, not overwrite it.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 80efc581e3f9..911a20f915c5 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1390,7 +1390,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 
 	if (descr)
 		WARN_ON(strscpy(fmt->description, descr, sz) < 0);
-	fmt->flags = flags;
+	fmt->flags |= flags;
 }
 
 static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
-- 
2.20.1

