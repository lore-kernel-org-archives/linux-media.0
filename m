Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914DD307AE9
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770237; cv=none; b=HV6OSqJktxsqDaq3sc6Vj7WP87AsRNSZKlnAhc3uSr3mPiLiXQuV9UR244McFXh3cSETfsvSd/uZU3rKjkn06gcGhYoOXcuQRN0braM8TQsm+lTiFxEO5qb2xczAIB0hLMlYUgoPs5/zWW/ORDqePJGMjE4ApVy19Z6dOpmqyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770237; c=relaxed/simple;
	bh=/KdwgBhOH37SHZmxnQABhGNsSw+zHM74t/5oA3kZyu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPzoyx6CqR1hxykHt56iyM2032K3k1+4BZx3uv9ke1bme9yc+fRa2YcYcg9SxyeAQwLFhpQEf0v+fi30bm9IuN2+jslGx2Ik738K1/aQjH4Btbal1HWEyIMkJ1jkkqsc2C590tony33B2YjWnFCaaOtUk74VrIFPoKbFmSjA0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FF7Of8IY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RKGohIzp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FF7Of8IY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RKGohIzp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9CgGG3146244
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 10:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dyMUPVIW3QaoDektteGnKCoKjTcCA2z4ZpXyNubAd0Q=; b=FF7Of8IY9T4hUvfz
	6L/rw+wtK62Esy4dYnZmPHM4yQyABD2Gyi5pGQv6Ei39BSRCHmF2oA/liBbsLRgs
	ttqKmix0ZNRPPvIPhhtctsCSIrwk0pgSW8Da+z14RJC8dbmOQVNvfa/qUJ52o1px
	5DHjSnE6GxAUus6pLXTIv4mPWtQiRdfrCioGOawYSdTpkWxeuO4b3vQYqDgiI+a3
	a1DzoOGQMiq34xyYD4zB52goHf1XRUDJp1PUDwlG7LpexQsDLNEYFYk5OOC4Y269
	AcQJCig5OsVDFTVzjiAFWiMdiQF7yT0id8Sov1UH2H8h8Pl1r8NxYZ1dXfTaHlQz
	LSaw1w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd7hr7x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 10:23:52 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7900f597d08so2774041b3a.1
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 02:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762770231; x=1763375031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyMUPVIW3QaoDektteGnKCoKjTcCA2z4ZpXyNubAd0Q=;
        b=RKGohIzpdec1oE3ikt6HAC5/+tSlnorXW2p7u6LVB0/WoSr2DSLG0vTDoP363Ap8cH
         6R0dTMqztaiEOvXzN+54nfghNf41/3PCunU0Exi/Qu5A/H4V7u3uqcMpvHSkH4VecSMa
         Z3cGNyZ/ekCxHQJFz40klm9gCHXT3J94diwyQ7ChW7yUGTSWsbq1Tezl1kr22iDwPFVm
         fbHoITTImUsT/Ub6EnL2jzpjIbLj4lRDP0stq2du+T4R12mbpQmIKiQn+k6hZtOAHJgS
         VkW2nKMQ2XRum5QaEb5ja4Y6DGZCwX1V5p3zQUArtRGKHcT39mSW3OA9RhgN2OMntbxP
         ntgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770231; x=1763375031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dyMUPVIW3QaoDektteGnKCoKjTcCA2z4ZpXyNubAd0Q=;
        b=dePDlEwrGEpiwauL2ktjdqIU2Wgop9KGbLCH/d/7H7xtYYGUF7b6F/zNCDHjTv3PRj
         AYX9vAv5MN3UZWPhCFxDGBLI4L9Yi8CkI08a9vDah1lE1hN8MkZ8MzjsKrr6MKHX0ggo
         8mMO9Flv5muaPXsq9zH/OLQCGQj493tMyWLyV18jwsey2FEpwLVGlOMnWo2cswJsPkxj
         EUT7vYBeHaymBomtM4WrCtD3OxClScU0L8DX9GDxXLzw879/CmOU7Lhf2EkVub8wNfbJ
         CAgjxx8oljSSNx1q2IYYfwGGYqICJpVIRVFPmR6/6qCbkG7q0xXaLzgVfLeH8Pi6yWOs
         rIhw==
