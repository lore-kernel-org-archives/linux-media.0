Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF4C4363C
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 20:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE51721D43
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 20:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgIUUjE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:39:04 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:39198 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727483AbgIUUjD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 16:39:03 -0400
Received: from [78.134.51.148] (port=50434 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kKSJn-0009Ai-UR; Mon, 21 Sep 2020 22:21:48 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v2 1/4] media: docs: v4l2-subdev: fix typo
Date:   Mon, 21 Sep 2020 22:21:31 +0200
Message-Id: <20200921202134.9792-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix "will to" -> "will do".

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v2: none
---
 Documentation/driver-api/media/v4l2-subdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/v4l2-subdev.rst b/Documentation/driver-api/media/v4l2-subdev.rst
index bc7e1fc40a9d..9a7dddd97f5a 100644
--- a/Documentation/driver-api/media/v4l2-subdev.rst
+++ b/Documentation/driver-api/media/v4l2-subdev.rst
@@ -191,7 +191,7 @@ but it is better and easier to use this macro:
 
 	err = v4l2_subdev_call(sd, core, g_std, &norm);
 
-The macro will to the right ``NULL`` pointer checks and returns ``-ENODEV``
+The macro will do the right ``NULL`` pointer checks and returns ``-ENODEV``
 if :c:type:`sd <v4l2_subdev>` is ``NULL``, ``-ENOIOCTLCMD`` if either
 :c:type:`sd <v4l2_subdev>`->core or :c:type:`sd <v4l2_subdev>`->core->g_std is ``NULL``, or the actual result of the
 :c:type:`sd <v4l2_subdev>`->ops->core->g_std ops.
-- 
2.28.0

