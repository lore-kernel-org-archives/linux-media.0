Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7F3191C3
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509030; cv=none; b=BzThP2ssBzNlnZx9zBx+SRMOXklPLhslQWhpiR/xWUA0lzQtLKAV/spl2jz0QzbwAQj95UO0pUYwwz70QfeyxBh0B6pYcO28Cr2l8+qd2vh9RHvfiBJO/k5bqXVAndAQTJZeJnMJdRZxKnC4FYj1Y/vsTEGBt1lq2kJTIpgzF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509030; c=relaxed/simple;
	bh=v2/eQttuoX1rwE/rswcTbvQkFFgVuyGsREbMQwuAxs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGImLGDquR/r9JQn/CuNU/KqolRkxPxMiBobeiSshq3MVFlZNsHXjx0715gmGuj9/6e1uw+b9xQsmmN3Dft+UwQt+Hl6z0i/k+cf+NGkPT2/w02Xnins7MJZeXPQj4M1Y72uXy6Yg61RA3A98knL3wAb4mURx1w/4VG9x86UOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EUHsAkLa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FGm8nkhk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EUHsAkLa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGm8nkhk"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A79A3YV1710421
	for <linux-media@vger.kernel.org>; Fri, 7 Nov 2025 09:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5IlwSvYdDB64FR4vxCrxBJvjL/o+hpUr0AMtnRKvU9Q=; b=EUHsAkLad8eREiPj
	ObZZyfaDftUwSD+xFtgr7U5bh/CLpTOaG0ApvC2CUkvzFxPH6RpIsChJSNCh3MDT
	cioAqT9TVfwYcgHlNRfH7kthiSmkhUivX/W1ohQyJsqwMtQnbtKRfJH0LYaPD0U9
	pRqxAUJCqYUQEQooMJuahDwOVnvufFqw7XuIS08NmN5khxjoM15wFWChFuYjDtC8
	LWRsEt5Sbq0Sr18a1qTQrbhVDF5zHA5zPpXW0MwyB75VHkCebdaUEcCUPW88JM4o
	U7zJ/0i8p9eAy5CUWSGSzrbRJYLHomP+7dCySeD4Vl0cwYHFcsQtqFtzUCqsPG5E
	rnzjTw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a96ue1cpv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 09:50:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290ab8f5af6so7150825ad.3
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 01:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762509026; x=1763113826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IlwSvYdDB64FR4vxCrxBJvjL/o+hpUr0AMtnRKvU9Q=;
        b=FGm8nkhkyL639p7BhtlnaV/BZyOlzC1Her5cT77goL08O9XN97MUFdrox7i3IJV3B2
         JytLNXdoAy3KCfXRZC5aEfuT+tLfhEZ0n4tSzWY5bCNT0sJT0vNNtlqXINW0oQDTaQ5A
         CM2cMU46j7HuPipyD2m39dawHTCl3ay/gZUG9j44TpRJZdloJ9sNLW6uWS1ogp8iC/gy
         L2mrTfIO0a4PCD9PPjzuIRyfz4pSbfht6ijyWXgL3FHJb3YmJDGmTeXStF0FZtfhMMe3
         Wr7i/e5y6Rjm1Y0XS+6ASY32PJL/SGcP1c7qtdrlRiuIY2xAxkCk8KgUAsrNIelzWXqO
         z5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509026; x=1763113826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5IlwSvYdDB64FR4vxCrxBJvjL/o+hpUr0AMtnRKvU9Q=;
        b=WI6ghtt8p9efR6TyffeVFnuXbzZBoQ+cVd2cS9ddW871BB91hu7atcRIzD/cpoEZXX
         LdIuMOub2iAMDnxvcs4hWVXxY1VY/9yOGHlA4modWcPiylLyTHE6hQa2Gvi/a6LS6WoK
         U8FWoSjCw6+ZPrIyP0/vJWLtQUD9SpJRlHe410wK+L4AoR7UE6dzYnFy4c3nhds//TQw
         ISBtrfkMD8X1xu/FezB7MsA7yvlaPpBu5RYns0JUABv/BowTCaaDxiKcGRJJz2Vxqsbw
         kjJ94wMA6o3tKXcHTqdU5Kbqkr2PFFoSm67Do3aP3ND448Zf4eRetQxibNKmB7MaWYm2
         UEBw==
