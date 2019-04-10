Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED20C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 10:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA64820830
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 10:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfDJKwh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:52:37 -0400
Received: from retiisi.org.uk ([95.216.213.190]:46936 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbfDJKwh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 06:52:37 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 27BBF634C7B
        for <linux-media@vger.kernel.org>; Wed, 10 Apr 2019 13:51:31 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1hEApH-0003cy-UE
        for linux-media@vger.kernel.org; Wed, 10 Apr 2019 13:51:31 +0300
Date:   Wed, 10 Apr 2019 13:51:31 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL for 5.2] Mipid02, ImgU and sensor driver patches
Message-ID: <20190410105131.7g4txlltmvkljxua@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Here's another set of sensor driver patches for 5.2. Included are also a
new driver for ST mipid02 CSI-2 to parallel converter as well as some
improvements for the ImgU driver.

Please pull.


The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the git repository at:

  ssh://linuxtv.org/git/sailus/media_tree.git tags/for-5.1-4-signed

for you to fetch changes up to 895be0bf180177f15a92f668b6599d2bb8dc0f19:

  ipu3-imgu: Use %u for formatting unsigned values (not %d) (2019-04-10 13:49:37 +0300)

----------------------------------------------------------------
mipid02 + cio2 + sensor patches

----------------------------------------------------------------
Akinobu Mita (2):
      media: ov2659: make S_FMT ioctl succeed even if requested format doesn't match
      media: ov2659: fix unbalanced mutex_lock/unlock

Bingbu Cao (1):
      media:staging/intel-ipu3: parameter buffer refactoring

Janusz Krzysztofik (3):
      media: ov6650: Fix sensor possibly not detected on probe
      media: ov6650: Move v4l2_clk_get() to ov6650_video_probe() helper
      media: ov6650: Register with asynchronous subdevice framework

Mickael Guene (3):
      media: uapi: Add MEDIA_BUS_FMT_BGR888_3X8 media bus format
      dt-bindings: Document MIPID02 bindings
      media: st-mipid02: MIPID02 CSI-2 to PARALLEL bridge driver

Sakari Ailus (1):
      ipu3-imgu: Use %u for formatting unsigned values (not %d)

 .../bindings/media/i2c/st,st-mipid02.txt           |   82 ++
 Documentation/media/uapi/v4l/subdev-formats.rst    |  107 ++
 MAINTAINERS                                        |    8 +
 drivers/media/i2c/Kconfig                          |   13 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/ov2659.c                         |    8 +-
 drivers/media/i2c/ov6650.c                         |   43 +-
 drivers/media/i2c/st-mipid02.c                     | 1033 ++++++++++++++++++++
 drivers/staging/media/ipu3/ipu3-css.c              |    5 -
 drivers/staging/media/ipu3/ipu3-v4l2.c             |   86 +-
 drivers/staging/media/ipu3/ipu3.c                  |   30 +
 include/uapi/linux/media-bus-format.h              |    3 +-
 12 files changed, 1345 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
 create mode 100644 drivers/media/i2c/st-mipid02.c

-- 
Sakari Ailus
