Return-Path: <SRS0=vHo0=VC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0952C4649A
	for <linux-media@archiver.kernel.org>; Fri,  5 Jul 2019 04:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41B421852
	for <linux-media@archiver.kernel.org>; Fri,  5 Jul 2019 04:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfGEE4g (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:56:36 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:59445 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbfGEE4g (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 5 Jul 2019 00:56:36 -0400
X-Halon-ID: 31ac608f-9ee1-11e9-8d05-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (unknown [145.14.112.32])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id 31ac608f-9ee1-11e9-8d05-005056917f90;
        Fri, 05 Jul 2019 06:56:28 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/4] rcar-vin: Add support for V4L2_FIELD_ALTERNATE
Date:   Fri,  5 Jul 2019 06:55:53 +0200
Message-Id: <20190705045557.25463-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

This series adds support for V4L2_FIELD_ALTERNATE to rcar-vin. This 
removes a limitation in the driver where a video sources delivering 
video using the alternating field format was forced to use the rcar-vin 
interlacer and V4L2_FIELD_INTERLACED was delivers to the user. After 
this series the use of the interlacer is still default but the user have 
the option to explicit ask for alternate.

It is based on latest media-tree and tested on R-Car Gen2 and Gen3 
hardware.

Patch 1/4 prepares for the work by renaming a poorly variable, 2/4 fixes 
a problem with scaling (Gen2 only) which was found when testing 
alternating between V4L2_FIELD_ALTERNATE and V4L2_FIELD_INTERLACED.  
Patch 3/4 is the real change adding support for the new field format.  
And last 4/4 takes advantage of that the hardware interlacer is no 
longer a requirement and removes a bit of ugly code as a result.

Niklas Söderlund (4):
  rcar-vin: Rename rectangle holding holding the video source
    information
  rcar-vin: Do not reset the crop and compose rectangles in s_fmt
  rcar-vin: Add support for V4L2_FIELD_ALTERNATE
  rcar-vin: Clean up how format is set on subdevice

 drivers/media/platform/rcar-vin/rcar-dma.c  |  54 ++++++-----
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 100 +++++++++-----------
 drivers/media/platform/rcar-vin/rcar-vin.h  |   4 +-
 3 files changed, 78 insertions(+), 80 deletions(-)

-- 
2.21.0

