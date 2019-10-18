Return-Path: <SRS0=lAxh=YL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF52CA9EA9
	for <linux-media@archiver.kernel.org>; Fri, 18 Oct 2019 15:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCC2222C3
	for <linux-media@archiver.kernel.org>; Fri, 18 Oct 2019 15:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408542AbfJRPKl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:10:41 -0400
Received: from retiisi.org.uk ([95.216.213.190]:51486 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbfJRPKl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 18 Oct 2019 11:10:41 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id BBB5D634C87;
        Fri, 18 Oct 2019 18:10:06 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com
Subject: [PATCH 0/3] smiapp PM improvements, omap3isp system crash fix
Date:   Fri, 18 Oct 2019 18:07:17 +0300
Message-Id: <20191018150720.31674-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi folks,

Here's a few patches remaining from my previous smiapp and omap3isp sets.

Sakari Ailus (3):
  omap3isp: Don't restart CCDC if we're about to stop
  smiapp: Avoid maintaining power state information
  smiapp: Put the device again if starting streaming fails

 drivers/media/i2c/smiapp/smiapp-core.c    | 198 +++++++++++++---------
 drivers/media/i2c/smiapp/smiapp-regs.c    |   3 -
 drivers/media/i2c/smiapp/smiapp.h         |   1 -
 drivers/media/platform/omap3isp/ispccdc.c |  12 +-
 4 files changed, 122 insertions(+), 92 deletions(-)

-- 
2.20.1

