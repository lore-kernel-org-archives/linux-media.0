Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3B7C43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6A0206A3
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfDZBYM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:24:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36552 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDZBYL (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 21:24:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 2BC8A267743
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v4 00/14]  media: vimc: Add support for multiplanar formats 
Date:   Thu, 25 Apr 2019 22:22:09 -0300
Message-Id: <20190426012223.17826-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

This series implements support for multiplane pixel formats at Vimc.
A lot of changes were required since vimc support for singleplane
was "hardcoded". The code has been adapted in order to support both
formats. When was possible, the functions were written generically,
avoiding functions for just one type of pixel format.

The debayer subdevice is the only one that currently doesn't supports
multiplanar formats. Documentation to each device will be made in a
future patch. In hardcoded topology, the exposed capture device
`RGB/YUV Capture` have a debayer in the pipeline, so it will fail when
tested with multiplanar formats.

The last commit of this series was tested using Hans' virtme.sh[1]
script here are the summary of results:

Grand Total for vivid device /dev/media0: 631, Succeeded: 631, Failed: 0, Warnings: 6
Grand Total for vivid device /dev/media1: 631, Succeeded: 631, Failed: 0, Warnings: 6
Grand Total for vim2m device /dev/media3: 61, Succeeded: 61, Failed: 0, Warnings: 0
Grand Total for vimc device /dev/media3: 478, Succeeded: 478, Failed: 0, Warnings: 0
Final Summary: 1801, Succeeded: 1801, Failed: 0, Warnings: 12

Thanks,
	André

[1] https://hverkuil.home.xs4all.nl/virtme/virtme.sh

Changes in v4:
- Remove unutilized commit "Propagate multiplanar state in the stream" 
- Split "Create multiplanar parameter and ioctls"
- Check for try_fmt return value
- Change ret from `unsigned int` to `int`
- Remove label `free_planes` from else scope
- Change vars at vimc-scaler

Changes in v3:
- Refactor vimc_frame and vimc_fill_frame in order to be more clear and
simple
- Squash "Add handler for multiplanar fmt ioctls" and "Create multiplanar
parameter"
- Define format ioctls of capture device according to it capabilities
- Get rid of `IS_MULTIPLANAR(vcap)` verification on format ioctls
- Remove some format ioctl handlers
- Reorder "Move sp2mp functions to v4l2-common"
- Minimal code style and comments changes
- Assign ioctls according to capture device capabilities

Changes in v2:
- Fix typos
- Fix indentations
- Enhance v4l2_fmt_* documentation
- Change the order of commits, now the multiplanar parameter is the last
one with the commit to set the device capabilities
- Squash "unnecessary checks" commits together
- In v1, the whole media device was in singleplanar or in multiplanar
format. Now, each stream/pipeline can be in a format
- Check the capture capabilities to get if the stream is in
singleplanar/multiplanar mode, instead of checking the module parameter.
- Change `if (multiplanar)` to `if (IS_MULTIPLANAR(vcap))`
- Add a new commit to propagate in the stream if the capture device is
in multiplanar or singleplanar mode

André Almeida (14):
  media: vimc: Remove unnecessary stream checks
  media: vimc: cap: Change vimc_cap_device.format type
  media: vimc: cap: Dynamically define stream pixelformat
  media: Move sp2mp functions to v4l2-common
  media: vimc: cap: refactor singleplanar as a subset of multiplanar
  media: vimc: cap: Add handler for multiplanar fmt ioctls
  media: vimc: cap: Add multiplanar formats
  media: vimc: cap: Add multiplanar default format
  media: vimc: cap: Allocate and verify mplanar buffers
  media: vimc: Add and use new struct vimc_frame
  media: vimc: sen: Add support for multiplanar formats
  media: vimc: sca: Add support for multiplanar formats
  media: vimc: cap: Add support for multiplanar formats
  media: vimc: Create multiplanar parameter

 drivers/media/platform/vimc/vimc-capture.c    | 288 ++++++++++++++----
 drivers/media/platform/vimc/vimc-common.c     |   8 +
 drivers/media/platform/vimc/vimc-common.h     |  41 ++-
 drivers/media/platform/vimc/vimc-debayer.c    |  38 ++-
 drivers/media/platform/vimc/vimc-scaler.c     | 129 +++++---
 drivers/media/platform/vimc/vimc-sensor.c     |  67 ++--
 drivers/media/platform/vimc/vimc-streamer.c   |   2 +-
 drivers/media/platform/vivid/vivid-vid-cap.c  |   6 +-
 .../media/platform/vivid/vivid-vid-common.c   |  59 ----
 .../media/platform/vivid/vivid-vid-common.h   |   9 -
 drivers/media/platform/vivid/vivid-vid-out.c  |   6 +-
 drivers/media/v4l2-core/v4l2-common.c         |  62 ++++
 include/media/v4l2-common.h                   |  37 +++
 13 files changed, 515 insertions(+), 237 deletions(-)

-- 
2.21.0

