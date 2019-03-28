Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8D6C10F06
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECC520700
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfC1SIO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:08:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54154 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfC1SIM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 14:08:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id BCDE728227F
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/2] media: Introduce pixel format helpers
Date:   Thu, 28 Mar 2019 15:07:02 -0300
Message-Id: <20190328180704.24761-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Following the "Add MPEG-2 decoding to Rockchip VPU"[1], and given we want to start
using the pixel format helpers rather soon, I've decided to submit them separatedly.

Aside from documenting the block_w and block_h, as suggested by Emil Velikov, these
two patches are unmodified compared to v2 [1].

This series contains the minimum patches to introduce the pixel format
helpers, it currently will have no users, but we expect users to start
popping-up soon.
very shortly [2].

To avoid confusing the patches here with those on v2 [1], I'm marking them as v3.

Thanks!

[1] https://patchwork.kernel.org/cover/10838327/
[2] https://patchwork.kernel.org/patch/10851639/

Ezequiel Garcia (2):
  rockchip/vpu: Rename pixel format helpers
  media: Introduce helpers to fill pixel format structs

 drivers/media/v4l2-core/v4l2-common.c         | 164 ++++++++++++++++++
 .../media/rockchip/vpu/rockchip_vpu_enc.c     |  12 +-
 include/media/v4l2-common.h                   |  33 ++++
 3 files changed, 203 insertions(+), 6 deletions(-)

-- 
2.20.1

