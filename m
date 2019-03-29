Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DDBC43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 12:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EF82183E
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 12:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfC2MbZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:31:25 -0400
Received: from retiisi.org.uk ([95.216.213.190]:43170 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729411AbfC2MbZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 08:31:25 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 56A2C634C7B
        for <linux-media@vger.kernel.org>; Fri, 29 Mar 2019 14:31:06 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1h9qf5-0000pg-6M
        for linux-media@vger.kernel.org; Fri, 29 Mar 2019 14:31:07 +0200
Date:   Fri, 29 Mar 2019 14:31:07 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL for 5.2] Sensor driver patch and SoC camera cleanups
Message-ID: <20190329123107.m42l5ky6eorqo2jo@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Here's a single sensor driver patch plus a few SoC camera cleanups.

Please pull.


The following changes since commit 122d0e8dd050cc5dc3fb9e9b5f2dee3c5276ce35:

  media: dvbdev: remove double-unlock (2019-03-28 14:36:14 -0400)

are available in the git repository at:

  ssh://linuxtv.org/git/sailus/media_tree.git tags/for-5.2-2-signed

for you to fetch changes up to 7b9bfd139ec256629fb104fc8f85e88f6c3f7ebb:

  soc_camera: Remove leftover files, add TODO (2019-03-29 14:28:32 +0200)

----------------------------------------------------------------
sensor stuff for 5.2

----------------------------------------------------------------
Akinobu Mita (1):
      media: ov7740: enable to get exposure control in autoexposure mode

Sakari Ailus (2):
      MAINTAINERS: Fix files for obsolete SoC camera framework
      soc_camera: Remove leftover files, add TODO

 MAINTAINERS                            |  5 ++---
 drivers/media/i2c/ov7740.c             | 28 +++++++++++++++++++++++++---
 drivers/staging/media/mt9t031/Kconfig  |  5 -----
 drivers/staging/media/mt9t031/Makefile |  1 -
 drivers/staging/media/mt9t031/TODO     |  5 -----
 drivers/staging/media/soc_camera/TODO  |  4 ++++
 6 files changed, 31 insertions(+), 17 deletions(-)
 delete mode 100644 drivers/staging/media/mt9t031/Kconfig
 delete mode 100644 drivers/staging/media/mt9t031/Makefile
 delete mode 100644 drivers/staging/media/mt9t031/TODO
 create mode 100644 drivers/staging/media/soc_camera/TODO

-- 
Sakari Ailus
