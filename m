Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1C6C433E0
	for <linux-media@archiver.kernel.org>; Mon, 21 Dec 2020 22:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4147322CB2
	for <linux-media@archiver.kernel.org>; Mon, 21 Dec 2020 22:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLUWXd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Dec 2020 17:23:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:42712 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgLUWXd (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Dec 2020 17:23:33 -0500
IronPort-SDR: 8YOe3Oxoy3Ggwa95nGUMSGVd2jSI/s7NGzTaZOYlE/A7Wo2WDd8sYsF4ZIC5H/XweJ1iYeEZti
 WXs7XF2OVDFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="260521913"
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="260521913"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 14:21:46 -0800
IronPort-SDR: PS9v6jx1y4Zk2+CT4iwry61c5UoDxY0SjTCemykD8hVs6PLfnxgfHftbemXJiNYLxzqdOrImj9
 MYZA6Z2eiSiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="372892687"
Received: from maru.jf.intel.com ([10.54.51.77])
  by orsmga008.jf.intel.com with ESMTP; 21 Dec 2020 14:21:45 -0800
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2 0/1] Fix kernel panic issues caused by AST2500 Video Engine
Date:   Mon, 21 Dec 2020 14:32:24 -0800
Message-Id: <20201221223225.14723-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Video engine uses eclk and vclk for its clock sources and its reset
control is coupled with eclk so the current clock enabling sequence works
like below.

 Enable eclk
 De-assert Video Engine reset
 10ms delay
 Enable vclk

It introduces improper reset on the Video Engine hardware and eventually
the hardware generates unexpected DMA memory transfers that can corrupt
memory region in random and sporadic patterns. This issue is observed
very rarely on some specific AST2500 SoCs but it causes a critical
kernel panic with making a various shape of signature so it's extremely
hard to debug. Moreover, the issue is observed even when the video
engine is not actively used because udevd turns on the video engine
hardware for a short time to make a query in every boot.

To fix this issue, this commit changes the clock handling logic to make
the reset de-assertion triggered after enabling both eclk and vclk. Also,
it adds clk_unprepare call for a case when probe fails.

In case of AST2600, the video engine reset setting should be coupled with
eclk to match it with the setting for previous Aspeed SoCs which is defined
in clk-aspeed.c since all Aspeed SoCs are sharing a single video engine
driver. Also, reset bit 6 is defined as 'Video Engine' reset in datasheet
so it should be de-asserted when eclk is enabled. This commit fixes the
setting too.

Please review this squashed patch.

Changes since v1:
- Squashed two patches due to dependency.

Jae Hyun Yoo (1):
  media: aspeed: fix clock handling logic

 drivers/clk/clk-ast2600.c             | 4 ++--
 drivers/media/platform/aspeed-video.c | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.17.1

