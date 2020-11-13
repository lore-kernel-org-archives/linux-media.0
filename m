Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC815C61DD8
	for <linux-media@archiver.kernel.org>; Fri, 13 Nov 2020 17:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD25F2223F
	for <linux-media@archiver.kernel.org>; Fri, 13 Nov 2020 17:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKMREY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:04:24 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48069 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMREY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 13 Nov 2020 12:04:24 -0500
X-Originating-IP: 93.29.109.196
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 64B4BE0009;
        Fri, 13 Nov 2020 17:04:21 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/3] media: i2c: OV8865 image sensor support
Date:   Fri, 13 Nov 2020 18:03:41 +0100
Message-Id: <20201113170344.2252234-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series adds support for the OV8865 image sensor, as a V4L2 subdev
driver. Although an initial series was submitted by Kévin L'hôpital some
weeks ago, this version is significantly new and should be considered a
new series.

The final patch (not for merge) shows how to enable the OV8865 on the
Banana Pi Camera Board v2 with the Banana Pi M3.

Changes since v1:
- Used runtime pm;
- Used assigned-clock-rate;
- Removed clock name;
- Returned closest size in set_fmt;
- Removed unneeded references to v4l2 controls;
- Removed unneeded structure packing attribute;
- Removed i2c device table;
- Dual-licensed bindings;
- Used SPDX tags.

Cheers,

Paul

Kévin L'hôpital (1):
  ARM: dts: sun8i: a83t: bananapi-m3: Enable MIPI CSI-2 with OV8865

Paul Kocialkowski (2):
  dt-bindings: media: i2c: Add OV8865 bindings documentation
  media: i2c: Add support for the OV8865 image sensor

 .../bindings/media/i2c/ovti,ov8865.yaml       |  120 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |   99 +
 drivers/media/i2c/Kconfig                     |   13 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/ov8865.c                    | 3043 +++++++++++++++++
 5 files changed, 3276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov8865.yaml
 create mode 100644 drivers/media/i2c/ov8865.c

-- 
2.28.0

