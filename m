Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751A0C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D4120651
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553868160;
	bh=QvLaOvXo+f9+/S9y9uSA4jT+QhQY9C6sav+N5wmgMac=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=XSKTiZxgOZGLL5xfze9BJue34ZvEIGSFnBoBtfl6/ME3AoELMBGZ3fil6sGyC2XRw
	 X6qYsS38xob8XqUf25IFcJOIi6i6DgRgHTv5PbAENejwpw05cv9nP6SoULVKtiffXt
	 We/Sr+A1nrafXorUqoKqwuLwx5eBkzdspVRtISrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfC2OCj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:02:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfC2OCj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 10:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7IPAfp9ct1bU/dq7mb3fuUTUUOxJzmSgUsXKXjDisZA=; b=tbcLeLVdYMqMkiJwCtAo8blqR
        77JHmgZeYSjYPtsFiDaGD5987jk6McZP5f8RVa3fy0AnZQVNJDi5fvvdGGLi17KUDk9OOf7NMqTMc
        dYZKfPRdNliyxKaVHpvKcNfXWKCE+nstwhjPcLDL3Vnh6twaTClVTJuhvsfMOswuBOmLpk97hqcyV
        F85P73ExzEqrXyYirkeJ8wKaAtBTp9i9mPF1dZT4eXcb6S2c0g49RTpLEvNkuPi/x9l06JRp+HVh6
        /O9qltWXfcZsyi6h1qsnl1svTKMDA57CplrWGLXGUqdlG19PW6Sfhb+tlVZGvN/Kjkq7FQvwZM0a1
        z0uTC+VeQ==;
Received: from [179.183.99.176] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9s5b-0008UW-L7; Fri, 29 Mar 2019 14:02:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1h9s5Z-0008i4-Fg; Fri, 29 Mar 2019 10:02:33 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH v2] media: replace strncpy() by strscpy()
Date:   Fri, 29 Mar 2019 10:02:30 -0400
Message-Id: <1ba964c82b9f3353945bab7da4cb7b713fe6e3a7.1553868148.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The strncpy() function is being deprecated upstream. Replace
it by the safer strscpy().

While here, replace a few occurences of strlcpy() that were
recently added to also use strscpy().

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/dvb-frontends/as102_fe.c           |  2 +-
 drivers/media/dvb-frontends/dib7000p.c           |  3 ++-
 drivers/media/dvb-frontends/dib8000.c            |  4 ++--
 drivers/media/dvb-frontends/dib9000.c            |  6 ++++--
 drivers/media/dvb-frontends/dvb-pll.c            |  2 +-
 drivers/media/dvb-frontends/m88ds3103.c          |  2 +-
 drivers/media/pci/bt8xx/dst.c                    |  3 ++-
 drivers/media/pci/mantis/mantis_i2c.c            |  2 +-
 drivers/media/pci/saa7134/saa7134-go7007.c       |  2 +-
 drivers/media/platform/am437x/am437x-vpfe.c      |  2 +-
 drivers/media/platform/davinci/vpfe_capture.c    |  2 +-
 drivers/media/platform/davinci/vpif_capture.c    |  3 ++-
 drivers/media/platform/davinci/vpif_display.c    |  4 ++--
 drivers/media/platform/exynos4-is/fimc-capture.c |  2 +-
 drivers/media/platform/exynos4-is/fimc-m2m.c     |  2 +-
 drivers/media/platform/imx-pxp.c                 |  4 ++--
 drivers/media/platform/mtk-vpu/mtk_vpu.c         |  2 +-
 drivers/media/platform/mx2_emmaprp.c             |  4 ++--
 drivers/media/platform/s5p-g2d/g2d.c             |  6 +++---
 .../media/platform/sunxi/sun6i-csi/sun6i_video.c |  4 ++--
 drivers/media/platform/ti-vpe/vpe.c              |  6 +++---
 drivers/media/platform/vicodec/vicodec-core.c    |  4 ++--
 drivers/media/platform/vim2m.c                   |  4 ++--
 drivers/media/platform/vivid/vivid-core.c        |  2 +-
 drivers/media/radio/si4713/si4713.c              |  2 +-
 drivers/media/usb/go7007/go7007-usb.c            | 16 ++++++++--------
 drivers/media/usb/go7007/go7007-v4l2.c           |  2 +-
 drivers/media/usb/hdpvr/hdpvr-video.c            | 10 ++++------
 drivers/media/usb/pulse8-cec/pulse8-cec.c        |  4 ++--
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c          |  4 ++--
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c         |  4 ++--
 drivers/staging/media/bcm2048/radio-bcm2048.c    |  4 ++--
 drivers/staging/media/imx/imx-ic-common.c        |  2 +-
 drivers/staging/media/imx/imx-media-vdic.c       |  2 +-
 drivers/staging/media/zoran/zoran_driver.c       | 10 +++++-----
 35 files changed, 70 insertions(+), 67 deletions(-)

