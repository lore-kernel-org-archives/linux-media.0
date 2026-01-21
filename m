Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F6425CED
	for <linux-media@vger.kernel.org>; Wed, 21 Jan 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003632; cv=none; b=eN/vqyf+6ArByE4lvnGBHJRaq2Y/d5q/umrfgq/xDtlDlksofS1qAJcH4/z4Aw13jfYTRzQ9F2n7wXLueDMsggt+MwCs+YgH0tJKh9DTgRn8MtdZCq4GWAysfK78t+bY/cwcantr/H5NlOjLMc3mViWKPCsPe9J1C/MfnVKltO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003632; c=relaxed/simple;
	bh=p7tnoGIy5s0ld68Nn6F8o8jQKdr5pDoWy5OnuOMIGEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofiny5jARR6IznxliUxfJO6dai9qh1n9psvAQmJBOzn46Mr2d3fh4y4E43M4UYPrd5KzaIDm5CVwrhPZ+PREhidpuOsBsjeUP83LZtUnzXvJYgo1PY3Y4weRDFfU/yqZxD3uWox1B87iaCuJ8qpL4sqDB3qXd8/b8eW62Bt2OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoqVbMIf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoqVbMIf"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b30275e69so8312529e87.1
        for <linux-media@vger.kernel.org>; Wed, 21 Jan 2026 05:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769003629; x=1769608429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BiW/Kbt0Xt2Iu6dILJG0LN8ImOU4Lje+9qVieFZB6eI=;
        b=CoqVbMIfX+pLQFK9opUtGDmAgsZEVyrAYFvR8Ve8oLcs6AoPVuOpf7gO1BoOfNe5eG
         tDIS+Y8/Vk0SU/xxqsB3GjdQ7USfJqACTPkbLIoirZr09vujFEROzVYkM6AkjyaeTrip
         a2fLvFdosr2jLBgbylkO+8Al8N0ll5lEnWRzPzxWhhk62tgbITWZZyfR4UYZ+mU2/Yvr
         AnRD2n0SddLy1EUxf5bDB0FRHeX60ZHXbZYqE1jhoTV5VvWNqCL/5OC2p5I1nX6gQjVa
         IZFI27T1TI0zRK7DAWkO8xz3DwgGriVOhfyrr502i8zu2ZshwW+girCFUaZ1f+stYzxR
         YhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003629; x=1769608429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiW/Kbt0Xt2Iu6dILJG0LN8ImOU4Lje+9qVieFZB6eI=;
        b=ENOuqwGjoCSH5T/iXbyXgusvTbhyZVbInFb3lFbG7RUhk3jzJyG6+lQqkA/uvERxi4
         rBak3CUSKZCifUTvJj7WWFtCcJS8EDbqdfyB5whlx5h+G0ZxdmwxGG21WBHYmohsZw/q
         rFNqbMvAsSfeQT9LcqVgcod2xtKH8bSCaYWDk09bgKWdh1ni1CNDOpEjWKTK5kvDj/Y6
         YKjU/WgfpLeGCxiceNW2lNSK59VG1HfH3R8PwURXvJiJhIYEKWLlgxlN7Fv3DisZw93h
         CwTqBOqJxu+LOxh2+kjOo6sA+GhlnNw1XnYWEqc7luXS3H5wG+pZtnj0h5Yrx8Hs3vpE
         Hupw==
X-Gm-Message-State: AOJu0YwD0Z6vWPe/wz8SUlfAa3z2e8rWCE4x8OCDwRvvxTLuwyevugRV
	oilIWBzNXm+Kpixl9xI4u8KEkGenwdjG+ADOHqwLaj+G3yRZvdG6YTQiKzEMLMNI
X-Gm-Gg: AZuq6aKnY1LeAR1kWZbwgWGrPwGpxQgHhDkIdRorTNaeqMEAsIM/TPn0g0u/4NwzHTu
	F5g886z/z35GdLoA5h2VA+QPc2ty7CfYqzG67eEpDRivioY9Ffs+45OvzFEt84MFRt7aY5bB+h/
	/LRvKa+e99oNV0UUb1LH49fpad2EGqgYukvMZnvH0O0YetXC/Ha/j6tzQ7jaNGwKksVsegF2wVb
	kr+DZNTzsfrExH9WDSxFJztQ+N3G7xULwbRvzCB7XH9kjl7VnY1RIfzYQgiXyxfdcKRW9/6301W
	XFsJsGOg8GHFmPYy/jbuFoMBmojJEVCAxkNHxTrQx0A6VOtKQ9KZFeNgPhi87Ke7vVcaENeTnjt
	fNaZs9DO7CN33msjl1KC7NajVPqnmZJVz2KNG3ucswfBUL8jx8tndDMI05a9NtSj8ktEX1Nm46P
	KA2BULCshiPp8TQDGI9m7XQyex2J0=
X-Received: by 2002:a05:6512:688:b0:59b:7973:c015 with SMTP id 2adb3069b0e04-59bafdc1303mr6405208e87.16.1769003628435;
        Wed, 21 Jan 2026 05:53:48 -0800 (PST)
Received: from gentoo.sknt.ru ([95.161.221.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33ed0asm4823233e87.19.2026.01.21.05.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:53:47 -0800 (PST)
From: Alexander Shiyan <eagle.alexander923@gmail.com>
To: linux-media@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Alexander Shiyan <eagle.alexander923@gmail.com>
Subject: [PATCH] media: i2c: imx290: Adjust initialization registers for IMX327 sensor
Date: Wed, 21 Jan 2026 16:53:24 +0300
Message-ID: <20260121135324.2256008-1-eagle.alexander923@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the global initialization sequence for the IMX327 sensor
to match the recommended values from the IMX327LQR-C Rev0.2 datasheet.

Additionally, hexadecimal literals for registers 0x309e and 0x309f are changed
to lowercase to maintain consistency with the rest of the driver code.

Fixes: f2055c1d62d6 ("media: i2c: imx290: Register 0x3011 varies between imx327 and imx290")
Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 drivers/media/i2c/imx290.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 9eca7f9db97d..da8966f0b243 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -375,10 +375,11 @@ static const struct cci_reg_sequence xclk_regs[][IMX290_NUM_CLK_REGS] = {
 };
 
 static const struct cci_reg_sequence imx290_global_init_settings_327[] = {
-	{ CCI_REG8(0x3011), 0x02 },
-	{ CCI_REG8(0x309e), 0x4A },
-	{ CCI_REG8(0x309f), 0x4A },
-	{ CCI_REG8(0x313b), 0x61 },
+	{ CCI_REG8(0x3011), 0x0a },
+	{ CCI_REG8(0x309e), 0x4a },
+	{ CCI_REG8(0x309f), 0x4a },
+	{ CCI_REG8(0x3128), 0x04 },
+	{ CCI_REG8(0x313b), 0x41 },
 };
 
 static const struct cci_reg_sequence imx290_1080p_settings[] = {
-- 
2.52.0

