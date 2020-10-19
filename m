Return-Path: <SRS0=R2Oz=D2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AE0C433DF
	for <linux-media@archiver.kernel.org>; Mon, 19 Oct 2020 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4209322282
	for <linux-media@archiver.kernel.org>; Mon, 19 Oct 2020 21:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbgJSVAF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732451AbgJSVAF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 19 Oct 2020 17:00:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5919BC0613CE
        for <linux-media@vger.kernel.org>; Mon, 19 Oct 2020 14:00:05 -0700 (PDT)
Received: from guri.fritz.box (p200300c7cf435b00546912335c7d1654.dip0.t-ipconnect.de [IPv6:2003:c7:cf43:5b00:5469:1233:5c7d:1654])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A57821F44FBE;
        Mon, 19 Oct 2020 22:00:03 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
Subject: [PATCH 0/4] media: staging: rkisp1: send cleanups and checkpatch fixes
Date:   Mon, 19 Oct 2020 22:59:52 +0200
Message-Id: <20201019205956.6980-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patchset aims to remove the TODO item "Fix checkpatch errors."

Some cleanups to the rkisp1-params.c code are also sent.

The following false positiv issues are still generated:
* "line length of * exceeds 100 columns" for the topology diagram in rkisp1-dev.c
* "DT compatible string "rockchip,rk3399-cif-isp" appears un-documented" - this will be
solved once the driver will be destaged and the file rockchip-isp1.yaml will move
to the global documentation
* "Prefer using the BIT macro" - in the uapi header 'rkisp1-config.h The BIT() macro is not
available to userspace


Dafna Hirschfeld (4):
  media: staging: rkisp1: fix coding style issues
  media: staging: rkisp1: params: remove unnecessary "!!"
  media: staging: rkisp1: params: remove unnecessary parentheses
  media: staging: rkisp1: params: remove extra 'if' conditions

 drivers/staging/media/rkisp1/TODO             |   1 -
 drivers/staging/media/rkisp1/rkisp1-dev.c     |   4 +-
 drivers/staging/media/rkisp1/rkisp1-isp.c     |   1 -
 drivers/staging/media/rkisp1/rkisp1-params.c  | 420 ++++++++----------
 drivers/staging/media/rkisp1/rkisp1-resizer.c |   4 +-
 5 files changed, 179 insertions(+), 251 deletions(-)

-- 
2.17.1

