Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CB3C2D0E4
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 11:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB3720708
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 11:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2BkpWgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbgKXLIB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732072AbgKXLGe (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 06:06:34 -0500
Received: from mail.kernel.org (ip5f5ad5c3.dynamic.kabel-deutschland.de [95.90.213.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D286B20857;
        Tue, 24 Nov 2020 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606215991;
        bh=ysijRedu2Lw7oyPuj7hDrcGia/PbcM2WOUIB5zMcUEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2BkpWgiGCJ2JICWfBOv8uMQr/N5S9tbjveo5kdkTw6HdgCGfn5QVaTotaZtYdDI8
         YtC70anVZaJp28fjFonl2DSNkiSq/WdSijbYNy9eoqh6zLAnIYVUzDktNub7J5Dm5W
         B+pl9vOAlNBn1KvqoGu5Xcj0Kz+8rB1eGni4IDrA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1khW9U-000FZY-NP; Tue, 24 Nov 2020 12:06:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 06/31] media: vidtv: fix some notes at the tone generator
Date:   Tue, 24 Nov 2020 12:06:02 +0100
Message-Id: <59b95aa60fdf0fb7e1071f195ed479ee5533a32e.1606215584.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606215584.git.mchehab+huawei@kernel.org>
References: <cover.1606215584.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The sheet music used to generate the tones had a few
polyphonic notes. Due to that, its conversion to a
tones sequence had a few errors.

Also, due to a bug at the tone generator, it was missing
the pause at the initial compass.

Fix them.

While here, reduce the compass to 100bpm.

The music was converted from a Music XML file using
this small script:

<snip>
my $count = 0;
my $silent = 0;
my $note;
my $octave;
print "\t";
while (<>) {
	$note = $1 if (m,\<step\>(.*)\</step\>,);
	$octave = "_$1" if (m,\<octave\>(.*)\</octave\>,);
	if (m,\<alter\>1\</alter\>,) {
		$note .= "S";
		$sharp = 1;
	}
	if (m,\<rest/\>,) {
		$note = "SILENT";
		$silent = 1;
	}
	if (m,\<duration\>(.*)\</duration\>,) {
		printf "{ NOTE_${note}${octave}, %d},", $1 * 128 / 480;
		$count++;
		if ($silent || $count >= 3) {
			print "\n\t";
			$count = 0;
			$silent = 0;
		} else {
			print " ";
			print " " if (!$sharp);
		}
		$sharp = 0;
		$note = "";
		$octave = "";
	};
};
print "\n";
</snip>

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../media/test-drivers/vidtv/vidtv_s302m.c    | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
index fdb3d649c516..569e7a50129f 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
@@ -78,8 +78,9 @@ struct tone_duration {
 	int duration;
 };
 
-#define COMPASS 120		/* beats per minute (Allegro) */
+#define COMPASS 100 /* beats per minute */
 static const struct tone_duration beethoven_fur_elise[] = {
+	{ NOTE_SILENT, 512},
 	{ NOTE_E_6, 128},  { NOTE_DS_6, 128}, { NOTE_E_6, 128},
 	{ NOTE_DS_6, 128}, { NOTE_E_6, 128},  { NOTE_B_5, 128},
 	{ NOTE_D_6, 128},  { NOTE_C_6, 128},  { NOTE_A_3, 128},
@@ -120,26 +121,27 @@ static const struct tone_duration beethoven_fur_elise[] = {
 	{ NOTE_E_5, 128},  { NOTE_D_5, 128},  { NOTE_A_3, 128},
 	{ NOTE_E_4, 128},  { NOTE_A_4, 128},  { NOTE_E_4, 128},
 	{ NOTE_D_5, 128},  { NOTE_C_5, 128},  { NOTE_E_3, 128},
-	{ NOTE_E_4, 128},  { NOTE_E_5, 255},  { NOTE_E_6, 128},
-	{ NOTE_E_5, 128},  { NOTE_E_6, 128},  { NOTE_E_5, 255},
+	{ NOTE_E_4, 128},  { NOTE_E_5, 128},  { NOTE_E_5, 128},
+	{ NOTE_E_6, 128},  { NOTE_E_5, 128},  { NOTE_E_6, 128},
+	{ NOTE_E_5, 128},  { NOTE_E_5, 128},  { NOTE_DS_5, 128},
+	{ NOTE_E_5, 128},  { NOTE_DS_6, 128}, { NOTE_E_6, 128},
 	{ NOTE_DS_5, 128}, { NOTE_E_5, 128},  { NOTE_DS_6, 128},
-	{ NOTE_E_6, 128},  { NOTE_DS_5, 128}, { NOTE_E_5, 128},
-	{ NOTE_DS_6, 128}, { NOTE_E_6, 128},  { NOTE_DS_6, 128},
 	{ NOTE_E_6, 128},  { NOTE_DS_6, 128}, { NOTE_E_6, 128},
-	{ NOTE_B_5, 128},  { NOTE_D_6, 128},  { NOTE_C_6, 128},
-	{ NOTE_A_3, 128},  { NOTE_E_4, 128},  { NOTE_A_4, 128},
-	{ NOTE_C_5, 128},  { NOTE_E_5, 128},  { NOTE_A_5, 128},
-	{ NOTE_E_3, 128},  { NOTE_E_4, 128},  { NOTE_GS_4, 128},
-	{ NOTE_E_5, 128},  { NOTE_GS_5, 128}, { NOTE_B_5, 128},
-	{ NOTE_A_3, 128},  { NOTE_E_4, 128},  { NOTE_A_4, 128},
-	{ NOTE_E_5, 128},  { NOTE_E_6, 128},  { NOTE_DS_6, 128},
+	{ NOTE_DS_6, 128}, { NOTE_E_6, 128},  { NOTE_B_5, 128},
+	{ NOTE_D_6, 128},  { NOTE_C_6, 128},  { NOTE_A_3, 128},
+	{ NOTE_E_4, 128},  { NOTE_A_4, 128},  { NOTE_C_5, 128},
+	{ NOTE_E_5, 128},  { NOTE_A_5, 128},  { NOTE_E_3, 128},
+	{ NOTE_E_4, 128},  { NOTE_GS_4, 128}, { NOTE_E_5, 128},
+	{ NOTE_GS_5, 128}, { NOTE_B_5, 128},  { NOTE_A_3, 128},
+	{ NOTE_E_4, 128},  { NOTE_A_4, 128},  { NOTE_E_5, 128},
 	{ NOTE_E_6, 128},  { NOTE_DS_6, 128}, { NOTE_E_6, 128},
-	{ NOTE_B_5, 128},  { NOTE_D_6, 128},  { NOTE_C_6, 128},
-	{ NOTE_A_3, 128},  { NOTE_E_4, 128},  { NOTE_A_4, 128},
-	{ NOTE_C_5, 128},  { NOTE_E_5, 128},  { NOTE_A_5, 128},
-	{ NOTE_E_3, 128},  { NOTE_E_4, 128},  { NOTE_GS_4, 128},
-	{ NOTE_E_5, 128},  { NOTE_C_6, 128},  { NOTE_B_5, 128},
-	{ NOTE_C_5, 255},  { NOTE_C_5, 255},  { NOTE_SILENT, 512},
+	{ NOTE_DS_6, 128}, { NOTE_E_6, 128},  { NOTE_B_5, 128},
+	{ NOTE_D_6, 128},  { NOTE_C_6, 128},  { NOTE_A_3, 128},
+	{ NOTE_E_4, 128},  { NOTE_A_4, 128},  { NOTE_C_5, 128},
+	{ NOTE_E_5, 128},  { NOTE_A_5, 128},  { NOTE_E_3, 128},
+	{ NOTE_E_4, 128},  { NOTE_GS_4, 128}, { NOTE_E_5, 128},
+	{ NOTE_C_6, 128},  { NOTE_B_5, 128},  { NOTE_A_5, 512},
+	{ NOTE_SILENT, 256},
 };
 
 static struct vidtv_access_unit *vidtv_s302m_access_unit_init(struct vidtv_access_unit *head)
-- 
2.28.0

