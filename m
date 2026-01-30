Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43E1607A4;
	Fri, 30 Jan 2026 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769746738; cv=none; b=o9qoaOdOt6d9ogfqiV2GgtEeFQLsbI2BR9pYE2bctiF7lS4BJE0jVTY64zcnB1AgrqClKdZcZ5CFe8XX+ITU6P26yGyIIO6nBucbb1nRPH2h5bqlQbUixAkW2VLYWSz9rV2jmLMoNJlsZA6z9pMElpzsFXYhbWEfZ6c1tyPodU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769746738; c=relaxed/simple;
	bh=DSfMMfwN3LXHUMf7GD65vT0+CqHG0v6NaKckMZlEf+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uwBh4u6K5fYOgsgynvp3iSjHlOHlV4HJElJDDZhaQIRHNyCJT2ktSZDKf0wmFiloknX+t4IQXgLmkoDYZhuSpULmtK4x0/hzHoYBGIm8LqV+F3Z2KNaxLAU9wQOOrLzo/JJGiSOhYBd/cAmvbZcqdrmVjCmveydGT+RyxbQomWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACXKQ0fMXxpLC8IBw--.22751S2;
	Fri, 30 Jan 2026 12:18:39 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: khalasa@piap.pl,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] media: i2c: ar0521: Check return value of devm_gpiod_get_optional() in ar0521_probe()
Date: Fri, 30 Jan 2026 12:18:15 +0800
Message-Id: <20260130041815.2988011-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXKQ0fMXxpLC8IBw--.22751S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4DXrW3Xr4UJF15tFy5Jwb_yoWkuFcEkw
	nYvrn7Xw1kGFnI93WUZFZ7ArWDAr4Dur18XFZYg3y3K3WUuFsrJrWv9r9xXw1xJr4Y9F9x
	Ar13uF1Skw1IgjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY
	1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x0JU5hL8UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The devm_gpiod_get_optional() function may return an error pointer
(ERR_PTR) in case of a genuine failure during GPIO acquisition, not just
NULL which indicates the legitimate absence of an optional GPIO.

Add an IS_ERR() check after the function call to catch such errors and
propagate them to the probe function, ensuring the driver fails to load
safely rather than proceeding with an invalid pointer.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/media/i2c/ar0521.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
index f156058500e3..ed324c2d87aa 100644
--- a/drivers/media/i2c/ar0521.c
+++ b/drivers/media/i2c/ar0521.c
@@ -1094,6 +1094,9 @@ static int ar0521_probe(struct i2c_client *client)
 	/* Request optional reset pin (usually active low) and assert it */
 	sensor->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						     GPIOD_OUT_HIGH);
+	if (IS_ERR(sensor->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(sensor->reset_gpio),
+				     "failed to get reset gpio\n");
 
 	v4l2_i2c_subdev_init(&sensor->sd, client, &ar0521_subdev_ops);
 
-- 
2.25.1

