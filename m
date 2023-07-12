Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52834EB64D9
	for <linux-media@archiver.kernel.org>; Wed, 12 Jul 2023 08:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGLIwP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 12 Jul 2023 04:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGLIwO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 12 Jul 2023 04:52:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3AB1
        for <linux-media@vger.kernel.org>; Wed, 12 Jul 2023 01:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9386161696
        for <linux-media@vger.kernel.org>; Wed, 12 Jul 2023 08:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6D3C433C7;
        Wed, 12 Jul 2023 08:52:10 +0000 (UTC)
Message-ID: <9028875f-69d8-9643-af9e-f911560b2751@xs4all.nl>
Date:   Wed, 12 Jul 2023 10:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v6.5] Two verisilicon fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v6.5n

for you to fetch changes up to 90a0416f9e1152b90ee9d5e2157db0a5b7686388:

  media: verisilicon: change confusingly named relaxed register access (2023-07-12 10:07:08 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Arnd Bergmann (2):
      media: verisilicon: fix excessive stack usage
      media: verisilicon: change confusingly named relaxed register access

 drivers/media/platform/verisilicon/hantro.h          | 50 +++++++++++++++++++++++++-------------------------
 drivers/media/platform/verisilicon/hantro_postproc.c | 12 ++++++------
 2 files changed, 31 insertions(+), 31 deletions(-)
