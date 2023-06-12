Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D19EC88CB6
	for <linux-media@archiver.kernel.org>; Mon, 12 Jun 2023 14:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjFLOAV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Jun 2023 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjFLN7r (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Jun 2023 09:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B704E78
        for <linux-media@vger.kernel.org>; Mon, 12 Jun 2023 06:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC3461758
        for <linux-media@vger.kernel.org>; Mon, 12 Jun 2023 13:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4393CC433D2;
        Mon, 12 Jun 2023 13:58:41 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Zheng Zhang <zheng.zhang@email.ucr.edu>
Subject: [PATCH 0/3] media: cec: core: fix locking issues
Date:   Mon, 12 Jun 2023 15:58:36 +0200
Message-Id: <20230612135839.254935-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Two cec callbacks (adap_configured and received) could be called
either with or without adap->lock held. This was 1) very confusing,
and 2) could cause a deadlock.

Stop 'overloading' these callbacks and just split them up according
to the specific use-case.

All adap_* callbacks now take the mutex, and all other callbacks do
not.

Hans Verkuil (3):
  media: cec: core: add adap_nb_transmit_canceled() callback
  media: cec: core: add adap_unconfigured() callback
  Documentation: media: cec: describe new callbacks

 Documentation/driver-api/media/cec-core.rst | 44 ++++++++++++++++-----
 drivers/media/cec/core/cec-adap.c           |  8 ++--
 include/media/cec.h                         | 11 ++++--
 3 files changed, 45 insertions(+), 18 deletions(-)

-- 
2.39.2

