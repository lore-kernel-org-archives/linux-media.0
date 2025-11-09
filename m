Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A692E1EE5
	for <linux-media@vger.kernel.org>; Sun,  9 Nov 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681213; cv=none; b=EvWJHWOdSyX+EKtJ5IWRfytA9uGxYJHn663bH/JiwBwneTIrL/toKmVBcrHwWmquaynHi9O0L08YhLxW16uPeVowneJ/Kx3wBsEA7fqNCZhLPadlyWs4+ZMP4tcO3quo5ubECsztr/WD2SmOWFgsPaSlQlKo+65Vk5TgCRJVi/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681213; c=relaxed/simple;
	bh=VXwGpFFT1vaAOoPY/0tXVH43viwfn+2AYUMVwvI0mT4=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SxHiDK+Kk3hzJh2CeB+DMpTyF7HK+5FJhxkiQc+GVVycyHXciIQ0wUDqaGzXbfigPgs1cQ1vWJkGmbyfVOE8x8NQVRM5sVvciwQkity98J4qn0+2+ksarICjnX82hyIWiKpnoIYLwrbPZxlCXUqs/B30A75tdah1ErxauG10QoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxtv.org; spf=pass smtp.mailfrom=linuxtv.org; dkim=pass (2048-bit key) header.d=linuxtv.org header.i=@linuxtv.org header.b=sl2rBZhF; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linuxtv.org header.i=@linuxtv.org header.b="sl2rBZhF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linuxtv.org
	; s=s1; h=List-ID:Content-Type:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:Reply-To:From:Date:Sender:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Du5IQXeNWnqgNnQhSYCT218L1t/QxLa7qmRlQ6w5uyY=; b=sl2rBZhFi/QhjXg2/2VvVAFj5z
	0F2YQhCQhbeu0sSdd8WRbOguHrUF5lBgnkwGUAKsKhHvo/4sAdfx9BYv3YWlrwwqJAkO0uKc0AGVQ
	je0IrEPew1EIw448Zu544LPY5qLiLO0JcRGSBoB6HrwVbeTWmw+Q4thFA+pG2cwIsOa+9MuvUv+1U
	TL+diY2B7eDrg+g4AdGih99HcnKH2n/aYolKgaq3FAheSg2zc3Yt3kaVsGtXoKMDYONlnGCW3WDVG
	JlsLMFob9ZslJWFBgKJ3I84vi9W80R8YTD+tQp7kvFely2i96WHsghQzUx4bxj3VJVSMsbbtH4jDL
	QybItcHg==;
Received: from builder.linuxtv.org ([140.211.167.10])
	by linuxtv.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1vI1u3-0002lH-1F;
	Sun, 09 Nov 2025 09:40:07 +0000