X-Gm-Message-State: AOJu0YxrxDNLldGuytTlFezuF+9lT1AeGFsD/fGhCXNTkVd6P3Np8FIj
	VMsw/UvGBpItg1aQG/HpMjTYqZnQUqDFi1U8SmWE+6ejg+qZS/8SG0aUWKS5Xf7eYoyO0TsilDG
	yrfvndTdG6/MCiyLBcE3+Ecs0dVAJuZEqgUgZ7+piFcBGz5VIiKuI8vQFs977B6aH0w==
X-Gm-Gg: ASbGnctoGSDRHIX3BLfyTQnOER7lBzii3S0gOS9yCtTjMF4CytR3y0lyUAdTzzGUbHc
	rEfUPopIqjoJIZhbqYObqbv7Ub04DOM0dDm22Qrs6iOBO7hI9GpTl+HKsIIyAjb4hkra97Ngay/
	vNeT0limwqeEtYBH5z5EtrwavexEGHno7V/Z2LR7d1TX1vcdyhOQmTkB73PFeVeZja+AY9DW9iT
	ltk7LOz4t9LJgoBvqEKbZhJqNIAK4uS5/9waE5155oUqu8Q2lSQoN31XRxH0JVHNUOpnxVzHYXC
	dm2kPAuag1mIER4b3H2ZFdmKuhMcYDhl3v2nbqnzWbiNpYI6tGWN1ws70HpZxzmXi0zJWhEN+wU
	DttmTPQxyWKskLN7MjQPkZF1ayqWjUlCh1IipVjTvR+HGPYes73kHO4HWJV7vrJH3GC1GQmKGFg
	==
X-Received: by 2002:a05:6a00:124b:b0:7aa:bd80:f4db with SMTP id d2e1a72fcca58-7b225aed47emr9460924b3a.5.1762770231257;
        Mon, 10 Nov 2025 02:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5YDn7+Xxy583OJQYUj0pLab+7Q2HQ8j7YkZLyN/VWd68HeJjuld1HcDPXH2TLuB00At1qWA==
X-Received: by 2002:a05:6a00:124b:b0:7aa:bd80:f4db with SMTP id d2e1a72fcca58-7b225aed47emr9460882b3a.5.1762770230533;
        Mon, 10 Nov 2025 02:23:50 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm11153832b3a.34.2025.11.10.02.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:23:50 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:23:15 +0800
Subject: [PATCH v5 4/6] media: qcom: iris: Add rotation support for encoder
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-iris_encoder_enhancements-v5-4-1dbb19968bd5@oss.qualcomm.com>
References: <20251110-iris_encoder_enhancements-v5-0-1dbb19968bd5@oss.qualcomm.com>
In-Reply-To: <20251110-iris_encoder_enhancements-v5-0-1dbb19968bd5@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762770213; l=14676;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=/KdwgBhOH37SHZmxnQABhGNsSw+zHM74t/5oA3kZyu4=;
 b=arUwA9ZMgJJCCC9OWi4dl7AFdQyWBeK+cSre4h5aMEadVk5PXeWF7dGd2/Mn+5LhiOpPQwrCw
 i0pWlG1FOmlBZw4dkxOYOdqMZ5S6nJPp0FEis2TvzQ1dHS3MTC31uPL
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-GUID: 6wzw1LM3CWmTnEOVT9a_0Jlj8ire2AQh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MCBTYWx0ZWRfX8nVmEaKFnAYE
 wMX8XSFbaBbMFV38+ohYxDbLe1i5LoA3FFlYMvbIa03ExuDpkfrRszhjYiS8+f24l3cgbA1YFGx
 ZbVEpnVTQlwbyQmcMWTLLKowaX1KBpT1+6Q/RdyVwZ+7LsBHw8NQpVwa74smVkJD1Nq9L2+z08S
 MjhQNwkwAVh5RtMctksXctcnREDdG6meoFfjt0OqQROaEn+ZCVsvpbPpiWWKGkFYFpaN9/rZ/ja
 Yii6yeJev8yAOzbGUJmMvJfarsd/vpYH7WuREzSZR67GmO+JUthLSh5H78QA7yNFxDKFVQyGYr/
 ls0Hhqko6S0HRBxaujF2a7qQmZAuOQlsG2HYXuCtyjnS0VXoh8Zy7nT0MDpEBFWtksYI5QfD8Y6
 KsQcsDKbFLqAYplA3IgnCYkufe4tQA==
