Return-Path: <SRS0=krkx=75=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C26C433DF
	for <linux-media@archiver.kernel.org>; Tue, 16 Jun 2020 12:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E44F2080D
	for <linux-media@archiver.kernel.org>; Tue, 16 Jun 2020 12:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgFPMsa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgFPMsa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Jun 2020 08:48:30 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1347C08C5C3
        for <linux-media@vger.kernel.org>; Tue, 16 Jun 2020 05:48:23 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id B44A611A002; Tue, 16 Jun 2020 13:48:18 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH 0/4] Remove unused functions found with clang
Date:   Tue, 16 Jun 2020 13:48:14 +0100
Message-Id: <cover.1592302248.git.sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Sean Young (4):
  media: drx-k: remove unused MulDiv32 function
  media: nuvoton-cir: remove setting tx carrier functions
  media: fintek-cir: remove unused function fintek_clear_reg_bit
  media: cx23888: remove unused functions

 drivers/media/dvb-frontends/drxk_hard.c | 11 ---------
 drivers/media/pci/cx23885/cx23888-ir.c  | 20 ----------------
 drivers/media/rc/fintek-cir.c           |  7 ------
 drivers/media/rc/nuvoton-cir.c          | 32 -------------------------
 4 files changed, 70 deletions(-)

-- 
2.26.2

