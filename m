Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A3AC001E0
	for <linux-media@archiver.kernel.org>; Mon, 24 Jul 2023 06:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGXG6W (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 Jul 2023 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGXG6T (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 Jul 2023 02:58:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB4187
        for <linux-media@vger.kernel.org>; Sun, 23 Jul 2023 23:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BDB560F53
        for <linux-media@vger.kernel.org>; Mon, 24 Jul 2023 06:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9B6C433C8;
        Mon, 24 Jul 2023 06:58:11 +0000 (UTC)
Message-ID: <f89e7218-3248-4647-ad0f-12cc14e57337@xs4all.nl>
Date:   Mon, 24 Jul 2023 08:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v6.5] mtk-jpeg: Set platform driver data earlier
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 28999781d15f94046e6c23a9a7d92ad28a436abf:

  media: i2c: ov01a10: Switch back to use struct i2c_driver::probe (2023-07-19 12:57:51 +0200)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v6.5o

for you to fetch changes up to 083c009fb4bf81e301112fb86d92fe8e8beff22f:

  media: mtk-jpeg: Set platform driver data earlier (2023-07-24 08:56:14 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Chen-Yu Tsai (1):
      media: mtk-jpeg: Set platform driver data earlier

 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
