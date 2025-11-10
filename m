Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12A2FFDCC
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770226; cv=none; b=SQBsJN8H0LK60nS7SAEjcEv/oOz6+mXKRED2hqXjBAFZUDr+J1vdsL47S3WoH7gLjX3NGnxVNoDoBpM49peGe336AJzmlR3Zo9PdS9YyIKW2RyJ84UQNnS+ovP7IQDUvS+EfPEEavakSiUJoFUKVhOo5CeEy2s1sv996EmArrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770226; c=relaxed/simple;
	bh=shJK7ajsNqFBFJaWVzEwFsy7w8X7aKP/iwR8uqxxodQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3SRccgxTQE2U/mP3Sq0QM7Z9fWmnkrE1cCwq4VreafSSJeVjsAxkkINzgQMsxjXHYSZBbqNAxSZnqwpTubbZBB5I9W6d4mvKsnqxNaODiz/0TwyzC+47OOznlt1bRyqi5u/Xxtj0TKWOxbDD11F5OAPBcB7i9p2zPI4GWDGzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QHzegJ9J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FELaa7pm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QHzegJ9J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FELaa7pm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8BFMR1144629
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 10:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gQhz4uNxSVTydOe8ll/dSa1TV34W5JQ/86IcLO6jK2g=; b=QHzegJ9Jek8buRJr
	nK5qH0NsqLkvwnzXy0n5Q3SpjyCGEj6QJ0xXHxnMa9NpHMBbIYdBgywzY0/EBwi0
	1IDHXNytFlK3aSsAy9oEcVvF4heuTMylJ8QF7cxhQEgiAiWQnJC054MrX11p6Gmd
	3nGlaFP/+//1Vi813xDxtUCrnKjqPoXQihIvfeZ9BbLQkfxcgAC4R0gF3fEgcX2x
	D9+jdrzOEk0IAeFynqfFZdtL+WYuZAnW6fKYfIqOvJuAj76zm9hSyRxp2CbkOAGl
	ilNpb5M/vqFPwP91IhN0rwYyQrWH85mI0kLES/3F6CSgYj92iy/lGiE9vcGTjSx1
	gKu4oQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjcbud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 10:23:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7ae9be0d8d5so5699704b3a.3
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 02:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762770221; x=1763375021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQhz4uNxSVTydOe8ll/dSa1TV34W5JQ/86IcLO6jK2g=;
        b=FELaa7pmZDRsUqDYTTtxB6+xN+MbkQvF5pR9aZ3lCOc2L77MYa45/n6eGpcBR8et4y
         AZRTocN9hPNK0CWkdxSsTJ0YK3Socj6zGsDqXJZAlIHkN3GhO9cDSrHoMFLU15vrckCM
         4fbXdyxN9ZY/5THrdlmo2YxS16JlZXiG/S6Iwui7psJDvBStjzMPb20WthIEbFtggLb+
         tIFGELTU/ZxTfGZ2CP9voLPIUedGZGgn3zAJaFTZXZvFW99QRgFizXCqNFrqsMhxSKWB
         djkiYa/M3fu6tQoFmg5PkW6yk+4/3p9vr4yBSevmpKWPc96WXBSWvI1Vr8ahaL7XKjwH
         IuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770221; x=1763375021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQhz4uNxSVTydOe8ll/dSa1TV34W5JQ/86IcLO6jK2g=;
        b=ntyR7xlHVKkZ7hoSyEYT+cPp2Tgm4XMTxD6pk68MlqKFVGP4DwuJzg9xOTmMB3srFp
         d/w2Jgtm3QmPiRU8z8w7e3EkKYv3A6BrSvnUwDVDpzQzPF/E1j1lQsDkxvD32TsSMqsu
         bzSbfe8VQ3WRyYXbAmt60Q0RYbqTOgRR1WvPWSZA1mrJenhQ8+UUYvz8rNgxq7+2bDDa
         1diy4pqIeW3Fxcs6xUrN67Jixo6T8LNnUBbBKIX0Fr0tinHPkTElezxrt7c+m+EW+uaA
         pvjp7+aSW1L8sObqAPSAK3Qb74dWzCa9PWqEl2c2wQjf0h04dpZI5AfnvVXyNX99ri9R
         fYgA==
X-Gm-Message-State: AOJu0Yy3AxEWUDu0tbil7jhAg8A+UEOK3SnrGjq9rk6qnMRuQphpxKoF
	nSR284pq248NjrqNxRTlz9X+lU3aZ9RtUVLLoTmepnYdOO7RlwcNN/rWx5O4IgHExxlZkI6y6WE
	49ZsKHT1AJNMOj8oyGYZgzJ+yFUxVUlDStOZLAGKBYF4MR8F/030NtXrf28BJHLIi/AFSXfw2WV
	WR
X-Gm-Gg: ASbGncuTTvK19RM3BeK1pzpvyblWxV+a0YNmhYkrf4xqoCsBHAZNQlLkOELoqs+mGJ2
	ZODhDoF44eiqPe+lWuhPCHGapCeafLM/PJFjwCmmY35s5Ca1zvR+7zW5+mykXnUsL5UFoTDF1y6
	njPKgG8HfsMKoaPe2rHYaxe7LSEdAKNZ0iuEZC72u2117UUur1hgTBI1ZgZHGXwFOiwo5sHaB8Z
	hVd6zO0MLcjzy+7FRFjjmz+iSq9Mzgf2rjPhqypIUDzzJgQcwSxDEzZi2FaL74RobCUJPaUzDAw
	jb8f28VS/ffmcbYR17ZfFI7vZ7DxS+sJmSLTZAbFOiHCEeG0BWPhfNxCawYjaJY6AG6RiNUdToN
	O2qGCFZrPL/cPgKhABMeCLaJLrPYYtiSb2l0h4nxabo2Wt587u2MrM2dANVClwa39jwYQHLIgNQ
	==
