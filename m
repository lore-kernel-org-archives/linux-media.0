Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15D2D5932
	for <linux-media@vger.kernel.org>; Sat,  8 Nov 2025 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762575855; cv=none; b=kMM6GfLyHb021pBjm0KuPx5wiolrvl1z71Adphbwr10OGFQ1znKZNhLLntcghKhNRLHAtQgOK27DvYOByXg2nFr7BjnP9fWTc6epiyRBm86tfd2A+pIUff2rA69XaBg9Gl4Xj/A/bhXRCYFfjX7RY2iw1c+pBHOfO6HoVtNAWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762575855; c=relaxed/simple;
	bh=RzruQ9wp8ycOBWczy25ujS8bJ+hwcf0vs17Xh670YBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=renDiE4C5HEk6Ho7eQITA/tlg3IaWvznXQf/56obbkr363s1jgHARShwuhM8PQZRqzrJHnuSrYkGQujJSjzFgiRUb+SGbenX3+XENRVTgttxbXgVna5+21FHGsLp1M1voi7IhmWlMWcoO4apgOFEmavpkgex3H1H1mCbOzpMtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QWf4LCWh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AGtM29M1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWf4LCWh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AGtM29M1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A82A1Ff557506
	for <linux-media@vger.kernel.org>; Sat, 8 Nov 2025 04:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Wn/mGVWsg+Fjxsv+KjjZhfuYj6drt3gZw0kiebo5zY=; b=QWf4LCWhBIetda7E
	ZKcMJbQ8FNl91ZJPKvgGK6wPVrsmXmxyXdCOEaVYERQuQhNzcmrfzWPILYarNtNx
	ySqQNUv/QTiKIR2G0o10WSh0UgH31HfWok6mjgiMcjMUVc8DnXb2dYCTVoQz/fJX
	XVNZvJTyWin9leu4LCrr0aN9k7NZkYffmXdQv4VK53wi8Yk3H3qZxquJQO0xGZ1A
	njPCXA9FnW/cpX1TW9TVO71CzNdPN61Xtl8mOCkMIefvlyIxeAN85m2hTeerJcAN
	gjYqrTNhVNPM2BqSmm1FMFTcM0tBcDwnW2TJPTP0BhWsVb4goalHpTIQymCSvCGW
	HUcIdA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9vtr05qd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Sat, 08 Nov 2025 04:24:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269b2d8af0cso4016565ad.2
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 20:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762575851; x=1763180651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Wn/mGVWsg+Fjxsv+KjjZhfuYj6drt3gZw0kiebo5zY=;
        b=AGtM29M1qbtwrliiN097ZILXbarAA+Q52ri9OyGEf5XGYVAJsAXKjAHMgCf1xDYGu2
         YlvbPeqhQ4pjItGeYFJpfj2HJ8yMm3jr+zp4k0se+VEbwTgw6BZw54+9Rf8sXf1c8kxj
         gXY5PkXaAOm+bSTe5d731K6kld492DS18HFsShoOsDRd8NHk6oidLfBSUKTWqojmmLJc
         Fh9siSO/qnfG8YMKyb24jxu+pz+X9tGlcEuIKKe1tVK2d+Cfs734VLDvBqtOnUaZgY6r
         24TaThuYtqL3ZzWH1PMeGBXsl9eazxNB01PTxieaqzHXQ/ARpcW4Gt/C+Pw4UB1nx1uC
         zzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762575851; x=1763180651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Wn/mGVWsg+Fjxsv+KjjZhfuYj6drt3gZw0kiebo5zY=;
        b=W23ENl8fud9imkZdpUF/VAFjxmPXWxyrfq5IpJfJFMugmfOcIIZBgKfmJiTp4krJzG
         4TV0oBWSDFcglP1+fBrA4onv8Ovo48hzBePdNAShsMOOD3WxN+KbdgGDJgJByhBZid9V
         vMnUCXfMLrQenaLH7rjinhSOrQDKdbnDuO1Ovl90LhB6RVY60PYZIqDLjNx535tMCyiC
         0f3R79FdDn7Elno0DwMiN19SeexW7+OvR+XqZqtH4LLdS4uLWB/UPLnGnurE6W7eXORC
         SKpY7sWiGWhVZ9+vFqy3Nx6DXDj+JNCFSxVzWBBbBWonCF3NSOOllxhtJEzj84xQmy1B
         WEPg==
X-Gm-Message-State: AOJu0Yy37IHTb1wkd0nnNdCcPtUFP7yhA5j8CUh1phryo1t0otjZd8UM
	S0lpSnkdPcgoCcg6o6Lg8IH32WN21/sWwx+O8UfKH6PshIKxewgWt1tMDzZw+PwVWBfABY5wYtb
	0lCYelGCaZTUn1RMsghZBLxw6klonKLAIty3+AfMIYrnziaThTNwbZBBNYSCXw5hpyA==
