Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B312D6E63
	for <linux-media@vger.kernel.org>; Sat,  8 Nov 2025 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762575855; cv=none; b=pgiRJW8mI/tjLo6G8HARElcssKD7Gumpxxmwk3OK5II87zbaoBSh5F8AWVFLKQ6QchGDClR2lB7tkBoqYBUc0YvKqS0iBtA2O5DzjaYw7mcCzQgI8BtLg4L8QUHXuNaWL4clHR5uyZPQU4ZQ63pkdwfgQt7sS1MmTWnpw+P9Ubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762575855; c=relaxed/simple;
	bh=FzzoO9k4M9sQjlK8nyUnKg9cqOI8/oU0g2MJWe3xnTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zh5b9ulgtSI0CvEHSKgOaR7jUI1OkRtc8Ht4FWquMCleqe9b+4igiB/LU0LswHvtHLsCAsvrjocidmUV360l4ulywdQ2UalOVrFKF6p+vku1H8dehmBvn4VhQW7dn0L4fYeh12o+CcKJk85hyhOyTy7OtFwzkD17McvVprX3rvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQWbF1JA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2BH/8E3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQWbF1JA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2BH/8E3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7DPMZW3129682
	for <linux-media@vger.kernel.org>; Sat, 8 Nov 2025 04:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NYWtNOwI1aavZwSln38Rwrj/x9o/h5lzzgA17JpG11A=; b=PQWbF1JA+YRre02j
	6ov2H3s0wFa1k+zR2e3qpIMvrpzqQGye0/+hzDEex5CIWVuXOP2NC9xD5kqib2Cz
	z8/ctrhnnPHeTpNMfiaYxCXRLLWbmlnw2tjnkKfWoLmWRzs4EgELl+95LobRFXd7
	+kUvAFjwaT/bfusuzLg14A90ehNCgTgd8pzNJRrBLasbvOT+fzuqef5gAIGZmBVX
	7TuHb0abn3z090LchFlFkIGTp+8rox/EYlVhALIQIDU5xdPa+OpriqdnYBd7znfZ
	gI4Te8mM2e2QFAsqILJZlGx2q/A3prD6qaaOMSIqtJJtMq8YMsuJZAZ4x92n/cRf
	7SjN9w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9hn09wkv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Sat, 08 Nov 2025 04:24:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2964d6164bfso4663775ad.0
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 20:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762575852; x=1763180652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYWtNOwI1aavZwSln38Rwrj/x9o/h5lzzgA17JpG11A=;
        b=K2BH/8E3eG6z3N7WFc9Npap/UalmvciU0rpTboWvNG1p12bBjQTX01XZ1jI5SCzUKE
         AyAgfYnlT969/VAD509ulJI3E+PFZ5w6+JvmA1Of/MBLWXFABrPb7V29/tdG9m1Kkq4F
         lGugsEUpLAhDcM2+5ahVOtkpwwRN0tNPlzeZn27aaeBgA6XPWAAakZuQWtUqRORV/jxg
         /3L4GJSK1pCydad96yZTxNjHe6TPwZfzIJ9m+69RiJhOCezbjw6kHvUsiIVjTPHbSFUZ
         3uwDhFy9AFMwtyDSqoeHVWLO3MFwHOeWe9Xs6kHr6uLNXAzmiYMwDutLXj4IY8bW1rn1
         fc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762575852; x=1763180652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NYWtNOwI1aavZwSln38Rwrj/x9o/h5lzzgA17JpG11A=;
        b=a113OW1F9GXm4wVpZOvuq5S0KCMc6FgQqZ0IEUgbjvtcfEZcjv/uV8DXJnsiXtCkmo
         J3siuagEhCu4o1Ls+t5KEniu8qGHxcGAIhc7K8YbnWjgJALVFPiDD9wDN01Mmvk27mbn
         zbUF87l2I0nV4nN6HxUU2z224/PDK0HuVUc07hkBiW6wTuspa7WtOv2h7hBX5jDGX0/t
         ilqIBH55eA2DcXQy+dt1OvHKntXxFgyQK01UBI6A9+fxzoORLGrlRuKHDF7IuO042xy7
         ywcBTXsbg8DTfxAj3kXNK0jAhriYZ5EOL1F6yN2BkHJGh8DMfXgTGqGh77lgBH7EZpy2
         ibRA==
X-Gm-Message-State: AOJu0YwKIgv0278/NQAIeEBnnba7BvQVrYGAFGIuX6CucTgzrYmNSApO
	/gsi/WWGZw2SMans3oIC7suaTWXyPvVEue0kcli/Uw+U0ydTlxQMwiBATw1hL2NdSyDv++y/LHo
	PXNMmeuSuPF8DMxszn9Em/eI0gCTjP3yLfaYBpahZn81us8y9sq7myrJlAgsLQVkPlw==
