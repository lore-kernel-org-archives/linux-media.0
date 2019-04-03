Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06859C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 09:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D663D206B8
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 09:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDCJnc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:43:32 -0400
Received: from retiisi.org.uk ([95.216.213.190]:46806 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfDCJna (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 3 Apr 2019 05:43:30 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 6500C634C7D;
        Wed,  3 Apr 2019 12:42:53 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v3 0/3] Videobuf2 corner case fixes
Date:   Wed,  3 Apr 2019 12:43:25 +0300
Message-Id: <20190403094328.4895-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi all,

Here's a third version of the set fixing a few videobuf2 corner cases.
Most drivers have limits for the size already but not necessarily all of
them.

since v2:

- Remove the sanity check from the second patch as suggested by Mauro.

since v1:

- Add a sanity check for alignment in vb2_dma_sg_alloc_compacted.

- Add a comment in __vb2_buf_mem_alloc noting that the size shall be page
  aligned.

Sakari Ailus (3):
  videobuf2-core: Prevent size alignment wrapping buffer size to 0
  videobuf2-dma-sg: Prevent size from overflowing
  videobuf2-core.h: Document the alloc memop size argument as page
    aligned

 drivers/media/common/videobuf2/videobuf2-core.c   | 5 +++++
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 2 +-
 include/media/videobuf2-core.h                    | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.11.0

