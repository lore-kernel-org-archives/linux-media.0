Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC381632DD
	for <linux-media@vger.kernel.org>; Sun, 25 Jan 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348953; cv=none; b=fY5+McUFoxLn6kUu3CLul+S0gHtgvpgA020fCgFvDwFbOIBqwov45mw272KfWPi3plDPsVsXtOWZmLJsfZI9GsoDGFr+UbqlC+pjsHNVq2onpV5E7G9hfTdvu1r4JzI+7/tijOppHSfPJRAbnQeTE00+ex+qH2sy8h44dnxM588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348953; c=relaxed/simple;
	bh=h6M+KLjiVFypP8v/V3hgi/xRXMPMzHyblkAsadDGc/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZquIPKXZJUW4SsdKmoAhboNv/Pik7rSjX4cuk8qYAPhOd7nKbSgbT58F3Rr/Xinroq8FwakLHRIuZJuhfyuh1IiVbpOvg+XrQ4tlA25yW56STyYGTHJRnkUTwfLONFRharmGFuzIXsmGXZk7QnVylm0XcBJpvuE0cli+eeTl/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOTZ0/Jh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOTZ0/Jh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-435903c4040so2222639f8f.3
        for <linux-media@vger.kernel.org>; Sun, 25 Jan 2026 05:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769348950; x=1769953750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=okJxgcNxyT0t1LmxmVSD+6wad8n7jcqCMxTOL8WlsjQ=;
        b=LOTZ0/JhfgyTRPSHctrdrcToQRn7+d8mU7VMsOC+FqeHNFM+qsj+DZXwAeX3QBBVaR
         JEVg7O6imvgLfrJCKNgnC8E/8oL7lndaY6+hrLqjxCocHjnDvbF6s9FcaU8dhvCm1rS0
         2Uv4b+uE/cloDVcuIObfzSdkHgmpaHihsPHq0nb+NPzKewh837CaVSiml73yKM4xMzaj
         IeTrlJiYiO7UOBsiy/7PgBaFqiKNxMs+q86zddiIBIQdPTmkHSIu0LOlrNLsr6chbFfH
         XQMI7ixKtjM0RG6eS6uiE+KTR+RQTmCEkA0G0HwSZpMio1XdzNYvdNCdzAKnIGHdVW+q
         /oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769348950; x=1769953750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okJxgcNxyT0t1LmxmVSD+6wad8n7jcqCMxTOL8WlsjQ=;
        b=Vvae+YN1Hn9w+rv8tHutAEX444nW6+SabzDXxxn5PcN3CZC7tKoDdpsaeV4EPHiNWU
         9uc79tfpnqAE+J8rAL9NQj/A90jBj9eEO1Qk5YVwzSt6TxmzIsHQqXM6Fl6evWNZDQ3U
         x+1VcUDoSi/dgTEV9hvgS0tgodsOrljxY8KT/RKHn4Lx5BRhNnnPjmrfzO2gViNwl7HP
         rHAplI8UjjP0bHYJNpNYdnyAU7gELsvSAHCkDrbMsPyRU9DH/MqPPKlNYymzNFbiFsg3
         cg3+dzX7nV/EUSXUyHovH+rel4FSFeJKa3JzJXTMd7F+6jHFDBCeRAhH/H3YGVeArVlO
         6r3g==
X-Gm-Message-State: AOJu0YyEHvaYmw//+RaYxgs8IpmFaegcBUosfr1rRjAVaR0z7iQSFb3Y
	mc4usdCuPLEXt9+6OYjY9sTe74Rer3n2R61BFqEAuOrf3lXrnxcu60ST3d6tvg==
X-Gm-Gg: AZuq6aLmdtRqXlDovlFQBIY88PnvN3wHQpSPcSDMK5prZlDEQTVGY09Ruxv75bVjMb5
	xheOPPt4l6hLbUVnmOcaZHMqMXacra28/z9RKptz0QdT69pvEICx7i5o1uIBaOXtIx4WV7t5i+S
	ijIg1wPwp1eS19XJoYUR6Ay8FrSLMbu5JuHjwYh13vNmgtc320DKZGY7SRq8c95KN2Z9EZ2dpdh
	RYG+xMP+er+m/B+9NjiBzss4P/0M6VSxuQfn7hrloimkcg9iNwpdez5PQSK+921cG+ueFRFIKDh
	yVLETOeTrwG5q8XFeO4O2+bNFkbP8URON6nyBz+pGjZvrHAmN5q6k9vL7rLfm6GdMKw6ZTTv4bP
	vgGnWOgf8SHoKHgMaYAuvlPqvnmto6xYtWgdfINiIBPwpE2TH7QJhmH3mx1Ut0q7CbIeojfnBma
	T/Nn6TGJ/h
X-Received: by 2002:a05:6000:288d:b0:435:9801:d393 with SMTP id ffacd0b85a97d-435ca19f4edmr2899870f8f.37.1769348949934;
        Sun, 25 Jan 2026 05:49:09 -0800 (PST)
Received: from TTPP ([31.176.173.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e715d3sm22743402f8f.28.2026.01.25.05.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:49:09 -0800 (PST)
From: Omer El Idrissi <omer.e.idrissi@gmail.com>
To: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	gregkh@linuxfoudnation.org
Cc: linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Omer El Idrissi <omer.e.idrissi@gmail.com>
Subject: [PATCH] staging: media: ipu3: fix function argument alignment
Date: Sun, 25 Jan 2026 14:49:00 +0100
Message-ID: <20260125134900.9964-1-omer.e.idrissi@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix alignment of function arguments to match kernel coding
style as reported by checkpatch.pl

Signed-off-by: Omer El Idrissi <omer.e.idrissi@gmail.com>
---
 drivers/staging/media/ipu3/ipu3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ipu3/ipu3.c
index bdf5a457752b..c34ff01484e1 100644
--- a/drivers/staging/media/ipu3/ipu3.c
+++ b/drivers/staging/media/ipu3/ipu3.c
@@ -151,7 +151,7 @@ static int imgu_dummybufs_init(struct imgu_device *imgu, unsigned int pipe)
 
 /* May be called from atomic context */
 static struct imgu_css_buffer *imgu_dummybufs_get(struct imgu_device *imgu,
-						   int queue, unsigned int pipe)
+						 int queue, unsigned int pipe)
 {
 	unsigned int i;
 	struct imgu_media_pipe *imgu_pipe = &imgu->imgu_pipe[pipe];
-- 
2.51.0

