Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7789EC10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480B120883
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 12:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfDOMog (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:44:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41427 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfDOMof (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 08:44:35 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yJ-0000RK-81; Mon, 15 Apr 2019 14:44:27 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hG0yG-00025B-Tb; Mon, 15 Apr 2019 14:44:24 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v6 00/13] TVP5150 new features
Date:   Mon, 15 Apr 2019 14:44:00 +0200
Message-Id: <20190415124413.18456-1-m.felsch@pengutronix.de>
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

many thanks to Hans and Jacopo for the feedack :) this v6 address the
comments both made on my v5 [1].

In short this is round fixes just some minor issues rather than major
ones so the diff to the v5 is really small. The changed patches contain
the changelog so I omit it here.

I've tested it on a custom hardware but I can't test the em28xx usb
use-case since I haven't such a device. So other testers are welcome :)

Looking forward for your feedack,

	Marco

[1] https://patchwork.kernel.org/cover/10886903/

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
 drivers/media/i2c/tvp5150.c                   | 672 +++++++++++++-----
 drivers/media/v4l2-core/v4l2-fwnode.c         | 111 +++
 include/dt-bindings/media/tvnorms.h           |  56 ++
 include/dt-bindings/media/tvp5150.h           |   2 -
 include/media/v4l2-connector.h                |  30 +
 include/media/v4l2-fwnode.h                   |  49 ++
 8 files changed, 859 insertions(+), 190 deletions(-)
 create mode 100644 include/dt-bindings/media/tvnorms.h
 create mode 100644 include/media/v4l2-connector.h

-- 
2.20.1

