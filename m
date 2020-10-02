Return-Path: <SRS0=i6Q9=DJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F7FC35257
	for <linux-media@archiver.kernel.org>; Fri,  2 Oct 2020 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B2D208B6
	for <linux-media@archiver.kernel.org>; Fri,  2 Oct 2020 18:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbgJBSmf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 2 Oct 2020 14:42:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52462 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbgJBSmf (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 2 Oct 2020 14:42:35 -0400
Received: from guri.fritz.box (p200300c7cf13ec00987cfa6c93a91dfa.dip0.t-ipconnect.de [IPv6:2003:c7:cf13:ec00:987c:fa6c:93a9:1dfa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 111A929DBF7;
        Fri,  2 Oct 2020 19:42:34 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
Subject: [PATCH 5/6] media: staging: rkisp1: params: add '__must_hold' to rkisp1_params_apply_params_cfg
Date:   Fri,  2 Oct 2020 20:42:21 +0200
Message-Id: <20201002184222.7094-6-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002184222.7094-1-dafna.hirschfeld@collabora.com>
References: <20201002184222.7094-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The function rkisp1_params_apply_params_cfg must be under the
the lock of params->config_lock. Add the __must_hold annotation
to indicate it.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/staging/media/rkisp1/rkisp1-params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/rkisp1/rkisp1-params.c b/drivers/staging/media/rkisp1/rkisp1-params.c
index 3afbc24ca05e..aa18a113245b 100644
--- a/drivers/staging/media/rkisp1/rkisp1-params.c
+++ b/drivers/staging/media/rkisp1/rkisp1-params.c
@@ -1187,6 +1187,7 @@ static void rkisp1_isp_isr_meas_config(struct rkisp1_params *params,
 
 static void rkisp1_params_apply_params_cfg(struct rkisp1_params *params,
 					   unsigned int frame_sequence)
+	__must_hold(&params->config_lock)
 {
 	struct rkisp1_params_cfg *new_params;
 	struct rkisp1_buffer *cur_buf = NULL;
-- 
2.17.1

