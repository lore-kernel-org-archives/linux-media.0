Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C623E9F90;
	Wed,  4 Feb 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204318; cv=none; b=E5HhUxfvumpvHCvPvkpeANH3HJIlWwvE/tmo4UNFg3QMO6AZq8yTsCeiisCTabxhZRHpzef4Lmc6Vm0EDDZ0itkuWXxUkrCNAYCf9VVC8uRbqQzIdJnMmbp18+iyRJRPSvzrMCle0KbWhDRxKeOqDZtnD3TsWMxxTxGKKsg5sek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204318; c=relaxed/simple;
	bh=5Nan95yq+Wog55Wh8dTymZ5+cZk1zyjYOzCC7cyupi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRJ16v8Ur2phcChy9CYQY83I85ZDTdOwKUE1rWeMxs3NQL/f3HVR4Qi3J8O4gBEgUQGNO/jbGYeFI49csXXVk2Q//c2f5SCpI/Pl5R2KC9hvdxBAl6luqST3tUv7t1NpKd/5Nv9AxQUlvdZ1t48t7OAGtiil6cgaajyXoGDtje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aAWLW527; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aAWLW527"
Received: from t16.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B489BC79;
	Wed,  4 Feb 2026 12:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770204269;
	bh=5Nan95yq+Wog55Wh8dTymZ5+cZk1zyjYOzCC7cyupi8=;
	h=From:To:Cc:Subject:Date:From;
	b=aAWLW527Qxg/Z/BwFk7rxJ6ga0kQ/4zc6JLiH7hLKjXo+wNc1JorfTJ6ZXbkNIFNq
	 uNsSv2ZcyzEJ7MJdbAXuf7HFE/GnAGSqZvvKFmTWXeBrKvrAeIo2Yv/d81AXVz4bqn
	 6xOdFi8JkTl4Kwboj/ayO4flF4Bg59x/RKMpn94M=
From: Isaac Scott <isaac.scott@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: dafna@fastmail.com,
	laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org,
	heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Isaac Scott <isaac.scott@ideasonboard.com>
Subject: [PATCH v1 0/6] media: rkisp1: Add YUV bypass support for rkisp1 
Date: Wed,  4 Feb 2026 11:25:00 +0000
Message-ID: <20260204112506.3706049-1-isaac.scott@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

"Smart" cameras that do all image processing on the camera module itself
may not have the ability to output image data in RAW formats. These
cameras would require the use of the ISI, which is sometimes not
included in the hardware.

In hotplug systems, it is also impossible to switch between the ISP and
ISI at runtime, meaning if a media pipeline was set up between the
sensor and the rkisp1 ISP capture device, it would not be possible to
switch from a sensor supporting RAW formats to one outputting only YUV.

Thankfully, the ISP can be configured to allow the incoming YUV stream
to "bypass" the ISP blocks, allowing these sensors to be used. It
bypasses all ISP blocks and passes through the resizer, with the input
image data being presented at the output of the ISP to be captured.

In bypass mode, stats buffers are not provided by the ISP.

This series adds support for "YUV bypass", allowing sensors which only
output YUV streams to be used through the rkisp1.

Tested on: v6.18
Compile-tested on: media/next

Isaac Scott (6):
  media: rkisp1-resizer: Add YUV source formats to resizer
  media: rkisp1-isp: Add in_bypass flag for YUV bypass
  media: rkisp1-isp: Add target_format
  media: rkisp1-isp: Propagate sink -> source format in YUV passthough
  media: rkisp1: Give buffers back instead of dropping in bypass mode
  media: rkisp1: Treat 8 bus width and 16 bus width formats the same

 .../platform/rockchip/rkisp1/rkisp1-capture.c |  5 ++++
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  1 +
 .../platform/rockchip/rkisp1/rkisp1-isp.c     | 26 ++++++++++++++-----
 .../platform/rockchip/rkisp1/rkisp1-resizer.c | 15 +++++++++++
 4 files changed, 40 insertions(+), 7 deletions(-)

-- 
2.43.0

