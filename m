Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DFC2D8195;
	Tue, 29 Apr 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970819; cv=none; b=WnR46jBMErvuRF6u4zeVHgh5T1KW7Pd0iET5vSdFp19VxqQUzXrUZ2Svrklr1HjefbLar7g4P1viGyfJ6Q6H3LU44q9sXYfI+vo48k4BaLcUmGEy8+j7ou5PByr5Tb/ik6TscziUFsJKoVi0KG+5N2J7N4JJw5NLamOVdVw0euQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970819; c=relaxed/simple;
	bh=nUHEpcVOMFTl03dFb+HgklHSeDXNFpL6MGznPjJA0Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twCljYvK75ChTwkauFk6yRvr7PSy+YizdCaCTSlxgnc2wYkujyl3K0vB79VjeUKSN5Z96Qz4YIT4u5sX0mminN1IoF48oBY/uWXGz4QXpWjLXmrWg4xhRSpcXZPUbPZfyEqpAucR7yv0ox+HGiUbBarJq177bEfAiqWrT2+7fpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lHJzx+JG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lHJzx+JG"
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BCC25667;
	Wed, 30 Apr 2025 01:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745970803;
	bh=nUHEpcVOMFTl03dFb+HgklHSeDXNFpL6MGznPjJA0Gg=;
	h=From:To:Cc:Subject:Date:From;
	b=lHJzx+JGEvZW5yv7KcTxwijcULgiA3ttNyD0F+LyTUJ+MK3hRIm9FE+ThofTzP3Kf
	 OZU7Ya176QQStxUXL8+pt9ZFlV+JLXb4AAAp2OAeRWWqSI6rVcBvpsa8IYb58LdJXZ
	 cjvIslnf0MfQ7k6LvUeMgjODShy/W69hykKyd7FY=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/7] media: renesas: vsp1: Fix v4l2-compliance failures
Date: Wed, 30 Apr 2025 02:53:15 +0300
Message-ID: <20250429235322.29826-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series fixes all v4l2-compliance failures in the VSP1 driver. It
builds on top of the recently posted "[PATCH v2 0/9] media: renesas:
vsp1: Add colorspace support" series ([1]).

The v4l2-compliance log is long, and not that interesting as there's no
failure. Here's the executive summary, if anyone wants the full log,
please let me know.

----------------------------------------
root@buildroot ~ # v4l2-compliance -m /dev/media1
v4l2-compliance 1.29.0-5370, 64 bits, 64-bit time_t
v4l2-compliance SHA: 81ccbfe204c7 2025-04-29 15:36:05

Compliance test for vsp1 device /dev/media1:

Media Driver Info:
        Driver name      : vsp1
        Model            : VSP2-BD
        Serial           :
        Bus info         : platform:fe960000.vsp
        Media version    : 6.15.0
        Hardware revision: 0x01011504 (16848132)
        Driver version   : 6.15.0

[...]

Grand Total for vsp1 device /dev/media1: 757, Succeeded: 757, Failed: 0, Warnings: 0
----------------------------------------

To achieve zero failures, I had to disable a streaming test that can't
succeed on the VSP, as it is an MC-based device. The patch ("[v4l-utils]
[PATCH] v4l2-compliance: Don't perform blocking DQBUF test on MC_IO
devices") has been posted in [2].

The series has also been tested with the vsp-tests suite, which reported
no regression.

[1] https://lore.kernel.org/linux-media/20250429232904.26413-1-laurent.pinchart+renesas@ideasonboard.com
[2] https://lore.kernel.org/linux-media/20250429203922.23078-1-laurent.pinchart@ideasonboard.com

Laurent Pinchart (7):
  media: renesas: vsp1: Store supported media bus codes in vsp1_entity
  media: renesas: vsp1: Store size limits in vsp1_entity
  media: renesas: vsp1: Fix code checks in frame size enumeration
  media: renesas: vsp1: Fix RPF sink alignment for YUV formats
  media: renesas: vsp1: Fix RWPF media bus code and frame size
    enumeration
  media: renesas: vsp1: Fix format propagation on the BRX
  media: renesas: vsp1: Implement control events

 .../media/platform/renesas/vsp1/vsp1_brx.c    |  37 ++---
 .../media/platform/renesas/vsp1/vsp1_clu.c    |  47 ++----
 .../media/platform/renesas/vsp1/vsp1_entity.c | 108 +++++++-------
 .../media/platform/renesas/vsp1/vsp1_entity.h |  21 +--
 .../media/platform/renesas/vsp1/vsp1_histo.c  |  27 ++--
 .../media/platform/renesas/vsp1/vsp1_histo.h  |   2 -
 .../media/platform/renesas/vsp1/vsp1_hsit.c   |  24 ++--
 .../media/platform/renesas/vsp1/vsp1_lif.c    |  40 ++----
 .../media/platform/renesas/vsp1/vsp1_lut.c    |  47 ++----
 .../media/platform/renesas/vsp1/vsp1_rpf.c    |   5 +-
 .../media/platform/renesas/vsp1/vsp1_rwpf.c   | 135 ++++++++++++++----
 .../media/platform/renesas/vsp1/vsp1_rwpf.h   |   3 -
 .../media/platform/renesas/vsp1/vsp1_sru.c    |  61 ++++----
 .../media/platform/renesas/vsp1/vsp1_uds.c    |  60 ++++----
 .../media/platform/renesas/vsp1/vsp1_uif.c    |  40 ++----
 .../media/platform/renesas/vsp1/vsp1_wpf.c    |  10 +-
 16 files changed, 314 insertions(+), 353 deletions(-)


base-commit: 398a1b33f1479af35ca915c5efc9b00d6204f8fa
prerequisite-patch-id: e3d9847d1da4398f1bf0b57f5ef4a612392c7255
prerequisite-patch-id: 54ade6c92a08292f509ad0c42cc578e2b355e699
prerequisite-patch-id: c2f29968199990b573d655ca9ea9ac0883842a9c
prerequisite-patch-id: 96e1d3ee682a91153ecd32207a641274cdd88b7a
prerequisite-patch-id: 221744f7a7fc757b67c32a1eb2160fb46cd59111
prerequisite-patch-id: 8c3ebcd92a4297b0f28949e6dba038c042f7dfa1
prerequisite-patch-id: 439fe909a37bc235622e8feacc2fc01429dcb4bb
prerequisite-patch-id: 5940443948cee464fb7448778ed180d50736d771
prerequisite-patch-id: eabcbd4bedb2617adf11740c67014de31f99a182
prerequisite-patch-id: 048286f07c4a5cb2bf695cc9876640759aec970c
-- 
Regards,

Laurent Pinchart

