Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AF2C433F5
	for <linux-media@archiver.kernel.org>; Tue, 10 May 2022 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345198AbiEJPWm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 10 May 2022 11:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345595AbiEJPUg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 10 May 2022 11:20:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1F53B6C
        for <linux-media@vger.kernel.org>; Tue, 10 May 2022 08:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 944D2B81B89
        for <linux-media@vger.kernel.org>; Tue, 10 May 2022 15:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5536C385A6
        for <linux-media@vger.kernel.org>; Tue, 10 May 2022 15:00:24 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Subject: [PATCH 0/7] CEC framework fixes
Date:   Tue, 10 May 2022 17:00:15 +0200
Message-Id: <20220510150022.1787112-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When testing what happens when randomly configuring and unconfiguring
a CEC adapter, and simultaneously setting an invalidating the physical
address, and starting and stopping monitoring and pin monitoring using
two cec-gpio instances, a whole bunch of race conditions were found.

This patch series addresses them.

Hans Verkuil (7):
  cec-pin: disabling the adapter cannot call kthread_stop
  cec-pin: don't zero work_pin_num_events in adap_enable
  cec-adap.c: don't unconfigure if already unconfigured
  cec-adap.c: stop trying LAs on CEC_TX_STATUS_TIMEOUT
  cec-adap.c: fix is_configuring state
  cec-adap.c: reconfigure if the PA changes during configuration
  cec-adap: drop activate_cnt, use state info instead

 drivers/media/cec/core/cec-adap.c | 188 ++++++++++++++----------------
 drivers/media/cec/core/cec-pin.c  |  57 +++++----
 include/media/cec.h               |   6 +-
 3 files changed, 124 insertions(+), 127 deletions(-)

-- 
2.34.1

