Return-Path: <SRS0=pJLX=BG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CB4C433E3
	for <linux-media@archiver.kernel.org>; Mon, 27 Jul 2020 17:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE432064B
	for <linux-media@archiver.kernel.org>; Mon, 27 Jul 2020 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgG0RFs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:05:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40196 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbgG0RFs (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 27 Jul 2020 13:05:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 6D65C295CAB
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 0/2] hantro: postproc related fixes
Date:   Mon, 27 Jul 2020 14:05:36 -0300
Message-Id: <20200727170538.32894-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Doing some more extended testing, we found a few
issues when the post-processor is enabled (currently
for color conversion).

The two patches below should fix these issues.

Changes from v1:

* Undo the change to the comment about the
  MV and MC layout. As pointed out by Jonas,
  the layout is not generic, and depends on the
  version of the decoder core. For now, let's
  leave it as is.

Ezequiel Garcia (2):
  hantro: h264: Get the correct fallback reference buffer
  hantro: postproc: Fix motion vector space allocation

 drivers/staging/media/hantro/hantro_h264.c     | 2 +-
 drivers/staging/media/hantro/hantro_postproc.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.27.0

