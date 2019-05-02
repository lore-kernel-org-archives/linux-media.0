Return-Path: <SRS0=NwtJ=TC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7125FC43219
	for <linux-media@archiver.kernel.org>; Thu,  2 May 2019 22:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434E12064A
	for <linux-media@archiver.kernel.org>; Thu,  2 May 2019 22:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfEBWAz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 2 May 2019 18:00:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42692 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWAz (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 2 May 2019 18:00:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id BC47227FDD4
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 0/4] Assorted CODA fixes
Date:   Thu,  2 May 2019 19:00:41 -0300
Message-Id: <20190502220045.14962-1-ezequiel@collabora.com>
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

Patches 2 and 3 address unneeded usage of a threaded interrupt.
Careful code inspection shows the interrupt can be serviced
on a normal handler.

Finally, patch 4 clears a hardware register called INT_REASON.
Without this clearing the firmware has been found to get stuck
on our CODA980. I believe this fix might be useful to carry upstream,
because it's so small and we have some  indications that it's actually
the right thing to do.

Not much has changed in this series, compared to v1.

v2:

 * Add R-B by Philip.
 * Drop the worker removal patch, which is a controversial change.
 * Use video_device_node_name as suggested by Hans.

Ezequiel Garcia (4):
  media: coda: Print a nicer device registered message
  media: coda: Remove unbalanced and unneeded mutex unlock
  media: coda: Replace the threaded interrupt with a hard interrupt
  media: coda: Clear the interrupt reason

 drivers/media/platform/coda/coda-bit.c    |  2 +-
 drivers/media/platform/coda/coda-common.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.20.1

