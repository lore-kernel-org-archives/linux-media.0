Return-Path: <SRS0=OLWu=4B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A49C2BA83
	for <linux-media@archiver.kernel.org>; Thu, 13 Feb 2020 09:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B3C20848
	for <linux-media@archiver.kernel.org>; Thu, 13 Feb 2020 09:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgBMJtg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:49:36 -0500
Received: from retiisi.org.uk ([95.216.213.190]:59662 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgBMJtg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 13 Feb 2020 04:49:36 -0500
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 0E763634C89
        for <linux-media@vger.kernel.org>; Thu, 13 Feb 2020 11:49:18 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 0/7] smiapp, omap3isp: Cleanups and fixes
Date:   Thu, 13 Feb 2020 11:49:27 +0200
Message-Id: <20200213094934.18595-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi all,

This set contains a small fix for the omap3isp crashing the system, as
well as cleanups for the smiapp driver.

Sakari Ailus (7):
  omap3isp: Prevent enabling CCDC when stopping streaming
  smiapp: Simplify condition for choosing 8-bit access
  smiapp: Use unaligned get and put functions
  smiapp: Turn limit lookup into a function
  smiapp: Move SMIA limit reading up
  smiapp: Refactor reading SMIA limits
  smiapp: Move definitions under driver directory

 drivers/media/i2c/smiapp/smiapp-core.c    | 259 +++++++++++-----------
 drivers/media/i2c/smiapp/smiapp-reg.h     |   4 +
 drivers/media/i2c/smiapp/smiapp-regs.c    |  71 ++----
 drivers/media/i2c/smiapp/smiapp.h         |  44 +++-
 drivers/media/platform/omap3isp/ispccdc.c |   4 +
 include/media/i2c/smiapp.h                |  63 ------
 6 files changed, 200 insertions(+), 245 deletions(-)
 delete mode 100644 include/media/i2c/smiapp.h

-- 
2.20.1

