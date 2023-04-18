Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C35C77B75
	for <linux-media@archiver.kernel.org>; Tue, 18 Apr 2023 09:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjDRJQF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Apr 2023 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjDRJQC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Apr 2023 05:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE50D1;
        Tue, 18 Apr 2023 02:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8706960F87;
        Tue, 18 Apr 2023 09:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59289C433D2;
        Tue, 18 Apr 2023 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681809360;
        bh=i8nVDFAokOgYqujZXdzkVQr8aJvHUufQtj/uWLHRiLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=T/hrPpv3I+K/TuV8sg7CAaDvM+g0MlH/1F4N39W5MjPOLifXQdoP9DIPgZTXfe0o3
         fduBrg0+trdeWQiQzxjk3y+OFm3PLHFzDJXY4xldPcxsYCdmkOVI1C7Sqd47dgY3F9
         4G6ZGDdAcUIEewnWGRYlyk/PZC5nopW/izCFwAsuSheiAHwjBvnSR6D7WR2RK+3OWS
         r83r6QFzfm/pidwR7+JspzU1Zsp/7SUKVjLwtsbU9qqwXLhT8LhIH/Pi+a7DqLlo5U
         NrJRwVdNDMwfegNk18HSWHDEASy1fmUlreNmQjCDbAFeQ8kPNkxWVDLmv8JKRaxx0S
         ldUqYvFlD8Exg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sun Ke <sunke32@huawei.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] media: platform: mtk-mdp3: work around unused-variable warning
Date:   Tue, 18 Apr 2023 11:15:48 +0200
Message-Id: <20230418091555.2605961-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_OF is disabled, the 'data' variable is not used at all
because of_match_node() turns into a dummy macro:

drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c: In function 'mdp_comp_sub_create':
drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:1038:36: error: unused variable 'data' [-Werror=unused-variable]
 1038 |  const struct mtk_mdp_driver_data *data = mdp->mdp_data;
      |                                    ^~~~

Remove the variable again by moving the pointer dereference into the
of_match_node call.

Fixes: b385b991ef2f ("media: platform: mtk-mdp3: chip config split about subcomponents")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 75c92e282fa2..19a4a085f73a 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -1035,7 +1035,6 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
 {
 	struct device *dev = &mdp->pdev->dev;
 	struct device_node *node, *parent;
-	const struct mtk_mdp_driver_data *data = mdp->mdp_data;
 
 	parent = dev->of_node->parent;
 
@@ -1045,7 +1044,7 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
 		int id, alias_id;
 		struct mdp_comp *comp;
 
-		of_id = of_match_node(data->mdp_sub_comp_dt_ids, node);
+		of_id = of_match_node(mdp->mdp_data->mdp_sub_comp_dt_ids, node);
 		if (!of_id)
 			continue;
 		if (!of_device_is_available(node)) {
-- 
2.39.2

