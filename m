Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EF1C433DB
	for <linux-media@archiver.kernel.org>; Thu,  7 Jan 2021 13:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5066122B4B
	for <linux-media@archiver.kernel.org>; Thu,  7 Jan 2021 13:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbhAGNl5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 7 Jan 2021 08:41:57 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39149 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGNl5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 7 Jan 2021 08:41:57 -0500
X-Originating-IP: 93.29.109.196
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 18014C0005;
        Thu,  7 Jan 2021 13:41:10 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 0/5] Rockchip PX30 RGA and VPU support
Date:   Thu,  7 Jan 2021 14:40:56 +0100
Message-Id: <20210107134101.195426-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series adds the required bits for RGA and VPU support on the
Rockchip PX30 SoC.

Cheers,

Paul

Paul Kocialkowski (5):
  dt-bindings: media: rockchip-rga: Add PX30 compatible
  arm64: dts: rockchip: Add RGA support to the PX30
  dt-bindings: media: rockchip-vpu: Add PX30 compatible
  arm64: dts: rockchip: Add VPU support for the PX30
  media: hantro: Add support for the Rockchip PX30

 .../bindings/media/rockchip-rga.yaml          |  4 ++-
 .../bindings/media/rockchip-vpu.yaml          | 25 +++++++++-----
 arch/arm64/boot/dts/rockchip/px30.dtsi        | 34 +++++++++++++++++++
 drivers/staging/media/hantro/hantro_drv.c     |  5 +--
 drivers/staging/media/hantro/hantro_hw.h      |  1 +
 drivers/staging/media/hantro/rk3399_vpu_hw.c  | 21 ++++++++++++
 6 files changed, 79 insertions(+), 11 deletions(-)

-- 
2.30.0

