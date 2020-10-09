Return-Path: <SRS0=wJZ5=DQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA6FC433DF
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 12:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534C3222B8
	for <linux-media@archiver.kernel.org>; Fri,  9 Oct 2020 12:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgJIMdy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 9 Oct 2020 08:33:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730598AbgJIMdy (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 9 Oct 2020 08:33:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4F3A95143872931FB34E;
        Fri,  9 Oct 2020 20:33:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 20:33:41 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <rick.chang@mediatek.com>, <bin.liu@mediatek.com>,
        <mchehab@kernel.org>, <matthias.bgg@gmail.com>,
        <tiffany.lin@mediatek.com>, <andrew-ct.chen@mediatek.com>,
        <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <hverkuil-cisco@xs4all.nl>, <jcliang@chromium.org>,
        <minghsiu.tsai@mediatek.com>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH V2 0/7] patches to add missing put_device() call 
Date:   Fri, 9 Oct 2020 20:37:57 +0800
Message-ID: <20201009123804.3977562-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

changes in V2:
 - add several patches suggested by Hans

Yu Kuai (7):
  media: platform: add missing put_device() call in mtk_jpeg_clk_init()
  media: platform: add missing put_device() call in mtk_jpeg_probe()
  media: platform: add missing put_device() call in mtk_jpeg_remove()
  media: mtk-vcodec: add missing put_device() call in
    mtk_vcodec_init_dec_pm()
  media: mtk-vcodec: add missing put_device() call in
    mtk_vcodec_release_dec_pm()
  media: mtk-vcodec: add missing put_device() call in
    mtk_vcodec_init_enc_pm()
  media: mtk-vcodec: add missing put_device() call in
    mtk_vcodec_release_enc_pm()

 .../media/platform/mtk-jpeg/mtk_jpeg_core.c   |  3 ++
 .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 19 +++++++++----
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 28 ++++++++++++++-----
 3 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.25.4