X-Received: by 2002:a05:6a00:138b:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7b225b6e947mr9006542b3a.10.1762770220584;
        Mon, 10 Nov 2025 02:23:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP6BQkQxVi6bdkeW0sMfQKTtiLwy4raEK8y4cUl+jwF3eMZvwFgd3Qht6lBmHXH6c7KlL50g==
X-Received: by 2002:a05:6a00:138b:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7b225b6e947mr9006510b3a.10.1762770220086;
        Mon, 10 Nov 2025 02:23:40 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm11153832b3a.34.2025.11.10.02.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:23:39 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:23:12 +0800
Subject: [PATCH v5 1/6] media: qcom: iris: Improve format alignment for
 encoder
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-iris_encoder_enhancements-v5-1-1dbb19968bd5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762770213; l=3388;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=shJK7ajsNqFBFJaWVzEwFsy7w8X7aKP/iwR8uqxxodQ=;
 b=DyKumYDHQgn3k2u0AXKwR3U0ftWmRYVq2/1JxHMvkUBpPxb2sdxBN9n6dHFtTLkenewBclgNW
 9X55j/0p5aVDBqnoLHMRFe5323JRKCW/LvB+yLipT2fUwA0sIT4S5ho
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=6911bd2d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Ydk8v881x4eQe87C_TwA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kSYQscf1qvRb3mNA2zHZqIVyar32z1UY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MCBTYWx0ZWRfXzZXcEdqHuHYK
 rW15oSwgEKa2uy1NCiLa2EAbOzjfI8BrZRvf5bC+6gIGEqI2XvEkZVeEqlsCv7jFSM+BJu6xLvM
 g/yKLq4LK1QqqNVvokg5wfmeHHVAlvaVOTct6zQNkgr1grirTnCLBF6Nf5ZWgKmi/+y27PSHzLZ
 I0vaTYHPQApyyDgFuAxTOm4+Jz5vWhlyenoZ7q8q0zr0qrmToEdc9uEFu031YX9xug+7oZKUajt
 JxP2EDHJr62tkj8FsdCVeyG9u4BEqccGo6Riag4sBnkUqB5sCsCrayi2lrX1J08fpNqEALBx0ML
 ayXLOf8FvRo0j3Q8rSVWnVkg3d4pQgNuig8YjtFG4SP//s5hlMAqxghVJxTf4H+w0S77qYJeGcJ
 gEyT/nO0J8nIjYkcBkp7CAWk0Vp66g==
X-Proofpoint-GUID: kSYQscf1qvRb3mNA2zHZqIVyar32z1UY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100090

Add members enc_raw_width, enc_raw_height to the struct iris_inst to
support codec alignment requirements.

HFI_PROP_RAW_RESOLUTION needs to be set to the actual YUV resolution.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 3 +--
 drivers/media/platform/qcom/iris/iris_instance.h         | 4 ++++
 drivers/media/platform/qcom/iris/iris_venc.c             | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 4ce71a14250832440099e4cf3835b4aedfb749e8..48962d2e4962935bbc24244edfbbdcd42dab151f 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -168,8 +168,7 @@ static int iris_hfi_gen2_session_set_property(struct iris_inst *inst, u32 packet
 
 static int iris_hfi_gen2_set_raw_resolution(struct iris_inst *inst, u32 plane)
 {
-	u32 resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
-		inst->fmt_src->fmt.pix_mp.height;
+	u32 resolution = inst->enc_raw_width << 16 | inst->enc_raw_height;
 	u32 port = iris_hfi_gen2_get_port(inst, plane);
 
 	return iris_hfi_gen2_session_set_property(inst,
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 5982d7adefeab80905478b32cddba7bd4651a691..a9892988c10bc28e9b2d8c3b5482e99b5b9af623 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -64,6 +64,8 @@ struct iris_fmt {
  * @frame_rate: frame rate of current instance
  * @operating_rate: operating rate of current instance
  * @hfi_rc_type: rate control type
+ * @enc_raw_width: source image width for encoder instance
+ * @enc_raw_height: source image height for encoder instance
  */
 
 struct iris_inst {
@@ -102,6 +104,8 @@ struct iris_inst {
 	u32				frame_rate;
 	u32				operating_rate;
 	u32				hfi_rc_type;
+	u32				enc_raw_width;
+	u32				enc_raw_height;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 099bd5ed4ae0294725860305254c4cad1ec88d7e..50a3eb975a2523abf1c2df128a66a762a1ed35c6 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -68,6 +68,9 @@ int iris_venc_inst_init(struct iris_inst *inst)
 	inst->operating_rate = DEFAULT_FPS;
 	inst->frame_rate = DEFAULT_FPS;
 
+	inst->enc_raw_width = DEFAULT_WIDTH;
+	inst->enc_raw_height = DEFAULT_HEIGHT;
+
 	memcpy(&inst->fw_caps[0], &core->inst_fw_caps_enc[0],
 	       INST_FW_CAP_MAX * sizeof(struct platform_inst_fw_cap));
 
@@ -249,6 +252,9 @@ static int iris_venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
 	inst->buffers[BUF_INPUT].min_count = iris_vpu_buf_count(inst, BUF_INPUT);
 	inst->buffers[BUF_INPUT].size = fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
 
+	inst->enc_raw_width = f->fmt.pix_mp.width;
+	inst->enc_raw_height = f->fmt.pix_mp.height;
+
 	if (f->fmt.pix_mp.width != inst->crop.width ||
 	    f->fmt.pix_mp.height != inst->crop.height) {
 		inst->crop.top = 0;

-- 
2.43.0

