Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEE1C4360F
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 10:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBBC20856
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 10:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDBKEZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:04:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:14081 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725920AbfDBKEZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 2 Apr 2019 06:04:25 -0400
X-UUID: 6848d36acada463db0b3c2fd673c8e09-20190402
X-UUID: 6848d36acada463db0b3c2fd673c8e09-20190402
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <jungo.lin@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 149675693; Tue, 02 Apr 2019 18:04:10 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Apr 2019 18:04:08 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Apr 2019 18:04:08 +0800
From:   Jungo Lin <jungo.lin@mediatek.com>
To:     <tfiga@chromium.org>, <hans.verkuil@cisco.com>,
        <laurent.pinchart+renesas@ideasonboard.com>,
        <matthias.bgg@gmail.com>, <mchehab@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <Sean.Cheng@mediatek.com>,
        <sj.huang@mediatek.com>, <christie.yu@mediatek.com>,
        <holmes.chiou@mediatek.com>, <frederic.chen@mediatek.com>,
        <Jerry-ch.Chen@mediatek.com>, <jungo.lin@mediatek.com>,
        <frankie.chiu@mediatek.com>, <seraph.huang@mediatek.com>,
        <ryan.yu@mediatek.com>, <Rynn.Wu@mediatek.com>,
        <yuzhao@chromium.org>, <zwisler@chromium.org>,
        <srv_heupstream@mediatek.com>,
        Jungo Lin <jungo.lin@mediatek.corp-partner.google.com>
Subject: [PATCH v1] media: media_device_enum_links32: fix missing reserved field copy
Date:   Tue, 2 Apr 2019 18:04:04 +0800
Message-ID: <1554199444-16827-1-git-send-email-jungo.lin@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <Jungo Lin <jungo.lin@mediatek.com>
References: <Jungo Lin <jungo.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Jungo Lin <jungo.lin@mediatek.corp-partner.google.com>

In v4l2-compliance utility, test MEDIA_IOC_ENUM_ENTITIES
will check whether reserved field of media_links_enum filled
with zero. Reserved field is filled with zero in media_device_enum_links.

However, for 32 bit program, the reserved field is missing
copy from kernel space to user space in media_device_enum_links32
function.

This patch copies reserved field of media_links_enum from kernel space
to user space.

Signed-off-by: Jungo Lin <jungo.lin@mediatek.com>
---
 drivers/media/media-device.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/media-device.c b/drivers/media/media-device.c
index b8ec886..f420829 100644
--- a/drivers/media/media-device.c
+++ b/drivers/media/media-device.c
@@ -502,6 +502,7 @@ static long media_device_enum_links32(struct media_device *mdev,
 {
 	struct media_links_enum links;
 	compat_uptr_t pads_ptr, links_ptr;
+	int ret;
 
 	memset(&links, 0, sizeof(links));
 
@@ -513,7 +514,15 @@ static long media_device_enum_links32(struct media_device *mdev,
 	links.pads = compat_ptr(pads_ptr);
 	links.links = compat_ptr(links_ptr);
 
-	return media_device_enum_links(mdev, &links);
+	ret = media_device_enum_links(mdev, &links);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(ulinks->reserved, &links.reserved,
+			 sizeof(links.reserved)))
+		return -EFAULT;
+
+	return 0;
 }
 
 #define MEDIA_IOC_ENUM_LINKS32		_IOWR('|', 0x02, struct media_links_enum32)
-- 
1.9.1

