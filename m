Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35663C43381
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 02:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084BE20830
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 02:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfDBCFZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:05:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23306 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728624AbfDBCFZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 22:05:25 -0400
X-UUID: 91badc9fe5cb4c3cbe3bab4af31d87f4-20190402
X-UUID: 91badc9fe5cb4c3cbe3bab4af31d87f4-20190402
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 695087679; Tue, 02 Apr 2019 10:05:07 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Apr 2019 10:05:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Apr 2019 10:05:04 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     <linux-firmware@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <tiffany.lin@mediatek.com>,
        <srv_heupstream@mediatek.com>, <yunfei.dong@mediatek.com>
Subject: pull request: linux-firmware: Update Mediatek MT8173 VPU firmware
Date:   Tue, 2 Apr 2019 10:05:00 +0800
Message-ID: <1554170701-10210-1-git-send-email-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AD1EEADAC5E92F62927B8F0A16B25F9F85F169CEEEC7FB5638FBE3E56CBCD1082000:8
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

  mediatek: update MT8173 VPU firmware to v1.1.2 (2019-04-01 16:02:08 +0800)

 ----------------------------------------------------------------
Yunfei Dong (1):
    mediatek: update MT8173 VPU firmware to v1.1.2

vpu_d.bin |  Bin 2977008 -> 2977008 bytes vpu_p.bin |  Bin 131168 -> 131180 bytes
2 files changed, 0 insertions(+), 0 deletions(-)