X-Proofpoint-ORIG-GUID: 6wzw1LM3CWmTnEOVT9a_0Jlj8ire2AQh
X-Authority-Analysis: v=2.4 cv=Yt4ChoYX c=1 sm=1 tr=0 ts=6911bd38 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=0PQ7lrkXE1FeiLWnmyUA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100090

Add rotation control for encoder, enabling V4L2_CID_ROTATE and handling
 90/180/270 degree rotation.

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c      | 34 +++++++++++++++
 drivers/media/platform/qcom/iris/iris_ctrls.h      |  1 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 41 ++++++++++++-----
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  9 ++++
 .../platform/qcom/iris/iris_platform_common.h      |  1 +
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 10 +++++
 drivers/media/platform/qcom/iris/iris_utils.c      |  6 +++
 drivers/media/platform/qcom/iris/iris_utils.h      |  1 +
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 51 +++++++++++++---------
 9 files changed, 123 insertions(+), 31 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 754a5ad718bc37630bb861012301df7a2e7342a1..00949c207ddb0203e51df359214bf23c3d8265d0 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -98,6 +98,8 @@ static enum platform_inst_fw_cap_type iris_get_cap_id(u32 id)
 		return B_FRAME_QP_H264;
 	case V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP:
 		return B_FRAME_QP_HEVC;
+	case V4L2_CID_ROTATE:
+		return ROTATION;
 	default:
 		return INST_FW_CAP_MAX;
 	}
@@ -185,6 +187,8 @@ static u32 iris_get_v4l2_id(enum platform_inst_fw_cap_type cap_id)
 		return V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP;
 	case B_FRAME_QP_HEVC:
 		return V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP;
+	case ROTATION:
+		return V4L2_CID_ROTATE;
 	default:
 		return 0;
 	}
@@ -883,6 +887,36 @@ int iris_set_qp_range(struct iris_inst *inst, enum platform_inst_fw_cap_type cap
 				     &range, sizeof(range));
 }
 
