Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0433120C
	for <linux-media@vger.kernel.org>; Wed, 11 Feb 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833395; cv=none; b=t4OKe7Jgz8fPurqR7G8YCJ+wIT0FoVkgTEjXb/0ocqJoA6r987TrjtVY2IC/JC2oMi3DBKnqvvhOVYI5f3EA6jHDd0vG98ZSv3+g4j6zmv+cFPtUTyY5wPSG30TxwTryPLnmsaVDjFRPtm3x91jvwD73HOjRc0Gvs0Bk2vHSREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833395; c=relaxed/simple;
	bh=N6F5wXEEoa3JFHoZLVncCUnyL6t68CUNroPc6uskhvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3J/XV/k+mFuJJt+0rEMFNZ3k9wLy6nT/X704K2Cn8RH9QG1f0DyhQBMmOOzUxcWIvYn8Dr3kJm7ojiUv8IgZposZdYsN1nkCppobldHGDnLDkz7sB8Qkheeb6Uzew+OhGc4WT14aJAOR3lGnVO6xxlBz2w4jEjJVRhvbEE3/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A9niTKx2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A9niTKx2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A9niTKx2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A9niTKx2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 799AA5BDC9;
	Wed, 11 Feb 2026 18:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770833392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kXr++mOtFoeb9eNhC1Eo4lc/efmlzOQsI2BLbIJ/IcE=;
	b=A9niTKx2LsTpyjA5N1kl3LltVgvuutU7mf4KW9V1o4HNEmP6m42vwUNyObyFvohWMuTF+o
	0UbuMvaH9DoWC6moeAvQeR6R4NsSM67RCazWgA6KDIAi0mdSQlQhHpwlHYyYahsO5Rh7+Y
	r7vmJA8X2xkyY0eCG7hZBm04kHJYOvs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770833392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kXr++mOtFoeb9eNhC1Eo4lc/efmlzOQsI2BLbIJ/IcE=;
	b=A9niTKx2LsTpyjA5N1kl3LltVgvuutU7mf4KW9V1o4HNEmP6m42vwUNyObyFvohWMuTF+o
	0UbuMvaH9DoWC6moeAvQeR6R4NsSM67RCazWgA6KDIAi0mdSQlQhHpwlHYyYahsO5Rh7+Y
	r7vmJA8X2xkyY0eCG7hZBm04kHJYOvs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 449F43EA62;
	Wed, 11 Feb 2026 18:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NDWUDvDFjGl7RAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 11 Feb 2026 18:09:52 +0000
From: Oliver Neukum <oneukum@suse.com>
To: benpicco@googlemail.com,
	sean@mess.org,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 2/4] media: rc: xbox_remote: heed DMA restrictions
Date: Wed, 11 Feb 2026 19:09:44 +0100
Message-ID: <20260211180944.1000093-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[googlemail.com,mess.org,kernel.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[googlemail.com]
X-Spam-Level: 
X-Spam-Flag: NO

The buffer for IO must not be part f the device structure
because that violates the DMA coherency rules.

Fixes: 02d32bdad3123 ("media: rc: add driver for Xbox DVD Movie Playback Kit")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/rc/xbox_remote.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/xbox_remote.c b/drivers/media/rc/xbox_remote.c
index a1572381d097..71087594e86a 100644
--- a/drivers/media/rc/xbox_remote.c
+++ b/drivers/media/rc/xbox_remote.c
@@ -55,7 +55,7 @@ struct xbox_remote {
 	struct usb_interface *interface;
 
 	struct urb *irq_urb;
-	unsigned char inbuf[DATA_BUFSIZE] __aligned(sizeof(u16));
+	u8 *inbuf;
 
 	char rc_name[NAME_BUFSIZE];
 	char rc_phys[NAME_BUFSIZE];
@@ -215,7 +215,8 @@ static int xbox_remote_probe(struct usb_interface *interface,
 
 	xbox_remote = kzalloc(sizeof(*xbox_remote), GFP_KERNEL);
 	rc_dev = rc_allocate_device(RC_DRIVER_SCANCODE);
-	if (!xbox_remote || !rc_dev)
+	xbox_remote->inbuf = kzalloc(DATA_BUFSIZE, GFP_KERNEL);
+	if (!xbox_remote || !rc_dev || !xbox_remote->inbuf)
 		goto exit_free_dev_rdev;
 
 	/* Allocate URB buffer */
@@ -264,6 +265,7 @@ static int xbox_remote_probe(struct usb_interface *interface,
 	usb_free_urb(xbox_remote->irq_urb);
 exit_free_dev_rdev:
 	rc_free_device(rc_dev);
+	kfree(xbox_remote->inbuf);
 	kfree(xbox_remote);
 
 	return err;
@@ -286,6 +288,7 @@ static void xbox_remote_disconnect(struct usb_interface *interface)
 	usb_kill_urb(xbox_remote->irq_urb);
 	rc_unregister_device(xbox_remote->rdev);
 	usb_free_urb(xbox_remote->irq_urb);
+	kfree(xbox_remote->inbuf);
 	kfree(xbox_remote);
 }
 
-- 
2.53.0

