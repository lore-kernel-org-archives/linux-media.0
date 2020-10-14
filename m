Return-Path: <SRS0=7hcH=DV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486BEC43467
	for <linux-media@archiver.kernel.org>; Wed, 14 Oct 2020 15:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012AF2222F
	for <linux-media@archiver.kernel.org>; Wed, 14 Oct 2020 15:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgJNP5a (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:57:30 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:1802 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727161AbgJNP51 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 14 Oct 2020 11:57:27 -0400
X-IronPort-AV: E=Sophos;i="5.77,375,1596466800"; 
   d="scan'208";a="59783592"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Oct 2020 00:57:26 +0900
Received: from devel.example.org?044ree.adwin.renesas.com (unknown [10.226.36.120])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 42F09400C4E3;
        Thu, 15 Oct 2020 00:57:24 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Ramesh Shanmugasundaram <rashanmu@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 1/5] MAINTAINERS: Update MAINTAINERS for Renesas DRIF driver
Date:   Wed, 14 Oct 2020 16:57:15 +0100
Message-Id: <20201014155719.15120-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201014155719.15120-1-fabrizio.castro.jz@renesas.com>
References: <20201014155719.15120-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add Fabrizio castro and remove Ramesh Shanmugasundaram.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Ramesh Shanmugasundaram <rashanmu@gmail.com>
---
v3->v4:
* No change
v2->v3:
* Removed Ramesh Shanmugasundaram as maintainer, as suggested
  by Ramesh
* Reworked commit title and changelog
v1->v2:
* No change

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a54806ebf02..4ff8e65df4e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10835,7 +10835,7 @@ F:	drivers/media/platform/renesas-ceu.c
 F:	include/media/drv-intf/renesas-ceu.h
 
 MEDIA DRIVERS FOR RENESAS - DRIF
-M:	Ramesh Shanmugasundaram <rashanmu@gmail.com>
+M:	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
 L:	linux-media@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
-- 
2.25.1

