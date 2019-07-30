Return-Path: <SRS0=JK+F=V3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2F5C433FF
	for <linux-media@archiver.kernel.org>; Tue, 30 Jul 2019 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFD1206A2
	for <linux-media@archiver.kernel.org>; Tue, 30 Jul 2019 17:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbfG3R4L (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:56:11 -0400
Received: from sauhun.de ([88.99.104.3]:55972 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfG3R4L (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 30 Jul 2019 13:56:11 -0400
Received: from localhost (p54B33338.dip0.t-ipconnect.de [84.179.51.56])
        by pokefinder.org (Postfix) with ESMTPSA id 5642A2C7BD8;
        Tue, 30 Jul 2019 19:56:09 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 0/2] media: ir-kbd-i2c: convert to devm_i2c_new_dummy_device & minor cleanup
Date:   Tue, 30 Jul 2019 19:55:53 +0200
Message-Id: <20190730175555.14098-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series is part of a tree-wide movement to replace the I2C API call
'i2c_new_dummy' which returns NULL with its new counterpart returning an
ERRPTR.

It was manually converted and only build tested. A small cleanup was
added while working on this driver. Looking for ack/rev/test for this
series.

The series is based on v5.3-rc2.

Happy hacking,

   Wolfram


Wolfram Sang (2):
  media: ir-kbd-i2c: convert to i2c_new_dummy_device()
  media: ir-kbd-i2c: remove outdated comments

 drivers/media/i2c/ir-kbd-i2c.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

-- 
2.20.1

