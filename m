Return-Path: <SRS0=o2oZ=AG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A32C433E0
	for <linux-media@archiver.kernel.org>; Thu, 25 Jun 2020 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B169207FC
	for <linux-media@archiver.kernel.org>; Thu, 25 Jun 2020 18:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404190AbgFYSu2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390895AbgFYSu2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Jun 2020 14:50:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC3BC08C5C1
        for <linux-media@vger.kernel.org>; Thu, 25 Jun 2020 11:50:27 -0700 (PDT)
Received: from localhost.localdomain (p200300cb8737cf00e4140a231ed1025d.dip0.t-ipconnect.de [IPv6:2003:cb:8737:cf00:e414:a23:1ed1:25d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 926482A572D;
        Thu, 25 Jun 2020 19:50:25 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
Subject: [PATCH 0/4] media: staging: rkisp1: fixes related to the uapi lsc struct
Date:   Thu, 25 Jun 2020 20:50:13 +0200
Message-Id: <20200625185017.16493-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix several issues related to the struct rkisp1_cif_isp_lsc_config
defined in:
drivers/staging/media/rkisp1/uapi/rkisp1-config.h

The issues are mentioned in comments from Tomasz Figa:
https://patchwork.kernel.org/patch/10267411/#21766475

Dafna Hirschfeld (4):
  media: staging: rkisp1: remove two unused fields in uapi struct
  media: staging: rkisp1: set "*_data_tbl" fields in
    rkisp1_cif_isp_lsc_config as 2D arries
  media: staging: rkisp1: replace to identical macros with one
  media: staging: rkisp1: change type of fields in
    'rkisp1_cif_isp_lsc_config' from u32 to u16

 drivers/staging/media/rkisp1/rkisp1-params.c  | 32 +++++++++----------
 drivers/staging/media/rkisp1/rkisp1-regs.h    |  1 -
 .../staging/media/rkisp1/uapi/rkisp1-config.h | 29 ++++++++---------
 3 files changed, 28 insertions(+), 34 deletions(-)

-- 
2.17.1

