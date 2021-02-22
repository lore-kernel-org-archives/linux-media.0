Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BAFC433E0
	for <linux-media@archiver.kernel.org>; Mon, 22 Feb 2021 10:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38EC64E32
	for <linux-media@archiver.kernel.org>; Mon, 22 Feb 2021 10:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBVKoN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Feb 2021 05:44:13 -0500
Received: from gofer.mess.org ([88.97.38.141]:39585 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230141AbhBVKoM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Feb 2021 05:44:12 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id E0A1BC63BD; Mon, 22 Feb 2021 10:43:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1613990609; bh=ot/DIU9x38hW1kJhEKp1VaEU+I211SSFhF5qW3ZBcg0=;
        h=From:To:Subject:Date:From;
        b=B+GrnYtvMFuWx7Z+kE7oaJ3nbaw6+RGUuXv0PrPEO9gqX9G2NGPngLAUOasUpZlQN
         m48u79/I29BSckKa7czATNgH+rZWOpG8qtS2j/rIIPw3KXT+8lkUJb803yXIIwUa2G
         dpqC9DpekwNuFpuaHDUnjw9wPZhQwndG92asP+K4ikJW0HYX9n9tJH48Qhi796RkAa
         YAWgxZ411FOsSSeuCyUZd9FEOlN+CqNVlk+AuCTxmrzKMMy8JOxwo3TbJBWVnhNfFx
         lp4IpiguglL7c+X5/kuz+62DNWfAH27jH49a7c5lboKSQ3FltaqC1NsSte82qLhkZK
         bHTa3aE/jHj3A==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, Matthias Reichl <hias@horus.com>,
        =?UTF-8?q?Juan=20Jes=C3=BAs=20Garc=C3=ADa=20de=20Soria?= 
        <skandalfo@gmail.com>
Subject: [PATCH 0/6] media: ite-cir driver cleanups
Date:   Mon, 22 Feb 2021 10:43:23 +0000
Message-Id: <cover.1613989288.git.sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This should not be any functional changes, just various cleanups.

Sean Young (6):
  media: ite-cir: remove unused fields
  media: ite-cir: set parent device
  media: ite-cir: use standard logging and reduce noise
  media: ite-cir: carrier and duty cycle can be set via ioctl
  media: ite-cir: move runtime information into driver data
  media: ite-cir: check for receive overflow

 drivers/media/rc/ite-cir.c | 341 +++++++++----------------------------
 drivers/media/rc/ite-cir.h |  49 ++----
 2 files changed, 91 insertions(+), 299 deletions(-)

-- 
2.29.2

