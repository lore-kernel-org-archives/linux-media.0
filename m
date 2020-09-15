Return-Path: <SRS0=a2Vr=CY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C79C433E2
	for <linux-media@archiver.kernel.org>; Tue, 15 Sep 2020 06:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4690206B2
	for <linux-media@archiver.kernel.org>; Tue, 15 Sep 2020 06:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600150293;
	bh=8EzCGZb9hhJIZCxpuPsy+aIAHBckgwelp4BuBumDmLo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G+CWm69xUtQVUfX8KRdEzM6SFCdK4AiysdL7lcaWbKWJXUQUvSHKB2m6b0rU8gKqr
	 JmKHrlqlVNFyHxtGR9vMpBzDhf4ia5wZ/cFUw/Kiu6GE/NF4dJ+GZtDHnUNScEeBrB
	 +YpI9mwPkZHNobyu0x8sS7B07uqZHTJ5Ndfn1O4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgIOGLa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 15 Sep 2020 02:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgIOGL2 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 15 Sep 2020 02:11:28 -0400
Received: from mail.kernel.org (ip5f5ad5a5.dynamic.kabel-deutschland.de [95.90.213.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB784206B2;
        Tue, 15 Sep 2020 06:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600150287;
        bh=8EzCGZb9hhJIZCxpuPsy+aIAHBckgwelp4BuBumDmLo=;
        h=From:To:Cc:Subject:Date:From;
        b=1hTJZWMz2mRGuuwhW1vGGo35+cMwXZHopJGnEfHV5PFxkw2ZvvBUn6SB6F/agDBkg
         m/pa3aochA8aDKE++22/1s+twVbMGjEeM744c/aWB5yIw0osm0Ff3mcgOJ7h/DCpih
         T7kIMLMMx/7oMc0Tz+0RhJ2nWe0jEXTUppHZo6UE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kI4BZ-004Suk-7Y; Tue, 15 Sep 2020 08:11:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: vidtv: don't initialize cnr2qual var
Date:   Tue, 15 Sep 2020 08:11:23 +0200
Message-ID: <741043b02c2e00c8fea1a0f6f8ce43c6326cd9e8.1600092692.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org
Message-ID: <20200915061123.V3cIKZlcwL45w1W-O3V_JKNZvyVFyZe-Ubvp8oy2-sc@z>

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

