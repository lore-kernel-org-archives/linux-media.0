Return-Path: <SRS0=nGM0=2A=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED1DC47409
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 13:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11202465C
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 13:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLJN7B (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:59:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:51534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfLJN7B (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 10 Dec 2019 08:59:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4854AD6C;
        Tue, 10 Dec 2019 13:58:59 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-media@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH for-5.6 03/14] media: usbtv: Use managed buffer allocation
Date:   Tue, 10 Dec 2019 14:58:38 +0100
Message-Id: <20191210135849.15607-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210135849.15607-1-tiwai@suse.de>
References: <20191210135849.15607-1-tiwai@suse.de>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Clean up the driver with the new managed buffer allocation API.
The hw_params and hw_free callbacks became superfluous and dropped.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/usb/usbtv/usbtv-audio.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-audio.c b/drivers/media/usb/usbtv/usbtv-audio.c
index e746c8ddfc49..b27009875758 100644
--- a/drivers/media/usb/usbtv/usbtv-audio.c
+++ b/drivers/media/usb/usbtv/usbtv-audio.c
@@ -85,30 +85,6 @@ static int snd_usbtv_pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_usbtv_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *hw_params)
-{
-	int rv;
-	struct usbtv *chip = snd_pcm_substream_chip(substream);
-
-	rv = snd_pcm_lib_malloc_pages(substream,
-		params_buffer_bytes(hw_params));
-
-	if (rv < 0) {
-		dev_warn(chip->dev, "pcm audio buffer allocation failure %i\n",
-			rv);
-		return rv;
-	}
-
-	return 0;
-}
-
-static int snd_usbtv_hw_free(struct snd_pcm_substream *substream)
-{
-	snd_pcm_lib_free_pages(substream);
-	return 0;
-}
-
 static int snd_usbtv_prepare(struct snd_pcm_substream *substream)
 {
 	struct usbtv *chip = snd_pcm_substream_chip(substream);
@@ -337,8 +313,6 @@ static const struct snd_pcm_ops snd_usbtv_pcm_ops = {
 	.open = snd_usbtv_pcm_open,
 	.close = snd_usbtv_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = snd_usbtv_hw_params,
-	.hw_free = snd_usbtv_hw_free,
 	.prepare = snd_usbtv_prepare,
 	.trigger = snd_usbtv_card_trigger,
 	.pointer = snd_usbtv_pointer,
@@ -377,7 +351,7 @@ int usbtv_audio_init(struct usbtv *usbtv)
 	pcm->private_data = usbtv;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_usbtv_pcm_ops);
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 		NULL, USBTV_AUDIO_BUFFER, USBTV_AUDIO_BUFFER);
 
 	rv = snd_card_register(card);
-- 
2.16.4