diff --git a/drivers/media/dvb-frontends/as102_fe.c b/drivers/media/dvb-frontends/as102_fe.c
index f59a102b0a64..9ba8f39fe310 100644
--- a/drivers/media/dvb-frontends/as102_fe.c
+++ b/drivers/media/dvb-frontends/as102_fe.c
@@ -467,7 +467,7 @@ struct dvb_frontend *as102_attach(const char *name,
 
 	/* init frontend callback ops */
 	memcpy(&fe->ops, &as102_fe_ops, sizeof(struct dvb_frontend_ops));
-	strncpy(fe->ops.info.name, name, sizeof(fe->ops.info.name));
+	strscpy(fe->ops.info.name, name, sizeof(fe->ops.info.name));
 
 	return fe;
 
diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index f8040f6def62..d869029ca87d 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -2774,7 +2774,8 @@ static struct dvb_frontend *dib7000p_init(struct i2c_adapter *i2c_adap, u8 i2c_a
 	dibx000_init_i2c_master(&st->i2c_master, DIB7000P, st->i2c_adap, st->i2c_addr);
 
 	/* init 7090 tuner adapter */
-	strncpy(st->dib7090_tuner_adap.name, "DiB7090 tuner interface", sizeof(st->dib7090_tuner_adap.name));
+	strscpy(st->dib7090_tuner_adap.name, "DiB7090 tuner interface",
+		sizeof(st->dib7090_tuner_adap.name));
 	st->dib7090_tuner_adap.algo = &dib7090_tuner_xfer_algo;
 	st->dib7090_tuner_adap.algo_data = NULL;
 	st->dib7090_tuner_adap.dev.parent = st->i2c_adap->dev.parent;
diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index 85c429cce23e..564669338dc6 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -4458,8 +4458,8 @@ static struct dvb_frontend *dib8000_init(struct i2c_adapter *i2c_adap, u8 i2c_ad
 	dibx000_init_i2c_master(&state->i2c_master, DIB8000, state->i2c.adap, state->i2c.addr);
 
 	/* init 8096p tuner adapter */
-	strncpy(state->dib8096p_tuner_adap.name, "DiB8096P tuner interface",
-			sizeof(state->dib8096p_tuner_adap.name));
+	strscpy(state->dib8096p_tuner_adap.name, "DiB8096P tuner interface",
+		sizeof(state->dib8096p_tuner_adap.name));
 	state->dib8096p_tuner_adap.algo = &dib8096p_tuner_xfer_algo;
 	state->dib8096p_tuner_adap.algo_data = NULL;
 	state->dib8096p_tuner_adap.dev.parent = state->i2c.adap->dev.parent;
diff --git a/drivers/media/dvb-frontends/dib9000.c b/drivers/media/dvb-frontends/dib9000.c
index 1875da07c150..e7838926e6bc 100644
--- a/drivers/media/dvb-frontends/dib9000.c
+++ b/drivers/media/dvb-frontends/dib9000.c
@@ -2521,7 +2521,8 @@ struct dvb_frontend *dib9000_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr, c
 	dibx000_init_i2c_master(&st->i2c_master, DIB7000MC, st->i2c.i2c_adap, st->i2c.i2c_addr);
 
 	st->tuner_adap.dev.parent = i2c_adap->dev.parent;
-	strncpy(st->tuner_adap.name, "DIB9000_FW TUNER ACCESS", sizeof(st->tuner_adap.name));
+	strscpy(st->tuner_adap.name, "DIB9000_FW TUNER ACCESS",
+		sizeof(st->tuner_adap.name));
 	st->tuner_adap.algo = &dib9000_tuner_algo;
 	st->tuner_adap.algo_data = NULL;
 	i2c_set_adapdata(&st->tuner_adap, st);
@@ -2529,7 +2530,8 @@ struct dvb_frontend *dib9000_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr, c
 		goto error;
 
 	st->component_bus.dev.parent = i2c_adap->dev.parent;
-	strncpy(st->component_bus.name, "DIB9000_FW COMPONENT BUS ACCESS", sizeof(st->component_bus.name));
+	strscpy(st->component_bus.name, "DIB9000_FW COMPONENT BUS ACCESS",
+		sizeof(st->component_bus.name));
 	st->component_bus.algo = &dib9000_component_bus_algo;
 	st->component_bus.algo_data = NULL;
 	st->component_bus_speed = 340;
diff --git a/drivers/media/dvb-frontends/dvb-pll.c b/drivers/media/dvb-frontends/dvb-pll.c
index 29836c1a40e9..da1b48a18515 100644
--- a/drivers/media/dvb-frontends/dvb-pll.c
+++ b/drivers/media/dvb-frontends/dvb-pll.c
@@ -839,7 +839,7 @@ struct dvb_frontend *dvb_pll_attach(struct dvb_frontend *fe, int pll_addr,
 	memcpy(&fe->ops.tuner_ops, &dvb_pll_tuner_ops,
 	       sizeof(struct dvb_tuner_ops));
 
-	strncpy(fe->ops.tuner_ops.info.name, desc->name,
+	strscpy(fe->ops.tuner_ops.info.name, desc->name,
 		sizeof(fe->ops.tuner_ops.info.name));
 
 	fe->ops.tuner_ops.info.frequency_min_hz = desc->min;
diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index 403f42806455..b543e1c4c4f9 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -1469,7 +1469,7 @@ static int m88ds3103_probe(struct i2c_client *client,
 	/* create dvb_frontend */
 	memcpy(&dev->fe.ops, &m88ds3103_ops, sizeof(struct dvb_frontend_ops));
 	if (dev->chip_id == M88RS6000_CHIP_ID)
-		strncpy(dev->fe.ops.info.name, "Montage Technology M88RS6000",
+		strscpy(dev->fe.ops.info.name, "Montage Technology M88RS6000",
 			sizeof(dev->fe.ops.info.name));
 	if (!pdata->attach_in_use)
 		dev->fe.ops.release = NULL;
diff --git a/drivers/media/pci/bt8xx/dst.c b/drivers/media/pci/bt8xx/dst.c
index c94318c71a0c..3315a6d67edf 100644
--- a/drivers/media/pci/bt8xx/dst.c
+++ b/drivers/media/pci/bt8xx/dst.c
@@ -1100,7 +1100,8 @@ static int dst_get_device_id(struct dst_state *state)
 			/*	Card capabilities	*/
 			state->dst_hw_cap = p_dst_type->dst_feature;
 			pr_err("Recognise [%s]\n", p_dst_type->device_id);
-			strncpy(&state->fw_name[0], p_dst_type->device_id, 6);
+			strscpy((char *)state->fw_name, p_dst_type->device_id,
+				sizeof(state->fw_name));
 			/*	Multiple tuners		*/
 			if (p_dst_type->tuner_type & TUNER_TYPE_MULTI) {
 				switch (use_dst_type) {
diff --git a/drivers/media/pci/mantis/mantis_i2c.c b/drivers/media/pci/mantis/mantis_i2c.c
index 6528a2180119..f8b503ef42bc 100644
--- a/drivers/media/pci/mantis/mantis_i2c.c
+++ b/drivers/media/pci/mantis/mantis_i2c.c
@@ -225,7 +225,7 @@ int mantis_i2c_init(struct mantis_pci *mantis)
 
 	init_waitqueue_head(&mantis->i2c_wq);
 	mutex_init(&mantis->i2c_lock);
-	strncpy(i2c_adapter->name, "Mantis I2C", sizeof(i2c_adapter->name));
+	strscpy(i2c_adapter->name, "Mantis I2C", sizeof(i2c_adapter->name));
 	i2c_set_adapdata(i2c_adapter, mantis);
 
 	i2c_adapter->owner	= THIS_MODULE;
diff --git a/drivers/media/pci/saa7134/saa7134-go7007.c b/drivers/media/pci/saa7134/saa7134-go7007.c
index 275c5e151818..626e130a9770 100644
--- a/drivers/media/pci/saa7134/saa7134-go7007.c
+++ b/drivers/media/pci/saa7134/saa7134-go7007.c
@@ -444,7 +444,7 @@ static int saa7134_go7007_init(struct saa7134_dev *dev)
 	sd = &saa->sd;
 	v4l2_subdev_init(sd, &saa7134_go7007_sd_ops);
 	v4l2_set_subdevdata(sd, saa);
-	strncpy(sd->name, "saa7134-go7007", sizeof(sd->name));
+	strscpy(sd->name, "saa7134-go7007", sizeof(sd->name));
 
 	/* Allocate a couple pages for receiving the compressed stream */
 	saa->top = (u8 *)get_zeroed_page(GFP_KERNEL);
diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
index 5c17624aaade..fe7b937eb5f2 100644
--- a/drivers/media/platform/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/am437x/am437x-vpfe.c
@@ -1540,7 +1540,7 @@ static int vpfe_enum_fmt(struct file *file, void  *priv,
 	if (!fmt)
 		return -EINVAL;
 
-	strncpy(f->description, fmt->name, sizeof(f->description) - 1);
+	strscpy(f->description, fmt->name, sizeof(f->description));
 	f->pixelformat = fmt->fourcc;
 	f->type = vpfe->fmt.type;
 
diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
index 26dadbba930f..1e3a13830544 100644
--- a/drivers/media/platform/davinci/vpfe_capture.c
+++ b/drivers/media/platform/davinci/vpfe_capture.c
@@ -1759,7 +1759,7 @@ static int vpfe_probe(struct platform_device *pdev)
 
 	mutex_lock(&ccdc_lock);
 
-	strncpy(ccdc_cfg->name, vpfe_cfg->ccdc, 32);
+	strscpy(ccdc_cfg->name, vpfe_cfg->ccdc, sizeof(ccdc_cfg->name));
 	/* Get VINT0 irq resource */
 	res1 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res1) {
diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index 6216b7ac6875..b5aacb0fb96b 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1254,7 +1254,8 @@ static int vpif_s_dv_timings(struct file *file, void *priv,
 	} else {
 		std_info->l5 = std_info->vsize - (bt->vfrontporch - 1);
 	}
-	strncpy(std_info->name, "Custom timings BT656/1120", VPIF_MAX_NAME);
+	strscpy(std_info->name, "Custom timings BT656/1120",
+		sizeof(std_info->name));
 	std_info->width = bt->width;
 	std_info->height = bt->height;
 	std_info->frm_fmt = bt->interlaced ? 0 : 1;
diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
index f4b4f2a1dfc0..a69897c68a50 100644
--- a/drivers/media/platform/davinci/vpif_display.c
+++ b/drivers/media/platform/davinci/vpif_display.c
@@ -987,8 +987,8 @@ static int vpif_s_dv_timings(struct file *file, void *priv,
 	} else {
 		std_info->l5 = std_info->vsize - (bt->vfrontporch - 1);
 	}
-	strncpy(std_info->name, "Custom timings BT656/1120",
-			VPIF_MAX_NAME);
+	strscpy(std_info->name, "Custom timings BT656/1120",
+		sizeof(std_info->name));
 	std_info->width = bt->width;
 	std_info->height = bt->height;
 	std_info->frm_fmt = bt->interlaced ? 0 : 1;
diff --git a/drivers/media/platform/exynos4-is/fimc-capture.c b/drivers/media/platform/exynos4-is/fimc-capture.c
index 3e9fcf4f8a13..de4af0357a3c 100644
--- a/drivers/media/platform/exynos4-is/fimc-capture.c
+++ b/drivers/media/platform/exynos4-is/fimc-capture.c
@@ -742,7 +742,7 @@ static int fimc_cap_enum_fmt_mplane(struct file *file, void *priv,
 			       f->index);
 	if (!fmt)
 		return -EINVAL;
-	strncpy(f->description, fmt->name, sizeof(f->description) - 1);
+	strscpy(f->description, fmt->name, sizeof(f->description));
 	f->pixelformat = fmt->fourcc;
 	if (fmt->fourcc == MEDIA_BUS_FMT_JPEG_1X8)
 		f->flags |= V4L2_FMT_FLAG_COMPRESSED;
diff --git a/drivers/media/platform/exynos4-is/fimc-m2m.c b/drivers/media/platform/exynos4-is/fimc-m2m.c
index 61c8177409cf..1bea1ce4091e 100644
--- a/drivers/media/platform/exynos4-is/fimc-m2m.c
+++ b/drivers/media/platform/exynos4-is/fimc-m2m.c
@@ -252,7 +252,7 @@ static int fimc_m2m_enum_fmt_mplane(struct file *file, void *priv,
 	if (!fmt)
 		return -EINVAL;
 
-	strncpy(f->description, fmt->name, sizeof(f->description) - 1);
+	strscpy(f->description, fmt->name, sizeof(f->description));
 	f->pixelformat = fmt->fourcc;
 	return 0;
 }
diff --git a/drivers/media/platform/imx-pxp.c b/drivers/media/platform/imx-pxp.c
index 0bcfc5aa8f3d..8e7ef23b9a7e 100644
--- a/drivers/media/platform/imx-pxp.c
+++ b/drivers/media/platform/imx-pxp.c
@@ -1025,8 +1025,8 @@ static irqreturn_t pxp_irq_handler(int irq, void *dev_id)
 static int pxp_querycap(struct file *file, void *priv,
 			   struct v4l2_capability *cap)
 {
-	strlcpy(cap->driver, MEM2MEM_NAME, sizeof(cap->driver));
-	strlcpy(cap->card, MEM2MEM_NAME, sizeof(cap->card));
+	strscpy(cap->driver, MEM2MEM_NAME, sizeof(cap->driver));
+	strscpy(cap->card, MEM2MEM_NAME, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info),
 			"platform:%s", MEM2MEM_NAME);
 	return 0;
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index b6602490a247..46c45f93c977 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -614,7 +614,7 @@ static void vpu_init_ipi_handler(void *data, unsigned int len, void *priv)
 	struct vpu_run *run = (struct vpu_run *)data;
 
 	vpu->run.signaled = run->signaled;
-	strncpy(vpu->run.fw_ver, run->fw_ver, VPU_FW_VER_LEN);
+	strscpy(vpu->run.fw_ver, run->fw_ver, sizeof(vpu->run.fw_ver));
 	vpu->run.dec_capability = run->dec_capability;
 	vpu->run.enc_capability = run->enc_capability;
 	wake_up_interruptible(&vpu->run.wq);
diff --git a/drivers/media/platform/mx2_emmaprp.c b/drivers/media/platform/mx2_emmaprp.c
index f60f499c596b..e100b30bb6f5 100644
--- a/drivers/media/platform/mx2_emmaprp.c
+++ b/drivers/media/platform/mx2_emmaprp.c
@@ -385,8 +385,8 @@ static irqreturn_t emmaprp_irq(int irq_emma, void *data)
 static int vidioc_querycap(struct file *file, void *priv,
 			   struct v4l2_capability *cap)
 {
-	strncpy(cap->driver, MEM2MEM_NAME, sizeof(cap->driver) - 1);
-	strncpy(cap->card, MEM2MEM_NAME, sizeof(cap->card) - 1);
+	strscpy(cap->driver, MEM2MEM_NAME, sizeof(cap->driver));
+	strscpy(cap->card, MEM2MEM_NAME, sizeof(cap->card));
 	cap->device_caps = V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING;
 	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
 	return 0;
diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/s5p-g2d/g2d.c
index 971c47165010..c8f394e1aff4 100644
--- a/drivers/media/platform/s5p-g2d/g2d.c
+++ b/drivers/media/platform/s5p-g2d/g2d.c
@@ -297,8 +297,8 @@ static int g2d_release(struct file *file)
 static int vidioc_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
-	strncpy(cap->driver, G2D_NAME, sizeof(cap->driver) - 1);
-	strncpy(cap->card, G2D_NAME, sizeof(cap->card) - 1);
+	strscpy(cap->driver, G2D_NAME, sizeof(cap->driver));
+	strscpy(cap->card, G2D_NAME, sizeof(cap->card));
 	cap->bus_info[0] = 0;
 	cap->device_caps = V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING;
 	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
@@ -312,7 +312,7 @@ static int vidioc_enum_fmt(struct file *file, void *prv, struct v4l2_fmtdesc *f)
 		return -EINVAL;
 	fmt = &formats[f->index];
 	f->pixelformat = fmt->fourcc;
-	strncpy(f->description, fmt->name, sizeof(f->description) - 1);
+	strscpy(f->description, fmt->name, sizeof(f->description));
 	return 0;
 }
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 1fd16861f111..f0dfe68486d1 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -412,7 +412,7 @@ static int vidioc_enum_input(struct file *file, void *fh,
 	if (inp->index != 0)
 		return -EINVAL;
 
-	strlcpy(inp->name, "camera", sizeof(inp->name));
+	strscpy(inp->name, "camera", sizeof(inp->name));
 	inp->type = V4L2_INPUT_TYPE_CAMERA;
 
 	return 0;
@@ -644,7 +644,7 @@ int sun6i_video_init(struct sun6i_video *video, struct sun6i_csi *csi,
 	}
 
 	/* Register video device */
-	strlcpy(vdev->name, name, sizeof(vdev->name));
+	strscpy(vdev->name, name, sizeof(vdev->name));
 	vdev->release		= video_device_release_empty;
 	vdev->fops		= &sun6i_video_fops;
 	vdev->ioctl_ops		= &sun6i_video_ioctl_ops;
diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index 207e7e76c048..1e40eafec284 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -1491,8 +1491,8 @@ static irqreturn_t vpe_irq(int irq_vpe, void *data)
 static int vpe_querycap(struct file *file, void *priv,
 			struct v4l2_capability *cap)
 {
-	strncpy(cap->driver, VPE_MODULE_NAME, sizeof(cap->driver) - 1);
-	strncpy(cap->card, VPE_MODULE_NAME, sizeof(cap->card) - 1);
+	strscpy(cap->driver, VPE_MODULE_NAME, sizeof(cap->driver));
+	strscpy(cap->card, VPE_MODULE_NAME, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
 		VPE_MODULE_NAME);
 	cap->device_caps  = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
@@ -1519,7 +1519,7 @@ static int __enum_fmt(struct v4l2_fmtdesc *f, u32 type)
 	if (!fmt)
 		return -EINVAL;
 
-	strncpy(f->description, fmt->name, sizeof(f->description) - 1);
+	strscpy(f->description, fmt->name, sizeof(f->description));
 	f->pixelformat = fmt->fourcc;
 	return 0;
 }
diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index a5f8f74ea3bf..bd01a9206aa6 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -692,8 +692,8 @@ static const struct v4l2_fwht_pixfmt_info *find_fmt(u32 fmt)
 static int vidioc_querycap(struct file *file, void *priv,
 			   struct v4l2_capability *cap)
 {
-	strncpy(cap->driver, VICODEC_NAME, sizeof(cap->driver) - 1);
-	strncpy(cap->card, VICODEC_NAME, sizeof(cap->card) - 1);
+	strscpy(cap->driver, VICODEC_NAME, sizeof(cap->driver));
+	strscpy(cap->card, VICODEC_NAME, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info),
 			"platform:%s", VICODEC_NAME);
 	return 0;
diff --git a/drivers/media/platform/vim2m.c b/drivers/media/platform/vim2m.c
index d8763a8a7be6..243c82b5d537 100644
--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@ -659,8 +659,8 @@ static void device_work(struct work_struct *w)
 static int vidioc_querycap(struct file *file, void *priv,
 			   struct v4l2_capability *cap)
 {
-	strncpy(cap->driver, MEM2MEM_NAME, sizeof(cap->driver) - 1);
-	strncpy(cap->card, MEM2MEM_NAME, sizeof(cap->card) - 1);
+	strscpy(cap->driver, MEM2MEM_NAME, sizeof(cap->driver));
+	strscpy(cap->card, MEM2MEM_NAME, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info),
 		 "platform:%s", MEM2MEM_NAME);
 	return 0;
diff --git a/drivers/media/platform/vivid/vivid-core.c b/drivers/media/platform/vivid/vivid-core.c
index 342e0e6c103b..7047df6f0e0e 100644
--- a/drivers/media/platform/vivid/vivid-core.c
+++ b/drivers/media/platform/vivid/vivid-core.c
@@ -681,7 +681,7 @@ static int vivid_create_instance(struct platform_device *pdev, int inst)
 	dev->v4l2_dev.mdev = &dev->mdev;
 
 	/* Initialize media device */
-	strlcpy(dev->mdev.model, VIVID_MODULE_NAME, sizeof(dev->mdev.model));
+	strscpy(dev->mdev.model, VIVID_MODULE_NAME, sizeof(dev->mdev.model));
 	snprintf(dev->mdev.bus_info, sizeof(dev->mdev.bus_info),
 		 "platform:%s-%03d", VIVID_MODULE_NAME, inst);
 	dev->mdev.dev = &pdev->dev;
diff --git a/drivers/media/radio/si4713/si4713.c b/drivers/media/radio/si4713/si4713.c
index f4a53f1e856e..a8584371a32d 100644
--- a/drivers/media/radio/si4713/si4713.c
+++ b/drivers/media/radio/si4713/si4713.c
@@ -1272,7 +1272,7 @@ static int si4713_g_modulator(struct v4l2_subdev *sd, struct v4l2_modulator *vm)
 	if (vm->index > 0)
 		return -EINVAL;
 
-	strncpy(vm->name, "FM Modulator", 32);
+	strscpy(vm->name, "FM Modulator", sizeof(vm->name));
 	vm->capability = V4L2_TUNER_CAP_STEREO | V4L2_TUNER_CAP_LOW |
 		V4L2_TUNER_CAP_RDS | V4L2_TUNER_CAP_RDS_CONTROLS;
 
diff --git a/drivers/media/usb/go7007/go7007-usb.c b/drivers/media/usb/go7007/go7007-usb.c
index 19c6a0354ce0..abe98488be23 100644
--- a/drivers/media/usb/go7007/go7007-usb.c
+++ b/drivers/media/usb/go7007/go7007-usb.c
@@ -1132,7 +1132,7 @@ static int go7007_usb_probe(struct usb_interface *intf,
 	usb->usbdev = usbdev;
 	usb_make_path(usbdev, go->bus_info, sizeof(go->bus_info));
 	go->board_id = id->driver_info;
-	strncpy(go->name, name, sizeof(go->name));
+	strscpy(go->name, name, sizeof(go->name));
 	if (board->flags & GO7007_USB_EZUSB)
 		go->hpi_ops = &go7007_usb_ezusb_hpi_ops;
 	else
@@ -1198,7 +1198,7 @@ static int go7007_usb_probe(struct usb_interface *intf,
 				go->board_id = GO7007_BOARDID_ENDURA;
 				usb->board = board = &board_endura;
 				go->board_info = &board->main_info;
-				strncpy(go->name, "Pelco Endura",
+				strscpy(go->name, "Pelco Endura",
 					sizeof(go->name));
 			} else {
 				u16 channel;
@@ -1232,21 +1232,21 @@ static int go7007_usb_probe(struct usb_interface *intf,
 		case 1:
 			go->tuner_type = TUNER_SONY_BTF_PG472Z;
 			go->std = V4L2_STD_PAL;
-			strncpy(go->name, "Plextor PX-TV402U-EU",
-					sizeof(go->name));
+			strscpy(go->name, "Plextor PX-TV402U-EU",
+				sizeof(go->name));
 			break;
 		case 2:
 			go->tuner_type = TUNER_SONY_BTF_PK467Z;
 			go->std = V4L2_STD_NTSC_M_JP;
 			num_i2c_devs -= 2;
-			strncpy(go->name, "Plextor PX-TV402U-JP",
-					sizeof(go->name));
+			strscpy(go->name, "Plextor PX-TV402U-JP",
+				sizeof(go->name));
 			break;
 		case 3:
 			go->tuner_type = TUNER_SONY_BTF_PB463Z;
 			num_i2c_devs -= 2;
-			strncpy(go->name, "Plextor PX-TV402U-NA",
-					sizeof(go->name));
+			strscpy(go->name, "Plextor PX-TV402U-NA",
+				sizeof(go->name));
 			break;
 		default:
 			pr_debug("unable to detect tuner type!\n");
diff --git a/drivers/media/usb/go7007/go7007-v4l2.c b/drivers/media/usb/go7007/go7007-v4l2.c
index 7a2781fa83e7..bebdfcecf600 100644
--- a/drivers/media/usb/go7007/go7007-v4l2.c
+++ b/drivers/media/usb/go7007/go7007-v4l2.c
@@ -327,7 +327,7 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void  *priv,
 	fmt->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	fmt->flags = V4L2_FMT_FLAG_COMPRESSED;
 
-	strncpy(fmt->description, desc, sizeof(fmt->description));
+	strscpy(fmt->description, desc, sizeof(fmt->description));
 
 	return 0;
 }
diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index e082086428a4..3804aa3fb50f 100644
--- a/drivers/media/usb/hdpvr/hdpvr-video.c
+++ b/drivers/media/usb/hdpvr/hdpvr-video.c
@@ -769,8 +769,7 @@ static int vidioc_enum_input(struct file *file, void *_fh, struct v4l2_input *i)
 
 	i->type = V4L2_INPUT_TYPE_CAMERA;
 
-	strncpy(i->name, iname[n], sizeof(i->name) - 1);
-	i->name[sizeof(i->name) - 1] = '\0';
+	strscpy(i->name, iname[n], sizeof(i->name));
 
 	i->audioset = 1<<HDPVR_RCA_FRONT | 1<<HDPVR_RCA_BACK | 1<<HDPVR_SPDIF;
 
@@ -841,8 +840,7 @@ static int vidioc_enumaudio(struct file *file, void *priv,
 
 	audio->capability = V4L2_AUDCAP_STEREO;
 
-	strncpy(audio->name, audio_iname[n], sizeof(audio->name) - 1);
-	audio->name[sizeof(audio->name) - 1] = '\0';
+	strscpy(audio->name, audio_iname[n], sizeof(audio->name));
 
 	return 0;
 }
@@ -874,7 +872,6 @@ static int vidioc_g_audio(struct file *file, void *private_data,
 	audio->index = dev->options.audio_input;
 	audio->capability = V4L2_AUDCAP_STEREO;
 	strscpy(audio->name, audio_iname[audio->index], sizeof(audio->name));
-	audio->name[sizeof(audio->name) - 1] = '\0';
 	return 0;
 }
 
@@ -991,7 +988,8 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void *private_data,
 		return -EINVAL;
 
 	f->flags = V4L2_FMT_FLAG_COMPRESSED;
-	strncpy(f->description, "MPEG2-TS with AVC/AAC streams", 32);
+	strscpy(f->description, "MPEG2-TS with AVC/AAC streams",
+		sizeof(f->description));
 	f->pixelformat = V4L2_PIX_FMT_MPEG;
 
 	return 0;
diff --git a/drivers/media/usb/pulse8-cec/pulse8-cec.c b/drivers/media/usb/pulse8-cec/pulse8-cec.c
index b085b14f3f87..ea9ee74fa336 100644
--- a/drivers/media/usb/pulse8-cec/pulse8-cec.c
+++ b/drivers/media/usb/pulse8-cec/pulse8-cec.c
@@ -435,7 +435,7 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
 	err = pulse8_send_and_wait(pulse8, cmd, 1, cmd[0], 0);
 	if (err)
 		return err;
-	strncpy(log_addrs->osd_name, data, 13);
+	strscpy(log_addrs->osd_name, data, sizeof(log_addrs->osd_name));
 	dev_dbg(pulse8->dev, "OSD name: %s\n", log_addrs->osd_name);
 
 	return 0;
@@ -566,7 +566,7 @@ static int pulse8_cec_adap_log_addr(struct cec_adapter *adap, u8 log_addr)
 		char *osd_str = cmd + 1;
 
 		cmd[0] = MSGCODE_SET_OSD_NAME;
-		strncpy(cmd + 1, adap->log_addrs.osd_name, 13);
+		strscpy(cmd + 1, adap->log_addrs.osd_name, sizeof(cmd) - 1);
 		if (osd_len < 4) {
 			memset(osd_str + osd_len, ' ', 4 - osd_len);
 			osd_len = 4;
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 446a999dd2ce..bea28f589210 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -2459,8 +2459,8 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
 		if (!(qctrl.flags & V4L2_CTRL_FLAG_READ_ONLY)) {
 			ciptr->set_value = ctrl_cx2341x_set;
 		}
-		strncpy(hdw->mpeg_ctrl_info[idx].desc,qctrl.name,
-			PVR2_CTLD_INFO_DESC_SIZE);
+		strscpy(hdw->mpeg_ctrl_info[idx].desc, qctrl.name,
+			sizeof(hdw->mpeg_ctrl_info[idx].desc));
 		hdw->mpeg_ctrl_info[idx].desc[PVR2_CTLD_INFO_DESC_SIZE-1] = 0;
 		ciptr->default_value = qctrl.default_value;
 		switch (qctrl.type) {
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index 08d5b7aa3537..cb6668580d77 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -284,7 +284,7 @@ static int pvr2_enumaudio(struct file *file, void *priv, struct v4l2_audio *vin)
 
 	if (vin->index > 0)
 		return -EINVAL;
-	strncpy(vin->name, "PVRUSB2 Audio", 14);
+	strscpy(vin->name, "PVRUSB2 Audio", sizeof(vin->name));
 	vin->capability = V4L2_AUDCAP_STEREO;
 	return 0;
 }
@@ -293,7 +293,7 @@ static int pvr2_g_audio(struct file *file, void *priv, struct v4l2_audio *vin)
 {
 	/* pkt: FIXME: see above comment (VIDIOC_ENUMAUDIO) */
 	vin->index = 0;
-	strncpy(vin->name, "PVRUSB2 Audio", 14);
+	strscpy(vin->name, "PVRUSB2 Audio", sizeof(vin->name));
 	vin->capability = V4L2_AUDCAP_STEREO;
 	return 0;
 }
diff --git a/drivers/staging/media/bcm2048/radio-bcm2048.c b/drivers/staging/media/bcm2048/radio-bcm2048.c
index d9b02ff66259..09903ffb13ba 100644
--- a/drivers/staging/media/bcm2048/radio-bcm2048.c
+++ b/drivers/staging/media/bcm2048/radio-bcm2048.c
@@ -2404,7 +2404,7 @@ static int bcm2048_vidioc_g_audio(struct file *file, void *priv,
 	if (audio->index > 1)
 		return -EINVAL;
 
-	strncpy(audio->name, "Radio", 32);
+	strscpy(audio->name, "Radio", sizeof(audio->name));
 	audio->capability = V4L2_AUDCAP_STEREO;
 
 	return 0;
@@ -2432,7 +2432,7 @@ static int bcm2048_vidioc_g_tuner(struct file *file, void *priv,
 	if (tuner->index > 0)
 		return -EINVAL;
 
-	strncpy(tuner->name, "FM Receiver", 32);
+	strscpy(tuner->name, "FM Receiver", sizeof(tuner->name));
 	tuner->type = V4L2_TUNER_RADIO;
 	tuner->rangelow =
 		dev_to_v4l2(bcm2048_get_region_bottom_frequency(bdev));
diff --git a/drivers/staging/media/imx/imx-ic-common.c b/drivers/staging/media/imx/imx-ic-common.c
index 90a926891eb9..1addb0893c57 100644
--- a/drivers/staging/media/imx/imx-ic-common.c
+++ b/drivers/staging/media/imx/imx-ic-common.c
@@ -63,7 +63,7 @@ static int imx_ic_probe(struct platform_device *pdev)
 	priv->sd.owner = THIS_MODULE;
 	priv->sd.flags = V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
 	priv->sd.grp_id = pdata->grp_id;
-	strncpy(priv->sd.name, pdata->sd_name, sizeof(priv->sd.name));
+	strscpy(priv->sd.name, pdata->sd_name, sizeof(priv->sd.name));
 
 	ret = ic_ops[priv->task_id]->init(priv);
 	if (ret)
diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
index f8c84a07dad9..5439b88dba20 100644
--- a/drivers/staging/media/imx/imx-media-vdic.c
+++ b/drivers/staging/media/imx/imx-media-vdic.c
@@ -964,7 +964,7 @@ static int imx_vdic_probe(struct platform_device *pdev)
 	priv->sd.flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
 	/* get our group id */
 	priv->sd.grp_id = pdata->grp_id;
-	strncpy(priv->sd.name, pdata->sd_name, sizeof(priv->sd.name));
+	strscpy(priv->sd.name, pdata->sd_name, sizeof(priv->sd.name));
 
 	mutex_init(&priv->lock);
 
diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 04f88f9d6bb4..c998aa4dc73b 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -1526,8 +1526,8 @@ static int zoran_enum_fmt(struct zoran *zr, struct v4l2_fmtdesc *fmt, int flag)
 
 	for (num = i = 0; i < NUM_FORMATS; i++) {
 		if (zoran_formats[i].flags & flag && num++ == fmt->index) {
-			strncpy(fmt->description, zoran_formats[i].name,
-				sizeof(fmt->description) - 1);
+			strscpy(fmt->description, zoran_formats[i].name,
+				sizeof(fmt->description));
 			/* fmt struct pre-zeroed, so adding '\0' not needed */
 			fmt->pixelformat = zoran_formats[i].fourcc;
 			if (zoran_formats[i].flags & ZORAN_FORMAT_COMPRESSED)
@@ -2301,8 +2301,8 @@ static int zoran_enum_input(struct file *file, void *__fh,
 	if (inp->index >= zr->card.inputs)
 		return -EINVAL;
 
-	strncpy(inp->name, zr->card.input[inp->index].name,
-		sizeof(inp->name) - 1);
+	strscpy(inp->name, zr->card.input[inp->index].name,
+		sizeof(inp->name));
 	inp->type = V4L2_INPUT_TYPE_CAMERA;
 	inp->std = V4L2_STD_ALL;
 
@@ -2344,7 +2344,7 @@ static int zoran_enum_output(struct file *file, void *__fh,
 
 	outp->index = 0;
 	outp->type = V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY;
-	strncpy(outp->name, "Autodetect", sizeof(outp->name)-1);
+	strscpy(outp->name, "Autodetect", sizeof(outp->name));
 
 	return 0;
 }
-- 
2.20.1

