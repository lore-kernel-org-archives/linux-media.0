Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8741C01
	for <linux-media@vger.kernel.org>; Wed, 11 Feb 2026 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833476; cv=none; b=YqjFu1yG1SK2ZwiZ6Cs839ekExXFWWnaKWuJPKciL0BuX/S6mwtKjEFlDeJM3B0N2q19Ljkx0bw1F9aEghGbyiZ0wBKm+HSeSOH8rmN8TJt/QubJu66gfffrtvuJoGpYPjVSykvAgYoKzc9anggCXewjgdBADCMPp51xW3iCDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833476; c=relaxed/simple;
	bh=1pqKHdW9lxrQAWtLEIwkWkbhnHZrnJ478fhMllLiRDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEl8C92VkfJ1sBaeLnJjUs1dpke12iA8Vcv14JW2gcrLYZrGniNLj3HzqnsDGSRpS1xp9JR9Q217kELXK+lbuWR7LwwKsmpHYiJ6PaJsEowLL3cWj+8kGY2FAziaR/5b9rzo0W0PQ/kVEqyIj4/zmFk1J4HZS6L2Azkm4xF0NtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PBe0CpMi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hvmSZ648; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PBe0CpMi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hvmSZ648"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA1A05BDDB;
	Wed, 11 Feb 2026 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770833473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FgIGFEThiYSvOUZ3+kM0gdhyv3U2FF/HmW+DPRB7A10=;
	b=PBe0CpMiC95p9qaaoS4n/oZLalKBWF7i2xPSi6ELOdEN9Ebrb4sXf1p4PysPlP+LOk8q8S
	yocGvPjzMvtjWo0X+iHIKJMONi+twisgn6YbG4v0IYkfwPG4DMj+NbD6jXxkovpiTVLn/c
	ABXBss7syz613tVpuycU4PclVqluLNI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770833471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FgIGFEThiYSvOUZ3+kM0gdhyv3U2FF/HmW+DPRB7A10=;
	b=hvmSZ6483uf/sDSoGDv9Kuo7ekUo5qFKI0J6ar5eIr4XmPC6Dd06Jlh2+V0Ars/mUD5Pgp
	ri69wqnNS1if+VWiHSdyHdRnXIOutzPh8AP2V+wGUUO/uMIp2v+fSjdwohf04WpwA1cjNU
	mOMAIXWxGa/U4xPoAlFmlMyB2EaJz8k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDEFB3EA62;
	Wed, 11 Feb 2026 18:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bhgdLT/GjGlaWQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 11 Feb 2026 18:11:11 +0000
From: Oliver Neukum <oneukum@suse.com>
To: sean@mess.org,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 3/4] media: rc: ttusbir: respect DMA coherency rules
Date: Wed, 11 Feb 2026 19:11:04 +0100
Message-ID: <20260211181104.1003010-1-oneukum@suse.com>
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
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Buffers must not share a cache line with other data structures.
Allocate seperately.

Fixes: 0938069fa0897 ("[media] rc: Add support for the TechnoTrend USB IR Receiver")
Signed-of-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/rc/ttusbir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
index 560a26f3965c..b82c8c18bca1 100644
--- a/drivers/media/rc/ttusbir.c
+++ b/drivers/media/rc/ttusbir.c
@@ -32,7 +32,7 @@ struct ttusbir {
 
 	struct led_classdev led;
 	struct urb *bulk_urb;
-	uint8_t bulk_buffer[5];
+	u8 *bulk_buffer;
 	int bulk_out_endp, iso_in_endp;
 	bool led_on, is_led_on;
 	atomic_t led_complete;
@@ -186,13 +186,16 @@ static int ttusbir_probe(struct usb_interface *intf,
 	struct rc_dev *rc;
 	int i, j, ret;
 	int altsetting = -1;
+	u8 *buffer;
 
 	tt = kzalloc(sizeof(*tt), GFP_KERNEL);
+	buffer = kzalloc(5, GFP_KERNEL);
 	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
-	if (!tt || !rc) {
+	if (!tt || !rc || buffer) {
 		ret = -ENOMEM;
 		goto out;
 	}
+	tt->bulk_buffer = buffer;
 
 	/* find the correct alt setting */
 	for (i = 0; i < intf->num_altsetting && altsetting == -1; i++) {
@@ -351,6 +354,7 @@ static int ttusbir_probe(struct usb_interface *intf,
 		kfree(tt);
 	}
 	rc_free_device(rc);
+	kfree(buffer);
 
 	return ret;
 }
@@ -373,6 +377,7 @@ static void ttusbir_disconnect(struct usb_interface *intf)
 	}
 	usb_kill_urb(tt->bulk_urb);
 	usb_free_urb(tt->bulk_urb);
+	kfree(tt->bulk_buffer);
 	usb_set_intfdata(intf, NULL);
 	kfree(tt);
 }
-- 
2.53.0

