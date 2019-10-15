Return-Path: <SRS0=iZr9=YI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78438C10F14
	for <linux-media@archiver.kernel.org>; Tue, 15 Oct 2019 10:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591EA2089C
	for <linux-media@archiver.kernel.org>; Tue, 15 Oct 2019 10:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfJOK6n (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:58:43 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:55418 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbfJOK6n (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 15 Oct 2019 06:58:43 -0400
X-IronPort-AV: E=Sophos;i="5.67,299,1566831600"; 
   d="scan'208";a="28927857"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Oct 2019 19:58:41 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 213A64006DFD;
        Tue, 15 Oct 2019 19:58:37 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/4] Add VIN/CSI-2 support
Date:   Tue, 15 Oct 2019 11:57:54 +0100
Message-Id: <1571137078-28922-1-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch series add VIN/CSI-2 driver support for RZ/G2N SoC.

Biju Das (4):
  media: dt-bindings: rcar-vin: Add R8A774B1 support
  media: dt-bindings: rcar-csi2: Add R8A774B1 support
  media: rcar-vin: Enable support for R8A774B1
  media: rcar-csi2: Enable support for R8A774B1

 Documentation/devicetree/bindings/media/renesas,csi2.txt | 1 +
 Documentation/devicetree/bindings/media/renesas,vin.txt  | 1 +
 drivers/media/platform/rcar-vin/rcar-core.c              | 4 ++++
 drivers/media/platform/rcar-vin/rcar-csi2.c              | 4 ++++
 4 files changed, 10 insertions(+)

-- 
2.7.4

