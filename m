Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD83C4332B
	for <linux-media@archiver.kernel.org>; Wed, 23 Dec 2020 11:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780AC222F9
	for <linux-media@archiver.kernel.org>; Wed, 23 Dec 2020 11:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgLWLH5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Dec 2020 06:07:57 -0500
Received: from mailoutvs35.siol.net ([185.57.226.226]:43256 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728611AbgLWLH4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Dec 2020 06:07:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 2599A5223E4;
        Wed, 23 Dec 2020 12:07:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gHen5p7CaN0H; Wed, 23 Dec 2020 12:07:13 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id CE31452248C;
        Wed, 23 Dec 2020 12:07:13 +0100 (CET)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 7D6145224CF;
        Wed, 23 Dec 2020 12:07:11 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        hans.verkuil@cisco.com, nicolas.dufresne@collabora.com,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-sunxi@googlegroups.com,
        Andre Heider <a.heider@gmail.com>
Subject: [PATCH 2/2] media: cedrus: Fix H264 decoding
Date:   Wed, 23 Dec 2020 12:06:59 +0100
Message-Id: <20201223110659.2631255-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223110659.2631255-1-jernej.skrabec@siol.net>
References: <20201223110659.2631255-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

During H264 API overhaul subtle bug was introduced Cedrus driver.
Progressive references have both, top and bottom reference flags set.
Cedrus reference list expects only bottom reference flag and only when
interlaced frames are decoded. However, due to a bug in Cedrus check,
exclusivity is not tested and that flag is set also for progressive
references. That causes "jumpy" background with many videos.

Fix that by checking that only bottom reference flag is set in control
and nothing else.

Tested-by: Andre Heider <a.heider@gmail.com>
Fixes: cfc8c3ed533e ("media: cedrus: h264: Properly configure reference f=
ield")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h264.c
index 781c84a9b1b7..de7442d4834d 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -203,7 +203,7 @@ static void _cedrus_write_ref_list(struct cedrus_ctx =
*ctx,
 		position =3D cedrus_buf->codec.h264.position;
=20
 		sram_array[i] |=3D position << 1;
-		if (ref_list[i].fields & V4L2_H264_BOTTOM_FIELD_REF)
+		if (ref_list[i].fields =3D=3D V4L2_H264_BOTTOM_FIELD_REF)
 			sram_array[i] |=3D BIT(0);
 	}
=20
--=20
2.29.2

