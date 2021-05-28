Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6338C47087
	for <linux-media@archiver.kernel.org>; Fri, 28 May 2021 08:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1B2613D4
	for <linux-media@archiver.kernel.org>; Fri, 28 May 2021 08:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhE1IPs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 28 May 2021 04:15:48 -0400
Received: from comms.puri.sm ([159.203.221.185]:41174 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234715AbhE1IPr (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 28 May 2021 04:15:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id F03D6E3C05;
        Fri, 28 May 2021 01:14:12 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ybR3mDS6BlZB; Fri, 28 May 2021 01:14:12 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     devicetree@vger.kernel.org, kernel@puri.sm,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, paul.kocialkowski@bootlin.com,
        robh@kernel.org, shawnx.tu@intel.com,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 0/5] Add support for the Hynix Hi-846 camera
Date:   Fri, 28 May 2021 10:13:31 +0200
Message-Id: <20210528081336.3858700-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

hi,

This patchset add support for the SK Hynix Hi-846 CMOS images sensor.
It includes documentation, dt-bindings and the driver.

patch 4 and 5 are basically optional: if i2c-cardlist is deprecated,
ignore it and act on it appropriately, and the defconfig would just
be convenience for now.

best wishes,

                              martin


revision history
----------------
v2:
sent a bit early due to stupid mistakes
fix build issues
fix dtschema issues
add enable for arm64 defconfig

v1:
https://lore.kernel.org/linux-media/20210527091221.3335998-1-martin.kepplinger@puri.sm/


Martin Kepplinger (5):
  dt-bindings: vendor-prefixes: Add SK Hynix Inc.
  dt-bindings: media: document SK Hynix Hi-846 MIPI CSI-2 8M pixel
    sensor
  media: i2c: add driver for the SK Hynix Hi-846 8M pixel camera
  arm64: defconfig: enable VIDEO_HI846
  Documentation: i2c-cardlist: add the Hynix hi846 sensor

 .../admin-guide/media/i2c-cardlist.rst        |    1 +
 .../bindings/media/i2c/hynix,hi846.yaml       |   99 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    6 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/media/i2c/Kconfig                     |   13 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/hi846.c                     | 2137 +++++++++++++++++
 8 files changed, 2260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
 create mode 100644 drivers/media/i2c/hi846.c

-- 
2.30.2

