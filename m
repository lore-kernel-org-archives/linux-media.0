Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3269CC433FE
	for <linux-media@archiver.kernel.org>; Tue, 18 Oct 2022 14:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJROGp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Oct 2022 10:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJROGo (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Oct 2022 10:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17655D38E9
        for <linux-media@vger.kernel.org>; Tue, 18 Oct 2022 07:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E84976159C
        for <linux-media@vger.kernel.org>; Tue, 18 Oct 2022 14:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12249C433D7
        for <linux-media@vger.kernel.org>; Tue, 18 Oct 2022 14:06:09 +0000 (UTC)
Message-ID: <4cdb3def-71dd-9f50-ed2e-8c7470e4a2fe@xs4all.nl>
Date:   Tue, 18 Oct 2022 16:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-US
To:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v6.1] vivid fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit d67614f276c1499ad939fa5c1aadd35498cc6b34:

  Merge fixes into media_stage (2022-09-27 10:27:56 +0200)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v6.1r

for you to fetch changes up to 124d0ceab877b01c90b8ac54ec317bdde3aee508:

  videodev2.h: V4L2_DV_BT_BLANKING_HEIGHT should check 'interlaced' (2022-10-17 16:32:21 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (4):
      vivid: s_fbuf: add more sanity checks
      vivid: dev->bitmap_cap wasn't freed in all cases
      v4l2-dv-timings: add sanity checks for blanking values
      videodev2.h: V4L2_DV_BT_BLANKING_HEIGHT should check 'interlaced'

 drivers/media/test-drivers/vivid/vivid-core.c    | 22 ++++++++++++++++++++++
 drivers/media/test-drivers/vivid/vivid-core.h    |  2 ++
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 27 +++++++++++++++++++++------
 drivers/media/v4l2-core/v4l2-dv-timings.c        | 14 ++++++++++++++
 include/uapi/linux/videodev2.h                   |  3 ++-
 5 files changed, 61 insertions(+), 7 deletions(-)
