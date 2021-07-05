Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2646CC11F66
	for <linux-media@archiver.kernel.org>; Mon,  5 Jul 2021 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6466196A
	for <linux-media@archiver.kernel.org>; Mon,  5 Jul 2021 18:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhGESeN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 5 Jul 2021 14:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhGESeM (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 5 Jul 2021 14:34:12 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26264C061574
        for <linux-media@vger.kernel.org>; Mon,  5 Jul 2021 11:31:35 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 0D7F7C63BB; Mon,  5 Jul 2021 19:31:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1625509893; bh=8VANDNzKGpI2FQc2Z8zHI0HwDM+ODfJ/oqQYNG4/14k=;
        h=From:To:Subject:Date:From;
        b=T8zqS0jk43Bz94TXZeFAFbsw5/z4APB8YFb82F9riu1WlAMgOO5B/Ldm/RyPRsDKW
         XL+gx7XNZvfzt7fg5eo2Oeop+KN/uRRNMQ53tLYKlVG5+AQXg3aPBIAlQahimhZkid
         Tp1Zt8DMVBtCQkETOmCgI3I1BUxL/RXVagwOKPgpAZLJmy9IQzJLGDKe+4aQfP/j7e
         pxX9auXvVYs76MLKjZpJ2UarEEuV8J4yDJzzxWFqworAiqFx1LbU2XWXTOPwV4xlXR
         sb3X9w+8L2p9MiiNvtIPFqTe5bcMXB4GmfUWxOv5bff2rIX7MHB0MPWygY4ffJgyBi
         g3oktDYfU9Izw==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH v2 0/5] Various rc-loopback fixes
Date:   Mon,  5 Jul 2021 19:31:27 +0100
Message-Id: <cover.1625509803.git.sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Sean Young (5):
  media: rc-loopback: return number of emitters rather than error
  media: rc-loopback: use dev_dbg() rather than handrolled debug
  media: rc-loopback: send carrier reports
  media: rc-loopback: max_timeout of UINT_MAX does not work
  media: rc: rename s_learning_mode() to s_wideband_receiver()

 drivers/media/rc/ene_ir.c      |  2 +-
 drivers/media/rc/lirc_dev.c    |  6 +--
 drivers/media/rc/mceusb.c      |  2 +-
 drivers/media/rc/rc-loopback.c | 82 +++++++++++++++++-----------------
 include/media/rc-core.h        |  5 ++-
 5 files changed, 49 insertions(+), 48 deletions(-)

-- 
2.31.1

