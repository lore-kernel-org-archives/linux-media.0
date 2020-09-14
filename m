Return-Path: <SRS0=4kUN=CX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A422C43461
	for <linux-media@archiver.kernel.org>; Mon, 14 Sep 2020 14:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B717F2193E
	for <linux-media@archiver.kernel.org>; Mon, 14 Sep 2020 14:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600092722;
	bh=8EzCGZb9hhJIZCxpuPsy+aIAHBckgwelp4BuBumDmLo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hraiMyXzkHSyoWQJjPIVAUehaLpxnU48Fk5awFCO1NzHXPy3k9fiG9xiNNLHl5cpG
	 g2Pfgv32EI8Ek+q//I2AbmROHi1s+RvAtd9uQjYaKVyPYt+AB1HzQ/meFQOg6udVSH
	 cbHZ1/gFX3VkJQ5z0qQto/8zh6Ls0/d+qsqfvKd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgINOLx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Sep 2020 10:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgINOLi (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Sep 2020 10:11:38 -0400
Received: from mail.kernel.org (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C5620672;
        Mon, 14 Sep 2020 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600092697;
        bh=8EzCGZb9hhJIZCxpuPsy+aIAHBckgwelp4BuBumDmLo=;
        h=From:To:Cc:Subject:Date:From;
        b=p6Fn26+mfGutJIPpAnWQVP0WOo3dbvuhye6fVXMvgB40Bg00czy3x+w5eE6WtjKgb
         17KSGFW6WoJ5mCWQAmC7rvdXPsoaTW5JHw8c7UPlpXv1Uq9nEdSm+26unrHp9hTAvI
         ZJAZg22eNBM9ggGP4juKTq04CJNwj4f6t8OpdJQY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kHpCg-004Ohw-Mw; Mon, 14 Sep 2020 16:11:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: vidtv: don't initialize cnr2qual var
Date:   Mon, 14 Sep 2020 16:11:33 +0200
Message-Id: <741043b02c2e00c8fea1a0f6f8ce43c6326cd9e8.1600092692.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As reported by gcc:

	drivers/media/test-drivers/vidtv/vidtv_demod.c: In function 'vidtv_demod_set_frontend':
	drivers/media/test-drivers/vidtv/vidtv_demod.c:265:42: warning: variable 'cnr2qual' set but not used [-Wunused-but-set-variable]
	  265 |  const struct vidtv_demod_cnr_to_qual_s *cnr2qual = NULL;
	      |                                          ^~~~~~~~

It turns that the var is not needed at all. So, just drop it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_demod.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_demod.c b/drivers/media/test-drivers/vidtv/vidtv_demod.c
index c825842758f0..2d05910bbc26 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_demod.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_demod.c
@@ -73,8 +73,7 @@ static const struct vidtv_demod_cnr_to_qual_s vidtv_demod_t_cnr_2_qual[] = {
 	{ QAM_64, FEC_7_8, 22000, 24000},
 };
 
-static const struct vidtv_demod_cnr_to_qual_s
-	     *vidtv_match_cnr_s(struct dvb_frontend *fe)
+static const struct vidtv_demod_cnr_to_qual_s *vidtv_match_cnr_s(struct dvb_frontend *fe)
 {
 	const struct vidtv_demod_cnr_to_qual_s *cnr2qual = NULL;
 	struct device *dev = fe->dvb->device;
@@ -262,7 +261,6 @@ static int vidtv_demod_get_frontend(struct dvb_frontend *fe,
 
 static int vidtv_demod_set_frontend(struct dvb_frontend *fe)
 {
-	const struct vidtv_demod_cnr_to_qual_s *cnr2qual = NULL;
 	struct vidtv_demod_state *state = fe->demodulator_priv;
 	u32 tuner_status = 0;
 	int ret;
@@ -284,7 +282,6 @@ static int vidtv_demod_set_frontend(struct dvb_frontend *fe)
 						    FE_HAS_SYNC    |
 						    FE_HAS_LOCK	 :
 						    0;
-	cnr2qual = vidtv_match_cnr_s(fe);
 
 	vidtv_demod_update_stats(fe);
 
-- 
2.26.2

