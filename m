Return-Path: <SRS0=qt09=DT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E83FC43467
	for <linux-media@archiver.kernel.org>; Mon, 12 Oct 2020 18:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED1B2076D
	for <linux-media@archiver.kernel.org>; Mon, 12 Oct 2020 18:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404147AbgJLSEa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404140AbgJLSE2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Oct 2020 14:04:28 -0400
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.eu [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C63C0613D0
        for <linux-media@vger.kernel.org>; Mon, 12 Oct 2020 11:04:28 -0700 (PDT)
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1002])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 6C324634C87;
        Mon, 12 Oct 2020 21:03:14 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     Tsuchiya Yuto <kitakar@gmail.com>, bingbu.cao@intel.com,
        Yong Zhi <yong.zhi@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v3 0/8] ipu3-cio2 format and other fixes
Date:   Mon, 12 Oct 2020 21:04:06 +0300
Message-Id: <20201012180414.11579-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello all,

This set addresses most notable subdev format related issues, namely the
sub-device sink format being unaccessible. The result of accessing it
varied from oopses to crashes.

since v2:

- Cc the fixes to the stable tree, cleanups to master only

- Add the size checks first, then make size (as well as a bunch of other
  constants) unsigned. Then remove the explicit type from size checks.

- Add a patch to rename the length macro as height (which it really
  is about)

- Add a patch to remove driver queue references to buffers returned to
  vb2 (cc that to stable, too).

since v1:

- Validate try format, too

- Set field in subdev format to V4L2_FIELD_NONE

- Add a comment explaining the lock

- Make values that should be unsigned, unsigned

Sakari Ailus (8):
  ipu3-cio2: Return actual subdev format
  ipu3-cio2: Serialise access to pad format
  ipu3-cio2: Validate mbus format in setting subdev format
  ipu3-cio2: Make the field on subdev format V4L2_FIELD_NONE
  ipu3-cio2: Use unsigned values where appropriate
  ipu3-cio2: Remove explicit type from frame size checks
  ipu3-cio2: Rename CIO2_IMAGE_MAX_LENGTH as CIO2_IMAGE_MAX_HEIGHT
  ipu3-cio2: Remove traces of returned buffers

 drivers/media/pci/intel/ipu3/ipu3-cio2.c |  65 +++++-----
 drivers/media/pci/intel/ipu3/ipu3-cio2.h | 157 ++++++++++++-----------
 2 files changed, 114 insertions(+), 108 deletions(-)

-- 
2.27.0
