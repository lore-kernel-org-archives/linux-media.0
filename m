Return-Path: <SRS0=m313=5D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D03EC1975A
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 00:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A4E20663
	for <linux-media@archiver.kernel.org>; Wed, 18 Mar 2020 00:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UcfYVC4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgCRAZW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:25:22 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59866 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgCRAZW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 Mar 2020 20:25:22 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 85D8AF9;
        Wed, 18 Mar 2020 01:25:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584491121;
        bh=O1zXy6ASBfeWdk8kZcDq3aFVRprW4OHL5Y9o73yZ0Nc=;
        h=From:To:Cc:Subject:Date:From;
        b=UcfYVC4IqPon+jZCIgXnFfg784VGT/TzQxP6PCJn5zcGuFp1OCPh37IL1mEM3oAIH
         rdsX/B2Z+i2aVB81waqFlr/MdQ/eQ//EDTMsWV+EyeMtnE1EXP/M+Pgjf235o7b9e+
         KMyKgBUGe5U/uCghK9uLYwO/gL6LEi+kN9/4jmnU=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/4] media: v4l2-async: Accept endpoints and devices for fwnode matching
Date:   Wed, 18 Mar 2020 02:25:03 +0200
Message-Id: <20200318002507.30336-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

This patch series is the second version of fwnode endpoint matching
support in v4l2-async. The first version was a single patch and can be
found at [1].

Compared to v1, two additional changes have been made, which I have kept
as separate patches for now as they're under discussion. On top of the
base patch (1/4), patches 2/4 and 3/4 log a message when an heterogenous
match is detected. This should help speeding up the transition. Patch
4/4 moves away from checking the node name to determine if a fwnode is
an endpoint, as requesting by Sakari.

[1] https://lore.kernel.org/linux-media/20200318001726.GQ2527@pendragon.ideasonboard.com/T/#mfd71ee449a34f4f453941d5ec9a11f02cfb9e494

Laurent Pinchart (4):
  media: v4l2-async: Accept endpoints and devices for fwnode matching
  media: v4l2-async: Pass notifier pointer to match functions
  media: v4l2-async: Log message in case of heterogenous fwnode match
  media: v4l2-async: Don't check fwnode name to detect endpoint

 drivers/media/v4l2-core/v4l2-async.c | 81 +++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 8 deletions(-)

-- 
Regards,

Laurent Pinchart

