Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9605C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5CD2086D
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfDLXpd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:45:33 -0400
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:47950 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbfDLXpd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 19:45:33 -0400
X-Halon-ID: 0740b781-5d7d-11e9-8fa2-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (unknown [89.233.230.99])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 0740b781-5d7d-11e9-8fa2-005056917a89;
        Sat, 13 Apr 2019 01:45:26 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/8] rcar-vin: Merge Gen2 and Gen3 file operations
Date:   Sat, 13 Apr 2019 01:43:51 +0200
Message-Id: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

This series aims to merge the two different set of file operations used 
in the rcar-vin driver. One set was used on Renesas Gen2 boards while 
the other set was used on Gen3. Main difference between the two is that 
Gen2 uses a device node centric world view while Gen3 subscribes to the 
media controller way of looking at things ;-)

After refactoring out a lot of code left over from the Gen2 mode which 
stems from the drivers origin in soc_camera it became apparent that a 
lot of code could me removed my merging the two sets.

Tested on both Gen2 and Gen3 no regressions found.

Niklas Söderlund (8):
  rcar-vin: Do not call pm_runtime_{resume,suspend}()
  rcar-vin: Remove unneeded calls to pm_runtime_{enable,disable}
  rcar-vin: Allow interrupting lock when trying to open the video device
  rcar-vin: Do not sync subdevice format when opening the video device
  rcar-vin: Move pm_runtime_{get,put} out of helpers
  rcar-vin: Merge helpers dealing with powering the parallel subdevice
  rcar-vin: Fold rvin_initialize_device() into rvin_open()
  rcar-vin: Merge Gen2 and Gen3 file operations

 drivers/media/platform/rcar-vin/rcar-v4l2.c | 188 ++++----------------
 1 file changed, 38 insertions(+), 150 deletions(-)

-- 
2.21.0

