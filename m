Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B4CC43332
	for <linux-media@archiver.kernel.org>; Wed, 23 Dec 2020 02:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA82312E
	for <linux-media@archiver.kernel.org>; Wed, 23 Dec 2020 02:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgLWCuT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgLWCV5 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Dec 2020 21:21:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20E3323331;
        Wed, 23 Dec 2020 02:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690101;
        bh=YXIWa7XaLqGFPNM1mpvRGlffOOv+GXfX5bi9zuJMsII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDUz2H1lMlTFr+RjqsMLiVuXY0E8Sb31z155FEyqx5alBKdd2Lem8aabviqoJ+5kn
         U68XZyIKUcEZxM0iLnlwkP0BW2n7izrxnVEtpUSuarCbPwhON4ZM3bHw08mds2VtTp
         lF3J9Ro4i9xBvwdmrr9zJrIG2gPRYHaqjiJwviUfHsYGdK5oi5DfuZmhw1jpVv0Eil
         CPjyF2Db14MBUQqylI83JaUUFx43FU3mzV6DczH/AJylG/WFJe4/R/doRnaHi2NzKu
         mY6wJmH0cMat/ouGhmjFniAjTc++HxfP2ZMa8K4R9C4ztcHXveYUILHzPDL++TlRip
         QC2YI2LURdhLA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 31/87] media: dvbdev: Fix memleak in dvb_register_device
Date:   Tue, 22 Dec 2020 21:20:07 -0500
Message-Id: <20201223022103.2792705-31-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022103.2792705-1-sashal@kernel.org>
References: <20201223022103.2792705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 167faadfcf9339088910e9e85a1b711fcbbef8e9 ]

When device_create() fails, dvbdev and dvbdevfops should
be freed just like when dvb_register_media_device() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 04dc2f4bc7aaf..a652b6b1eb1fd 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -541,6 +541,9 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
+		dvb_media_device_free(dvbdev);
+		kfree(dvbdevfops);
+		kfree(dvbdev);
 		return PTR_ERR(clsdev);
 	}
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
-- 
2.27.0