+int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id)
+{
+	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
+	u32 hfi_id = inst->fw_caps[cap_id].hfi_id;
+	u32 hfi_val;
+
+	switch (inst->fw_caps[cap_id].value) {
+	case 0:
+		hfi_val = HFI_ROTATION_NONE;
+		return 0;
+	case 90:
+		hfi_val = HFI_ROTATION_90;
+		break;
+	case 180:
+		hfi_val = HFI_ROTATION_180;
+		break;
+	case 270:
+		hfi_val = HFI_ROTATION_270;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return hfi_ops->session_set_property(inst, hfi_id,
+					     HFI_HOST_FLAGS_NONE,
+					     iris_get_port_info(inst, cap_id),
+					     HFI_PAYLOAD_U32,
+					     &hfi_val, sizeof(u32));
+}
+
 int iris_set_properties(struct iris_inst *inst, u32 plane)
 {
 	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.h b/drivers/media/platform/qcom/iris/iris_ctrls.h
index 30af333cc4941e737eb1ae83a6944b4192896e23..3ea0a00c7587a516f19bb7307a0eb9a60c856ab0 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.h
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.h
@@ -32,6 +32,7 @@ int iris_set_min_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_i
 int iris_set_max_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_frame_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_qp_range(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
+int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_properties(struct iris_inst *inst, u32 plane);
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 8945e94ec9e87750fc87bebf63f4fbb634d8571a..140f56c988f452227197b2b6a2070a2e07cc6e0e 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -180,22 +180,36 @@ static int iris_hfi_gen2_set_raw_resolution(struct iris_inst *inst, u32 plane)
 						  sizeof(u32));
 }
 
+static inline u32 iris_hfi_get_aligned_resolution(struct iris_inst *inst, u32 width, u32 height)
+{
+	u32 codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
+
+	return (ALIGN(width, codec_align) << 16 | ALIGN(height, codec_align));
+}
+
 static int iris_hfi_gen2_set_bitstream_resolution(struct iris_inst *inst, u32 plane)
 {
 	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
 	u32 port = iris_hfi_gen2_get_port(inst, plane);
 	enum hfi_packet_payload_info payload_type;
-	u32 resolution, codec_align;
+	u32 width, height;
+	u32 resolution;
 
 	if (inst->domain == DECODER) {
-		resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
-			inst->fmt_src->fmt.pix_mp.height;
+		width = inst->fmt_src->fmt.pix_mp.width;
+		height = inst->fmt_src->fmt.pix_mp.height;
+		resolution = iris_hfi_get_aligned_resolution(inst, width, height);
 		inst_hfi_gen2->src_subcr_params.bitstream_resolution = resolution;
 		payload_type = HFI_PAYLOAD_U32;
 	} else {
-		codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
-		resolution = ALIGN(inst->enc_scale_width, codec_align) << 16 |
-			ALIGN(inst->enc_scale_height, codec_align);
+		if (is_rotation_90_or_270(inst)) {
+			width = inst->enc_scale_height;
+			height = inst->enc_scale_width;
+		} else {
+			width = inst->enc_scale_width;
+			height = inst->enc_scale_height;
+		}
+		resolution = iris_hfi_get_aligned_resolution(inst, width, height);
 		inst_hfi_gen2->dst_subcr_params.bitstream_resolution = resolution;
 		payload_type = HFI_PAYLOAD_32_PACKED;
 	}
@@ -237,10 +251,17 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 			left_offset = inst->crop.left;
 			top_offset = inst->crop.top;
 		} else {
-			bottom_offset = (ALIGN(inst->enc_scale_height, codec_align) -
-					inst->enc_scale_height);
-			right_offset = (ALIGN(inst->enc_scale_width, codec_align) -
-				       inst->enc_scale_width);
+			if (is_rotation_90_or_270(inst)) {
+				bottom_offset = (ALIGN(inst->enc_scale_width, codec_align) -
+						inst->enc_scale_width);
+				right_offset = (ALIGN(inst->enc_scale_height, codec_align) -
+					       inst->enc_scale_height);
+			} else {
+				bottom_offset = (ALIGN(inst->enc_scale_height, codec_align) -
+						inst->enc_scale_height);
+				right_offset = (ALIGN(inst->enc_scale_width, codec_align) -
+					       inst->enc_scale_width);
+			}
 			left_offset = 0;
 			top_offset = 0;
 		}
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index aa1f795f5626c1f76a32dd650302633877ce67be..4edcce7faf5e2f74bfecfdbf574391d5b1c9cca5 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
@@ -83,6 +83,15 @@ enum hfi_seq_header_mode {
 };
 
 #define HFI_PROP_SEQ_HEADER_MODE		0x03000149
+
+enum hfi_rotation {
+	HFI_ROTATION_NONE = 0x00000000,
+	HFI_ROTATION_90   = 0x00000001,
+	HFI_ROTATION_180  = 0x00000002,
+	HFI_ROTATION_270  = 0x00000003,
+};
+
+#define HFI_PROP_ROTATION			0x0300014b
 #define HFI_PROP_SIGNAL_COLOR_INFO		0x03000155
 #define HFI_PROP_PICTURE_TYPE			0x03000162
 #define HFI_PROP_DEC_DEFAULT_HEADER		0x03000168
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 58d05e0a112eed25faea027a34c719c89d6c3897..9a4232b1c64eea6ce909e1e311769dd958b84c6e 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -140,6 +140,7 @@ enum platform_inst_fw_cap_type {
 	P_FRAME_QP_HEVC,
 	B_FRAME_QP_H264,
 	B_FRAME_QP_HEVC,
+	ROTATION,
 	INST_FW_CAP_MAX,
 };
 
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index d3306189d902a1f42666010468c9e4e4316a66e1..c1f83e179d441c45df8d6487dc87e137e482fb63 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -588,6 +588,16 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
 		.flags = CAP_FLAG_OUTPUT_PORT,
 		.set = iris_set_u32,
 	},
