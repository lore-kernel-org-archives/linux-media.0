Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242FDC282DD
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F1520883
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDHIqM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:46:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDHIqK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 04:46:10 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDPuq-00075y-TB
        for linux-media@vger.kernel.org; Mon, 08 Apr 2019 10:46:08 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-media@vger.kernel.org
Subject: [PATCH v4l-utils 0/2] v4l2-compliance colors
Date:   Mon,  8 Apr 2019 10:45:56 +0200
Message-Id: <20190408084558.2979-1-p.zabel@pengutronix.de>
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

not sure if anybody finds this as useful as I do to spot compliance
failures and warnings in a sea of OKs more easily, but this patch adds
some color escape codes to the output of v4l2-compliance. It marks "OK"
green, "warn" bold, and "fail" / "FAIL" bright red if the output is a
terminal. I would have preferred to mark warnings yellow, but that
doesn't work well on black-on-white terminals.

regards
Philipp

Philipp Zabel (2):
  v4l2-compliance: use warn() in warn_once()
  v4l2-compliance: add colors

 utils/v4l2-compliance/v4l2-compliance.cpp | 11 ++++++++---
 utils/v4l2-compliance/v4l2-compliance.h   | 22 +++++++++++++---------
 2 files changed, 21 insertions(+), 12 deletions(-)

-- 
2.20.1

