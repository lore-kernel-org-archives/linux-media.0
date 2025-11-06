Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E030BB96
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467304; cv=none; b=W8BLbyGlVjy6/HsAF5gws9lmL7OPv2dUdooVKMzVBlfgJc1SFS9eDnqJdJOLL6yyq/Rsn56FOvT252oOOzLKWEJ9KvbtYspdW5Ph8VC2L9ki6LKtM1fVpaXY0XJMM2Ekjnb6X6437HF/w5d/hGRJe5sz5u4g//S4QjTm0sLPBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467304; c=relaxed/simple;
	bh=AEDr5gv2oR7h1oZiOPh97zK+TD8jP0sbmQXd/TOQgnA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tlXikgPrzlxj909OCJmpWq5RboPZ7X74lRP8u3LK0TeL2RJ2k+mh0B/CNtbmjaQLoiU+DTITxibJKo5X3cgj/v7AkFS9Jjex6/I9+7tWyNyKwpostp4xqiz/DUEVIIn/E3/GCTWq5+22VWtU2Z+yi5AumyjLOr4X47g/M2VRF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxtv.org; spf=pass smtp.mailfrom=linuxtv.org; dkim=pass (2048-bit key) header.d=linuxtv.org header.i=@linuxtv.org header.b=V9E17zu/; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linuxtv.org header.i=@linuxtv.org header.b="V9E17zu/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linuxtv.org
	; s=s1; h=List-ID:Content-Type:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:Reply-To:From:Date:Sender:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TFoTH7bNRLR5YB5rft9qxLtVRxilb4sj1EvN1yyTArM=; b=V9E17zu/PykUnFCDMpg+QRSFaT
	gHTLSgK6yV1xZGPUOb3QXDY+MyNsEs6LsdYHSHZ2M3SQAxcfrUErUytqfl5GDNQFuCvhzU8+9Sg86
	miWXTH1zEv9gHtMr7MA/AwhrP/NmwiQY//E+3zge1vwqPXZ80KZtaKieQyzsIwUGiv2UHsPhR22PB
	1jOwsa0Jja8x2688LZGtzsxnbm1boTJv7MBu45VfPaFYwbQDFhr5n0rG5ObhkigWQMaFke2IzAewe
	+ji9DXUW6i2rszJdwl2/uevbJiHAyl/NcoADEcdpo3YeUAVf59Od19bhwjkhq2uJfeIIQgzpRweWd
	2Qznbdww==;
Received: from builder.linuxtv.org ([140.211.167.10])
	by linuxtv.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1vH8Fx-0001ph-2R;
	Thu, 06 Nov 2025 22:15:01 +0000
