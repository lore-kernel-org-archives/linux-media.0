Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC27E;
	Wed, 15 Nov 2023 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id C9E1F114;
	Wed, 15 Nov 2023 00:58:34 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id B57E860230185;
	Wed, 15 Nov 2023 16:58:22 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: s.nawrocki@samsung.com,
	mchehab@kernel.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	trix@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] media: platform: exynos4-is: return callee's error code rather than -ENXIO
Date: Wed, 15 Nov 2023 16:57:54 +0800
Message-Id: <20231115085753.1027348-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static analyzer complains that value stored to 'ret' is never read.
Return the callee's error code to fix this.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/media/platform/samsung/exynos4-is/fimc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index 97908778e1c8..0be687b01ce5 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -814,7 +814,7 @@ static int fimc_clk_get(struct fimc_dev *fimc)
 	fimc_clk_put(fimc);
 	dev_err(&fimc->pdev->dev, "failed to get clock: %s\n",
 		fimc_clocks[i]);
-	return -ENXIO;
+	return ret;
 }
 
 #ifdef CONFIG_PM
-- 
2.30.2

