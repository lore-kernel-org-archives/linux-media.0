Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D77278E47
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751133; cv=none; b=mntMZ3jBJ+jH6BCJPdGTfgQ5rQcs5xR1rnVN22G7723/GuJ790aVTSyNdq9yKEx2Kb0pX7einr8RFIF7YkpQQ1uye3V9Fu+4kAcYIjGYOBIY9YVjwmpP9WiYR7wZyKeSYShF1k+ehuYlCIL8l1S/Ff53Q4gIkEU5Y5ZqrwUbJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751133; c=relaxed/simple;
	bh=ipOXdtGjKV0acIkxzAKMgIxcdIDcutwV8byhDh64ZE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YS+a4KVDp3WNXvS8l9Opjdh3BEiVw9xDwzoNj5/uu8UHutXK1r2ir1EUSNytXkHidxJy60g1FJ4NR88/1U9aXvw9eZG5tw3bhsDHRpw3oeHTOLFBTvq0Tg20aKHtPoL2TLP3v9NbH8ZyQC44GOTxa8BDJa4HmOFGfrnI7ZnEVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V0vfPXfb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gOUirTlp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V0vfPXfb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gOUirTlp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA3jlY82546904
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 05:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MhBhkrgr4Lc7EC7NW8irJn
	njl+mTO/We/Jo1PtGaIzQ=; b=V0vfPXfbKprZ+DKQNpLK333Q0BgLNTIu3Dn2Db
	iGzLLitXNLPuwzuAatmNrQ14MiINHesY74Cp8LzJZsOMFncVHEO7edMTEYIpEVeC
	glAGyLZaXWixFfCQbmx/+4Dz1JwI/m91bR9EZnj7jO4haZbGGpMDJ+hx3sfyqFLU
	CDavsMiEHMUsiUDkevKvbcacuiLC9K2vmKxTnh+c2L6jun3qp1T414K8nD9eTnV2
	L5dQA0uN8w6ziuc/QOBs9d9xlCBS0mXEDVZuNIjILbneESPbux1kFlmeu8dWLjhG
	GeGrXur3wNRdEM7lanRYWt7GXEyTxEO1eopcyP4F2WI74u+Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab8ea84me-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 05:05:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3435dd4103aso907804a91.3
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 21:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762751129; x=1763355929; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhBhkrgr4Lc7EC7NW8irJnnjl+mTO/We/Jo1PtGaIzQ=;
        b=gOUirTlp+wSTgqlBthhLaIKizpFp2kGOT7MfAOxflHSXK+9Ob4pCk3mUIwVlK3MOOv
         aziV/wcUEEIu79mtmQSGRcQANGR4zXt8mzUFaONGIjo/XjXLveXi9hM8w3Dgo4vE0JnN
         TZ7jSDMXJuqzvhksQTm76K6QhG2XzrTVGz3kY+Dn3RpUjeS04s8VaXCGZhW9dVjPgfWk
         ifEIMGcJVyxnG33sOPkjBinN4+y0qzMey1c3elE7StfXkd5WGQ/AccmnoTPGJy/HTKBY
         /b9PPD8QbQRODh1IhBLbwwgFhHYVS46C4TRcJdyHfrZLjv7gd85ds1ZR6LifqYIjyfzx
         De5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762751129; x=1763355929;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhBhkrgr4Lc7EC7NW8irJnnjl+mTO/We/Jo1PtGaIzQ=;
        b=wgQkjmxkwR1p9DbIxh41HAIFMfmvEcK/eCXhflawi9GZnTzG684FwnPDORzKN9DDdY
         fmdQXwcztaxjW8jlW78SB8zUxvbK1dBVpBQ5roCHY8WmW5ZBbRAfgXG1/eAmHJ1Um+zz
         YUrv7izeb9OD6S0sCVH5zB3yh9CmMe1FkWwDxShLVPsLWGcj53XdTRYYxvGxkJES42/b
         11vcAg4oNcpkS5MOZjt2dPWFJKN1PPMtPDGnsW6vBilAsAk+MdIxvV+X0z8ymjO/6BOi
         AzoRj5jLysXORl21f1sOHK76BVB32CMMv5P3EIuMHM4QSEXQVRcHmft3g/jfbo9NohXn
         Hcwg==
X-Gm-Message-State: AOJu0Yz6F+PCAUUJoriVb/QC9VpiGVv/WUh/L7yRqiqlPMiUWOXubE++
	0eFOTMl0errqXmKkZ37wLqDpAfNY4Q9ZURfsTOyqGPhqExElX+N9QxflB0Tg1MgKnZOypEO2WQc
	8zPFO0sBWo2zNaPURCVJbaAlX1loVlqiIcW0Hq5tz59VI0J1TYGcwH/mDhfPw59B4t4ygF4207J
	uA
