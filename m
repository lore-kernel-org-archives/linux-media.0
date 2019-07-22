Return-Path: <SRS0=6VSJ=VT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C470C7618F
	for <linux-media@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B7C21E6B
	for <linux-media@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfGVR0f (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:26:35 -0400
Received: from sauhun.de ([88.99.104.3]:42368 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731335AbfGVR0e (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:34 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id DB15E4A149C;
        Mon, 22 Jul 2019 19:26:32 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 0/2] media: ir-kbd-i2c: fix potential OOPS & minor cleanup
Date:   Mon, 22 Jul 2019 19:26:30 +0200
Message-Id: <20190722172632.4402-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Wolfram Sang <wsa@the-dreams.de>

This series is part of a tree-wide movement to replace the I2C API call
'i2c_new_dummy' which returns NULL with its new counterpart returning an
ERRPTR.

It was manually converted and only build tested (by me and buildbot). A
small cleanup was added while working on this driver. Looking for
someone to ack/rev/test this series.

The series is based on v5.3-rc1. A branch (with some more stuff included) can
be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/new_dummy

Thanks!


Wolfram Sang (2):
  media: ir-kbd-i2c: prevent potential NULL pointer access
  media: ir-kbd-i2c: remove outdated comments

 drivers/media/i2c/ir-kbd-i2c.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

-- 
2.20.1

