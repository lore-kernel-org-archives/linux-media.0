Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D7C43218
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31C92067C
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 18:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDYSgw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:36:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35394 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDYSgw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 14:36:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 4CC912841F1
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/5] Assorted CODA fixes
Date:   Thu, 25 Apr 2019 15:35:41 -0300
Message-Id: <20190425183546.16244-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

While working on a SoC with CODA980 (currently not supported by the
driver), I came across some low-hanging fruit that looked worth
addressing.

Patch 1 is just a cosmetic change to print a different "more standard"
device registered message, if such thing exists.

Patches 2 to 4 address unneeded usage of threaded interrupt and deferred
worker. Careful code inspection shows the interrupt can be serviced
on a normal handler.

In this regard, the driver is still waiting for job completion in
the .device_run hook, which the framework already does. Therefore,
there are two waits: one in the driver, one in the mem2mem core.

Please note that I'm not addressing this for now.

Finally, patch 5 clears a hardware register called INT_REASON.
Without this clearing the firmware has been found to get stuck
on our CODA980. I believe this fix might be useful to carry upstream,
because it's so small and we have some  indications that it's actually
the right thing to do.

Ezequiel Garcia (5):
  media: coda: Print a nicer device registered message
  media: coda: Remove unbalanced and unneeded mutex unlock
  media: coda: Replace the threaded interrupt with a hard interrupt
  media: coda: Remove pic_run_work worker
  media: coda: Clear the interrupt reason

 drivers/media/platform/coda/coda-bit.c    |  2 +-
 drivers/media/platform/coda/coda-common.c | 26 ++++++++++-------------
 drivers/media/platform/coda/coda.h        |  1 -
 3 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.20.1

