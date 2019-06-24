Return-Path: <SRS0=DyX0=UX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF4C43613
	for <linux-media@archiver.kernel.org>; Mon, 24 Jun 2019 17:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B3A20657
	for <linux-media@archiver.kernel.org>; Mon, 24 Jun 2019 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561396275;
	bh=IpHd28kyJkivdcSj34MFZX6YyS0UHq0EsmRgdA6ypsA=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=Lh3cXXnhldvCE/NaNTAuJAd1kcm3F+qChfzjjmpmGo19cJBD1GCuPnw87fEGo0TuR
	 uem1aWP+j7uD59HZUd83lKV3tD7YpUgssolqD+FNqlJx2FHaUrLfXnZ2h1mmiEuayV
	 2DTTMQN6LIaV3/yT8h2NCAkzijHxH1mYG9Vs00x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfFXRLO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:11:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbfFXRLO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 Jun 2019 13:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/iTMJD57KHo/L9NbSTMb1BtaYZU9WBXTvdeVbmej5vU=; b=TNVcWyvcUS/eVggZlMEDBox0d
        aE6vB42IEaaqul3lBve9H+wY3HGx80/6y6PmaMjMT2ji9hZceNezrX9KUzgSsqNOOf3tcC4x9qFXC
        Atw9Asnu2TIpbjrM3waIEQRoBuzDHy4Yz/JG0eotHRUBnTBs2+9vL1GBCOa32fHEWuEEZ0bIcQaq9
        dCnnZ9CuWT/CqW58S8BTlELWiCnYN8UoAUSCBOevZriTTLH/WxLaYlWjs43/YAvdzZBySyj/JVn8T
        GRAY9gzMiuxSfEUqBzWhPL3waq5fETI0LhkJ2yiIA98viKZ3TZ/3hPhOWHtcqJCz73GZEWa0YoEep
        fPEIS8okw==;
Received: from 177.205.71.220.dynamic.adsl.gvt.net.br ([177.205.71.220] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfSUs-0001zc-3p; Mon, 24 Jun 2019 17:11:14 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hfSUp-00050a-7A; Mon, 24 Jun 2019 13:11:11 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] media: cafe-driver: mark an static var as such
Date:   Mon, 24 Jun 2019 13:11:10 -0400
Message-Id: <932952e525e5c8d38cf3df4a3265be5652d57c97.1561396268.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As warned by sparse:

	drivers/media/platform/marvell-ccic/cafe-driver.c:475:23:  warning: symbol 'ov7670_info' was not declared. Should it be static?

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/platform/marvell-ccic/cafe-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/marvell-ccic/cafe-driver.c b/drivers/media/platform/marvell-ccic/cafe-driver.c
index 16602628f895..37fdcc53a1c4 100644
--- a/drivers/media/platform/marvell-ccic/cafe-driver.c
+++ b/drivers/media/platform/marvell-ccic/cafe-driver.c
@@ -472,7 +472,7 @@ static struct ov7670_config sensor_cfg = {
 	.use_smbus = 1,
 };
 
-struct i2c_board_info ov7670_info = {
+static struct i2c_board_info ov7670_info = {
 	.type = "ov7670",
 	.addr = 0x42 >> 1,
 	.platform_data = &sensor_cfg,
-- 
2.21.0

