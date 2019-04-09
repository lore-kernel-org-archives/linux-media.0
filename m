Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFD1C10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20D72064B
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 14:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfDIOuE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:50:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44741 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIOuE (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 10:50:04 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDs4Z-0005vk-AK
        for linux-media@vger.kernel.org; Tue, 09 Apr 2019 16:50:03 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Subject: [PATCH v4l-utils v2 0/4] compliance colors
Date:   Tue,  9 Apr 2019 16:49:54 +0200
Message-Id: <20190409144958.31233-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

take two, with an environment variable MEDIA_APPS_COLOR=always|never|auto,
and an override option --color always|never|auto for both cec-compliance
and v4l2-compliance.

regards
Philipp

Philipp Zabel (4):
  v4l2-compliance: use warn() in warn_once()
  v4l2-compliance: add colors
  cec-compliance: use warn() in warn_once()
  cec-compliance: add colors

 utils/cec-compliance/cec-compliance.1.in   |  5 +++
 utils/cec-compliance/cec-compliance.cpp    | 42 +++++++++++++++++++---
 utils/cec-compliance/cec-compliance.h      | 19 +++++-----
 utils/v4l2-compliance/v4l2-compliance.1.in |  5 +++
 utils/v4l2-compliance/v4l2-compliance.cpp  | 37 +++++++++++++++++--
 utils/v4l2-compliance/v4l2-compliance.h    | 22 +++++++-----
 6 files changed, 105 insertions(+), 25 deletions(-)

-- 
2.20.1

