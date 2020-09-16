Return-Path: <SRS0=oGXw=CZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604A2C43461
	for <linux-media@archiver.kernel.org>; Wed, 16 Sep 2020 20:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1394E20936
	for <linux-media@archiver.kernel.org>; Wed, 16 Sep 2020 20:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgIPUWI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:22:08 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:38446 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727133AbgIPR3d (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Sep 2020 13:29:33 -0400
X-IronPort-AV: E=Sophos;i="5.76,432,1592838000"; 
   d="scan'208";a="57427880"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Sep 2020 19:59:55 +0900
Received: from devel.example.org?044ree.adwin.renesas.com (unknown [10.226.36.120])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 746884277746;
        Wed, 16 Sep 2020 19:59:52 +0900 (JST)
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
Subject: [PATCH v2 0/3] Document r8a77990 DRIF support
Date:   Wed, 16 Sep 2020 11:59:46 +0100
Message-Id: <20200916105949.24858-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Dear All,

this series documents DRIF support for the r8a77990
(a.k.a. R-Car E3).

Thanks,
Fab

Fabrizio Castro (3):
  MAINTAINERS: Add Fabrizio Castro to Renesas DRIF
  media: dt-bindings: media: renesas,drif: Convert to json-schema
  media: dt-bindings: media: renesas,drif: Add r8a77990 support

 .../bindings/media/renesas,drif.txt           | 177 ------------
 .../bindings/media/renesas,drif.yaml          | 271 ++++++++++++++++++
 MAINTAINERS                                   |   3 +-
 3 files changed, 273 insertions(+), 178 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/renesas,drif.txt
 create mode 100644 Documentation/devicetree/bindings/media/renesas,drif.yaml

-- 
2.25.1

