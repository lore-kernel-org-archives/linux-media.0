Return-Path: <SRS0=C6Fs=6S=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1EDC3A5A9
	for <linux-media@archiver.kernel.org>; Mon,  4 May 2020 09:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8035E206B9
	for <linux-media@archiver.kernel.org>; Mon,  4 May 2020 09:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DefwXQjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgEDJ0t (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 May 2020 05:26:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56776 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgEDJ0s (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 4 May 2020 05:26:48 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 412D211FC;
        Mon,  4 May 2020 11:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1588584404;
        bh=9NtgkeLVgWE7v9BqrI8Tx5NtA2yHZs41cJqWjcNliZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DefwXQjOtmVh6vfkS7DLbKnvfvZiAgzZtRvm4tdIEcgggTzwr3W93Qfo3lWb5zGvK
         NaE7mBAnZI69poY59J23l0P1oLOMz1NHUSr/6tthUn0fuZPn2tqmdTEIVc0FWcrZSP
         Benf1Dt/ib0zThm6c+/vC5aqE/DPXzM3462tST7o=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Naushir Patuck <naush@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v2 25/34] staging: vchiq_arm: Register vcsm-cma as a platform driver
Date:   Mon,  4 May 2020 12:26:02 +0300
Message-Id: <20200504092611.9798-26-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504092611.9798-1-laurent.pinchart@ideasonboard.com>
References: <20200504092611.9798-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Following the same pattern as bcm2835-camera and bcm2835-audio,
register the vcsm-cma driver as a platform driver

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index a1ea9777a444..c5c7af28c1c8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -107,6 +107,7 @@ static struct class  *vchiq_class;
 static DEFINE_SPINLOCK(msg_queue_spinlock);
 static struct platform_device *bcm2835_camera;
 static struct platform_device *bcm2835_audio;
+static struct platform_device *vcsm_cma;
 
 static struct vchiq_drvdata bcm2835_drvdata = {
 	.cache_line_size = 32,
@@ -2789,6 +2790,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		VCHIQ_VERSION, VCHIQ_VERSION_MIN,
 		MAJOR(vchiq_devid), MINOR(vchiq_devid));
 
+	vcsm_cma = vchiq_register_child(pdev, "vcsm-cma");
 	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
 	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
 
@@ -2804,6 +2806,7 @@ static int vchiq_probe(struct platform_device *pdev)
 static int vchiq_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(bcm2835_camera);
+	platform_device_unregister(vcsm_cma);
 	vchiq_debugfs_deinit();
 	device_destroy(vchiq_class, vchiq_devid);
 	cdev_del(&vchiq_cdev);
-- 
Regards,

Laurent Pinchart

