Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C36C4338F
	for <linux-media@archiver.kernel.org>; Wed,  4 Aug 2021 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B0560E97
	for <linux-media@archiver.kernel.org>; Wed,  4 Aug 2021 14:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhHDObD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:31:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39582 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbhHDO2x (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 4 Aug 2021 10:28:53 -0400
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:adf4:1f5e:19c9:b75f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7093A1F43A25;
        Wed,  4 Aug 2021 15:27:42 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com, mchehab@kernel.org,
        tfiga@chromium.org, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, matthias.bgg@gmail.com,
        hsinyi@chromium.org, maoguang.meng@mediatek.com,
        irui.wang@mediatek.com, acourbot@chromium.org,
        Yunfei.Dong@mediatek.com, yong.wu@mediatek.com, eizan@chromium.org
Subject: [PATCH 0/5] media: mtk-vcodec: venc: variouse bug fixes
Date:   Wed,  4 Aug 2021 16:27:24 +0200
Message-Id: <20210804142729.7231-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Some bug fixes mainly in case of error handling

Dafna Hirschfeld (5):
  media: mtk-vcodec: enter ABORT state if encoding failed
  media: mtk-vcodec: call v4l2_m2m_ctx_release first when file is
    released
  media: mtk-vcodec: change the venc handler funcs to return int
  media: mtk-vcodec: Add two error cases upon vpu irq handling
  media: mtk-vcodec: venc: Fail if a msg sent to VPU was not signaled

 .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 +
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  2 +-
 .../media/platform/mtk-vcodec/venc_vpu_if.c   | 27 +++++++++++++------
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.17.1

