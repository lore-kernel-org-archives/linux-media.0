Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D48C10F06
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF3420811
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfC1UFk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:05:40 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34325 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfC1UFk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:05:40 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B14F8E000C;
        Thu, 28 Mar 2019 20:05:36 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 00/31] v4l: add support for multiplexed streams
Date:   Thu, 28 Mar 2019 21:05:37 +0100
Message-Id: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,
   new iteration of multiplexed stream support patch series.

V3 available at:
https://patchwork.kernel.org/cover/10839889/

V2 sent by Niklas is available at:
https://patchwork.kernel.org/cover/10573817/

Series available at:
git://jmondi.org/linux v4l2-mux/media-master/v4

Few changes compared to v3:
- Rebased on latest media master
- Include Sakari's and Luca's comments on documentation patch
- Improve connected pad operator as suggested by Ian and Sakari
- Fix a bogus -EINVAL return in 31/31 as suggested by Sakari
- Improve adv748x afe has_route as suggested by Luca and Sakari
- Closed some checkpatch warnings (there are still a few though)

v2 -> v3
- Added IOCTLs documentation, and a section to describe multiplexed media links
  to the v4l2-subdevice interface chapter and expanded functions documentation
- Re-worked the IOCTLs so that they don't need a compat version
- Sort pads to be passed to has_route() by their index values
- Drop indirect routes support from this initial version. Might be considered
  later to simplify subdevice drivers implementations
- Add has_route() operations to adv748x and rcar-csi2 subdevice drivers


Jacopo Mondi (4):
  media: entity: Add iterator helper for entity pads
  media: Documentation: Add GS_ROUTING documentation
  adv748x: afe: Implement has_route()
  media: rcar-csi2: Implement has_route()

Laurent Pinchart (4):
  media: entity: Add has_route entity operation
  media: entity: Add media_entity_has_route() function
  media: entity: Use routing information during graph traversal
  v4l: subdev: Add [GS]_ROUTING subdev ioctls and operations

Niklas Söderlund (7):
  adv748x: csi2: add translation from pixelcode to CSI-2 datatype
  adv748x: csi2: only allow formats on sink pads
  adv748x: csi2: describe the multiplexed stream
  adv748x: csi2: add internal routing configuration
  adv748x: afe: add routing support
  rcar-csi2: use frame description information to configure CSI-2 bus
  rcar-csi2: expose the subdevice internal routing

Sakari Ailus (16):
  media: entity: Use pad as a starting point for graph walk
  media: entity: Use pads instead of entities in the media graph walk
    stack
  media: entity: Walk the graph based on pads
  v4l: mc: Start walk from a specific pad in use count calculation
  media: entity: Move the pipeline from entity to pads
  media: entity: Use pad as the starting point for a pipeline
  media: entity: Skip link validation for pads to which there is no
    route to
  media: entity: Add an iterator helper for connected pads
  media: entity: Add only connected pads to the pipeline
  media: entity: Add debug information in graph walk route check
  v4l: Add bus type to frame descriptors
  v4l: Add CSI-2 bus configuration to frame descriptors
  v4l: Add stream to frame descriptor
  v4l: subdev: Take routing information into account in link validation
  v4l: subdev: Improve link format validation debug messages
  v4l: mc: Add an S_ROUTING helper function for power state changes

 Documentation/media/kapi/mc-core.rst          |  15 +-
 Documentation/media/uapi/v4l/dev-subdev.rst   |  92 ++++++
 Documentation/media/uapi/v4l/user-func.rst    |   1 +
 .../uapi/v4l/vidioc-subdev-g-routing.rst      | 139 ++++++++
 drivers/media/i2c/adv748x/adv748x-afe.c       |  91 ++++++
 drivers/media/i2c/adv748x/adv748x-csi2.c      | 136 +++++++-
 drivers/media/i2c/adv748x/adv748x.h           |   1 +
 drivers/media/media-device.c                  |  13 +-
 drivers/media/media-entity.c                  | 238 ++++++++------
 drivers/media/pci/intel/ipu3/ipu3-cio2.c      |   6 +-
 .../media/platform/exynos4-is/fimc-capture.c  |   8 +-
 .../platform/exynos4-is/fimc-isp-video.c      |   8 +-
 drivers/media/platform/exynos4-is/fimc-isp.c  |   2 +-
 drivers/media/platform/exynos4-is/fimc-lite.c |  10 +-
 drivers/media/platform/exynos4-is/media-dev.c |  20 +-
 drivers/media/platform/omap3isp/isp.c         |   2 +-
 drivers/media/platform/omap3isp/ispvideo.c    |  25 +-
 drivers/media/platform/omap3isp/ispvideo.h    |   2 +-
 .../media/platform/qcom/camss/camss-video.c   |   6 +-
 drivers/media/platform/rcar-vin/rcar-core.c   |  16 +-
 drivers/media/platform/rcar-vin/rcar-csi2.c   | 220 ++++++++++---
 drivers/media/platform/rcar-vin/rcar-dma.c    |   8 +-
 .../media/platform/s3c-camif/camif-capture.c  |   6 +-
 drivers/media/platform/vimc/vimc-capture.c    |   5 +-
 drivers/media/platform/vsp1/vsp1_video.c      |  18 +-
 drivers/media/platform/xilinx/xilinx-dma.c    |  20 +-
 drivers/media/platform/xilinx/xilinx-dma.h    |   2 +-
 drivers/media/usb/au0828/au0828-core.c        |   4 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |  25 +-
 drivers/media/v4l2-core/v4l2-mc.c             |  76 +++--
 drivers/media/v4l2-core/v4l2-subdev.c         | 296 ++++++++++++++++--
 .../staging/media/davinci_vpfe/vpfe_video.c   |  47 +--
 drivers/staging/media/imx/imx-media-utils.c   |   8 +-
 drivers/staging/media/omap4iss/iss.c          |   2 +-
 drivers/staging/media/omap4iss/iss_video.c    |  38 +--
 drivers/staging/media/omap4iss/iss_video.h    |   2 +-
 include/media/media-entity.h                  | 143 ++++++---
 include/media/v4l2-mc.h                       |  22 ++
 include/media/v4l2-subdev.h                   |  49 +++
 include/uapi/linux/v4l2-subdev.h              |  40 +++
 40 files changed, 1492 insertions(+), 370 deletions(-)
 create mode 100644 Documentation/media/uapi/v4l/vidioc-subdev-g-routing.rst

--
2.21.0

