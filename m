Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05BC433DB
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AE023741
	for <linux-media@archiver.kernel.org>; Thu, 14 Jan 2021 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbhANSF1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbhANSF0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 14 Jan 2021 13:05:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D0C061794;
        Thu, 14 Jan 2021 10:05:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id E11481F45C6D
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, hans.verkuil@cisco.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Subject: [PATCH 0/3] v4l2 framework minor improvements
Date:   Thu, 14 Jan 2021 15:01:46 -0300
Message-Id: <20210114180149.1755892-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Just minor things.
Add capabilities to v4l_print_create_buffers(), clarify docs and remove
a redundant check.

Helen Koike (3):
  media: v4l2-ioctl: print capabilities in v4l_print_create_buffers()
  media: videodev2.h: clarify v4l2_pix_format_mplane.sizeimage docs when
    to set to zero
  media: videobuf2-v4l2: remove redundant error test

 drivers/media/common/videobuf2/videobuf2-v4l2.c | 5 -----
 drivers/media/v4l2-core/v4l2-ioctl.c            | 6 +++---
 include/uapi/linux/videodev2.h                  | 1 +
 3 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.29.2