X-Forwarded-Encrypted: i=1; AJvYcCUiyne4un99vjqYQokpLuPVkOXeo0Kmw7KjcU+K6PkT+bgJ3HdcQl8qQ/cD+g/I+Ml/XHKHjew2Lgu4/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqUK71M1AS5zkKmTQl1aYTP36VGRwMsTxgMK9K3rZZ4aB9l21Q
	cEtS0aYWz7oftkdVwqFCDgaF0RGROGxQkWJXoF/jU4B7p/a42N4qefsGi/wYi89c6aJ3tw+Q19S
	h3hP6cNU3BUaPjmEpWI6aRXxkaG5yOA1MXjZfzyO2nynXHKqe5mObj/nsHvon/y7zwQ==
X-Gm-Gg: ASbGncv5cimlt96GF3PcEFmxwa/JMmZBTbiOnzZFUmhPn1QZOaGzvuZRtmaDYIZtSju
	QFWx3YO9XSyXlwqxWwKmtsDfHy+e+C5iQ4ue3AaKeJ9shrf+KsQtyKuIuR1xFUYJAJ/RaCYsL1s
	zElVl87mFwJHQOyW1U4pB0BSgD8aTz+8mVZqg0y4FDTP3d44j/i5/Dinq7mEadVqQHPZXwcmDzk
	TcvDEwbbx055GVyxeJ39xILuvuyfevZ0l3d7dQ3QQ0SrqZga3wYTUsejLo0QwmWCcmqmkJb1khx
	Pck+cYbtGdh+PzXea1qOhb1FMLBR1fJgVlctEknQ+77+y3SePr4F1fVkegfiQxe2B1HMY34GqBK
	sJKpdWB4qy4zwu1biW407NlaI40MLmazNsw==
X-Received: by 2002:a17:903:19c7:b0:295:4251:838d with SMTP id d9443c01a7336-297c04a60camr38224955ad.55.1762509025636;
        Fri, 07 Nov 2025 01:50:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwg1aILLEMlKRqLcW6UJkFuYJnFT1aKQZlvTwiWFG5CH5t14GfvhRBM/fy1t44DccFRt/K7A==
X-Received: by 2002:a17:903:19c7:b0:295:4251:838d with SMTP id d9443c01a7336-297c04a60camr38224545ad.55.1762509025077;
        Fri, 07 Nov 2025 01:50:25 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5f011sm54975895ad.25.2025.11.07.01.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:50:24 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 15:19:41 +0530
Subject: [PATCH v3 6/6] media: iris: Introduce vpu ops for vpu4 with
 necessary hooks
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-knp_video-v3-6-50c86cbb0eb8@oss.qualcomm.com>
References: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
In-Reply-To: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762508991; l=14963;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=v2/eQttuoX1rwE/rswcTbvQkFFgVuyGsREbMQwuAxs4=;
 b=SOA8387XS8MUGZHze/KlhLJsUDv6YUmjn6xTjneGwAiASS3nHXUkHbaB0tfyNaOjRiEMp3gTq
 MiFRonGxtHECt3qHNfNJ1KDB4nA+Fm7UPlLvNzFBT1Et06BrND09saT
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=fYKgCkQF c=1 sm=1 tr=0 ts=690dc0e2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=V7PGPLsNbH-VDMjO_1gA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: KtiMf0XCbmozPc_DOZ57JvkKN3tMann9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3OCBTYWx0ZWRfX2vvIJh+H0Hei
 kV34qlVqacbP2/gLEMDVrWkIzQ3bhLHaYMTNBoVBQGGjLXXdxdHcNfITvuqFilP7hqcCFyq0kl4
 dmIXf65YRQb6r4XMBqOLFRdTsJwsqqltR2jhiPbbUV/FBptLbNpBuY9u8bfjj5U75gEuWBmpV8P
 U3aOouaBP5sbcwZDb/Q2Du4CmjsIuYV4skJC6uf5jjDpHyHXMr8Y47rAzxcTFb0YLZnUmAM2skr
 RC1+dbVepuLpRLGFADejlJnteKdQnUYSRexO+GosdPTfqWDzgXwjYoqCaWYjDXCrX0qOJUHwqS1
 36Ykb0JZ2GsWaw4w7zXNUL+ouy69RNzckAavBh8v9gZLB8A0ewckgjxPvRYK7p/Gd5TcLyJwAnj
 OYaSBaPdhxiqZi+959ozRo0NKjccyA==
