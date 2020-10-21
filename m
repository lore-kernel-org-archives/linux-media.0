Return-Path: <SRS0=alUM=D4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33B4C55178
	for <linux-media@archiver.kernel.org>; Wed, 21 Oct 2020 13:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4812224E
	for <linux-media@archiver.kernel.org>; Wed, 21 Oct 2020 13:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441986AbgJUNxj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:53:39 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:28592 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439831AbgJUNxj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 21 Oct 2020 09:53:39 -0400
X-IronPort-AV: E=Sophos;i="5.77,401,1596466800"; 
   d="scan'208";a="60194882"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Oct 2020 22:53:37 +0900
Received: from devel.example.org?044ree.adwin.renesas.com (unknown [10.226.36.120])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 51E6A42980AC;
        Wed, 21 Oct 2020 22:53:35 +0900 (JST)
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
Subject: [PATCH v5 0/5] Add r8a77965 DRIF support
Date:   Wed, 21 Oct 2020 14:53:27 +0100
Message-Id: <20201021135332.4928-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Dear All,

this series is to add DRIF support for the r8a77965
(a.k.a. R-Car M3-N). Version 5 fixes a warning reported
by 'make dt_binding_check', as reported by Rob.

Thanks,
Fab

Fabrizio Castro (5):
  MAINTAINERS: Update MAINTAINERS for Renesas DRIF driver
  media: dt-bindings: media: renesas,drif: Convert to json-schema
  media: dt-bindings: media: renesas,drif: Add r8a77990 support
  media: dt-bindings: media: renesas,drif: Add r8a77965 support
  arm64: dts: r8a77965: Add DRIF support

 .../bindings/media/renesas,drif.txt           | 177 -----------
 .../bindings/media/renesas,drif.yaml          | 279 ++++++++++++++++++
 MAINTAINERS                                   |   4 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi     | 120 ++++++++
 4 files changed, 401 insertions(+), 179 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/renesas,drif.txt
 create mode 100644 Documentation/devicetree/bindings/media/renesas,drif.yaml

-- 
2.25.1

