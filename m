Return-Path: <SRS0=PKt4=VM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD44C7618F
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 21:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91E5206B8
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 21:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfGOVYI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:24:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52806 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfGOVYI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Jul 2019 17:24:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id C9C4A28B679
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/2] Some cleanups for ancillary drivers autoselect
Date:   Mon, 15 Jul 2019 18:23:14 -0300
Message-Id: <20190715212316.352-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro, Hans:

While developing the Rockchip ISP1 driver Helen and I noticed
that the MEDIA_SUBDRV_AUTOSELECT option was a bit confusing,
hiding some menu options, preventing us from jumping to sensor
drivers via the numbered menuconfig shortcuts.

Then, I noticed a user on IRC falling on the same trap,
and so decided the problem was common enough it was worth
a try.

Thanks!
Eze

Ezequiel Garcia (2):
  media: Don't default-enable "ancillary driver autoselect" if EMBEDDED
  media: Don't hide any menu if "ancillary drivers autoselect" is
    enabled

 drivers/media/Kconfig               | 2 +-
 drivers/media/dvb-frontends/Kconfig | 1 -
 drivers/media/i2c/Kconfig           | 1 -
 drivers/media/spi/Kconfig           | 1 -
 drivers/media/tuners/Kconfig        | 1 -
 5 files changed, 1 insertion(+), 5 deletions(-)

-- 
2.22.0

