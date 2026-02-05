Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873752D46A2;
	Thu,  5 Feb 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303388; cv=none; b=SH9IyCKRoyG+noSZG/OBZWoFZEbISN+OeLSnfkNUvvls9sDhYvXkHQgYIagYAfgnReuGQA9Ul1lXt4HSczqdkRFx1frZ9VHbQ8s2XTx5H6mBA8X4cg+gCrTVcHUv1f0mOKXDgl2kJ3A6+Qtfkf2ziHbvXvnFTBuuY4av/8MbM54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303388; c=relaxed/simple;
	bh=IAg2An7dZPfcLweRV0MG07I4CWHs8V6SJPOpFSNw4no=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h63ZLztyowUfMW375R+3osGC4ULDSsu3wFOYtDz7zj/hWAa/EreCK53zbhDBC8KOXJgDNOmXldrBcTaAO8R4i7hGbk4Mr6WKarwnlLhacoJnj21QWaDva7DNV3Ncys56btKjRtgaa/+ToJEEP6VJf9+zKS2cUKSkCBy2R5YRAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFtB4SOX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFtB4SOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1491C4CEF7;
	Thu,  5 Feb 2026 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770303388;
	bh=IAg2An7dZPfcLweRV0MG07I4CWHs8V6SJPOpFSNw4no=;
	h=From:To:Cc:Subject:Date:From;
	b=mFtB4SOX5LoLp6oxB4RuXSG6sQR0HHjPn1WuTZM8VLht49nghdtTwvZzSlTrUj7nr
	 RacIhH3GkqJw6ub1zp+ORHuFdBCjZrr0S+Pev+Ct1oLhVNvo88rSlgPsgEt7SlfUo+
	 dake+TKUtk/tRQJBj6hfDS6NTDvnC1xf3FSmp1WqMHg9qaq0hOiKzhCcC+tDRq/LCI
	 TfcP8/H/z9MScSiqCulfEwKX8/kuvnMMcOAvXLxOiX6wmJ7Go3vjqgKoKaZb1nZmfR
	 kISjqjziP0oSiuZypFHPkJq4LYJTJ+PrH56uxKNycV3C1VLgeXR7TiNS8vOob60PPD
	 72sXLB2TNH74w==
From: Arnd Bergmann <arnd@kernel.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	"Bryan O'Donoghue" <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Hans Verkuil <hverkuil@kernel.org>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: iris: fix QCOM_MDT_LOADER dependency
Date: Thu,  5 Feb 2026 15:56:19 +0100
Message-Id: <20260205145623.1360105-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When build-testined with CONFIG_QCOM_MDT_LOADER=m and VIDEO_QCOM_IRIS=y,
the kernel fails to link:

x86_64-linux-ld: drivers/media/platform/qcom/iris/iris_firmware.o: in function `iris_fw_load':
iris_firmware.c:(.text+0xb0): undefined reference to `qcom_mdt_get_size'
iris_firmware.c:(.text+0xfd): undefined reference to `qcom_mdt_load'

The problem is the conditional 'select' statement. Change this to
make the driver built-in here regardless of CONFIG_ARCH_QCOM.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/qcom/iris/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
index 3c803a05305a..5498f48362d1 100644
--- a/drivers/media/platform/qcom/iris/Kconfig
+++ b/drivers/media/platform/qcom/iris/Kconfig
@@ -3,7 +3,7 @@ config VIDEO_QCOM_IRIS
         depends on VIDEO_DEV
         depends on ARCH_QCOM || COMPILE_TEST
         select V4L2_MEM2MEM_DEV
-        select QCOM_MDT_LOADER if ARCH_QCOM
+        select QCOM_MDT_LOADER
         select QCOM_SCM
         select VIDEOBUF2_DMA_CONTIG
         help
-- 
2.39.5

