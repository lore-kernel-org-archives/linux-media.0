Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6834D3A9;
	Tue, 27 Jan 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541015; cv=none; b=Kdt8Uo74sCSQUW7OJ5yjEWodCAj18X5ILInwqKc/svTAgVumKVuUB+H1ngQhXSsNpYyGGq5o65aGfB/buwT78k2wL4EoewcI/hgkQvW/ekvjvhdcRcMRi+f+UnnGc2G+MKi0RITzA/WLgiO+IxLRfMNnV3HRHSJGKBHFexSY+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541015; c=relaxed/simple;
	bh=G3Cibhi5RJboaBcjArCmXJX8XlE6GD/3QoBcqEulD+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLA7+RW5zlEv1/XUTID5ooPHbG0/tqlSdJ0gneDpxF/A81J8+GOPXjvkGb2cbUnTswSuArzBiw+mE3x35gqoIhk0+DG0qUQ0LOLsa9AxmSmHadNI79JjlyzwXWd6TJSttbu/6AEMI76MTzLrjpvluFV44+te1VNo6pCu5DZiCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE872C116C6;
	Tue, 27 Jan 2026 19:10:12 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Michael Riesch <michael.riesch@collabora.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] media: synopsys: VIDEO_DW_MIPI_CSI2RX should depend on ARCH_ROCKCHIP
Date: Tue, 27 Jan 2026 20:10:09 +0100
Message-ID: <02ef452575fda61ca1d5d54086fec1223e3421a9.1769540923.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synopsys DesignWare MIPI CSI-2 Receiver is currently only supported
on Rockchip RK3568 SoCs.  Hence add a dependency on ARCH_ROCKCHIP, to
prevent asking the user about this driver when configuring a kernel
without Rockchip platform support.

The dependency can be relaxed later, when adding support for appropriate
SoCs from other vendors (if any).

Fixes: 355a110040665e43 ("media: synopsys: add driver for the designware mipi csi-2 receiver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/media/platform/synopsys/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/synopsys/Kconfig b/drivers/media/platform/synopsys/Kconfig
index e798ec00b1897560..8d0f5e3e8cd58eab 100644
--- a/drivers/media/platform/synopsys/Kconfig
+++ b/drivers/media/platform/synopsys/Kconfig
@@ -4,6 +4,7 @@ source "drivers/media/platform/synopsys/hdmirx/Kconfig"
 
 config VIDEO_DW_MIPI_CSI2RX
 	tristate "Synopsys DesignWare MIPI CSI-2 Receiver"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on VIDEO_DEV
 	depends on V4L_PLATFORM_DRIVERS
 	depends on PM && COMMON_CLK
-- 
2.43.0

