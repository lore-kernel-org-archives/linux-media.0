Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58622C4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 06:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F25206DD
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 06:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDEGDh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:03:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39097 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEGDh (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 02:03:37 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hCHwl-00081Y-Tv; Fri, 05 Apr 2019 08:03:27 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hCHwg-0003Le-Vv; Fri, 05 Apr 2019 08:03:22 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v5 00/13] TVP5150 new features
Date:   Fri,  5 Apr 2019 08:03:04 +0200
Message-Id: <20190405060317.11240-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

few months ago I send my v4 of this series [1] unfortunately I got no
feedback from Mauro but Jacopos feedback was quite helpfull =)

After my v4 I send another series which adds a generic way to parse
connector endpoints [2]. To make it easier for everyone I squashed both
series [1,2] into this one.

I recognized that patch ("media: v4l2-subdev: add stubs for
v4l2_subdev_get_try_*") was a possible blocker for this series so I
factored the patch out [3].

My main goal with the v5 was to simplify the link_setup() code a lot.
There were also some build-dep issues which I fixed too. Last
significant improvement is done on patch ("media: tvp5150: add
support to limit tv norms on connector").

I've tested it on a custom hardware and compile tested it too.

@Mauro
Please let me know how I can help you to speed up the review progress
since I wanted to get those changes merged in the near future =)

@Sakari, Hans
I've added you to the series since I made some core changes.

New patches (wasn't part of [1] or [2]):
  media: dt-bindings: tvp5150: cleanup bindings stlye
  media: dt-bindings: tvp5150: add optional tvnorms documentation
  media: tvp5150: make debug output more readable

New (squashed) patches (was part of [2]):
  dt-bindings: connector: analog: add tv norms property
  media: v4l2-fwnode: add v4l2_fwnode_connector
  media: v4l2-fwnode: add initial connector parsing support
  media: tvp5150: add support to limit tv norms on connector

Droped patches:
  media: v4l2-subdev: add stubs for v4l2_subdev_get_try_*

[1] https://patchwork.ozlabs.org/cover/1032891/
[2] https://patchwork.kernel.org/cover/10794703/
[3] https://www.mail-archive.com/linux-media@vger.kernel.org/msg146065.html

Regards,
	Marco

Javier Martinez Canillas (1):
  partial revert of "[media] tvp5150: add HW input connectors support"

Marco Felsch (11):
  dt-bindings: connector: analog: add tv norms property
  media: v4l2-fwnode: add v4l2_fwnode_connector
  media: v4l2-fwnode: add initial connector parsing support
  media: tvp5150: add input source selection of_graph support
  media: dt-bindings: tvp5150: Add input port connectors DT bindings
  media: tvp5150: add FORMAT_TRY support for get/set selection handlers
  media: tvp5150: add s_power callback
  media: dt-bindings: tvp5150: cleanup bindings stlye
  media: dt-bindings: tvp5150: add optional tvnorms documentation
  media: tvp5150: add support to limit tv norms on connector
  media: tvp5150: make debug output more readable

Michael Tretter (1):
  media: tvp5150: initialize subdev before parsing device tree

 .../display/connector/analog-tv-connector.txt |   4 +
 .../devicetree/bindings/media/i2c/tvp5150.txt | 125 +++-
 drivers/media/i2c/tvp5150.c                   | 673 +++++++++++++-----
 drivers/media/v4l2-core/v4l2-fwnode.c         | 113 +++
 include/dt-bindings/media/tvnorms.h           |  42 ++
 include/dt-bindings/media/tvp5150.h           |   2 -
 include/media/v4l2-connector.h                |  34 +
 include/media/v4l2-fwnode.h                   |  49 ++
 8 files changed, 850 insertions(+), 192 deletions(-)
 create mode 100644 include/dt-bindings/media/tvnorms.h
 create mode 100644 include/media/v4l2-connector.h

-- 
2.20.1

