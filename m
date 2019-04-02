Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0658C43381
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 02:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1CD20833
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 02:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDBCF0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:05:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16029 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728625AbfDBCF0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 22:05:26 -0400
X-UUID: 3dedb9c1ac99453485c01c493258d7d8-20190402
X-UUID: 3dedb9c1ac99453485c01c493258d7d8-20190402
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1767869146; Tue, 02 Apr 2019 10:05:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Apr 2019 10:05:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Apr 2019 10:05:05 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     <linux-firmware@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <tiffany.lin@mediatek.com>,
        <srv_heupstream@mediatek.com>, <yunfei.dong@mediatek.com>
Subject: [PATCH] mediatek: update MT8173 VPU firmware to v1.1.2 [decoder] Enlarge struct vdec_pic_info to support more capture buffer plane and capture buffer format change.
Date:   Tue, 2 Apr 2019 10:05:01 +0800
Message-ID: <1554170701-10210-2-git-send-email-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1554170701-10210-1-git-send-email-yunfei.dong@mediatek.com>
References: <1554170701-10210-1-git-send-email-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Release Version: 1.1.2

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 vpu_d.bin |  Bin 2977008 -> 2977008 bytes
 vpu_p.bin |  Bin 131168 -> 131180 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/vpu_d.bin b/vpu_d.bin
index f1a552edfc168973acc1d219db19e60f354daae0..a04dd793a7cbc88e633bee807f7c6460831f0096 100644
GIT binary patch
delta 374
zcmajWxeftg6hPrw{Pulk?8{h2gmT`)qv#b1onpL*f=Cp!GNn$VRLWGMbS9xAitpay
z-0NJnvV*l^s^j5kF3g26Whgsgs@icjv1G}$#O7_!{>JSGoPPArkK50<{<*tZvLP{~
z`=7%HU0E&crwR`Qyzs$~0D=f1j0mELA&vx+NFj|3vdAHi0*cU3LKziQQ9~UKG|@sE
QIy&g0hdzv*{T%4i7i*)ZHUIzs

delta 374
zcmajWyAHu{6oBzo{oU_(>VBzf#HerJf$S27?tKcAh(s(Bo55&fG@3d|M_&^*(&2Z`
z@SS7b_OgYoM^`4}=}PE^&}DcILRZw&VrI&cV~O?0hW(4vcR2p(-yf%+ado-7oAOX%
zNDr68C;ep_7h8cB0zUW=KoB8>5kV9&#F0P}DWs7>7CGcmKoKRVD5HWZYN(@uCR%8t
R0}WmD(8mD7!^IwH^EVqmrZ@lq

diff --git a/vpu_p.bin b/vpu_p.bin
index e2447299398e2e3393108231a883e8c406e9985b..25407fccbbcfc39fcb7fe480e4c17224d135d5ce 100644
GIT binary patch
delta 4292
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
Pn<oe%*OZDU&<XzsB_7@B

delta 4287
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
Zzf=sfnfJj0!z}MU!p&)=_CEB%KLJCJ-X{P6

-- 
1.7.9.5

