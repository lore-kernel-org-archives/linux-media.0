Return-Path: <SRS0=nGM0=2A=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82440C00454
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 13:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58056214AF
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 13:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLJN7E (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:59:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:51740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727385AbfLJN7D (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 10 Dec 2019 08:59:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3668CB1A1;
        Tue, 10 Dec 2019 13:59:00 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-media@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH for-5.6 13/14] media: ivtv: Drop superfluous ioctl PCM ops
Date:   Tue, 10 Dec 2019 14:58:48 +0100
Message-Id: <20191210135849.15607-14-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210135849.15607-1-tiwai@suse.de>
References: <20191210135849.15607-1-tiwai@suse.de>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

snd_ivtv_pcm_ioctl() does nothing but calling the default handler.
Now PCM core accepts NULL as the default ioctl ops, so let's drop
altogether.

Cc: Andy Walls <awalls@md.metrocast.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/pci/ivtv/ivtv-alsa-pcm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-alsa-pcm.c b/drivers/media/pci/ivtv/ivtv-alsa-pcm.c
index cb281ce089f9..8f346d7da9c8 100644
--- a/drivers/media/pci/ivtv/ivtv-alsa-pcm.c
+++ b/drivers/media/pci/ivtv/ivtv-alsa-pcm.c
@@ -204,18 +204,6 @@ static int snd_ivtv_pcm_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_ivtv_pcm_ioctl(struct snd_pcm_substream *substream,
-		     unsigned int cmd, void *arg)
-{
-	struct snd_ivtv_card *itvsc = snd_pcm_substream_chip(substream);
-	int ret;
-
-	snd_ivtv_lock(itvsc);
-	ret = snd_pcm_lib_ioctl(substream, cmd, arg);
-	snd_ivtv_unlock(itvsc);
-	return ret;
-}
-
 static int snd_ivtv_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_ivtv_card *itvsc = snd_pcm_substream_chip(substream);
@@ -248,7 +236,6 @@ snd_pcm_uframes_t snd_ivtv_pcm_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_ivtv_pcm_capture_ops = {
 	.open		= snd_ivtv_pcm_capture_open,
 	.close		= snd_ivtv_pcm_capture_close,
-	.ioctl		= snd_ivtv_pcm_ioctl,
 	.prepare	= snd_ivtv_pcm_prepare,
 	.trigger	= snd_ivtv_pcm_trigger,
 	.pointer	= snd_ivtv_pcm_pointer,
-- 
2.16.4

