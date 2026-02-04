Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601A21ADA4;
	Wed,  4 Feb 2026 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173982; cv=none; b=IA1bJuLIKGdYcH1gqQGkvgcHIkI2Gpz+qb/ymJySgzYSvjV7+UAOWndS1Y5028srB44bTnixWxaYb2vAOybdU4JlytLhSRDRGik5G2psvVLNsMSYZZNdfM1y31sPoWWMyLT4KrKEE2x56/1s2ptqsx3CMOfnHGfPKOhb88CqxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173982; c=relaxed/simple;
	bh=amBQh/Bez1mHjnwMCc5BnZgeFlYiy5BTDf+yICllN4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDvN7OuqLc4PTToQs0dsU69CDu0FQlg1oqIww+UZ01BbfEpOEBfrY/HRhGYgLSZUnxSrDkJa52OyqD7m4nwWRlLnOf3uieCT9fIeekpHCS/ZC8BgBc1pmQLd7JZ+DWeMRaPIlltFrpd451GkI0iqt/GvoTzaPLxk0/lvJ1E3e4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAXqAuctIJppjxyBw--.16922S2;
	Wed, 04 Feb 2026 10:53:16 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: dave.stevenson@raspberrypi.com,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	andrey.konovalov@linaro.org,
	jai.luthra@ideasonboard.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] media: i2c: imx219: Check return value of devm_gpiod_get_optional() in imx219_probe()
Date: Wed,  4 Feb 2026 10:48:59 +0800
Message-Id: <20260204024859.1178078-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <177016661698.9154.10184896089971298930@freya>
References: <177016661698.9154.10184896089971298930@freya>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXqAuctIJppjxyBw--.16922S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWUXr4DCr1UurWxJr13urg_yoW8GrW7pa
	yUZa4jkry8Gr4Uu3WUGayxuFn5KF4ftF1UCr92gws5uws8tF4qyF47Ka4Yva4DKFyxXa4a
	qF15Zr17C3Wq9r7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbLFxUUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The devm_gpiod_get_optional() function may return an error pointer
(ERR_PTR) in case of a genuine failure during GPIO acquisition,
not just NULL which indicates the legitimate absence of an optional
GPIO.

Add an IS_ERR() check after the function call to catch such errors and
propagate them to the probe function, ensuring the driver fails to load
safely rather than proceeding with an invalid pointer.

Fixes: 1283b3b8f82b ("media: i2c: Add driver for Sony IMX219 sensor")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
Changes in v2:
- Add Fixes tag.
---
 drivers/media/i2c/imx219.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index fee63bc106d9..7da02ce5da15 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1218,6 +1218,9 @@ static int imx219_probe(struct i2c_client *client)
 	/* Request optional enable pin */
 	imx219->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						     GPIOD_OUT_HIGH);
+	if (IS_ERR(imx219->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(imx219->reset_gpio),
+				     "failed to get reset gpio\n");
 
 	/*
 	 * The sensor must be powered for imx219_identify_module()
-- 
2.25.1

