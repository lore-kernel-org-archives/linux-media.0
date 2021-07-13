Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D78C07E95
	for <linux-media@archiver.kernel.org>; Tue, 13 Jul 2021 15:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF9660698
	for <linux-media@archiver.kernel.org>; Tue, 13 Jul 2021 15:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhGMPcQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:32:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:57355 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237099AbhGMPcP (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 13 Jul 2021 11:32:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="197368363"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="197368363"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 08:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="503183838"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2021 08:25:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0BA8D2B6; Tue, 13 Jul 2021 18:25:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 3/5] media: staging: atomisp: Annotate a couple of definitions with __maybe_unused
Date:   Tue, 13 Jul 2021 18:25:21 +0300
Message-Id: <20210713152523.19902-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713152523.19902-1-andriy.shevchenko@linux.intel.com>
References: <20210713152523.19902-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There are definitions in the header that are not used by all modules inside
the driver. Annotate them with __maybe_unused to avoid compiler warnings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added "media:" prefix
 .../staging/media/atomisp/pci/isp2400_input_system_local.h    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/isp2400_input_system_local.h b/drivers/staging/media/atomisp/pci/isp2400_input_system_local.h
index 27f3c8a45730..21f11bdfc85f 100644
--- a/drivers/staging/media/atomisp/pci/isp2400_input_system_local.h
+++ b/drivers/staging/media/atomisp/pci/isp2400_input_system_local.h
@@ -356,7 +356,7 @@ struct rx_cfg_s {
 };
 
 /* NOTE: The base has already an offset of 0x0100 */
-static const hrt_address MIPI_PORT_OFFSET[N_MIPI_PORT_ID] = {
+static const hrt_address __maybe_unused MIPI_PORT_OFFSET[N_MIPI_PORT_ID] = {
 	0x00000000UL,
 	0x00000100UL,
 	0x00000200UL
@@ -373,7 +373,7 @@ static const mipi_lane_cfg_t MIPI_PORT_LANES[N_RX_MODE][N_MIPI_PORT_ID] = {
 	{MIPI_1LANE_CFG, MIPI_1LANE_CFG, MIPI_1LANE_CFG}
 };
 
-static const hrt_address SUB_SYSTEM_OFFSET[N_SUB_SYSTEM_ID] = {
+static const hrt_address __maybe_unused SUB_SYSTEM_OFFSET[N_SUB_SYSTEM_ID] = {
 	0x00001000UL,
 	0x00002000UL,
 	0x00003000UL,
-- 
2.30.2

