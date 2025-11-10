Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBCA2E6CA6
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751134; cv=none; b=lXKraALmGDrnEWBzrlSH5VzAs17k14hJCjlcac8qM7obAE7owzoZ89rDaxMlhIeojLVOmllsccsB0ceaR47SW/VoWVPbndvBbfC2CGSmKBLh23VyeAkr/xYkz8s/6IdkBgxRYrJ7cgYZu1OevxXmUf7so9vvxSw8A29z/v47Ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751134; c=relaxed/simple;
	bh=RzruQ9wp8ycOBWczy25ujS8bJ+hwcf0vs17Xh670YBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTCA+iq+cdsaEY/ltY4zGqOD8LTblvq2GS/GmyNMh9lxNjcvDhx4s+zx8++agzNrdBaQBvnQi30f/eimrtRU8YWJqGt/0Hvke/3/+ZOsI3lHNJWPjbF9wn8+hXrgN0AfK8kMR7JnPjLGStn25rLyiy08/0qIfXLEBf8O9harfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EMuU/IP4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dmRvWs+7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EMuU/IP4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dmRvWs+7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9NC5AI1841135
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 05:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Wn/mGVWsg+Fjxsv+KjjZhfuYj6drt3gZw0kiebo5zY=; b=EMuU/IP4jEEE6YMG
	o6ilu0Avh5VtITcPcBjdQ2gBE4KAIJPYv+iMYoaWdlPb7vEYFsQl0+oxlLdxMiCV
	IWB27YOsH9ZOXZjrP/W1cPBfo2gvbTu7o9DjWip3hwNqK47lIp3zKK0HFN1HkGXu
	hzV0wtVVjFMa/GoeKDsCGfLnRxiYvDHhc35UNqTo0MfO0nmrSXHDdmhLfg1pEPvk
	F7MbcNHPhn9Z+j3UF+ZDDmqDtbRu8zxo0KGo/AmM+0/qthqgId4+ndYQBfy7tnKl
	lv48qLrsTfNt65COl78cmy5hiciUD43JVcE1aDQvQcMdyeaMKw2bmLnQQ8cHdnME
	4zQ00A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aaue0h926-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 05:05:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340ec9b90faso937808a91.3
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 21:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762751130; x=1763355930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Wn/mGVWsg+Fjxsv+KjjZhfuYj6drt3gZw0kiebo5zY=;
        b=dmRvWs+78451jskzQhCNVRO1UXBhuaZhxxKfEMUtZZAUzoPi8wcMuUHgZ40RDhJ2CB
         UlvThW8FkRH3chvzS7fe21xcToyy/atTm1g6CsUlF4Sj2ivdiEq68o1BYeMg569nZaSY
         I7aNqbjOea720aBRsrgvh613tqTGocPlvMo39Z9pbC92iYMoJkEEa3wizmbv/wTXTJPM
         b4iSB6ke+yvOGGEP+DS6PcxV4dMwF1X08M03rE49OG+9w/XW1/hd0iYg8sIMwricIkqq
         lys1R+AgRCbqs6Rof3JU2KrlWwzlr3ZbbjwoFlT2EzY3ay63nikqhwefUuYGyjv/apdH
         2Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762751130; x=1763355930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Wn/mGVWsg+Fjxsv+KjjZhfuYj6drt3gZw0kiebo5zY=;
        b=tJvR1ZCWzSxOlAVGo2bB+PduMnfAPiP918ly6U/m/dnfcStyJWJWut4R9CSb8ORz4h
         ijhv85jY0JJKnrZwjUB3J/T4mZ7LbSt4bYxorjP/Ji+l4gOCbu9QyVtV2okka44NNzR/
         fIZ+n+uEI+ACiLfQKiLKAWn4SUY47kq1hEino0LN3FUCkBPrCg9lTBNEyeDiDHSZ51T4
         qgUPihAJ5ZmsoW6/l9TmZv4izJxl7cg+sVf7mwEuw3V9DR/aYnmF8jZRAKOnHSZZ9xq2
         M7eROGKE5ug+iL5wRrAeaYK/2W7ISPhiSfa5MlM/L6I3zgAC1e7+FPyy/U5rm6vki9zG
         4H2Q==
