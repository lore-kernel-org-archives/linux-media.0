Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08169C282CE
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 11:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18C92171F
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 11:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfDLLhw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:37:52 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54237 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfDLLhv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 07:37:51 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 69501C0016;
        Fri, 12 Apr 2019 11:37:48 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, sergei.shtylyov@cogentembedded.com,
        geert+renesas@glider.be
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 0/2] media: rcar-vin: Add "renesas,id" to V3H
Date:   Fri, 12 Apr 2019 13:38:30 +0200
Message-Id: <20190412113832.30075-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

These two patches add the mandatory "renesas,id" property to
V3H device tree.

As the property is mandatory and the driver checks for its presence,
this might actually fix VIN probe on V3H boards.

In order to support V3H, which has 16 VIN instances, modify the way the
VIN driver handles the maximum number of VIN, making it a per-SoC property.

As explained in the commit message of [2/2] if anyone with an V3H board could
provide a Tested-by tag, these two patches might actually be tagged as fixes.

Tested on Salvator-x M3-W and Ebisu E3.

Thanks
  j

Jacopo Mondi (2):
  media: rcar-vin: Make the number of VIN SoC-dependent
  arm64: dts: renesas: r8a77980: Add "renesas,id" to VIN

 arch/arm64/boot/dts/renesas/r8a77980.dtsi   | 16 ++++++++++++++
 drivers/media/platform/rcar-vin/rcar-core.c | 23 +++++++++++++++------
 drivers/media/platform/rcar-vin/rcar-vin.h  |  5 ++++-
 3 files changed, 37 insertions(+), 7 deletions(-)

--
2.21.0

