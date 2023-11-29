Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TenQ7hiF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73025212C;
	Wed, 29 Nov 2023 01:31:32 -0800 (PST)
Received: from pyrite.hamster-moth.ts.net (h175-177-049-135.catv02.itscom.jp [175.177.49.135])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 59D9E2B6;
	Wed, 29 Nov 2023 10:30:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1701250255;
	bh=6s5i+wYg8yBRKMHvy8A2VBBc3YDW9TeS6yCImfk8aEY=;
	h=From:To:Cc:Subject:Date:From;
	b=TenQ7hiFqKRqjSsIgFmHtPDaNWA4/Lqf8+64fUZwQ+7R700ktO8fpMrDnbqbz964M
	 4dEflplLyqgA0/YbAAPk42Ys9aVmz6jqgKyHAoEG5jrJ3QtSagdaKBqSh5PFLFiKLF
	 PdpE9CJsu38GkAKAIMA0Jsz/36H+giK1c+Yxb1CA=
From: Paul Elder <paul.elder@ideasonboard.com>
To: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	umang.jain@ideasonboard.com,
	Paul Elder <paul.elder@ideasonboard.com>
Subject: [PATCH 0/2] arm64: dts: imx8mp: Add support for the ISPs
Date: Wed, 29 Nov 2023 18:31:11 +0900
Message-Id: <20231129093113.255161-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support to the i.MX8MP device tree for the ISPs.

Laurent Pinchart (1):
  arm64: dts: imx8mp: Add overlays for ISP instances

Paul Elder (1):
  arm64: dts: imx8mp: Add DT nodes for the two ISPs

 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../arm64/boot/dts/freescale/imx8mp-isp1.dtso | 36 +++++++++++++
 .../arm64/boot/dts/freescale/imx8mp-isp2.dtso | 36 +++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 50 +++++++++++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso

-- 
2.39.2