Received: from localhost ([127.0.0.1] helo=builder.linuxtv.org)
	by builder.linuxtv.org with esmtp (Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1vI1u2-002a5c-35;
	Sun, 09 Nov 2025 09:40:07 +0000
Date: Sun, 9 Nov 2025 09:40:06 +0000 (UTC)
From: Jenkins Builder Robot <jenkins@linuxtv.org>
Reply-To: mchehab@kernel.org, media-committers@linuxtv.org,
	linux-media@vger.kernel.org
To: mchehab@kernel.org, media-committers@linuxtv.org,
	linux-media@vger.kernel.org, hans@jjverkuil.nl
Message-ID: <1620161643.2.1762681206960@builder.linuxtv.org>
In-Reply-To: <1601783977.2.1762505596213@builder.linuxtv.org>
References: <1601783977.2.1762505596213@builder.linuxtv.org>
Subject: [Jenkins] media.git_drivers_build #446: build failed for x86_64
 allyesconfig x86_64 allmodconfig x86_64 no PM
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1_139763028.1762681206716"
X-Jenkins-Job: media.git_drivers_build

------=_Part_1_139763028.1762681206716
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some tests failed:
	PASS: arm32 allmodconfig
	FAIL: x86_64 allyesconfig
	FAIL: x86_64 allmodconfig
	FAIL: x86_64 no PM
	PASS: arm32 allyesconfig
	PASS: arm64 allyesconfig
	PASS: arm64 allmodconfig
	PASS: clang15 allmodconfig

GENERAL INFO

BUILD SUCCESSFUL
Build URL: https://builder.linuxtv.org/job/media.git_drivers_build/446/
Project: media.git_drivers_build
Date of build: Sun, 9 Nov 2025 09:35:09 GMT
Build duration: 4 min 56 sec and counting


CHANGE SET

  	 Revision  by hverkuil: (media: Use of_reserved_mem_region_to_resource() for &quot;memory-region&quot;)

	 change: edit drivers/media/platform/amphion/vpu_core.c

	 change: edit drivers/media/platform/qcom/iris/iris_firmware.c

	 change: edit drivers/media/platform/qcom/venus/firmware.c

  	 Revision  by hverkuil: (media: venus: drop bogus probe deferrals)

	 change: edit drivers/media/platform/qcom/venus/vdec.c

	 change: edit drivers/media/platform/qcom/venus/venc.c

  	 Revision  by hverkuil: (media: venus: drop unused module aliases)

	 change: edit drivers/media/platform/qcom/venus/core.c

	 change: edit drivers/media/platform/qcom/venus/vdec.c

	 change: edit drivers/media/platform/qcom/venus/venc.c

  	 Revision  by hverkuil: (media: iris: Add support for HFI_PROP_OPB_ENABLE to control split mode)

	 change: edit drivers/media/platform/qcom/iris/iris_platform_gen2.c

	 change: edit drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c

	 change: edit drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h

  	 Revision  by hverkuil: (media: iris: Add support for QC08C format for decoder)

	 change: edit drivers/media/platform/qcom/iris/iris_utils.c

	 change: edit drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c

	 change: edit drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c

	 change: edit drivers/media/platform/qcom/iris/iris_vdec.c

	 change: edit drivers/media/platform/qcom/iris/iris_buffer.c

	 change: edit drivers/media/platform/qcom/iris/iris_instance.h

  	 Revision  by hverkuil: (media: iris: Add support for QC08C format for encoder)

	 change: edit drivers/media/platform/qcom/iris/iris_buffer.c

	 change: edit drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c

	 change: edit drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c

	 change: edit drivers/media/platform/qcom/iris/iris_venc.c

  	 Revision  by hverkuil: (media: iris: turn platform caps into constants)

	 change: edit drivers/media/platform/qcom/iris/iris_platform_common.h

	 change: edit drivers/media/platform/qcom/iris/iris_platform_qcs8300.h

	 change: edit drivers/media/platform/qcom/iris/iris_platform_sm8250.c

	 change: edit drivers/media/platform/qcom/iris/iris_ctrls.c

	 change: edit drivers/media/platform/qcom/iris/iris_platform_gen2.c

  	 Revision  by hverkuil: (media: iris: turn platform data into constants)

	 change: edit drivers/media/platform/qcom/iris/iris_platform_sm8250.c

	 change: edit drivers/media/platform/qcom/iris/iris_platform_gen2.c

	 change: edit drivers/media/platform/qcom/iris/iris_platform_common.h

  	 Revision  by hverkuil: (media: iris: stop encoding PIPE value into fw_caps)

	 change: edit drivers/media/platform/qcom/iris/iris_ctrls.c

	 change: edit drivers/media/platform/qcom/iris/iris_platform_qcs8300.h

	 change: edit drivers/media/platform/qcom/iris/iris_platform_sm8250.c

	 change: edit drivers/media/platform/qcom/iris/iris_platform_gen2.c

  	 Revision  by hverkuil: (media: iris: remove duplication between generic gen2 data and qcs8300)

	 change: edit drivers/media/platform/qcom/iris/iris_platform_gen2.c

	 change: edit drivers/media/platform/qcom/iris/iris_platform_qcs8300.h

  	 Revision  by hverkuil: (media: iris: rename sm8250 platform file to gen1)

	 change: delete drivers/media/platform/qcom/iris/iris_platform_sm8250.c

	 change: edit drivers/media/platform/qcom/iris/Makefile

	 change: add drivers/media/platform/qcom/iris/iris_platform_gen1.c

  	 Revision  by hverkuil: (media: iris: enable support for SC7280 platform)

	 change: edit drivers/media/platform/qcom/iris/iris_vpu2.c

	 change: edit drivers/media/platform/qcom/iris/iris_platform_common.h

	 change: edit drivers/media/platform/qcom/iris/iris_probe.c

	 change: edit drivers/media/platform/qcom/iris/iris_resources.c

	 change: edit drivers/media/platform/qcom/iris/iris_vpu_common.c

	 change: add drivers/media/platform/qcom/iris/iris_platform_sc7280.h

	 change: edit drivers/media/platform/qcom/iris/iris_platform_gen1.c

  	 Revision  by hverkuil: (media: iris: Constify iris_v4l2_file_ops)

	 change: edit drivers/media/platform/qcom/iris/iris_vidc.c

  	 Revision  by hverkuil: (media: iris: Refine internal buffer reconfiguration logic for resolution change)

	 change: edit drivers/media/platform/qcom/iris/iris_common.c

  	 Revision  by hverkuil: (media: iris: Add sanity check for stop streaming)

	 change: edit drivers/media/platform/qcom/iris/iris_vb2.c

  	 Revision  by hverkuil: (media: dt-bindings: qcom,x1e80100-camss: Fix typo in CSIPHY supply description)

	 change: edit Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml

  	 Revision  by hverkuil: (media: qcom: camss: drop unused module alias)

	 change: edit drivers/media/platform/qcom/camss/camss.c

  	 Revision  by hverkuil: (media: qcom: camss: Use a macro to specify the initial buffer count)

	 change: edit drivers/media/platform/qcom/camss/camss.h

	 change: edit drivers/media/platform/qcom/camss/camss-vfe.c

  	 Revision  by hverkuil: (media: qcom: camss: Enable setting the rate to camnoc_rt_axi clock)

	 change: edit drivers/media/platform/qcom/camss/camss-vfe.c

  	 Revision  by hverkuil: (dt-bindings: media: Describe Qualcomm SM8650 CAMSS IP)

	 change: add Documentation/devicetree/bindings/media/qcom,sm8650-camss.yaml

  	 Revision  by hverkuil: (media: qcom: camss: Add Qualcomm SM8650 CAMSS support)

	 change: edit drivers/media/platform/qcom/camss/camss-vfe.c

	 change: edit drivers/media/platform/qcom/camss/camss.c

	 change: edit drivers/media/platform/qcom/camss/camss.h

  	 Revision  by hverkuil: (media: qcom: camss: Add CSIPHY 2.2.0 lane configuration for SM8650)

	 change: edit drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c

  	 Revision  by hverkuil: (media: dt-bindings: Add qcom,msm8939-camss)

	 change: add Documentation/devicetree/bindings/media/qcom,msm8939-camss.yaml

  	 Revision  by hverkuil: (media: qcom: camss: vfe: Add VBIF setting support)

	 change: edit drivers/media/platform/qcom/camss/camss-vfe.c

	 change: edit drivers/media/platform/qcom/camss/Makefile

	 change: edit drivers/media/platform/qcom/camss/camss-vfe.h

	 change: edit drivers/media/platform/qcom/camss/camss-vfe-4-1.c

	 change: add drivers/media/platform/qcom/camss/camss-vfe-vbif.h

	 change: add drivers/media/platform/qcom/camss/camss-vfe-vbif.c

  	 Revision  by hverkuil: (media: qcom: camss: Add support for MSM8939)

	 change: edit drivers/media/platform/qcom/camss/camss.h

	 change: edit drivers/media/platform/qcom/camss/camss-csiphy.c

	 change: edit drivers/media/platform/qcom/camss/camss-vfe.c

	 change: edit drivers/media/platform/qcom/camss/camss-vfe-vbif.c

	 change: edit drivers/media/platform/qcom/camss/camss-ispif.c

	 change: edit drivers/media/platform/qcom/camss/camss.c
------=_Part_1_139763028.1762681206716--
