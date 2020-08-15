Return-Path: <SRS0=xPRW=BZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8CDC433E1
	for <linux-media@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452CB2053B
	for <linux-media@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgHOWC1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgHOVvY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AA8C08E826
        for <linux-media@vger.kernel.org>; Sat, 15 Aug 2020 03:37:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id BAA8029A948
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
Subject: [PATCH v2 03/14] media: staging: rkisp1: params: use the new effect value in cproc config
Date:   Sat, 15 Aug 2020 12:37:23 +0200
Message-Id: <20200815103734.31153-4-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815103734.31153-1-dafna.hirschfeld@collabora.com>
References: <20200815103734.31153-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The cproc (color processing) configuration needs to know if
an image effect is configured. The code uses the image effect
in 'cur_params' which is the first params buffer queued in the stream.
This is the wrong place to read the value. The value should be
taken from the current params buffer.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkisp1/rkisp1-params.c b/drivers/staging/media/rkisp1/rkisp1-params.c
index 8d881f1df1e6..eb77b4ed8655 100644
--- a/drivers/staging/media/rkisp1/rkisp1-params.c
+++ b/drivers/staging/media/rkisp1/rkisp1-params.c
@@ -560,7 +560,7 @@ static void rkisp1_cproc_config(struct rkisp1_params *params,
 				const struct rkisp1_cif_isp_cproc_config *arg)
 {
 	struct rkisp1_cif_isp_isp_other_cfg *cur_other_cfg =
-						&params->cur_params.others;
+		container_of(arg, struct rkisp1_cif_isp_isp_other_cfg, cproc_config);
 	struct rkisp1_cif_isp_ie_config *cur_ie_config =
 						&cur_other_cfg->ie_config;
 	u32 effect = cur_ie_config->effect;
-- 
2.17.1

