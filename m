Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7E6C4361B
	for <linux-media@archiver.kernel.org>; Tue,  8 Dec 2020 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F2B239E5
	for <linux-media@archiver.kernel.org>; Tue,  8 Dec 2020 16:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgLHQWf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Dec 2020 11:22:35 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:42570 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLHQWf (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 8 Dec 2020 11:22:35 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id B89D73AD504;
        Tue,  8 Dec 2020 16:16:18 +0000 (UTC)
X-Originating-IP: 90.76.70.27
Received: from pc-2.home (lfbn-tou-1-1249-27.w90-76.abo.wanadoo.fr [90.76.70.27])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C2989FF816;
        Tue,  8 Dec 2020 16:15:14 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 0/3] media: rockchip: Introduce driver for Rockchip's camera interface
Date:   Tue,  8 Dec 2020 17:15:06 +0100
Message-Id: <20201208161509.655862-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi everyone,

This is the fourth iteration of the series introducing a driver for the
PX30 camera interface.

This was previously known as the "cif" driver in other iterations, but
was renamed to "vip" following Ezequiel's advices to match the datasheet
name.

This is based on a BSP driver, and I'm not fully familiar with the media
and V4L2 frameworks, so I guess some review is still needed.

On top of the previous series, this series addresses most of the reviews
by Ezequiel (Thanks again), and was tested on a PX30 chip.

Maxime


Maxime Chevallier (3):
  media: dt-bindings: media: Document Rockchip VIP bindings
  media: rockchip: Introduce driver for Rockhip's camera interface
  arm64: dts: rockchip: Add the camera interface description of the PX30

 .../bindings/media/rockchip-vip.yaml          |   94 ++
 arch/arm64/boot/dts/rockchip/px30.dtsi        |   12 +
 drivers/media/platform/Kconfig                |   15 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/rockchip/vip/Makefile  |    3 +
 drivers/media/platform/rockchip/vip/capture.c | 1148 +++++++++++++++++
 drivers/media/platform/rockchip/vip/dev.c     |  333 +++++
 drivers/media/platform/rockchip/vip/dev.h     |  203 +++
 drivers/media/platform/rockchip/vip/regs.h    |  260 ++++
 9 files changed, 2069 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-vip.yaml
 create mode 100644 drivers/media/platform/rockchip/vip/Makefile
 create mode 100644 drivers/media/platform/rockchip/vip/capture.c
 create mode 100644 drivers/media/platform/rockchip/vip/dev.c
 create mode 100644 drivers/media/platform/rockchip/vip/dev.h
 create mode 100644 drivers/media/platform/rockchip/vip/regs.h

-- 
2.25.4

