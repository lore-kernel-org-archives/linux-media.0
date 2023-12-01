Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="m70AKK77"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3988794
	for <linux-media@vger.kernel.org>; Fri,  1 Dec 2023 06:04:51 -0800 (PST)
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0E014FAD;
	Fri,  1 Dec 2023 15:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1701439452;
	bh=pfSSnAAfqgfpEBtTEDM77fPiTlG6Vin5RIhMIHSqBEo=;
	h=From:To:Cc:Subject:Date:From;
	b=m70AKK77xrtOwE13tXjLX5OBdxBakl/Yy92HRXEvKpfYcZCFWRkImE31hXp7nTaDQ
	 QLCd7HkzPRae7b/c9ybK3KkwVkaDKmbbGzP6G1yBC+rInbJxK6x+CSKXoFSA0aoKHp
	 mZflLFcJ+xmYMHYN9ac4zpKQv5/7kwoRReU+hPfA=
From: Paul Elder <paul.elder@ideasonboard.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: laurent.pinchart@ideasonboard.com,
	kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	umang.jain@ideasonboard.com,
	Paul Elder <paul.elder@ideasonboard.com>
Subject: [PATCH v2 0/4] media: rkisp1: Misc fixes and debug
Date: Fri,  1 Dec 2023 23:04:29 +0900
Message-Id: <20231201140433.2126011-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a small cleanup of the register definitions, as well as
some additions to the debug for the rkisp1 driver.

Paul Elder (4):
  media: rkisp1: regs: Consolidate MI interrupt wrap fields
  media: rkisp1: debug: Add register dump for IS
  media: rkisp1: debug: Count completed frame interrupts
  media: rkisp1: debug: Consolidate counter debugfs files

 .../platform/rockchip/rkisp1/rkisp1-capture.c |  2 +
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  5 ++
 .../platform/rockchip/rkisp1/rkisp1-debug.c   | 71 +++++++++++++------
 .../platform/rockchip/rkisp1/rkisp1-isp.c     |  2 +
 .../platform/rockchip/rkisp1/rkisp1-regs.h    |  9 +--
 5 files changed, 60 insertions(+), 29 deletions(-)

-- 
2.39.2

