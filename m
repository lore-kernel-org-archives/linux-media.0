Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41716C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 08:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A029214C6
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 08:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfDAISf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:18:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21931 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731802AbfDAISf (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 04:18:35 -0400
X-UUID: d7d189f41ba54561ba46df7c7a2c1b3c-20190401
X-UUID: d7d189f41ba54561ba46df7c7a2c1b3c-20190401
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1664200843; Mon, 01 Apr 2019 16:18:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Apr 2019 16:18:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Apr 2019 16:18:23 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     <linux-firmware@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <tiffany.lin@mediatek.com>
Subject: pull request: linux-firmware: Update Mediatek MT8173 VPU firmware 
Date:   Mon, 1 Apr 2019 16:18:18 +0800
Message-ID: <1554106699-25469-1-git-send-email-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi linux-firmware maintainers,

The following changes since commit 7bc246451318b3536d9bfd3c4e46d541a9831b33:

  Merge branch 'for-upstream' of git://git.chelsio.net/pub/git/linux-firmware (2019-03-14 08:22:39 -0400)

are available in the git repository at:

  https://github.com/yunfei-dong/linux_fw_vpu_v1.1.2.git v1.1.2

for you to fetch changes up to c1b685587a6ffd651e900eff4e945619487f91bc:

  mediatek: update MT8173 VPU firmware to v1.1.2  (2019-04-01 16:02:08 +0800)

 ----------------------------------------------------------------
Yunfei Dong (1):
	mediatek: update MT8173 VPU firmware to v1.1.2.

vpu_d.bin | Bin 2977008 -> 2977008 bytes  vpu_p.bin | Bin 131168 -> 131180 bytes

2 files changed, 0 insertions(+), 0 deletions(-)