Received: from localhost ([127.0.0.1] helo=builder.linuxtv.org)
	by builder.linuxtv.org with esmtp (Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1vH8Fv-002BHq-0a;
	Thu, 06 Nov 2025 22:15:01 +0000
Date: Thu, 6 Nov 2025 22:14:58 +0000 (UTC)
From: Jenkins Builder Robot <jenkins@linuxtv.org>
Reply-To: mchehab@kernel.org, media-committers@linuxtv.org,
	linux-media@vger.kernel.org
To: mchehab@kernel.org, media-committers@linuxtv.org,
	linux-media@vger.kernel.org, hverkuil@xs4all.nl
Message-ID: <410281543.2.1762467299182@builder.linuxtv.org>
In-Reply-To: <1662667723.2.1762034868237@builder.linuxtv.org>
References: <1662667723.2.1762034868237@builder.linuxtv.org>
Subject: [Jenkins] media.git_drivers_build #444: build failed for x86_64
 allyesconfig x86_64 allmodconfig x86_64 no PM
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1_1623094149.1762467298921"
X-Jenkins-Job: media.git_drivers_build

------=_Part_1_1623094149.1762467298921
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some tests failed:
	FAIL: x86_64 allyesconfig
	FAIL: x86_64 allmodconfig
	FAIL: x86_64 no PM
	PASS: arm32 allmodconfig
	PASS: arm64 allyesconfig
	PASS: arm32 allyesconfig
	PASS: arm64 allmodconfig
	PASS: clang15 allmodconfig

GENERAL INFO

BUILD SUCCESSFUL
Build URL: https://builder.linuxtv.org/job/media.git_drivers_build/444/
Project: media.git_drivers_build
Date of build: Thu, 6 Nov 2025 22:05:06 GMT
Build duration: 9 min 52 sec and counting


CHANGE SET

  	 Revision  by hverkuil: (media: rkvdec: Add HEVC backend)

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec-regs.h

	 change: add drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-data.c

	 change: add drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec.h

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec.c

	 change: edit drivers/media/platform/rockchip/rkvdec/Makefile

  	 Revision  by hverkuil: (media: rkvdec: Add variants support)

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec.h

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec.c

  	 Revision  by hverkuil: (media: rkvdec: Implement capability filtering)

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec.c

  	 Revision  by hverkuil: (media: rkvdec: Add RK3288 variant)

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec.c

  	 Revision  by hverkuil: (media: rkvdec: Disable QoS for HEVC and VP9 on RK3328)

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec.h

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec.c

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec-regs.h

	 change: edit drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c

  	 Revision  by hverkuil: (media: dt-bindings: rockchip,vdec: Add RK3288 compatible)

	 change: edit Documentation/devicetree/bindings/media/rockchip,vdec.yaml

  	 Revision  by hverkuil: (MAINTAINERS: Add Frank Li as reviewer for NXP media drivers)

	 change: edit MAINTAINERS

  	 Revision  by hverkuil: (media: rkisp1: Improve frame sequence correctness on stats and params buffers)

	 change: edit drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c

	 change: edit drivers/media/platform/rockchip/rkisp1/rkisp1-common.h

  	 Revision  by hverkuil: (media: dt-bindings: nxp,imx8-isi: Add i.MX91 ISI compatible string)

	 change: edit Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml

  	 Revision  by hverkuil: (media: nxp: imx8-isi: Refine code by using helper macro)

	 change: edit drivers/media/platform/nxp/imx8-isi/imx8-isi-gasket.c

  	 Revision  by hverkuil: (media: nxp: imx8-isi: Add parallel camera input support for i.MX93)

	 change: edit drivers/media/platform/nxp/imx8-isi/imx8-isi-gasket.c

  	 Revision  by hverkuil: (media: nxp: imx8-isi: Reorder the platform data)

	 change: edit drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c

  	 Revision  by hverkuil: (media: nxp: imx8-isi: Add ISI support for i.MX91)

	 change: edit drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h

	 change: edit drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c

  	 Revision  by hverkuil: (media: imx-mipi-csis: drop unused module alias)

	 change: edit drivers/media/platform/nxp/imx-mipi-csis.c

  	 Revision  by hverkuil: (media: imx7-media-csi: drop unused module alias)

	 change: edit drivers/media/platform/nxp/imx7-media-csi.c

  	 Revision  by hverkuil: (media: imx8mq-mipi-csi2: drop unused module alias)

	 change: edit drivers/media/platform/nxp/imx8mq-mipi-csi2.c

  	 Revision  by hverkuil: (media: renesas: rcar_drif: fix device node reference leak in rcar_drif_bond_enabled)

	 change: edit drivers/media/platform/renesas/rcar_drif.c

  	 Revision  by hverkuil: (media: rcar_jpu: Convert to DEFINE_SIMPLE_DEV_PM_OPS())

	 change: edit drivers/media/platform/renesas/rcar_jpu.c

  	 Revision  by hverkuil: (media: amphion: Remove dummy PM handling)

	 change: edit drivers/media/platform/amphion/vpu_drv.c

  	 Revision  by hverkuil: (media: dvb_ca_en50221: fix &quot;writen&quot;-&gt;&quot;written&quot;)

	 change: edit drivers/media/dvb-core/dvb_ca_en50221.c

  	 Revision  by hverkuil: (media: v4l2-subdev: Make media_entity_to_v4l2_subdev() const-aware)

	 change: edit include/media/v4l2-subdev.h

  	 Revision  by hverkuil: (media: v4l2-dev: Make macros to obtain containers const-aware)

	 change: edit include/media/v4l2-dev.h

  	 Revision  by hverkuil: (media: mc: Make macros to obtain containers const-aware)

	 change: edit include/media/media-entity.h

  	 Revision  by hverkuil: (media: samsung: exynos4-is: fix potential ABBA deadlock on init)

	 change: edit drivers/media/platform/samsung/exynos4-is/media-dev.c

  	 Revision  by hverkuil: (media: i2c: ds90ub953: convert from round_rate() to determine_rate())

	 change: edit drivers/media/i2c/ds90ub953.c

  	 Revision  by hverkuil: (media: i2c: max96717: convert from round_rate() to determine_rate())

	 change: edit drivers/media/i2c/max96717.c

  	 Revision  by hverkuil: (media: i2c: tc358746: convert from round_rate() to determine_rate())

	 change: edit drivers/media/i2c/tc358746.c

  	 Revision  by hverkuil: (media: platform: ti: omap3isp: isp: convert from round_rate() to determine_rate())

	 change: edit drivers/media/platform/ti/omap3isp/isp.c

  	 Revision  by hverkuil: (media: vpif_capture: fix section mismatch)

	 change: edit drivers/media/platform/ti/davinci/vpif_capture.c

  	 Revision  by hverkuil: (media: vpif_display: fix section mismatch)

	 change: edit drivers/media/platform/ti/davinci/vpif_display.c

  	 Revision  by hverkuil: (media: exynos4-is: fimc-is: drop unused module alias)

	 change: edit drivers/media/platform/samsung/exynos4-is/fimc-is.c

  	 Revision  by hverkuil: (media: exynos4-is: fimc-lite: drop unused module alias)

	 change: edit drivers/media/platform/samsung/exynos4-is/fimc-lite.c

  	 Revision  by hverkuil: (Documentation: media: fix VIDIOC_REMOVE_BUFS typo)

	 change: edit Documentation/userspace-api/media/v4l/vidioc-remove-bufs.rst

  	 Revision  by hverkuil: (media: saa7146: Replace saa7146_ext_vv.vbi_fops with write function)

	 change: edit include/media/drv-intf/saa7146_vv.h

	 change: edit drivers/staging/media/av7110/av7110_v4l.c

	 change: edit drivers/media/common/saa7146/saa7146_fops.c

  	 Revision  by hverkuil: (media: videobuf2: Fix device reference leak in vb2_dc_alloc error path)

	 change: edit drivers/media/common/videobuf2/videobuf2-dma-contig.c

  	 Revision  by hverkuil: (media: pci: mgb4: Fix DV capabilities)

	 change: edit drivers/media/pci/mgb4/mgb4_vin.c

	 change: edit drivers/media/pci/mgb4/mgb4_vout.c
------=_Part_1_1623094149.1762467298921--
