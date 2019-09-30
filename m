Return-Path: <SRS0=DdSm=XZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E48C388F4
	for <linux-media@archiver.kernel.org>; Mon, 30 Sep 2019 09:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048CC21D56
	for <linux-media@archiver.kernel.org>; Mon, 30 Sep 2019 09:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfI3JjW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:39:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45221 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbfI3JjO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Sep 2019 05:39:14 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iEs92-0002RP-7t; Mon, 30 Sep 2019 11:39:04 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iEs90-0005u3-C8; Mon, 30 Sep 2019 11:39:02 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org, laurent.pinchart@ideasonboard.com
Cc:     devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-media@vger.kernel.org
Subject: [PATCH v11 00/15] TVP5150 Features and fixes
Date:   Mon, 30 Sep 2019 11:38:45 +0200
Message-Id: <20190930093900.16524-1-m.felsch@pengutronix.de>
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

this "last-one"+1 addresses Hans comments made on my v10 [1]. The v11
addresses all checkpatch issues and some style issues found by Hans.

Regards,
  Marco

[1] https://patchwork.linuxtv.org/cover/58504/

Javier Martinez Canillas (1):
  partial revert of "[media] tvp5150: add HW input connectors support"

Marco Felsch (13):
  dt-bindings: connector: analog: add sdtv standards property
  media: v4l: link dt-bindings and uapi
  media: v4l2-fwnode: add v4l2_fwnode_connector
  media: v4l2-fwnode: add initial connector parsing support
  media: tvp5150: add input source selection of_graph support
  media: dt-bindings: tvp5150: Add input port connectors DT bindings
  media: tvp5150: fix set_selection rectangle handling
  media: tvp5150: add FORMAT_TRY support for get/set selection handlers
  media: tvp5150: add s_power callback
  media: dt-bindings: tvp5150: cleanup bindings stlye
  media: dt-bindings: tvp5150: add optional sdtv standards documentation
  media: tvp5150: add support to limit sdtv standards
  media: tvp5150: make debug output more readable

Michael Tretter (1):
  media: tvp5150: initialize subdev before parsing device tree

 .../display/connector/analog-tv-connector.txt |   6 +
 .../devicetree/bindings/media/i2c/tvp5150.txt | 146 +++-
 drivers/media/i2c/tvp5150.c                   | 672 +++++++++++++-----
 drivers/media/v4l2-core/v4l2-fwnode.c         | 129 ++++
 include/dt-bindings/display/sdtv-standards.h  |  76 ++
 include/dt-bindings/media/tvp5150.h           |   2 -
 include/media/v4l2-fwnode.h                   |  81 +++
 include/uapi/linux/videodev2.h                |   4 +
 8 files changed, 917 insertions(+), 199 deletions(-)
 create mode 100644 include/dt-bindings/display/sdtv-standards.h

-- 
2.20.1