X-Proofpoint-GUID: KtiMf0XCbmozPc_DOZ57JvkKN3tMann9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070078

Add power sequence for vpu4 by reusing from previous generation wherever
possible. Hook up vpu4 op with vpu4 specific implemtation or resue from
earlier generation wherever feasible, like clock calculation in this
case.

Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Makefile          |   1 +
 .../platform/qcom/iris/iris_platform_common.h      |   7 +
 drivers/media/platform/qcom/iris/iris_vpu4x.c      | 358 +++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
 4 files changed, 367 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 13270cd6d899852dded675b33d37f5919b81ccba..1446f5732ab51db85ea4f52636d29e36d82b7a8f 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -22,6 +22,7 @@ qcom-iris-objs += iris_buffer.o \
              iris_venc.o \
              iris_vpu2.o \
              iris_vpu3x.o \
+             iris_vpu4x.o \
              iris_vpu_buffer.o \
              iris_vpu_common.o \
 
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index ae49e95ba2252fc1442f7c81d8010dbfd86da0da..d6d4a9fdfc189797f903dfeb56d931741b405ee2 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -54,6 +54,10 @@ enum platform_clk_type {
 	IRIS_AXI1_CLK,
 	IRIS_CTRL_FREERUN_CLK,
 	IRIS_HW_FREERUN_CLK,
+	IRIS_BSE_HW_CLK,
+	IRIS_VPP0_HW_CLK,
+	IRIS_VPP1_HW_CLK,
+	IRIS_APV_HW_CLK,
 };
 
 struct platform_clk_data {
@@ -188,6 +192,9 @@ struct icc_vote_data {
 enum platform_pm_domain_type {
 	IRIS_CTRL_POWER_DOMAIN,
 	IRIS_HW_POWER_DOMAIN,
+	IRIS_VPP0_HW_POWER_DOMAIN,
+	IRIS_VPP1_HW_POWER_DOMAIN,
+	IRIS_APV_HW_POWER_DOMAIN,
 };
 
 struct iris_platform_data {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu4x.c b/drivers/media/platform/qcom/iris/iris_vpu4x.c
new file mode 100644
index 0000000000000000000000000000000000000000..fa72f16ac38dcbc061698e3d496a1d2bbf17be27
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_vpu4x.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/iopoll.h>
+#include <linux/reset.h>
+
+#include "iris_instance.h"
+#include "iris_vpu_common.h"
+#include "iris_vpu_register_defines.h"
+
+#define AON_WRAPPER_MVP_NOC_RESET_SYNCRST	(AON_MVP_NOC_RESET + 0x08)
+#define CPU_CS_APV_BRIDGE_SYNC_RESET		(CPU_BASE_OFFS + 0x174)
+#define MVP_NOC_RESET_REQ_MASK			0x70103
+#define VPU_IDLE_BITS				0x7103
+#define WRAPPER_EFUSE_MONITOR			(WRAPPER_BASE_OFFS + 0x08)
+
+#define APV_CLK_HALT		BIT(1)
+#define CORE_CLK_HALT		BIT(0)
+#define CORE_PWR_ON		BIT(1)
+#define DISABLE_VIDEO_APV_BIT	BIT(27)
+#define DISABLE_VIDEO_VPP1_BIT	BIT(28)
+#define DISABLE_VIDEO_VPP0_BIT	BIT(29)
+
+static int iris_vpu4x_genpd_set_hwmode(struct iris_core *core, bool hw_mode, u32 efuse_value)
+{
+	int ret;
+
+	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], hw_mode);
+	if (ret)
+		return ret;
+
+	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT)) {
+		ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs
+					      [IRIS_VPP0_HW_POWER_DOMAIN], hw_mode);
+		if (ret)
+			goto restore_hw_domain_mode;
+	}
+
+	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT)) {
+		ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs
+					      [IRIS_VPP1_HW_POWER_DOMAIN], hw_mode);
+		if (ret)
+			goto restore_vpp0_domain_mode;
+	}
+
+	if (!(efuse_value & DISABLE_VIDEO_APV_BIT)) {
+		ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs
+					      [IRIS_APV_HW_POWER_DOMAIN], hw_mode);
+		if (ret)
+			goto restore_vpp1_domain_mode;
+	}
+
+	return 0;
+
+restore_vpp1_domain_mode:
+	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT))
+		dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VPP1_HW_POWER_DOMAIN],
+					!hw_mode);
+restore_vpp0_domain_mode:
+	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
+		dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VPP0_HW_POWER_DOMAIN],
+					!hw_mode);
+restore_hw_domain_mode:
+	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], !hw_mode);
+
+	return ret;
+}
+
+static int iris_vpu4x_power_on_apv(struct iris_core *core)
+{
+	int ret;
+
+	ret = iris_enable_power_domains(core,
+					core->pmdomain_tbl->pd_devs[IRIS_APV_HW_POWER_DOMAIN]);
+	if (ret)
+		return ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_APV_HW_CLK);
+	if (ret)
+		goto disable_apv_hw_power_domain;
+
+	return 0;
+
+disable_apv_hw_power_domain:
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_APV_HW_POWER_DOMAIN]);
+
+	return ret;
+}
+
+static void iris_vpu4x_power_off_apv(struct iris_core *core)
+{
+	bool handshake_done, handshake_busy;
+	u32 value, count = 0;
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	if (value & APV_CLK_HALT)
+		writel(0x0, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	do {
+		writel(REQ_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+		value = readl(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS);
+
+		handshake_done = value & NOC_LPI_STATUS_DONE;
+		handshake_busy = value & (NOC_LPI_STATUS_DENY | NOC_LPI_STATUS_ACTIVE);
+
+		if (handshake_done || !handshake_busy)
+			break;
+
+		writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+
+	} while (++count < 1000);
+
+	if (!handshake_done && handshake_busy)
+		dev_err(core->dev, "LPI handshake timeout\n");
+
+	writel(0x080200, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_REQ);
+	readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_RESET_ACK,
+			   value, value & 0x080200, 200, 2000);
+
+	writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_SYNCRST);
+	writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_REQ);
+	readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_RESET_ACK,
+			   value, value == 0x0, 200, 2000);
+
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_APV_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_APV_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_APV_BRIDGE_SYNC_RESET);
+
+	iris_disable_unprepare_clock(core, IRIS_APV_HW_CLK);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_APV_HW_POWER_DOMAIN]);
+}
+
+static void iris_vpu4x_ahb_sync_reset_apv(struct iris_core *core)
+{
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_APV_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_APV_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_APV_BRIDGE_SYNC_RESET);
+}
+
+static void iris_vpu4x_ahb_sync_reset_hardware(struct iris_core *core)
+{
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+}
+
+static int iris_vpu4x_enable_hardware_clocks(struct iris_core *core, u32 efuse_value)
+{
+	int ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_CLK);
+	if (ret)
+		return ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_HW_FREERUN_CLK);
+	if (ret)
+		goto disable_axi_clock;
+
+	ret = iris_prepare_enable_clock(core, IRIS_HW_CLK);
+	if (ret)
+		goto disable_hw_free_run_clock;
+
+	ret = iris_prepare_enable_clock(core, IRIS_BSE_HW_CLK);
+	if (ret)
+		goto disable_hw_clock;
+
+	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT)) {
+		ret = iris_prepare_enable_clock(core, IRIS_VPP0_HW_CLK);
+		if (ret)
+			goto disable_bse_hw_clock;
+	}
+
+	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT)) {
+		ret = iris_prepare_enable_clock(core, IRIS_VPP1_HW_CLK);
+		if (ret)
+			goto disable_vpp0_hw_clock;
+	}
+
+	return 0;
+
+disable_vpp0_hw_clock:
+	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
+		iris_disable_unprepare_clock(core, IRIS_VPP0_HW_CLK);
+disable_bse_hw_clock:
+	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
+disable_hw_clock:
+	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+disable_hw_free_run_clock:
+	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
+disable_axi_clock:
+	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+
+	return ret;
+}
+
+static void iris_vpu4x_disable_hardware_clocks(struct iris_core *core, u32 efuse_value)
+{
+	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT))
+		iris_disable_unprepare_clock(core, IRIS_VPP1_HW_CLK);
+
+	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
+		iris_disable_unprepare_clock(core, IRIS_VPP0_HW_CLK);
+
+	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
+	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+}
+
+static int iris_vpu4x_power_on_hardware(struct iris_core *core)
+{
+	u32 efuse_value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+	int ret;
+
+	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	if (ret)
+		return ret;
+
+	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT)) {
+		ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs
+						[IRIS_VPP0_HW_POWER_DOMAIN]);
+		if (ret)
+			goto disable_hw_power_domain;
+	}
+
+	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT)) {
+		ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs
+						[IRIS_VPP1_HW_POWER_DOMAIN]);
+		if (ret)
+			goto disable_vpp0_power_domain;
+	}
+
+	ret = iris_vpu4x_enable_hardware_clocks(core, efuse_value);
+	if (ret)
+		goto disable_vpp1_power_domain;
+
+	if (!(efuse_value & DISABLE_VIDEO_APV_BIT)) {
+		ret = iris_vpu4x_power_on_apv(core);
+		if (ret)
+			goto disable_hw_clocks;
+
+		iris_vpu4x_ahb_sync_reset_apv(core);
+	}
+
+	iris_vpu4x_ahb_sync_reset_hardware(core);
+
+	ret = iris_vpu4x_genpd_set_hwmode(core, true, efuse_value);
+	if (ret)
+		goto disable_apv_power_domain;
+
+	return 0;
+
+disable_apv_power_domain:
+	if (!(efuse_value & DISABLE_VIDEO_APV_BIT))
+		iris_vpu4x_power_off_apv(core);
+disable_hw_clocks:
+	iris_vpu4x_disable_hardware_clocks(core, efuse_value);
+disable_vpp1_power_domain:
+	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT))
+		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
+						[IRIS_VPP1_HW_POWER_DOMAIN]);
+disable_vpp0_power_domain:
+	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
+		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
+						[IRIS_VPP0_HW_POWER_DOMAIN]);
+disable_hw_power_domain:
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+
+	return ret;
+}
+
+static void iris_vpu4x_power_off_hardware(struct iris_core *core)
+{
+	u32 efuse_value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+	bool handshake_done, handshake_busy;
+	u32 value, count = 0;
+
+	iris_vpu4x_genpd_set_hwmode(core, false, efuse_value);
+
+	if (!(efuse_value & DISABLE_VIDEO_APV_BIT))
+		iris_vpu4x_power_off_apv(core);
+
+	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
+
+	if (!(value & CORE_PWR_ON))
+		goto disable_clocks_and_power;
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	if (value & CORE_CLK_HALT)
+		writel(0x0, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	readl_poll_timeout(core->reg_base + VCODEC_SS_IDLE_STATUSN, value,
+			   value & VPU_IDLE_BITS, 2000, 20000);
+
+	do {
+		writel(REQ_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+		value = readl(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS);
+
+		handshake_done = value & NOC_LPI_STATUS_DONE;
+		handshake_busy = value & (NOC_LPI_STATUS_DENY | NOC_LPI_STATUS_ACTIVE);
+
+		if (handshake_done || !handshake_busy)
+			break;
+
+		writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+
+	} while (++count < 1000);
+
+	if (!handshake_done && handshake_busy)
+		dev_err(core->dev, "LPI handshake timeout\n");
+
+	writel(MVP_NOC_RESET_REQ_MASK, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_REQ);
+	readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_RESET_ACK,
+			   value, value == MVP_NOC_RESET_REQ_MASK, 200, 2000);
+
+	writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_SYNCRST);
+	writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_REQ);
+	readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_RESET_ACK,
+			   value, value == 0x0, 200, 2000);
+
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+
+disable_clocks_and_power:
+	iris_vpu4x_disable_hardware_clocks(core, efuse_value);
+
+	if (!(efuse_value & DISABLE_VIDEO_VPP1_BIT))
+		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
+					   [IRIS_VPP1_HW_POWER_DOMAIN]);
+
+	if (!(efuse_value & DISABLE_VIDEO_VPP0_BIT))
+		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
+					   [IRIS_VPP0_HW_POWER_DOMAIN]);
+
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+}
+
+const struct vpu_ops iris_vpu4x_ops = {
+	.power_off_hw = iris_vpu4x_power_off_hardware,
+	.power_on_hw = iris_vpu4x_power_on_hardware,
+	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
+	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
+	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
+	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+};
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index 7cf4304604cca590544a938c7e811c202cea3d93..f6dffc613b822341fb21e12de6b1395202f62cde 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -12,6 +12,7 @@ extern const struct vpu_ops iris_vpu2_ops;
 extern const struct vpu_ops iris_vpu3_ops;
 extern const struct vpu_ops iris_vpu33_ops;
 extern const struct vpu_ops iris_vpu35_ops;
+extern const struct vpu_ops iris_vpu4x_ops;
 
 struct vpu_ops {
 	void (*power_off_hw)(struct iris_core *core);

-- 
2.34.1

