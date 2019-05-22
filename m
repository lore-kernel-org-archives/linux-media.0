Return-Path: <SRS0=OIs4=TW=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74DEC282CE
	for <linux-media@archiver.kernel.org>; Wed, 22 May 2019 11:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9423D20645
	for <linux-media@archiver.kernel.org>; Wed, 22 May 2019 11:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfEVLre (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 22 May 2019 07:47:34 -0400
Received: from retiisi.org.uk ([95.216.213.190]:56724 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbfEVLre (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 22 May 2019 07:47:34 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 53942634C7B
        for <linux-media@vger.kernel.org>; Wed, 22 May 2019 14:47:11 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1hTPiB-0000nS-89
        for linux-media@vger.kernel.org; Wed, 22 May 2019 14:47:11 +0300
Date:   Wed, 22 May 2019 14:47:11 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL for 5.3] Sensor and ccic driver patches
Message-ID: <20190522114711.5c6okeibdepthmoq@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Here are sensor and Marvell CCIC driver patches for v5.3. Included is also
a fix for fwnode C-PHY handling.

Please pull.


The following changes since commit bc8c479a5b19bd44f7379e42e627170957985ee9:

  media: venus: helpers: fix dynamic buffer mode for v4 (2019-05-21 09:03:25 -0400)

are available in the git repository at:

  ssh://linuxtv.org/git/sailus/media_tree.git tags/for-5.3-1-signed

for you to fetch changes up to b9656c3ca991c4edca908bb37455351f6fddf235:

  media:staging/intel-ipu3: update minimal GDC envelope size to 4 (2019-05-22 12:06:14 +0300)

----------------------------------------------------------------
sensor + ccic patches for 5.3

----------------------------------------------------------------
Akinobu Mita (4):
      media: ov7740: fix unbalanced pm_runtime_get/put
      media: ov7740: avoid invalid framesize setting
      media: ov7740: fix vertical flip control
      media: ov7740: remove redundant V4L2_CTRL_FLAG_VOLATILE set

Bingbu Cao (1):
      media:staging/intel-ipu3: update minimal GDC envelope size to 4

Lubomir Rintel (10):
      media: dt-bindings: marvell,mmp2-ccic: Add Marvell MMP2 camera
      marvell-ccic: fix DMA s/g desc number calculation
      marvell-ccic: don't generate EOF on parallel bus
      Revert "[media] marvell-ccic: reset ccic phy when stop streaming for stability"
      marvell-ccic: drop unused stuff
      marvell-ccic/mmp: enable clock before accessing registers
      marvell-ccic: rename the clocks
      marvell-ccic/mmp: add devicetree support
      marvell-ccic: use async notifier to get the sensor
      marvell-ccic: provide a clock for the sensor

Nicholas Mc Guire (1):
      media: smiapp: core: add small range to usleep_range

Sakari Ailus (1):
      v4l: fwnode: C-PHY has no clock lane

Shawnx Tu (1):
      media: ov8856: modify register to fix test pattern

 .../bindings/media/marvell,mmp2-ccic.txt           |  50 +++
 drivers/media/i2c/ov7740.c                         |  24 +-
 drivers/media/i2c/ov8856.c                         |  12 +-
 drivers/media/i2c/smiapp/smiapp-quirk.c            |   2 +-
 drivers/media/platform/marvell-ccic/Kconfig        |   2 +
 drivers/media/platform/marvell-ccic/cafe-driver.c  |  58 +++-
 drivers/media/platform/marvell-ccic/mcam-core.c    | 339 ++++++++++++++-------
 drivers/media/platform/marvell-ccic/mcam-core.h    |  12 +-
 drivers/media/platform/marvell-ccic/mmp-driver.c   | 241 ++++-----------
 drivers/media/v4l2-core/v4l2-fwnode.c              |   8 +-
 drivers/staging/media/ipu3/ipu3-css.c              |  14 +-
 include/linux/platform_data/media/mmp-camera.h     |   4 -
 12 files changed, 424 insertions(+), 342 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt


-- 
Sakari Ailus
