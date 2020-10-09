Return-Path: <SRS0=wJZ5=DQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DED2C433DF
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 15:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BA5222BA
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 15:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389199AbgJIPH7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:07:59 -0400
Received: from retiisi.eu ([95.216.213.190]:51570 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388736AbgJIPH6 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 9 Oct 2020 11:07:58 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 2EE2F634C87;
        Fri,  9 Oct 2020 18:07:05 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     Tsuchiya Yuto <kitakar@gmail.com>, bingbu.cao@intel.com,
        Yong Zhi <yong.zhi@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH 0/5] ipu3-cio2 format fixes
Date:   Fri,  9 Oct 2020 18:07:51 +0300
Message-Id: <20201009150756.3397-1-sakari.ailus@linux.intel.com>
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

since v1:

- Validate try format, too

- Set field in subdev format to V4L2_FIELD_NONE

- Add a comment explaining the lock

- Make values that should be unsigned, unsigned

Sakari Ailus (5):
  ipu3-cio2: Return actual subdev format
  ipu3-cio2: Serialise access to pad format
  ipu3-cio2: Use unsigned values where appropriate
  ipu3-cio2: Validate mbus format in setting subdev format
  ipu3-cio2: Make the field on subdev format V4L2_FIELD_NONE

 drivers/media/pci/intel/ipu3/ipu3-cio2.c |  60 +++++----
 drivers/media/pci/intel/ipu3/ipu3-cio2.h | 157 ++++++++++++-----------
 2 files changed, 111 insertions(+), 106 deletions(-)

-- 
2.27.0

