Return-Path: <SRS0=fNsq=6B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4888CC2D0EF
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AD7208E4
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 12:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgDQMiP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:38:15 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34337 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgDQMiP (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 17 Apr 2020 08:38:15 -0400
X-Originating-IP: 87.13.136.104
Received: from uno.homenet.telecomitalia.it (unknown [87.13.136.104])
        (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7FDBE60006;
        Fri, 17 Apr 2020 12:38:10 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@google.com, pavel@ucw.cz
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), libcamera-devel@lists.libcamera.org
Subject: [PATCH v9 00/11] media: report camera sensor properties
Date:   Fri, 17 Apr 2020 14:40:59 +0200
Message-Id: <20200417124110.72313-1-jacopo@jmondi.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Rebased on latest media master as the documentation has moved since my
last v8.

Hans, is this ready to be collected in your opinion ?

Jacopo Mondi (11):
  dt-bindings: video-interfaces: Document 'location' property
  media: v4l2-ctrl: Document V4L2_CID_CAMERA_SENSOR_LOCATION
  dt-bindings: video-interface: Replace 'rotation' description
  media: v4l2-ctrl: Document V4L2_CID_CAMERA_SENSOR_ROTATION
  media: v4l2-ctrls: Add camera location and rotation
  media: v4l2-fwnode: Add helper to parse device properties
  include: v4l2-ctrl: Sort forward declarations
  media: v4l2-ctrls: Sort includes alphabetically
  media: v4l2-ctrls: Add helper to register properties
  media: i2c: ov5670: Parse and register properties
  media: i2c: ov13858: Parse and register properties

v8->v9:
- Rebased on media master which has moved media documentation

v7->v8:
- Add Rob's ack to 03/11
- Address Hans typographical comments in 03/11

 .../bindings/media/video-interfaces.txt       | 372 +++++++++++++++++-
 .../media/v4l/ext-ctrls-camera.rst            | 153 +++++++
 drivers/media/i2c/ov13858.c                   |  11 +
 drivers/media/i2c/ov5670.c                    |  12 +
 drivers/media/v4l2-core/v4l2-ctrls.c          |  52 ++-
 drivers/media/v4l2-core/v4l2-fwnode.c         |  42 ++
 include/media/v4l2-ctrls.h                    |  34 +-
 include/media/v4l2-fwnode.h                   |  47 +++
 include/uapi/linux/v4l2-controls.h            |   7 +
 9 files changed, 718 insertions(+), 12 deletions(-)

--
2.26.1

