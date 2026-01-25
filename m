Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A721576E
	for <linux-media@vger.kernel.org>; Sun, 25 Jan 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769361485; cv=none; b=s6gDXfuhMc0DOQFkkV6b/uEV8OKEOOaCsEvXQFtMXl8TFduht68MJQQsEBMrYw+Kkiyn+Z+TzbuNp25cWLD2I4G9FWcIAU6HXzCpnt5Lwu9Vhapponcil4vEPSsSvs6uHY8FUzIljnY2O6l38QsG63JcWbTMj/PGE8cmQq8FvLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769361485; c=relaxed/simple;
	bh=SoaC+bTBADZsZ6lBW8YnpUI8AOZA6Bnbyobzs3M9ObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT8jZLj1BeghjvgGwiZqP6gE6oul1vbcAONwnbLm1XPqEKmm1ukFt8UiTd7TBTG/afTaduDL2sQ5LZAHroQzawRbeWMvq1kgwIhaFKQDK/gc1EQjyPN8+kmbC2hD0K5Li6QQMa7iV/rCXVCi+0tR2z4kzWk3DZxOXuNIbBO4C+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZzVFnCD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZzVFnCD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d52768ccso25335925ad.1
        for <linux-media@vger.kernel.org>; Sun, 25 Jan 2026 09:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769361483; x=1769966283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9H4UePuprwIqygwTYXIxu8X5uuYTZS1QdaUvyOfOkw=;
        b=RZzVFnCDOydk6G/N+EnSGCb0lhH/ldFiFgLgYCZFSN42B0rZKqsKOCGbTEkxPrx98r
         WoCCwYRavF/HYnQ+/qWzhQ5L1KyeqHhHmCGm6EPA0RvbYH7G5oF5pkFN8Es1rJ5JZyxA
         1nluzrj+yfZr2inGwLY0gmVaGoJuftFt0mI8Ngqen20pDQQT6uchQwRd3ZRt1rhUoi5K
         u8DRUQ0XBF4c7+sc/p/d0T8GFzN51m4Kf9uBzf28yAibDaAuhtyVpaNBFMY+ycUA2RTn
         A6E/kDSO9yTvbTklIMmENi6Ssr6TW/4aOK0reNL6kYpHG6R9H3kCMiGkr1IX68Ic37bs
         BL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769361483; x=1769966283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9H4UePuprwIqygwTYXIxu8X5uuYTZS1QdaUvyOfOkw=;
        b=F7MZOqwM8BoP96HfKkCW099q1hnSkT0Nyeiv01SYxLEKhzQ+bjpJKRr5RfrVEPo//8
         zdDR9QJMDTuX/dc0/wAfYZygXwmDx/8L3kqZYtz4lqwjQnzYFNCw4IADWYuVQO8FiKr1
         17nXgmowgIslARqQ5R1geHR93dDFeKohZddNk+sAk2dLVcSWqgD8WGLdVXqCvnRHBUeu
         BVouK48hOp79xb7ahxmO9Ckzm3hwjUK4pLXl/ycsRD0pOON8ii1ph4GhodasB8ttETFL
         KuJvBeEG5LQt/ZQd1tG7L8Qz+Tu5HuO95Gy1CZkWhwYllwxPFReObQSJeqBp7uVR2Ro+
         OmdA==
X-Gm-Message-State: AOJu0YzKHdXS3O5lldpF8SfiRPG9//+8Lu6uZ90tsg3uEHMfgz/6iDTr
	Ox3v0rKIdKDX671mc9JvpjwyncgdJpQzvOv0dbSyBY4kuTljD8rlfnRg1aMika3R
X-Gm-Gg: AZuq6aJob5K+RzcJBIIZlgkv6j4MvrpDe8VA/d0TBrRwOQ66PCT1I+3v6eHVUEZXtjB
	qirqnSZgiEYoRkyJ/2Aj/y3L4KQMto+X/gZlrovhlpm4jSnl2uTZG5XZf8sTfnLjye4fO8RUYci
	EAP5Yv4w+2C3FIOZ+yaZ/X9ZIRDXB0Ji7SKAUQw5qvi3OlYHxoMCWSlWPE8m2hNEBOUr+bFJapu
	jaxJPBB23ofqiObM4ph2wTQzy23TalBUMsK3CtvP9pe+BI+gP/3U0y8YTDE2DCKC6xQCN1DTAYK
	IT5RJ8oLFYJdy4IU0o2rHV3ciueC1JV5KlDUd1eqnZ318bm0gfVbTz/CORvHHfBoAsn1Vw3TCxR
	xpaJmJZ9UqyTMSzpZHrW9/1tea6BoE85cmjJ+2p0cpzaPhuWUPY2lFOLv/+xNVhbmrGjqDLIcsS
	sPMG1l3iQv7MxHMFMPJ/N9Wy1Hhm5amew18239
X-Received: by 2002:a17:902:f541:b0:29f:301a:f6cf with SMTP id d9443c01a7336-2a8452f0c27mr22161865ad.35.1769361482880;
        Sun, 25 Jan 2026 09:18:02 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:35ca:7619:a2ef:5e6c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a3f2e12sm6924293a12.22.2026.01.25.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 09:18:02 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	rfoss@kernel.org,
	todor.too@gmail.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org,
	vladimir.zapolskiy@linaro.org,
	hansg@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	Saikiran <bjsaikiran@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] media: i2c: ov02c10: Check for errors in disable_streams
Date: Sun, 25 Jan 2026 22:47:45 +0530
Message-ID: <20260125171745.484806-3-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125171745.484806-1-bjsaikiran@gmail.com>
References: <20260125171745.484806-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ov02c10_disable_streams() function ignores the return value from
cci_write() when stopping the sensor. If the I2C write fails (e.g.,
due to CCI timeout, power management race, or device removal), the
error is silently lost.

While we still need to return 0 and call pm_runtime_put() regardless
of hardware state (to prevent PM reference leaks and pipeline lock
issues), we should at least log when the hardware stop fails.

This change:
1. Captures the cci_write() return value
2. Logs an error if the write fails
3. Still returns 0 to ensure proper cleanup

Returning an error from disable_streams would cause the camss driver's
video_stop_streaming() to exit early without releasing the pipeline
lock, permanently locking the camera.

Fixes: 0e98938b0157 ("media: i2c: add OmniVision OV02C10 sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/media/i2c/ov02c10.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index b86cae3d2b74..743d8544ac53 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -629,8 +629,12 @@ static int ov02c10_disable_streams(struct v4l2_subdev *sd,
 				   u32 pad, u64 streams_mask)
 {
 	struct ov02c10 *ov02c10 = to_ov02c10(sd);
+	int ret;
+
+	ret = cci_write(ov02c10->regmap, OV02C10_REG_STREAM_CONTROL, 0, NULL);
+	if (ret)
+		dev_err(ov02c10->dev, "failed to stop streaming: %d\n", ret);
 
-	cci_write(ov02c10->regmap, OV02C10_REG_STREAM_CONTROL, 0, NULL);
 	pm_runtime_put(ov02c10->dev);
 
 	return 0;
-- 
2.51.0

