Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF634F49A;
	Wed, 28 Jan 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594169; cv=none; b=C5msWSq5p6xOUDHIVY1bSlYwV66DYXv4t6SG2jL3Crx80O+wSIDoy/2qUr7AygqoeFKtl7crSWWtl8rSo/wxOWlJ+SruDSQeSxa5wuSjcAHtpoRMpZFpIJP7wO9NLBHAWYxIbNoakVnUx9IGrlvbVfyV0G3+Avhm9jE/O4rFqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594169; c=relaxed/simple;
	bh=Sxgt1KJZwm+0LsoMaBdBds+HbVIA13lZJew214tUmWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWK6AyRHtq61hQ3NLYGnBIjJ8u23xwm1FYldaon01xwP7RnZN0NGc8ijsv5Qy/7i+082jOgjIO5lOqVMEF6MRchtoXod9Vl3DDkaD0g0XP9ATjVAvCkBQfa7Y2dqVolYrm8ZMVp+1Gm21cgL426AM7kyZe2JrUq2n2aWGw2yyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fRg3JWTX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3QfYe/mj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fRg3JWTX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3QfYe/mj"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyy16Axha9XsqNfK5K2jjl1PNjDbe2eng+HYnF3zS9A=;
	b=fRg3JWTX2RPm9XJC2N573zhv35cdQDkrEFSn6/35qDAPsRrVqW1CHg/dFk3h7Cd+dR2Sso
	8b5OfxPveHQOEt8O4q1oyPzQSg+2kOlzHm33XRF9le7Mo23g8jzFTu38C7qmB0Cie33rFq
	kOeDSkkukwNQot825CeRnSnqFfzj8T2gihrAYSoKIdv37w1iwE+PZ20zVLQLgPk9AJGqkc
	ncAdlrW2U1VMwqWJED75FSETNmQ+8DU/rUJ3/FN9PWFtCB1CNcCZiq+JM8v1SPNPuhUcOY
	C7+l52WTI/BQKOxnlCEAkw/S48FMZGIelRqMPgSjve0LZMkcen5iu0ddDtE0sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyy16Axha9XsqNfK5K2jjl1PNjDbe2eng+HYnF3zS9A=;
	b=3QfYe/mjImJUVTq2VsFaRzqMDSQKffMI86SYHxlwd8DM9ZO+nCZmYDorbq36GBQgZ8y5bW
	8Chberx3Sfe7fMDQ==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH v2 20/20] media: pci: mg4b: Use IRQF_NO_THREAD
Date: Wed, 28 Jan 2026 10:55:40 +0100
Message-ID: <20260128095540.863589-21-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke
other interrupt handler and this supposed to happen from within the
hardirq.

Use IRQF_NO_THREAD to forbid forced-threading.

Fixes: 0ab13674a9bd1 ("media: pci: mgb4: Added Digiteq Automotive MGB4 driv=
er")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4=
/mgb4_trigger.c
index 4f9a35904b418..70cad324df608 100644
--- a/drivers/media/pci/mgb4/mgb4_trigger.c
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -115,7 +115,7 @@ static int probe_trigger(struct iio_dev *indio_dev, int=
 irq)
 	if (!st->trig)
 		return -ENOMEM;
=20
-	ret =3D request_irq(irq, &iio_trigger_generic_data_rdy_poll, 0,
+	ret =3D request_irq(irq, &iio_trigger_generic_data_rdy_poll, IRQF_NO_THRE=
AD,
 			  "mgb4-trigger", st->trig);
 	if (ret)
 		goto error_free_trig;
--=20
2.51.0

