Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF592E7631
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 05:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751135; cv=none; b=EYDlrnQTCKmQOAzrnOrMD2oAuq9EMXLgpZSdHMf25mVUcujeqOrxBJvDaQ2RM6UiS/CMtad1STRFMKl/Vy84p0LiG7eq8UHBpTEKjbG+imyu5sem12pe/zFbohDefxrApaQY+E8Y+FFkoicNKeQ32/7zrXcHkEeGu7CE4rsg9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751135; c=relaxed/simple;
	bh=FzzoO9k4M9sQjlK8nyUnKg9cqOI8/oU0g2MJWe3xnTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qeMAKcbxs4zaPWUsdxgbg7HXUrJ3icj3y1kfzNijLprpBP6btXmjlR+Ka528rfit8bHVn4Jx9Y8h9L7vELWODco0Skk26Pnd8Ad/Eg+BqMkj1BA7MolWzkJdPVcEKjpZFMaqPcYrr7M2w96cs8VdGWjfKJC93trdn4A7cKbhM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vs3sb3Ef; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aPPT7CgD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vs3sb3Ef";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aPPT7CgD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9LX6CD1587509
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 05:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NYWtNOwI1aavZwSln38Rwrj/x9o/h5lzzgA17JpG11A=; b=Vs3sb3Efo4R5Ah3Q
	MdS9/nWbMapc2thA92+5FGlbbo21lSg5UNlHJ94P91dH63bPYryquLhB6AVSSsV4
	JPeCx9iZc6f5mlPmqYljp0pC6NEDkcTacoJtar/4JDVCrvmyRPzS9LORO/kpX5BX
	5LWtUrcB8YtUzK3uWSSS9LnWuKJzrTZiKVMBvpcExJeTvhh9VaOOQqkV3ySgMqPK
	OONgcWd6rmRspt859MRhvAnHjmxjYRf6co8J5TcqbUAAcet6gRMsP04a46ymOrd1
	Q5RaewOLP21UXz4qQwgR9Xlg9llq5/PticdruUTfv57+FX7i5yUUu/M0wiFv8j4N
	+O+7kQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aad2a28ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 05:05:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340ec9b90faso937812a91.3
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 21:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762751131; x=1763355931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYWtNOwI1aavZwSln38Rwrj/x9o/h5lzzgA17JpG11A=;
        b=aPPT7CgDtGFk/A59OKhwMP3PjViSgvQogH8m12N3H7KgiJcMBNcLT2UKSxVCSLag/z
         TZ3qPFr+XgogBpxrHttcgXaK6TKKwWvQSPK6kPTobBO/ZUsPvhBhcc5LGVSmY3xk7LJZ
         4tCT+8ALra4GAE1yC7XsWZ3oC3XrUXDh7L6h8+qnmKtpPE9YKhkIxjdMXpgwTxs1EeSG
         pFswcdtO4slsF43VyFA3lW87a1qBY8Gs15rLXDgZ8jRkQ5KaMbdzvFsT04lFTJDRb4vb
         a2nx5QFmdyqvE9ho7c+Vr8iHUx4Xgj3UFlJC7nt/j/uuURjkFPIYkz6nYsIJNdoAFst3
         hpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762751131; x=1763355931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NYWtNOwI1aavZwSln38Rwrj/x9o/h5lzzgA17JpG11A=;
        b=bvaj0nY8iLJouzVSo4ZVCEoeg8EMNjoBbN1K9or1Cahk0vXDdfheP5ijD7MB+lwhTv
         hY4NwyrKPAtDSSWkKGGH8HaEizl6SRwgUfZ3s23XH1rh92WtKCsm9zuLP2RzO5bXKgJE
         O+Yp4F7fDCkbRqrknGgSFOsx8a4ke5OpwbgPPwzeZ8cQk1Lq/ziy/jB5QiXhLvkCrctR
         XljrnV7DVXD1scRwSruBptjH3SNbvmsoczbcnpeCtSBcnBZLR0EzZtWz1VKdmPevkItP
         3Bsv2bvmH0FAOHQmsGsXzJWR54QhT6nF7iY6p3SFMt3/l/7bTpGD/Vf14HH7Ck2Pz/Oh
         shoQ==
X-Gm-Message-State: AOJu0YyqEeJr0QIzHR0+F7tSJP4DfgJ5vtLULvnb5ZkwCzWoVPV922v9
	uv8TTWoU2plWF+byID5vJIA6zxArTsH5NbHs0VANCj2MOQ9yYdTUoa9guJS4Zx6Gy1N8QXoYV6b
	nWEQaYkhBbrx3S38KakTdrO1PO61ssvaiTi/LmztFRpm+sMooOUyC9N6tGnI+9eoGIEa9dUpMfq
	hm