X-Gm-Gg: ASbGncspqFLCCcciwHN57TLf8bZ3fTgITrDb3jYlVvXzpeo6LCEHzI2PzSF8qWtf05r
	X52B44ddWGSdRv98LJkGdrwF67trkYkzOTv07XJcI+pKUkbDpN1uZhRk4I/lMOBctAKvkcKtT3w
	cO1S+nlWwL0KcjFMKCgohB88L5uHzyxmi2J8P+m/ibAR4peL9WUPXyRgRUvMYid6nupKXEsV7tr
	8XYVlkqkvOvk9Sak/VSUPXM4ryewYIdaECqeX60QM+hwluZdNa15KOLfTD9mK6qF/z1V0j2UpnJ
	WMJqU7KoTQ1b6XN/fxAkgBf5YdKu5hwG77hhND1dy5NVF9yviQCZ0XsZeFUtTkokWscyLOyZ5Tm
	WRrimaOnt2Cu99eK2Hq//NrcVXmnZBmDNOMz14CzYNdQjjt8XagG91+V6d/0=
X-Received: by 2002:a17:902:ea09:b0:295:511d:534 with SMTP id d9443c01a7336-297e5731561mr9029995ad.10.1762575852186;
        Fri, 07 Nov 2025 20:24:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSqsWbBHvTzFZL1WHxTgvVilDTYn9CNVtWEGvDpO+IqMm/AG7QmHqalVoUDMYLG7QGKbwXbg==
X-Received: by 2002:a17:902:ea09:b0:295:511d:534 with SMTP id d9443c01a7336-297e5731561mr9029835ad.10.1762575851683;
        Fri, 07 Nov 2025 20:24:11 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b90asm75442235ad.23.2025.11.07.20.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 20:24:11 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 20:24:06 -0800
Subject: [PATCH v5 2/5] media: v4l2: Add description for V4L2_PIX_FMT_AV1
 in v4l_fill_fmtdesc()
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-av1d_stateful_v3-v5-2-351652ba49cd@oss.qualcomm.com>
References: <20251107-av1d_stateful_v3-v5-0-351652ba49cd@oss.qualcomm.com>
In-Reply-To: <20251107-av1d_stateful_v3-v5-0-351652ba49cd@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762575848; l=1278;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=FzzoO9k4M9sQjlK8nyUnKg9cqOI8/oU0g2MJWe3xnTY=;
 b=OSNZmTiRLE7DwVZQ0nPcx2h8vlSC1BYm0QW8PpPXDjJ5VfLfqEJmeQYlQw5wHkk8bBIr4Qb4D
 nETq+MEH9x6D5ALeZmVE/hXlhw3TLaV8cgKdvJWRnpTG/9FNqzytGBS
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAzMyBTYWx0ZWRfX0h/cKspUBH3k
 c29Q5bnkqxbiRVHlR5q6QYsC5xVmkJN/nBIsqrj88SWPtPvQeGQRq61nFlvhxmI0n4bEmgddd67
 9YKAJ0Bqqp7Zv29a1wTGRGQfL8sUQzLi6UrX/7eNMsL+pxCg5pDMjz7RuxOkmlhZfZnIE395ELe
 Dh6f5NOEXpFsPfcqQad1QhKr5VO6z6Gedts7Bfx3g2zN4WuFpsPeLG4vUtVCXITK/Nwv/ITJ+4H
 jR1DuLtxMkgSrtwhOK9LwsiIGaJae6BiUh7YjxISmRx9cGzDZ35rTl6WFvexMc5XPadAtwwbXr9
 J5eoMgqlYsdqOKfv6Cf0qKjiFYkZHOqajASc3EXipp5tDcIQKDz3AvMuXDWz6Mge2oUsoGD3qXX
 pLcztmdLSmLlJEdgTu1isEZAl6Z2xw==
X-Proofpoint-GUID: z3Wwfh0F1XiSqgVIxeCA-ijjnNBqNcOW
X-Authority-Analysis: v=2.4 cv=MsJfKmae c=1 sm=1 tr=0 ts=690ec5ed cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=3VFMuRvh7oFGMF0ZDtIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: z3Wwfh0F1XiSqgVIxeCA-ijjnNBqNcOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080033

Add a descriptive string for the AV1 pixel format to v4l_fill_fmtdesc(),
enabling proper reporting of AV1 support via VIDIOC_ENUM_FMT.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..4f4f341c26b0795831dc20941a4cecc223af7746 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1542,6 +1542,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
 		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
+		case V4L2_PIX_FMT_AV1:		descr = "AV1 OBU Stream"; break;
 		case V4L2_PIX_FMT_MT2110T:	descr = "Mediatek 10bit Tile Mode"; break;
 		case V4L2_PIX_FMT_MT2110R:	descr = "Mediatek 10bit Raster Mode"; break;
 		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;

-- 
2.34.1

