Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A82326D5E;
	Sun,  1 Feb 2026 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769954383; cv=none; b=gvLScl7pwCKPPqCaroQqN0OZzV3t+PhL1f2KL6qH6mpMaa3+57BJkAiBUQB26zd0ag4wHRlFxaOPvt2LSFAFtKY/AstaHRxoFt9CoZJvbLuK2sLRf8WKm5++6bzAOxKlKPUFnGfiLU1YWG5sspLQO4vnNvoLY98NRfCMiic5nH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769954383; c=relaxed/simple;
	bh=PblPiPJVU9wko49tiQnPSMWn1MBhoQuUHd3Hz4jq2Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CtBaIJKEaZmzyAIr34RM25qo5vBi5UO6UUdxW13uUPM7bQsF4Nitr7Q++ptMMMp55ggYBEgO1i46zxHe2pO5x9Me3lErY4hw2ARF9o1NEyEk96755r9taQYLOgzwJKUymwdRn+iLbU8WevMRq/ctzsjT0gS74HPUd/T8MTFWwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=TkeZorxk; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="TkeZorxk"
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 32b293591;
	Sun, 1 Feb 2026 21:59:35 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: andy@kernel.org
Cc: hansg@kernel.org,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hverkuil@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2] media: atomisp: Fix memory leak in atomisp_fixed_pattern_table()
Date: Sun,  1 Feb 2026 13:59:33 +0000
Message-Id: <20260201135933.2052271-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c198076b503a1kunm439aa1751bba4d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSB1PVhlKTUMaHU5LSEpPGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=TkeZorxktUcgHFVc82JQUBnljMBJyVRAPflOkXHUD1/X6a/nb+Hkabc914Erfj/YHUqy0dLK0yB8MKKHDiRijoJYRj6AfnWKnXTkYT5NrebZVcLnW0gdmOU/sXF/Mwx5vL0JYdTtrTsQ5dBJRj8C78UJUSJnfy9bYxAlJr3bHrY=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=v0zfvT7KoL6zxgSsE7FU994QWzADLoLCPnX47RYr2RQ=;
	h=date:mime-version:subject:message-id:from;

atomisp_v4l2_framebuffer_to_css_frame() allocates memory for
temporary variable raw_black_frame, which must be released via
ia_css_frame_free() before the function returns. However, if
sh_css_set_black_frame() fails, the function returns immediately without
performing this cleanup, leading to a memory leak.

Fix this by assigning the error code to ret and allowing the code to
fall through to the ia_css_frame_free() call.

The bug was originally detected on v6.13-rc1 using an experimental
static analysis tool we are developing, and we have verified that the
issue persists in the latest mainline kernel. The tool is based on the
LLVM framework and is specifically designed to detect memory management
issues. It is currently under active development and not yet publicly
available.

We performed build testing on x86_64 with allyesconfig. Since triggering
this error path in atomisp requires specific Intel Atom ISP hardware and
firmware, we were unable to perform runtime testing and instead verified
the fix according to the code logic.

Fixes: 85b606e02ad7 ("media: atomisp: get rid of a bunch of other wrappers")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v2:
- Add detailed explanation about the tool and verification method.

 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 3a4eb4f6d3be..208ff85cd7fb 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -3369,7 +3369,7 @@ int atomisp_fixed_pattern_table(struct atomisp_sub_device *asd,
 
 	if (sh_css_set_black_frame(asd->stream_env[ATOMISP_INPUT_STREAM_GENERAL].stream,
 				   raw_black_frame) != 0)
-		return -ENOMEM;
+		ret = -ENOMEM;
 
 	ia_css_frame_free(raw_black_frame);
 	return ret;
-- 
2.34.1