X-Gm-Gg: ASbGncuflRwY082dyiCyMXJhwzCnpLRntHrRQAvHl5mElhR9bOT/EaOWK1n/5Ci5/GP
	Pi7nSojaIgOWvWCMEw4o909mx5RrEwMZoAfQQLz4w8tO0421cedp0Im786avEzsfTjiTd/nFjBc
	FzPmhWu2UI+ksPqumj89X6kW4sT5GA2jiR6k9Nm0AyWbEjg8ZIxZePJpbBbGyRaNzrebthwAiAe
	eTTDzIfCsvecbiMlFeisjBDUMx90FrzTM4qUV6uARSU3AQZ2EuApWQ+qQpQs3ZBjZCe4QpVDRpU
	NYSnPRAEqb+DoLvtAap0wFubruLuiqFj7TB8LUbQYpQSG4T3yKti6DA3eIcWOglVAAFZBkWjOcZ
	oc1Xy8obZ+41fpFzgBmEsbI9TGpwoeMNsucRo+00xqoqCFULkR2eJQIEH/lo=
X-Received: by 2002:a17:90b:4a0a:b0:341:8491:4734 with SMTP id 98e67ed59e1d1-3436cd06c78mr4896021a91.8.1762751130918;
        Sun, 09 Nov 2025 21:05:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1ZQlaMD2DhRGFL3hJaFUr9NexYv+YtjmuBFDRmdJ5aJYXw4KC0RZBdZvJvpXZg0wWg4HKNA==
X-Received: by 2002:a17:90b:4a0a:b0:341:8491:4734 with SMTP id 98e67ed59e1d1-3436cd06c78mr4896001a91.8.1762751130417;
        Sun, 09 Nov 2025 21:05:30 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343705c1354sm5913748a91.18.2025.11.09.21.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:05:30 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 21:05:16 -0800
Subject: [PATCH v6 2/5] media: v4l2: Add description for V4L2_PIX_FMT_AV1
 in v4l_fill_fmtdesc()
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-av1d_stateful_v3-v6-2-4a9bde86025a@oss.qualcomm.com>
References: <20251109-av1d_stateful_v3-v6-0-4a9bde86025a@oss.qualcomm.com>
In-Reply-To: <20251109-av1d_stateful_v3-v6-0-4a9bde86025a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762751127; l=1278;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=FzzoO9k4M9sQjlK8nyUnKg9cqOI8/oU0g2MJWe3xnTY=;
 b=k0yqKF4t9t5rOE2GT72HBsr0YSn3egf6rNBVy5bDeukHAgfg2EhFRirWIbMtyrvTdutW7xyXC
 NrK+zIfK8pVCBqbu6T/LbUReyhA3R3A0axjZDlMeqpYbV2ziOG7cUMs
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Authority-Analysis: v=2.4 cv=aedsXBot c=1 sm=1 tr=0 ts=6911729c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=3VFMuRvh7oFGMF0ZDtIA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA0MSBTYWx0ZWRfX6wOsgp3ut/BI
 XWPeyJEiKsBlPSjYqTu2n9uU2+0k4OW9aSrQ45T3+c3In46tG4svuhwxeJAtJOrIz8uO+ccJeFx
 JFDq1rlYNu/7boetfWCtXRrRL1o1AypdSiR9xcOGVc3c24h7VrHppSB09v4OSXL2XYX1u+zR4Th
 LqKcXQqs5r5gGygBYRo+2Qv2DcioUJ0ywbDSaBS9ZIWf1b/rawC2IGXGiHtpqbAi0YtNVHC6X1h
 ysxztP3ES/Ym+h2jZ+zU/T72cE/21mD/uruLno7dHYCaFH9EAbeZY+N5fozMg0dxM+YhtITv4Mb
 NaIbAJg0ZusQp88+lwt68gVVWEaZd0+SkgcEXmL+t9NJ56jFKvWj2VHQI91qnU7jkdJTsODOwRy
 O+/6weGK+6hgJ+la9A4Rt1Vy0TKurQ==
X-Proofpoint-ORIG-GUID: CZsu01tiXB74x0pDMj5n6n06JGQlBClh
X-Proofpoint-GUID: CZsu01tiXB74x0pDMj5n6n06JGQlBClh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100041

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