X-Gm-Gg: ASbGncukapIyK2CDn6XOGvV0Qy5Wfr3NPIbObMtEPMeDxPYgKwEUyAK1XNu9Jwdu/0t
	FIO2+BVFDIgUwWUl+YaST/pYQ1INrJcSRahlFEJbgWxTQvN4Cpw/rSiXGfSfc8IaaQ28VvAfhk/
	gHEcYaMG09ZUG5j2GqtegHa7vn8Tll27UCg5Ch+30QH4fLTwZ9GvAjRZRzonUzrm9EGGyD7aqZT
	dJEVcCf0A2YCk2KAsxLxS/amJXxd3WUZVw2JmupBaSSTRCCPUQsq0+MD5K0EhG00zsPu+r7wz40
	ShyWAwvBQ2wCx8Sn0MB6zIAsrumxZQXeKoWjOykGrgT0PY0NmASkuCmTtbg1XASKpa6OAGuP+FR
	03EOx8baVWzIuZTM1e1RoMpH442c0S3CWy0TVvLs43rjAPhraxuXepiVi7Tk=
X-Received: by 2002:a17:90b:384a:b0:343:6a63:85d1 with SMTP id 98e67ed59e1d1-3436cd1323dmr4792853a91.6.1762751128970;
        Sun, 09 Nov 2025 21:05:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkI+4af/OXKUKx0lkMAfRrMvjPn24pV4cLuozmpJRlnO1Foou5+gfniBoNVoq4hjg++jeb9g==
X-Received: by 2002:a17:90b:384a:b0:343:6a63:85d1 with SMTP id 98e67ed59e1d1-3436cd1323dmr4792825a91.6.1762751128409;
        Sun, 09 Nov 2025 21:05:28 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343705c1354sm5913748a91.18.2025.11.09.21.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:05:28 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Subject: [PATCH v6 0/5] Enable support for AV1 stateful decoder
Date: Sun, 09 Nov 2025 21:05:14 -0800
Message-Id: <20251109-av1d_stateful_v3-v6-0-4a9bde86025a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAItyEWkC/3XPy2rDMBAF0F8JWldBo5cfq/5HKWEsjRpBEieWr
 baE/Htle5FCXRCCO6CjuXeWaIiUWLu7s4FyTLG/lGBfdswd8fJBPPqSmRTSgJANxwz+kEYcKUy
 nQ1bcdaEJ5AHQO1aeXQcK8Wsh397XPNBtKvK4Dp9wO6uigZrn6KnncYiJT92n43TB7kS8rgidD
 RoC6jbLme8wEXf9+RzHFqxqoKpV4wQRqs4HUlaKIKtgoUJjgq+sEpLNexxjGvvhe2ma1bLIWkq
 Jv6XKKVOAWnsyMjj92qe0v014mr/el2sxs346BdpwdHGUcg4IsVZB/uOY30614ZjZMWCN7FA3z
 m84j8fjB1zK45nPAQAA
X-Change-ID: 20251029-av1d_stateful_v3-cbf9fed11adc
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762751127; l=8937;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=ipOXdtGjKV0acIkxzAKMgIxcdIDcutwV8byhDh64ZE4=;
 b=sJ2rpXsmm1XUqLXK6u/h2nGeS8aaX+uGZGd4XSDxINDvw+0PfFnBpQR6zoovvYYy0E3AqJN95
 ELBxpGsQdeJBfss6NiJjTUdRKLrEg8qSu9w9wQy98h5fk/sVUyl66/V
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-GUID: rRgLhsm8aPxGAe_5MBxl4cbsPTMDwnVB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA0MSBTYWx0ZWRfX6hDyW39+JlNK
 LEN+X7wyX29U5qSDZndgpw6UUpmcdJDTVEOGkmci+dBdAXw7mfcYExnCUPwtBtGTSdZR6/tY6z4
 IegxYD+z7p174QiIBe/rzsLXsEINsDU1GoJvYtl8QKHiVF3rKALX/pZ3tq8ATzOdf6vJUS23ZXa
 9NosakV/llaaXa5CBqxrCq52aWFuXJ3C96WJxrSwRoZUo77AC9IVazrClr18ksTK0NYaJUQ+Tlc
 WGhX5mOsKOfg8szxzcATjFNwQbYOp2UfXRs9hxS7ahxC0bCFI43io20CDLAKUx+VVd4FNAtz4Er
 5bVxy3D+NQX3X43zDACCiFdW31K+U+DOVtD6ID8r2JCY2/1NOkwuI8byiZIRS4QmDVE5sCHxWh3
 gmD/qrAh56xl2MEER+HaMKOxSrrQ7Q==
