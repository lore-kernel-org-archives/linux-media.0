Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B522129B
	for <linux-media@vger.kernel.org>; Thu,  5 Feb 2026 04:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770266253; cv=none; b=gnkWoZREVN66XrrcdRhvznoKCHtQLCraYdgIIZjuqvY2JsXG6WlxdFvbnykVSToTTdkONjgMKB7YltOq7cfYdBOvvdzZKXKurRGmm3VlQu4k6HYsJXQiNiWcB84hi7oHUDh8yMA3AOEB2nHBJ6dt6CdUDzOgzEFWX6hnR3CDL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770266253; c=relaxed/simple;
	bh=UnrAmmSbaRoksWNGky3SSS1vkAjebM2z+IvCmTfQyE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sK6XtUuqcYoOCIxegNGuKAlKCC2aJB7uXciLo+g9JWIlCqbNcsiKpXNGqMaxsSq/UfXrhQ2Frs4J8uM6cqYR5z0koZI8dRpqMcZwCMRqGGP0xBll3Kx6ijlmaxoLh8NQ1MR3ABvAUsue6H+1DvNbrBIHw0zif/nqudEmN0bvg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=DleOysBr; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="DleOysBr"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662f30d3f1fso992076eaf.1
        for <linux-media@vger.kernel.org>; Wed, 04 Feb 2026 20:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770266252; x=1770871052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ3frmblWiygOYmfj4eESIem1C0eBPRtCJOntjI5VdM=;
        b=DleOysBrx2KKarfVAbvQAyj3mghSiyzVhR3vaIYan0hrigWB95BNkB/ltt/wOkJvvl
         w/rziMGBkcelN7TZXhzW5AppvQ2ChgE953ii3ulheh3l1Wzo33PE3jSycqJJWPrXPM7T
         +HY3pw+BN3osz6CbQ7qkYcMtmRlXdhYgeNSO+g8miBzr/utl98WNFufZ+WlSBHI3FZ/Z
         H7S/+bdshfa2dBBSoL1cW3yOOOrvTfEjuXDjspzlbDxS43bN5EW7EpV/auWxHGQEGqNy
         soE+NFMhdn0TwAg73Tn400tIyiV9jTOCnC267vh4xf453laiDU3sBN1nai6benLM2Kh6
         9N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770266252; x=1770871052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJ3frmblWiygOYmfj4eESIem1C0eBPRtCJOntjI5VdM=;
        b=NErdwoSfAZTzOaGyXGGxzoo8vUu7dHsSmg0t88zCK6um9DpUgyQm4Q9xoJoJUQQbCd
         6Cb7MiUfUSMAVA1sSh82p55yCNssj6atxhCCYQ7DR1EZMJ5q5LFLWocnJslS1dbqyNeK
         dxrE97B9F4hHEoXM1LN5zbvQXyN+q0XrLiyJRNOST/Wp40r2XeH5HGvKyc/F104pu50v
         wFzLcoCQIZoIqOZuUme9xf5ksTp2ATWjW1ZwAtZ7poTAs6fIeL3BZ7R+Nw85OSder2sj
         uqO9pnTGY02T/l6XzgtfTS4gl8HlYYInJ4urTs5qPz3nEUez7isrL3qYJBtqxsq4uOjv
         AR5w==
X-Forwarded-Encrypted: i=1; AJvYcCXYvcs+aSaIar/Kn5GkUgTzuvPV0Mt5Bg6/QXoRkqfZqvlTL+HOIcKjjQ5NkopdKLmtGIq5QDpLyOfsdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK1QcdqKz0G6zv5syWVwa1HHaC2IvoDoHu1KYdogOplHnha4mH
	/IFYQAkIx0x38k4KPWn5mcea8LKu5XTGNRX+9fZXfCd/i94tMvB/3dGKUdk8LHzJnwQ=
X-Gm-Gg: AZuq6aLgq61kJHqzwPl7SvSpTTSmEdv1RxPXx5Y6gIC58gEKBoUZljA2QnZTWhfPdCt
	nmG76WvQFA015b4mJ457TSVWykLxLCNHLIG1BoClxK97Pp7sktvDltEws7d0ez6PyAMJc39Vs7O
	acK3wRkJ6z+Oi7ZZVCcSPC82257UGQRDZLRNUqkC9/yguLzZJjz29D28P4PcIOPynxAJNEBmMRd
	nDbRLPydt5ThK0FAA6R5IgY/GfvZ0MqeHAKII+68YvhlHUSLWkyh5jYVPP45PAr7qS+S2yo1JaM
	4yn9j57XmJDS9Qwa8YKlCn+Pxgpfp5Hdmj622cAfsuw8zuS0uf0cv+i+WwxJpmrR6ZUWp0xXDVU
	fAzsQoFj/slLdfpjgKVcoYOTdFzxd7T9vMlM7X2jQgO0HcZedywAfO23DRJM6XCuwx77GR0BqsQ
	2DUeom4g5VPbbQoSJZyrr4o4KwfLKonkO51UPg0p5x6c/57coD+0k5KgFEv3w1mGTs6elDGaLpU
	04BZj13/GGSStfiLfQbLm7g88K5BU0=
X-Received: by 2002:a05:6820:468c:b0:65f:6c48:7860 with SMTP id 006d021491bc7-66bac25b5c3mr775281eaf.9.1770266252383;
        Wed, 04 Feb 2026 20:37:32 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a33189b90sm2544993eaf.6.2026.02.04.20.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 20:37:31 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] media: atomisp: add missing mutex in atomisp_vidioc_default()
Date: Thu,  5 Feb 2026 04:37:30 +0000
Message-Id: <20260205043730.3856488-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atomisp_vidioc_default() calls atomisp_exp_id_unlock(),
atomisp_exp_id_capture(), and atomisp_inject_a_fake_event() without
holding isp->mutex. However, all three functions have
lockdep_assert_held(&isp->mutex) indicating callers must hold this lock.

Other ioctl handlers in the same driver (e.g., atomisp_start_streaming)
properly acquire the mutex before operating on ISP state.

Add mutex_lock()/mutex_unlock() around these three ioctl cases to fix the
missing lock protection.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index bb8b2f2213b0..ab13630c8149 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1521,10 +1521,14 @@ static long atomisp_vidioc_default(struct file *file, void *fh,
 		break;
 
 	case ATOMISP_IOC_EXP_ID_UNLOCK:
+		mutex_lock(&asd->isp->mutex);
 		err = atomisp_exp_id_unlock(asd, arg);
+		mutex_unlock(&asd->isp->mutex);
 		break;
 	case ATOMISP_IOC_EXP_ID_CAPTURE:
+		mutex_lock(&asd->isp->mutex);
 		err = atomisp_exp_id_capture(asd, arg);
+		mutex_unlock(&asd->isp->mutex);
 		break;
 	case ATOMISP_IOC_S_ENABLE_DZ_CAPT_PIPE:
 		err = atomisp_enable_dz_capt_pipe(asd, arg);
@@ -1537,7 +1541,9 @@ static long atomisp_vidioc_default(struct file *file, void *fh,
 		err = atomisp_formats(asd, 1, arg);
 		break;
 	case ATOMISP_IOC_INJECT_A_FAKE_EVENT:
+		mutex_lock(&asd->isp->mutex);
 		err = atomisp_inject_a_fake_event(asd, arg);
+		mutex_unlock(&asd->isp->mutex);
 		break;
 	case ATOMISP_IOC_S_ARRAY_RESOLUTION:
 		err = atomisp_set_array_res(asd, arg);
-- 
2.34.1

