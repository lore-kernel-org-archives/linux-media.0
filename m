Return-Path: <SRS0=PKt4=VM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1B6C7618F
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 21:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA0520665
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 21:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfGOVG7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:06:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52692 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731381AbfGOVG7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Jul 2019 17:06:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 84A0A28B67E
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/6] V4L2 core I2C/SPI code cleanup
Date:   Mon, 15 Jul 2019 18:06:41 -0300
Message-Id: <20190715210649.31681-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro, Hans:

While reading v4l2-common.c, I came across a few ifdefs
that could be cleaned-up with some minor reorganization.

Patch 1 is just cleaning the Makefile, removing ifeq/endif
to make it more readable.

Patch 2 merges v4l2-common.ko into videodev.ko, which
I think it's now possible. Let me know if having
these two modules separated serves a purpose
I'm missing.

The rest of the patches split the I2C and SPI helpers,
so they can be conditionally built.

There are a few checkpatch.pl issues triggered here,
all of them belonging to the already existing code.
Let me know if you want me to clean that as well.

The entire series should not affect any functionality,
but just clean-up the code a bit.

Thanks,
Eze

Ezequiel Garcia (6):
  media: v4l2-core: Cleanup Makefile
  media: v4l2-core: Module re-organization
  media: v4l2-core: move spi helpers out of v4l2-common.c
  media: v4l2-core: move i2c helpers out of v4l2-common.c
  media: v4l2-core: introduce a helper to unregister a SPI subdev
  media: v4l2-core: introduce a helper to unregister a I2C subdev

 drivers/media/v4l2-core/Kconfig       |   5 +
 drivers/media/v4l2-core/Makefile      |  15 +-
 drivers/media/v4l2-core/v4l2-common.c | 210 --------------------------
 drivers/media/v4l2-core/v4l2-device.c |  39 +----
 drivers/media/v4l2-core/v4l2-i2c.c    | 167 ++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-spi.c    |  73 +++++++++
 include/media/v4l2-common.h           | 150 +++++++++++++-----
 7 files changed, 366 insertions(+), 293 deletions(-)
 create mode 100644 drivers/media/v4l2-core/v4l2-i2c.c
 create mode 100644 drivers/media/v4l2-core/v4l2-spi.c

-- 
2.22.0

