Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A51A932
	for <linux-media@vger.kernel.org>; Wed, 11 Feb 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833192; cv=none; b=sZm5Msru+bY0A4Pxnl2dOwXpjJjnyqV3rNUsql/yRRndasHHUGWwPAMC+uJwJCPGSd+seO4xb4yUOd9fnfA68xTjr+gznqfZ2R1ASwfT4Juud5vCqTGHsa5CHdM0aGIB0QYLFwVVjSapkRl3dG9IOe75XEjnTyERyjCNn/qqazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833192; c=relaxed/simple;
	bh=6H0rEeqTkwfIofX53xl8hIT3ny7lMw5EOx7JV7K6LDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpSG86Dy/ooMaADw/KM3CCrL0MBOCDb3zqomEBVAXP5s1fffn421iHQ9nPpxQsWkNEmepr0c+ocV9TrcjYP1wNjf94Z96JMln094Sh6a6R5B78kpV8VY5nQ5URDZZ55r5R2aTCtwq4srYk6S3/Hu4jnZDyqJIKDp7aWTI4iP8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l8Qpfi+A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l8Qpfi+A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l8Qpfi+A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l8Qpfi+A"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8B555BDC9;
	Wed, 11 Feb 2026 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770833189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BgMo6RwzgqZnEdMnw8wn9T4E2Wpz79JV3Kuh3kEPlIM=;
	b=l8Qpfi+AU/t1q+NkKYREfbnaDP+7xeWgOk5ppfXWvI45VbRhZWCFM5ZMX7dxwD15qkn2WT
	MzfqeIW+YB9tmnz2kud3DoaAB41OPjzXcxMzB9gkjBc34SJI30Xbn73AubzLzOQEutf04P
	QtBKcWZnOz9WBJ4w+fX4kgvqB3Gg2OE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770833189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BgMo6RwzgqZnEdMnw8wn9T4E2Wpz79JV3Kuh3kEPlIM=;
	b=l8Qpfi+AU/t1q+NkKYREfbnaDP+7xeWgOk5ppfXWvI45VbRhZWCFM5ZMX7dxwD15qkn2WT
	MzfqeIW+YB9tmnz2kud3DoaAB41OPjzXcxMzB9gkjBc34SJI30Xbn73AubzLzOQEutf04P
	QtBKcWZnOz9WBJ4w+fX4kgvqB3Gg2OE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 769BE3EA62;
	Wed, 11 Feb 2026 18:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6PllGyXFjGnADQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 11 Feb 2026 18:06:29 +0000
From: Oliver Neukum <oneukum@suse.com>
To: sean@mess.org,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 1/4] media: rc: streamzap: error handling in probe
Date: Wed, 11 Feb 2026 19:06:21 +0100
Message-ID: <20260211180621.992776-1-oneukum@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

If submitting the URB fails, the device will be unusual.
Probe() must fail.

Fixes: 7a569f524dd36 ("V4L/DVB: IR/streamzap: functional in-kernel decoding")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/rc/streamzap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index d3b48a0dd1f4..8e9b156e4300 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -219,9 +219,8 @@ static void streamzap_callback(struct urb *urb)
 	case -ESHUTDOWN:
 		/*
 		 * this urb is terminated, clean up.
-		 * sz might already be invalid at this point
 		 */
-		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
+		dev_dbg(sz->dev, "urb terminated, status: %d\n", urb->status);
 		return;
 	default:
 		break;
@@ -358,11 +357,16 @@ static int streamzap_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, sz);
 
-	if (usb_submit_urb(sz->urb_in, GFP_ATOMIC))
+	retval = usb_submit_urb(sz->urb_in, GFP_ATOMIC);
+	if (retval < 0) {
 		dev_err(sz->dev, "urb submit failed\n");
+		goto rc_submit_fail;
+	}
 
 	return 0;
-
+rc_submit_fail:
+	rc_free_device(sz->rdev);
+	usb_set_intfdata(intf, NULL);
 rc_dev_fail:
 	usb_free_urb(sz->urb_in);
 free_buf_in:
-- 
2.53.0