+	{
+		.cap_id = ROTATION,
+		.min = 0,
+		.max = 270,
+		.step_or_mask = 90,
+		.value = 0,
+		.hfi_id = HFI_PROP_ROTATION,
+		.flags = CAP_FLAG_OUTPUT_PORT,
+		.set = iris_set_rotation,
+	},
 };
 
 static struct platform_inst_caps platform_inst_cap_sm8550 = {
diff --git a/drivers/media/platform/qcom/iris/iris_utils.c b/drivers/media/platform/qcom/iris/iris_utils.c
index 85c70a62b1fd2c409fc18b28f64771cb0097a7fd..97465dfbdec1497b1111b9069fd56dff286b2d0e 100644
--- a/drivers/media/platform/qcom/iris/iris_utils.c
+++ b/drivers/media/platform/qcom/iris/iris_utils.c
@@ -124,3 +124,9 @@ int iris_check_core_mbps(struct iris_inst *inst)
 
 	return 0;
 }
+
+bool is_rotation_90_or_270(struct iris_inst *inst)
+{
+	return inst->fw_caps[ROTATION].value == 90 ||
+		inst->fw_caps[ROTATION].value == 270;
+}
diff --git a/drivers/media/platform/qcom/iris/iris_utils.h b/drivers/media/platform/qcom/iris/iris_utils.h
index 75740181122f5bdf93d64d3f43b3a26a9fe97919..b5705d156431a5cf59d645ce988bc3a3c9b9c5e2 100644
--- a/drivers/media/platform/qcom/iris/iris_utils.h
+++ b/drivers/media/platform/qcom/iris/iris_utils.h
@@ -51,5 +51,6 @@ void iris_helper_buffers_done(struct iris_inst *inst, unsigned int type,
 int iris_wait_for_session_response(struct iris_inst *inst, bool is_flush);
 int iris_check_core_mbpf(struct iris_inst *inst);
 int iris_check_core_mbps(struct iris_inst *inst);
+bool is_rotation_90_or_270(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
index db5adadd1b39c06bc41ae6f1b3d2f924b3ebf150..1e54ace966c74956208d88f06837b97b1fd48e17 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
@@ -556,6 +556,22 @@ static u32 iris_vpu_dec_scratch1_size(struct iris_inst *inst)
 		iris_vpu_dec_line_size(inst);
 }
 
+static inline u32 iris_vpu_enc_get_bitstream_width(struct iris_inst *inst)
+{
+	if (is_rotation_90_or_270(inst))
+		return inst->fmt_dst->fmt.pix_mp.height;
+	else
+		return inst->fmt_dst->fmt.pix_mp.width;
+}
+
+static inline u32 iris_vpu_enc_get_bitstream_height(struct iris_inst *inst)
+{
+	if (is_rotation_90_or_270(inst))
+		return inst->fmt_dst->fmt.pix_mp.width;
+	else
+		return inst->fmt_dst->fmt.pix_mp.height;
+}
+
 static inline u32 size_bin_bitstream_enc(u32 width, u32 height,
 					 u32 rc_type)
 {
@@ -638,10 +654,9 @@ static inline u32 hfi_buffer_bin_enc(u32 width, u32 height,
 static u32 iris_vpu_enc_bin_size(struct iris_inst *inst)
 {
 	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
+	u32 height = iris_vpu_enc_get_bitstream_height(inst);
+	u32 width = iris_vpu_enc_get_bitstream_width(inst);
 	u32 stage = inst->fw_caps[STAGE].value;
-	struct v4l2_format *f = inst->fmt_dst;
-	u32 height = f->fmt.pix_mp.height;
-	u32 width = f->fmt.pix_mp.width;
 	u32 lcu_size;
 
 	if (inst->codec == V4L2_PIX_FMT_HEVC)
@@ -676,9 +691,8 @@ u32 hfi_buffer_comv_enc(u32 frame_width, u32 frame_height, u32 lcu_size,
 
 static u32 iris_vpu_enc_comv_size(struct iris_inst *inst)
 {
-	struct v4l2_format *f = inst->fmt_dst;
-	u32 height = f->fmt.pix_mp.height;
-	u32 width = f->fmt.pix_mp.width;
+	u32 height = iris_vpu_enc_get_bitstream_height(inst);
+	u32 width = iris_vpu_enc_get_bitstream_width(inst);
 	u32 num_recon = 1;
 	u32 lcu_size = 16;
 
@@ -958,9 +972,8 @@ u32 hfi_buffer_non_comv_enc(u32 frame_width, u32 frame_height,
 static u32 iris_vpu_enc_non_comv_size(struct iris_inst *inst)
 {
 	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
-	struct v4l2_format *f = inst->fmt_dst;
-	u32 height = f->fmt.pix_mp.height;
-	u32 width = f->fmt.pix_mp.width;
+	u32 height = iris_vpu_enc_get_bitstream_height(inst);
+	u32 width = iris_vpu_enc_get_bitstream_width(inst);
 	u32 lcu_size = 16;
 
 	if (inst->codec == V4L2_PIX_FMT_HEVC) {
@@ -1051,9 +1064,8 @@ u32 hfi_buffer_line_enc_vpu33(u32 frame_width, u32 frame_height, bool is_ten_bit
 static u32 iris_vpu_enc_line_size(struct iris_inst *inst)
 {
 	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
-	struct v4l2_format *f = inst->fmt_dst;
-	u32 height = f->fmt.pix_mp.height;
-	u32 width = f->fmt.pix_mp.width;
+	u32 height = iris_vpu_enc_get_bitstream_height(inst);
+	u32 width = iris_vpu_enc_get_bitstream_width(inst);
 	u32 lcu_size = 16;
 
 	if (inst->codec == V4L2_PIX_FMT_HEVC) {
@@ -1069,9 +1081,8 @@ static u32 iris_vpu_enc_line_size(struct iris_inst *inst)
 static u32 iris_vpu33_enc_line_size(struct iris_inst *inst)
 {
 	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
-	struct v4l2_format *f = inst->fmt_dst;
-	u32 height = f->fmt.pix_mp.height;
-	u32 width = f->fmt.pix_mp.width;
+	u32 height = iris_vpu_enc_get_bitstream_height(inst);
+	u32 width = iris_vpu_enc_get_bitstream_width(inst);
 	u32 lcu_size = 16;
 
 	if (inst->codec == V4L2_PIX_FMT_HEVC) {
@@ -1292,9 +1303,8 @@ static inline u32 hfi_buffer_scratch1_enc(u32 frame_width, u32 frame_height,
 static u32 iris_vpu_enc_scratch1_size(struct iris_inst *inst)
 {
 	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
-	struct v4l2_format *f = inst->fmt_dst;
-	u32 frame_height = f->fmt.pix_mp.height;
-	u32 frame_width = f->fmt.pix_mp.width;
+	u32 frame_height = iris_vpu_enc_get_bitstream_height(inst);
+	u32 frame_width = iris_vpu_enc_get_bitstream_width(inst);
 	u32 num_ref = 1;
 	u32 lcu_size;
 	bool is_h265;
@@ -1390,9 +1400,8 @@ static inline u32 hfi_buffer_scratch2_enc(u32 frame_width, u32 frame_height,
 
 static u32 iris_vpu_enc_scratch2_size(struct iris_inst *inst)
 {
-	struct v4l2_format *f = inst->fmt_dst;
-	u32 frame_width = f->fmt.pix_mp.width;
-	u32 frame_height = f->fmt.pix_mp.height;
+	u32 frame_height = iris_vpu_enc_get_bitstream_height(inst);
+	u32 frame_width = iris_vpu_enc_get_bitstream_width(inst);
 	u32 num_ref = 1;
 
 	return hfi_buffer_scratch2_enc(frame_width, frame_height, num_ref,

-- 
2.43.0

