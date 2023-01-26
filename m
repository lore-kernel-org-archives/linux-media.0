Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE7DC05027
	for <linux-media@archiver.kernel.org>; Thu, 26 Jan 2023 15:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjAZPHR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Jan 2023 10:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjAZPHN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Jan 2023 10:07:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE146B9A2
        for <linux-media@vger.kernel.org>; Thu, 26 Jan 2023 07:07:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 689E061870
        for <linux-media@vger.kernel.org>; Thu, 26 Jan 2023 15:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14269C433D2;
        Thu, 26 Jan 2023 15:07:10 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH 10/17] media: mediatek: mdp3: replace return by goto for proper unwind
Date:   Thu, 26 Jan 2023 16:06:50 +0100
Message-Id: <20230126150657.367921-11-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126150657.367921-1-hverkuil-cisco@xs4all.nl>
References: <20230126150657.367921-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

An error was returned at one point without going through the
goto label for proper unwinding.

This fixes a smatch warning:

mtk-mdp3-comp.c:1005 mdp_comp_config() warn: missing unwind goto?

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 7bc05f42a23c..091a68685590 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -1002,7 +1002,8 @@ int mdp_comp_config(struct mdp_dev *mdp)
 		if (!pdev) {
 			dev_warn(dev, "can't find platform device of node:%s\n",
 				 node->name);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_init_comps;
 		}
 
 		comp->comp_dev = &pdev->dev;
-- 
2.39.0