X-Gm-Gg: ASbGncvnWJRL6Qh+Cuxm9fY9mNFip7Qm3A9ZH6DRIhD/BWHjPRJlE2LTvrQaH/7j46m
	VmiL2zICE9Pxi7++wMfn1rRzXwJiQsn9L8Rfu6uJG1qg2Tn2QXn9s7y0bvvPISTv2FLStdjqhhP
	8B5t1Gf4ZN3kOFZqIT4vIXccQ3uvbtJW4bjRgKzPPKO+Hq2mGFSfmhTanmMbDHVTCH4h79rzT6W
	plkYPUjsXKivmh6zmcBDqCA/IaHSafpFT6aQ5Bonz41EdKc0ZYdUkfqJZzb9sc9GvxB0IZgXJQt
	fq3v8ksNb/5IKgBKpK4WtiZuduj8lJonjQtGK/M3Aw/vw3Wc2eRVQVZ17h4Sas3q+LSTGmNoedW
	tPHOrO26MEWrwfCE63x7WbcrlyDYZFne3f6kl8BPrLayPx2uh19GD2A2fOvM=
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr9475775ad.7.1762575850839;
        Fri, 07 Nov 2025 20:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc2T4l9Pub60u4mvuoxZoKdhoytBYJ9DnpI+jGuvhEiD9MFfksqlH6xBEpa+ahRhwh8csX/A==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr9475615ad.7.1762575850343;
        Fri, 07 Nov 2025 20:24:10 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b90asm75442235ad.23.2025.11.07.20.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 20:24:10 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 20:24:05 -0800
Subject: [PATCH v5 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-av1d_stateful_v3-v5-1-351652ba49cd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762575848; l=2537;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=RzruQ9wp8ycOBWczy25ujS8bJ+hwcf0vs17Xh670YBY=;
 b=cg1QpdXQckjwYuFtNcqmfDOWzTBpBbqjyOZC9kzEChBsuKtoYoRbh6TiEpY/G7s8JKGIoxGc/
 wNrzzoWrykaAOeSu7ikmNZodXOq64+3BKZTbFA7DZgYs9anMh5ldRN0
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-GUID: 8m3Rp52BvutAfZfbtZzHmELIAajDy1QQ
X-Proofpoint-ORIG-GUID: 8m3Rp52BvutAfZfbtZzHmELIAajDy1QQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAzMyBTYWx0ZWRfX8ipcUmOmF8Qw
 eFeeJ4fJaGK/jVarz91NHP4WZ7v5geoScaH5nZiJth5+UwusOHGpUlV2W8mz9iEk5csyiLss722
 Dp6GUiNZeQN28gBQynmEzauQhW7fttGcNYsW+nxUZ078gjovbG7jf7svygENQy5Yb9UZ5cYO1Wd
 vaW9DjgyTHZAp+p33fj9d5qk+FPnWh83oVd4ztczQW22zUk1lKQDCEF1iggNMHOvMOm21kgIOcD
 NpyVVIAlsqaH1NZ+W+qTNbNNc9NVUQLrYVxOuGV9nuGYSPmtVFblHS9JfkxGs3VYw7voBzt5TDS
 QXJeHCdqpI0UNaizuv8a0YK3oKPcTstX8/CHX8CW1YYyIn3UWEQDwI4sI55XwqIb78Got1DLSP4
 k+Ac0Obz/lZcptlOHooRMVT+m1SDBw==
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=690ec5eb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=5q8hE9cQKCNJD2usWYQA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080033

Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
Video4Linux2(V4L2) API. This format is intended for AV1
bitstreams in stateful decoding/encoding workflows.
The fourcc code 'AV10' is used to distinguish
this format from the existing V4L2_PIX_FMT_AV1_FRAME,
which is used for stateless AV1 decoder implementation.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 8 ++++++++
 include/uapi/linux/videodev2.h                              | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index c7efb0465db6480fe35be8557728c196e0e530f4..6ca63f35b801b8aae142b69eddfaa549a5568a3f 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -275,6 +275,14 @@ Compressed Formats
         of macroblocks to decode a full corresponding frame to the matching
         capture buffer.
 
+    * .. _V4L2-PIX-FMT-AV1:
+
+      - ``V4L2_PIX_FMT_AV1``
+      - 'AV01'
+      - AV1 compressed video frame. This format is adapted for implementing AV1
+        pipeline. The decoder implements stateful video decoder and expects one
+        Temporal Unit per buffer from OBU Stream.
+        The encoder generates one Temporal Unit per buffer.
 .. raw:: latex
 
     \normalsize
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..cf0b71bbe0f9d397e1e6c88433a0fc3ba11fb947 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -775,6 +775,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
 #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
 #define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
+#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '0', '1') /* AV1 */
 #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
 #define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
 #define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */

-- 
2.34.1

