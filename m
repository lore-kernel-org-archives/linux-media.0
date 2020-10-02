Return-Path: <SRS0=i6Q9=DJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA6C4363D
	for <linux-media@archiver.kernel.org>; Fri,  2 Oct 2020 18:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5187D20795
	for <linux-media@archiver.kernel.org>; Fri,  2 Oct 2020 18:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgJBSmc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 2 Oct 2020 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBSmb (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 2 Oct 2020 14:42:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16EEC0613D0
        for <linux-media@vger.kernel.org>; Fri,  2 Oct 2020 11:42:31 -0700 (PDT)
Received: from guri.fritz.box (p200300c7cf13ec00987cfa6c93a91dfa.dip0.t-ipconnect.de [IPv6:2003:c7:cf13:ec00:987c:fa6c:93a9:1dfa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2560A29C736;
        Fri,  2 Oct 2020 19:42:29 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
Subject: [PATCH 0/6] media: staging: rkisp1: improvements
Date:   Fri,  2 Oct 2020 20:42:16 +0200
Message-Id: <20201002184222.7094-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Some improvements to the rkisp1 code, mainly
to the params and stats.
The first patch was already part of previous patchset

I tested using wrappers for 'v4l2-ctl', 'media-ctl'
and for 'cam' command from libcamera:

git clone --single-branch --branch rkisp1-oct-2 https://gitlab.collabora.com/dafna/v4l-utils.git
cd v4l-utils/contrib/test/
./rkisp1-unit-tests.sh

Dafna Hirschfeld (6):
  media: staging: rkisp1: validate links before powering and streaming
  media: staging: rkisp1: params: in stop_streaming, use
    list_splice_init to move the buffers
  media: staging: rkisp1: initialize buffer lists only on probe
  media: staging: rkisp1: remove the 'is_streaming' field from stats and
    params
  media: staging: rkisp1: params: add '__must_hold' to
    rkisp1_params_apply_params_cfg
  media: staging: rkisp1: cap: add warning when link validation fails

 drivers/staging/media/rkisp1/rkisp1-capture.c | 31 +++++++++++-------
 drivers/staging/media/rkisp1/rkisp1-common.h  | 12 +++----
 drivers/staging/media/rkisp1/rkisp1-params.c  | 32 +++----------------
 drivers/staging/media/rkisp1/rkisp1-stats.c   | 21 ------------
 4 files changed, 29 insertions(+), 67 deletions(-)

-- 
2.17.1

