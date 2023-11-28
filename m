Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BA410F0
	for <linux-media@vger.kernel.org>; Tue, 28 Nov 2023 10:31:57 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f4d4:eef9:4487:4eb1])
	by xavier.telenet-ops.be with bizsmtp
	id FuXv2B0022jytoH01uXvqK; Tue, 28 Nov 2023 19:31:55 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1r82ry-00AHX4-TQ;
	Tue, 28 Nov 2023 19:31:55 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1r82sE-00B9qv-Td;
	Tue, 28 Nov 2023 19:31:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] staging: media: VIDEO_STARFIVE_CAMSS should depend on ARCH_STARFIVE
Date: Tue, 28 Nov 2023 19:31:53 +0100
Message-Id: <81476f48f7774fdd62e95458b160688952bb0068.1701196160.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The StarFive Camera Subsystem is only present on the StarFive JH7110
SoC.  Hence add a dependency on ARCH_STARFIVE, to prevent asking the
user about this driver when configuring a kernel without StarFive SoC
support.

Fixes: bba185d141b12787 ("media: staging: media: starfive: camss: Add core driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/staging/media/starfive/camss/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/starfive/camss/Kconfig b/drivers/staging/media/starfive/camss/Kconfig
index bd184f42c98fa853..9ea5708fe40955e2 100644
--- a/drivers/staging/media/starfive/camss/Kconfig
+++ b/drivers/staging/media/starfive/camss/Kconfig
@@ -5,6 +5,7 @@ config VIDEO_STARFIVE_CAMSS
 	depends on VIDEO_DEV && OF
 	depends on HAS_DMA
 	depends on PM
+	depends on ARCH_STARFIVE || COMPILE_TEST
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_DMA_CONTIG
-- 
2.34.1