X-Proofpoint-ORIG-GUID: rRgLhsm8aPxGAe_5MBxl4cbsPTMDwnVB
X-Authority-Analysis: v=2.4 cv=QLxlhwLL c=1 sm=1 tr=0 ts=6911729a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=e5mUnYsNAAAA:8 a=rSFLfVtXdW1OZ3NksNsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100041

Hi all,

This patch series adds initial support for the AV1 stateful decoder
codecs in iris decoder. Also it adds support for AV1 stateful decoder
in V4l2. The objective of this work is to extend the Iris decoder's
capabilities to handle AV1 format codec streams, including necessary
format handling and buffer management.

These patches also address the comments and feedback received from the
patches previously sent. I have made the necessary improvements
based on the community's suggestions.

Changes in v6:
- Fix for kernel test robot failure
- Link to v5:
  https://lore.kernel.org/r/20251107-av1d_stateful_v3-v5-0-351652ba49cd@oss.qualcomm.com

Changes in v5:
- Updated Documentation (Hans, Nicolas)
- Link to v4:
  https://lore.kernel.org/r/20251103-av1d_stateful_v3-v4-0-33cc1eaa83f2@oss.qualcomm.com

Changes in v4:
- Reuse sm8550_vdec_output_config_params (Dikshita)
- Add definition for 256 (Bryan)
- Fix identation (Bryan)
- Link to v3:
  https://lore.kernel.org/r/20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com

Changes in v3:
- Updated fourcc could be to match the ISO specification (Nicolas)
- Addressed comments and rebased changes to resolve potential merge
  conflicts (Dikshita)
- Updated GST MR
- Link to v2:
  https://lore.kernel.org/r/20251017-av1_irisdecoder-v2-0-964a5478139e@oss.qualcomm.com

Changes in v2:
- Updated documentation to target AV1 codec, not just AV1 decoder
  (Nicolas)
- Updated description for V4L2_PIX_FMT_AV1 (Nicolas)
- Simplified buffer calculations and replaced numbers with relevant
  enums (Bryan, Nicolas)
- Improved commit text for patch 5/5
- Fix for kernel test robot failure
  Reported-by: kernel test robot <lkp@intel.com>
  Closes:
  https://lore.kernel.org/oe-kbuild-all/202510021620.4BVCZwgf-lkp@intel.com/
- Link to v1:
  https://lore.kernel.org/r/20251001-av1_irisdecoder-v1-0-9fb08f3b96a0@oss.qualcomm.com

Changes since RFC:
- Addressed CRC issues seen during fluster testing which
  are fixed with firmware fix [1]
- Added Documentation for AV1 stateful uapi [Nicholas]
- Resolved issues reported by static tool analyzers
- RFC:
  https://lore.kernel.org/linux-media/20250902-rfc_split-v1-0-47307a70c061@oss.qualcomm.com/

[1]:
https://lore.kernel.org/linux-firmware/ff27f712-a96e-4fa6-7572-a0091537d8ac@oss.qualcomm.com/

These patches are tested on SM8550 for AV1 decoder while
ensuring other codecs are not affected.

Gstreamer testing:
Gstreamer MR for enabling AV1 stateful decoder:
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9892

Fluster testing:
Test suite: AV1-TEST-VECTORS
The result of fluster test on SM8550:
135/242 testcases passed while testing AV1-TEST-VECTORS with
GStreamer-AV1-V4L2-Gst1.0

failing tests:
unsupported content with bitdepth 10 (66 tests)
Iris decoder supports only 8bit NV12
av1-1-b10-00-quantizer-*

Unsupported resolution (36 tests).
Iris hardware decoder supports min resolution of 96x96
av1-1-b8-01-size-*

Unsupported colorformat (1 test)
av1-1-b8-24-monochrome

Unsupported SVC tests (2tests)
av1-1-b8-22-svc-L2T1
av1-1-b8-22-svc-L2T2

Bitstream corruption issue: (2tests)
av1-1-b8-03-sizeup
av1-1-b8-03-sizedown

Testsuite: CHROMIUM-8bit-AV1-TEST-VECTORS
13/13 testcases passed while testing CHROMIUM-8bit-AV1-TEST-VECTORS with
GStreamer-AV1-V4L2-Gst1.0

Following the RFC feedback, focused on only IVF/MKV content
as AV1 parser lacks support for below content
AV1-ARGON-PROFILE0-CORE-ANNEX-B
AV1-ARGON-PROFILE0-NON-ANNEX-B
AV1-ARGON-PROFILE0-NON-ANNEX-B

Unsupported test suites:
Iris Decoder supports only PROFILE0/V4L2_MPEG_VIDEO_AV1_PROFILE_MAIN
and 8 bit, 420 only
AV1-ARGON-PROFILE1-CORE-ANNEX-B
AV1-ARGON-PROFILE1-NON-ANNEX-B
AV1-ARGON-PROFILE1-STRESS-ANNEX-B
AV1-ARGON-PROFILE2-CORE-ANNEX-B
AV1-ARGON-PROFILE2-NON-ANNEX-B
AV1-ARGON-PROFILE2-STRESS-ANNEX-B
CHROMIUM-10bit-AV1-TEST-VECTORS

