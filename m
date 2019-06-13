Return-Path: <SRS0=gKyG=UM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A685C31E45
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FAE2054F
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbfFMPSu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:18:50 -0400
Received: from retiisi.org.uk ([95.216.213.190]:51206 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732150AbfFMNEI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 13 Jun 2019 09:04:08 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 61D8C634C7B;
        Thu, 13 Jun 2019 16:04:03 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl
Subject: [PATCH 0/2] Fix a few smatch warnings
Date:   Thu, 13 Jun 2019 16:03:58 +0300
Message-Id: <20190613130400.6388-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

This small set fixes a few trivial smatch warnings. They're not really
bugs either but changing the code cleans it up as well.

Sakari Ailus (2):
  v4l2-fwnode: Avoid using PTR_ERR(NULL)
  ov9640: Don't check for NULL on devm_gpiod_get return values

 drivers/media/i2c/ov9640.c            | 4 ++--
 drivers/media/v4l2-core/v4l2-fwnode.c | 6 +-----
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.11.0

