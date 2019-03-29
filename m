Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C44C4360F
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070A2218A2
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553873391;
	bh=JiVUuQVn3jKVgkFv677lYwj64kd09sEnTCjvOcT9qEI=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=HtyWeq7ODXhpHvVGxnnW1QU0BB75qyQH5nepnGNlnASyLOffyWTtFW+1XU6DnSP48
	 4AzJTqfCLUTrn5PfbDW9s4kVbTTCDfQfsMEOdQ/2jFz3HRNVf0v/U2xipLBfVDyVup
	 FqlHBTE94rywGJC93GU6CzIgn3UY7Czh9BcJ1wrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfC2P3u (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:29:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbfC2P3t (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 11:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fUByOpyFnOC/4B9wZuRfbFTUbDrHENJ/kvKFQUBAFmA=; b=XHyBlhCBWLAE3D7QXSV6D6tfv
        kRj34FRV6P6JA6gDvOI4zL5EoBdZQkMZIfO/A/YzYPpxIPLiJWgmdry6OA3B5HFBwZYh3P1YZjNmb
        Fh+IDVYnkn/foSLXXFVCrMHWK18gMi4xQYEm7iUdJ/GsNIVGx5MFsnQb6trv8m9BQPUGSePiQtIwJ
        0+89FsuygxEUdygAeFRz8DeWeyOsKbrawtyqCDKRnfWJE7ZKJnF/6iteghz/WwVecQqOHyyaAjjjM
        8zZpLPoIGi9q9SGIoU7hKYllE6vKfN/xKMXtJRKn+NSEGuLWxQ1stydS9Bw6dAqsNVQeIbLURlXTO
        xn59sehBg==;
Received: from [179.183.99.176] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9tRz-0002fU-J9; Fri, 29 Mar 2019 15:29:47 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1h9tRx-0009mh-26; Fri, 29 Mar 2019 11:29:45 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        YueHaibing <yuehaibing@huawei.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] media: staging: use strscpy() instead of strlcpy()
Date:   Fri, 29 Mar 2019 11:29:43 -0400
Message-Id: <e5ba9c47436888e9cc4c0cda6ca61ade31e703c0.1553873376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There are a few left overs at staging with were still using the
deprecated strlcpy() function.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/staging/media/imx/imx-media-dev-common.c      | 4 ++--
 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-dev-common.c b/drivers/staging/media/imx/imx-media-dev-common.c
index 910594125889..6cd93419b81d 100644
--- a/drivers/staging/media/imx/imx-media-dev-common.c
+++ b/drivers/staging/media/imx/imx-media-dev-common.c
@@ -30,7 +30,7 @@ struct imx_media_dev *imx_media_dev_init(struct device *dev)
 
 	dev_set_drvdata(dev, imxmd);
 
-	strlcpy(imxmd->md.model, "imx-media", sizeof(imxmd->md.model));
+	strscpy(imxmd->md.model, "imx-media", sizeof(imxmd->md.model));
 	imxmd->md.ops = &imx_media_md_ops;
 	imxmd->md.dev = dev;
 
@@ -38,7 +38,7 @@ struct imx_media_dev *imx_media_dev_init(struct device *dev)
 
 	imxmd->v4l2_dev.mdev = &imxmd->md;
 	imxmd->v4l2_dev.notify = imx_media_notify;
-	strlcpy(imxmd->v4l2_dev.name, "imx-media",
+	strscpy(imxmd->v4l2_dev.name, "imx-media",
 		sizeof(imxmd->v4l2_dev.name));
 
 	media_device_init(&imxmd->md);
diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
index 57611464ad07..58721c46fba4 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
@@ -462,7 +462,7 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
 	}
 
 	vpu->mdev.dev = vpu->dev;
-	strlcpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
+	strscpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
 	media_device_init(&vpu->mdev);
 	vpu->v4l2_dev.mdev = &vpu->mdev;
 
-- 
2.20.1