Compliance test for iris_driver device /dev/video0:

Driver Info:
		Driver name      : iris_driver
		Card type        : Iris Decoder
		Bus info         : platform:aa00000.video-codec
		Driver version   : 6.17.0
		Capabilities     : 0x84204000
				Video Memory-to-Memory Multiplanar
				Streaming
				Extended Pix Format
				Device Capabilities
		Device Caps      : 0x04204000
				Video Memory-to-Memory Multiplanar
				Streaming
				Extended Pix Format
		Detected Stateful Decoder

Required ioctls:
		test VIDIOC_QUERYCAP: OK
		test invalid ioctls: OK

Allow for multiple opens:
		test second /dev/video0 open: OK
		test VIDIOC_QUERYCAP: OK
		test VIDIOC_G/S_PRIORITY: OK
		test for unlimited opens: OK

Debug ioctls:
		test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
		test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
		test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not
Supported)
		test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
		test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
		test VIDIOC_ENUMAUDIO: OK (Not Supported)
		test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
		test VIDIOC_G/S_AUDIO: OK (Not Supported)
		Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
		test VIDIOC_G/S_MODULATOR: OK (Not Supported)
		test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
		test VIDIOC_ENUMAUDOUT: OK (Not Supported)
		test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
		test VIDIOC_G/S_AUDOUT: OK (Not Supported)
		Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
		test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
		test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not
Supported)
		test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
		test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
		test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
		test VIDIOC_QUERYCTRL: OK
		test VIDIOC_G/S_CTRL: OK
		test VIDIOC_G/S/TRY_EXT_CTRLS: OK
		test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
		test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
		Standard Controls: 12 Private Controls: 0

Format ioctls:
		test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
		test VIDIOC_G/S_PARM: OK (Not Supported)
		test VIDIOC_G_FBUF: OK (Not Supported)
		test VIDIOC_G_FMT: OK
		test VIDIOC_TRY_FMT: OK
		test VIDIOC_S_FMT: OK
		test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
		test Cropping: OK
		test Composing: OK
		test Scaling: OK (Not Supported)

Codec ioctls:
		test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
		test VIDIOC_G_ENC_INDEX: OK (Not Supported)
		test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
		test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
		test CREATE_BUFS maximum buffers: OK
		test VIDIOC_REMOVE_BUFS: OK
		test VIDIOC_EXPBUF: OK
		test Requests: OK (Not Supported)
		test blocking wait: OK

Total for iris_driver device /dev/video0: 48, Succeeded: 48, Failed: 0,
Warnings: 0

Thanks,
Deepa

Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
Deepa Guthyappa Madivalara (5):
      media: uapi: videodev2: Add support for AV1 stateful decoder
      media: v4l2: Add description for V4L2_PIX_FMT_AV1 in v4l_fill_fmtdesc()
      media: iris: Add support for AV1 format in iris decoder
      media: iris: Define AV1-specific platform capabilities and properties
      media: iris: Add internal buffer calculation for AV1 decoder

 .../userspace-api/media/v4l/pixfmt-compressed.rst  |   8 +
 drivers/media/platform/qcom/iris/iris_buffer.h     |   2 +
 drivers/media/platform/qcom/iris/iris_ctrls.c      |   8 +
 drivers/media/platform/qcom/iris/iris_hfi_common.h |   3 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     |  85 +++++-
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  11 +-
 .../platform/qcom/iris/iris_hfi_gen2_response.c    |  22 ++
 drivers/media/platform/qcom/iris/iris_instance.h   |   1 +
 .../platform/qcom/iris/iris_platform_common.h      |  13 +
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 142 +++++++++-
 .../platform/qcom/iris/iris_platform_sm8250.c      |  18 ++
 drivers/media/platform/qcom/iris/iris_vdec.c       |  23 +-
 drivers/media/platform/qcom/iris/iris_vidc.c       |   1 +
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 299 ++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h | 116 ++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
 include/uapi/linux/videodev2.h                     |   1 +
 17 files changed, 727 insertions(+), 27 deletions(-)
---
base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
change-id: 20251029-av1d_stateful_v3-cbf9fed11adc
prerequisite-change-id:20250918-video-iris-ubwc-enable-87eac6f41fa4:v2
prerequisite-patch-id: 11fd97eabf65d22120ff89985be5510599eb4159
prerequisite-patch-id: aea5a497f31db23a05424fe2cddedec613571f2a
prerequisite-patch-id: e3b10c34426c33432208e120a3e1239630893d88

Best regards,
-- 
Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>

