Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0DFC433EF
	for <linux-media@archiver.kernel.org>; Mon,  7 Feb 2022 01:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbiBGBVK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 6 Feb 2022 20:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGBVJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 6 Feb 2022 20:21:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B35FC06173B;
        Sun,  6 Feb 2022 17:21:07 -0800 (PST)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 911B7340;
        Mon,  7 Feb 2022 02:21:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644196863;
        bh=SLvsc5bL8lUIuWkHjRiML3fIElJ7Y19RwQ9juHy/qgI=;
        h=From:To:Cc:Subject:Date:From;
        b=l8f1UqawbFVr9OIdwoT/Cnv7RRPjWO2jRNntm9c4ieiGhHwrOkaJIQ38EnDC0s0du
         1zUo2VkO8CfjAxjZvVKwBz87y8ZvRClwvZK+aaNR19ytlijl8WddDSd5BlzimaQ3Kd
         7oIVhBfJS1jbL4/NdYO80NvUl0OUFaTp/coYnciM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] media: Add onsemi MT9M114 camera sensor driver
Date:   Mon,  7 Feb 2022 03:20:53 +0200
Message-Id: <20220207012055.15158-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

This series adds a driver for the onsemi MT9M114 camera sensor. It's all
a pretty standard story, DT bindings are in 1/2, and the driver in 2/2.
Review comments from v1 have been taken into account, except perhaps for
a couple of points that are still being discussed.

Laurent Pinchart (2):
  media: dt-bindings: media: i2c: Add MT9M114 camera sensor binding
  media: i2c: Add driver for onsemi MT9M114 camera sensor

 .../bindings/media/i2c/onnn,mt9m114.yaml      |  110 +
 MAINTAINERS                                   |    8 +
 drivers/media/i2c/Kconfig                     |   11 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/mt9m114.c                   | 2467 +++++++++++++++++
 5 files changed, 2597 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/onnn,mt9m114.yaml
 create mode 100644 drivers/media/i2c/mt9m114.c


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
Regards,

Laurent Pinchart