X-Gm-Message-State: AOJu0Yy5On1nMVjaw6LXcRGMz7wYkqzn98Ui0YdPwXrvTRmEaQx/pLwy
	cpROFaSIqjgv5j/Jv27DN5XReNdNgh2I7V+WiAGfyFJTcoOcOaWuID7f49nEmx+dfuSPrn+IVAd
	pngwJ34wJL00oOV18yOs4Rw7q5bdxpr+aBSF0japF20RzDmThwnKTSfKSRiHclNgvYHByXImoiF
	6z
X-Gm-Gg: ASbGncvslMBL+m4ETNMyk04MGZH0Lai3qUZr3tFMKYjDjKyMTynP64aBca4ycoxOf60
	U2ik+l6iV1ceg28UKW3cQLQkPHl4q5+l0SakjDKmV3VwSkaB2HQQOgn/qTY3mY4VIVPmfHixeUN
	riMEFfFoFIIBxrKXhq455B7eQQZox7nq7rKWa2nyaSO2bwJVoq3fpomcu1/BDBMPUlAHLBtkmCI
	zaE4ZwJGbzTZyoBp1Q2bSkLT1Zeh1815GrvMYku4MCmZksgtqvqovzh3d62cjvNFyRY+Rjp3Cs2
	91rMIQ1DlZOOC3cevZmgFz6a3f+poArRvoGoyqqRb9mmkJa44KE7Qk0lE/+UOJpGSXmh9zWsmlA
	2XT784nTcVhagHNwS/v57FrZA3tLo9hUtPUjcA5QnPrW3hLXt4r9bBY6PvZE=
X-Received: by 2002:a17:90b:164a:b0:33d:55b1:e336 with SMTP id 98e67ed59e1d1-3436cbf092emr4859905a91.6.1762751129921;
        Sun, 09 Nov 2025 21:05:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR72/MIEIGKNpXYc7OsoV2hqp53HrJgYOB/4/a56FbPWhcVd5z9h4gzeRMwzF7XO1Ft5WO6Q==
X-Received: by 2002:a17:90b:164a:b0:33d:55b1:e336 with SMTP id 98e67ed59e1d1-3436cbf092emr4859886a91.6.1762751129404;
        Sun, 09 Nov 2025 21:05:29 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343705c1354sm5913748a91.18.2025.11.09.21.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:05:29 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 21:05:15 -0800
Subject: [PATCH v6 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-av1d_stateful_v3-v6-1-4a9bde86025a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762751127; l=2537;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=RzruQ9wp8ycOBWczy25ujS8bJ+hwcf0vs17Xh670YBY=;
 b=Ad2uYGRWwrIgdcvhA53FD3hdqFNuQEfvwCq2Ng/hVzZjPBcA7eaITEILB8vrV2IPErkYoV3Q/
 Pw+mB4zmzxQDW16+pBmKl+KNDxWif+gPwy0hVVkLjdnzXROTzVOcJ99
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-ORIG-GUID: pTDAGn4w_8sEIwbjmaz0TneI9vNvM-BJ
X-Authority-Analysis: v=2.4 cv=BfDVE7t2 c=1 sm=1 tr=0 ts=6911729b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=5q8hE9cQKCNJD2usWYQA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: pTDAGn4w_8sEIwbjmaz0TneI9vNvM-BJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA0MSBTYWx0ZWRfX0Kr9mV5lSZ/w
 a7bikDq4pypPkW9cAKdaOK0+d7079KjPdbd9e1kQahqm4WFxUBH7FmIFlS/8nm3/tc6rDQdK/rI
 HOWAS1B/xFFd2HpWO3L7Qd24XxiQvlUHwb7YejDfcOJCCKLx1YamVKS4QsbzIr0J734VF4aflwq
 Nq0P6/3Cxtyvyg03+MYwJVJzyGq7yzzYdeYfjvZ52y4R88qITfgQpprZbdcTtOf6x7cezPcSwdQ
 /xkYMmJyLpCxwr0tp/oQxTpGAaqHyCc2C7UsSro1hLl1DRjr+DQbkH5gSdOic4ppWfQTw+bVl0C
 bX9IVGZpJh7IHr0/XFVAlcpMXqU9BABqRW/82HUDsDkSH7V0/WGDNUOpOjRWtoSekqn7Wc/WmBV
 g32GRRvP3oQ79FAXHmysUTJu0AoQxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100041

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

