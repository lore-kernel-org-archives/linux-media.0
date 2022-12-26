Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE2C4332F
	for <linux-media@archiver.kernel.org>; Mon, 26 Dec 2022 07:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiLZHCp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Dec 2022 02:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLZHCm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Dec 2022 02:02:42 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4921AC;
        Sun, 25 Dec 2022 23:02:40 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 559E21A0091E;
        Mon, 26 Dec 2022 15:02:45 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfs.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JoaWsWZB_SC5; Mon, 26 Dec 2022 15:02:44 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 501911A0087E;
        Mon, 26 Dec 2022 15:02:44 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, sebastian.fricke@collabora.com,
        ezequiel@vanguardiasur.com.ar
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH v2] drivers/media/v4l2-core/v4l2-h264 : add detection of null pointers
Date:   Mon, 26 Dec 2022 15:02:36 +0800
Message-Id: <20221226070236.4450-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When the pointer variable is judged to be null, null is returned
directly.

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
---
 v2: Directly return when pointer allocation fails.

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 72bd64f65198..0e7b35ae3e94 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -343,6 +343,8 @@ static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *bui
 	int n = 0, i;
 
 	*out_str = kmalloc(tmp_str_size, GFP_KERNEL);
+	if (*out_str == NULL)
+		return NULL;
 
 	n += snprintf(*out_str + n, tmp_str_size - n, "|");
 
@@ -356,7 +358,6 @@ static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *bui
 			       longterm ? 'l' : 's',
 			       ref_type_to_char(reflist[i].fields));
 	}
-
 	return *out_str;
 }
 
-- 
2.18.2

