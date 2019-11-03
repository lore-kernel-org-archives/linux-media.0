Return-Path: <SRS0=tKnt=Y3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE60CA9EBB
	for <linux-media@archiver.kernel.org>; Sun,  3 Nov 2019 11:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4D62080F
	for <linux-media@archiver.kernel.org>; Sun,  3 Nov 2019 11:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfKCLYt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 3 Nov 2019 06:24:49 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:34177 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727553AbfKCLYt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 3 Nov 2019 06:24:49 -0500
Received: from tschai.fritz.box ([46.9.232.237])
        by smtp-cloud8.xs4all.net with ESMTPA
        id RDzviydbGTzKrRDzzigkL9; Sun, 03 Nov 2019 12:24:47 +0100
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 7/8] ov6650: fix smatch warning
Date:   Sun,  3 Nov 2019 12:23:37 +0100
Message-Id: <20191103112338.22569-8-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103112338.22569-1-hverkuil-cisco@xs4all.nl>
References: <20191103112338.22569-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNNAn3hofzIq14hM2fVcja2yCx3Ix9gAlypF/SDzL7S+scT4oo/G226iEDwO2OgHb1x6yIF1Ox8NT6od6rUkbAc7G/5Ql0B8pO3Z1Io5u88Cs7usu2zZ
 DNZwglDg295YarYtdK7IzyCRvu+5zDEnXNyL7iZCCUn5XFsQ8it820wHPuIfoucKArYnY161S9Gryt2Gg2mdHGiurcSnUygf0jYdS7VSuY+oO3SLi47FAyYM
 XNw5UdHEzfMNp7+D/zDR3Kl9Yaadp6IbdWZXDY7nm9w=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Initialize ret to 0 to fix this smatch error:

drivers/media/i2c/ov6650.c:853 ov6650_video_probe() error: uninitialized symbol 'ret'.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ov6650.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 3c8f50f8619f..91906b94f978 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -819,7 +819,7 @@ static int ov6650_video_probe(struct v4l2_subdev *sd)
 	const struct ov6650_xclk *xclk = NULL;
 	unsigned long rate;
 	u8 pidh, pidl, midh, midl;
-	int i, ret;
+	int i, ret = 0;
 
 	priv->clk = v4l2_clk_get(&client->dev, NULL);
 	if (IS_ERR(priv->clk)) {
-- 
2.23.0

