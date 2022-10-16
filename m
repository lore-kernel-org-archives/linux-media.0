Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8310CC433FE
	for <linux-media@archiver.kernel.org>; Sun, 16 Oct 2022 06:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJPGPu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 16 Oct 2022 02:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJPGPt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 16 Oct 2022 02:15:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3703685D
        for <linux-media@vger.kernel.org>; Sat, 15 Oct 2022 23:15:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A05FC30A;
        Sun, 16 Oct 2022 08:15:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665900946;
        bh=ybkr0anRyu7nQ6zJ9MbB1Vx7g2eqXElB6hgbSnC/My0=;
        h=From:To:Cc:Subject:Date:From;
        b=DBuPEKJSG0p3NSgwBXEeWgsxzr94H0Jcy6RSYaSLnLxX8LK5LueOCTg0iA05YF8yy
         i11vjsFKnky6jR4Ly6nHRbQdOayCpXs5ogori7Y5jj5UGGt1Ad8SVyR1IMek/jNcsx
         lJWxmq2LsfBt2PKHF5X3auuGR2nN+R1Y1YW8TkhI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v2 00/20] media: i2c: imx290: Miscellaneous improvements
Date:   Sun, 16 Oct 2022 09:15:03 +0300
Message-Id: <20221016061523.30127-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

This patch series gathers miscellaneous improvements for the imx290
driver. The most notable changes on the kernel side is patch 08/20 that
simplifies register access, and on the userspace API side patches 15/20,
16/20 and 19/20 that extend the driver with controls and selection
rectangles required by libcamera.

Laurent Pinchart (20):
  media: dt-bindings: Convert imx290.txt to YAML
  media: i2c: imx290: Use device lock for the control handler
  media: i2c: imx290: Print error code when I2C transfer fails
  media: i2c: imx290: Replace macro with explicit ARRAY_SIZE()
  media: i2c: imx290: Drop imx290_write_buffered_reg()
  media: i2c: imx290: Drop regmap cache
  media: i2c: imx290: Specify HMAX values in decimal
  media: i2c: imx290: Support variable-sized registers
  media: i2c: imx290: Correct register sizes
  media: i2c: imx290: Simplify error handling when writing registers
  media: i2c: imx290: Define more register macros
  media: i2c: imx290: Add exposure time control
  media: i2c: imx290: Fix max gain value
  media: i2c: imx290: Split control initialization to separate function
  media: i2c: imx290: Implement HBLANK and VBLANK controls
  media: i2c: imx290: Create controls for fwnode properties
  media: i2c: imx290: Move registers with fixed value to init array
  media: i2c: imx290: Factor out format retrieval to separate function
  media: i2c: imx290: Add crop selection targets support
  media: i2c: imx290: Replace GAIN control with ANALOGUE_GAIN

 .../devicetree/bindings/media/i2c/imx290.txt  |  57 --
 .../bindings/media/i2c/sony,imx290.yaml       | 129 +++
 MAINTAINERS                                   |   2 +-
 drivers/media/i2c/imx290.c                    | 784 ++++++++++--------
 4 files changed, 591 insertions(+), 381 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml

-- 
Regards,

Laurent Pinchart

