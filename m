Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6D34F465
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857540; cv=none; b=MFm+OYxyU6sFEISSgg3rtZRsUJzL1Mh7MQCgb10jWgIjdGfgSaivFlwOCcYM1A0vOrgUpbUVEfqYwdMqMHYz+hNQTP7gH4t1uRTv6al8ZppqblCkVQy9RbnMr3/ZtPq7HxYG5G5xSkYwXzx/7iBXJrrHt/aHwDisA1QI+3CpVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857540; c=relaxed/simple;
	bh=A+acC3J962ujp7zmdIRESvKcu/fiPA9e1teWF7HgyAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FScr/H5w8jXTMzSOi5FhTt7ZB3WWRr4e9tycHXfk9jM9uE26yp5LnYuzvt28qd9bOAxsjYNTFtB8VjjjgB83UN6nfy0gO5qML9N6DNdpnSYKPVfsTWbeYugheY96OAt3wF/z7q2y3VVkJJJpPvkpU326KyY67pWVp0JyDKV+rP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IUsEyqJB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gt/3GH7D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IUsEyqJB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gt/3GH7D"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB5N1bh1480077
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 10:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=F0+rza3fzimpXJGQPolccb5l
	BPiW/LZvLZ5Q3IvvlME=; b=IUsEyqJBiWb3apyJhcCNHd38hPZH9q7qA8sIwrd0
	PSF9CYc7cFr3IjoRt7E2FWPsX4AT8H1TdidiTk3axYAuvXPB/mS4T8RkiyYc632H
	cd9VjYrn8EFngiToGqRSiabI0HsjlGdata6YRC+OfHzp0iTh84Gy798pzTz/6NVY
	+5ivDD8nTli+JSwvnZ58XRT8VZoHthoe+5JHPBKLLvbaSIvy/jd5f6cOHJz5G+Xd
	mupEY4qDiJLDxd6rWUDmQxJmdZrrpcpVa4Mt0ZJQeWNCCJRZrMhwhSzCR59yM3lZ
	cAszG0eOD1zUkTWTMhMqHdIRD4cOTCy9dKZx6T5oR6yQog==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxxu8w0b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 10:38:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edb927e4deso61565391cf.3
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 02:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762857536; x=1763462336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0+rza3fzimpXJGQPolccb5lBPiW/LZvLZ5Q3IvvlME=;
        b=gt/3GH7DFyv2rLyCFIlAaro4ZipkjieDq5CjJiZEt8FRNTrNxnc7QB3f9uMdkXvP7O
         jxc6CWWCBKcvjxHbPPezc5koFWErRs3U8+3Qk3eMbvskO4QjhvfRFJVgjlm/fANOsiSH
         h3fBYtGuT/e7iPaWu5p8u2aoZyNAe/79tz5+CUxUTy8ZSPmExjWTg3vGv5S0wPOvxrMj
         xaBkwGRUb9wuIsVATsMdgUaTQWkC50IrS+faT0zkeISETkSnD3HdGfXW+zW1vqLg+6uN
         J4TXF3ESv1Dt//58H2A2N9jRUfUuZLHZ6NtlmGexWqxCghHx7lqsZh7wbGabw3XYmAUq
         IeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857536; x=1763462336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0+rza3fzimpXJGQPolccb5lBPiW/LZvLZ5Q3IvvlME=;
        b=H/k5fzEHfXxacHU6Reipj9vhom64bzBAzk6BbRjIOSx9NGGVsyOkphalE0RwSLtPe8
         nxywoLl40mo9fgImQLnvuF4GaElut/5IvyK19k7/KhO5v4bkSCh3FJYDYEwZLRMrAM5j
         tOXO2Dj95o5QMFVGYLEugop9IWpIi9fthw4Wx8S8i044iGIJ3HyV388rHByGYzVTf+AD
         D51PGRtLeMHnPuBQyLzq9gUvnd0ub16ouIuyuJCfjmouRJEBJyYt8m/+Z+nSNKD/RRZ5
         4myhfTrfu9j8u3a4r9cwATPv/4V/C0iIKTJMgiQMzB+HqawBbIwHcbOg9g0z+hY3lYDD
         NixQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJK5Rizk59iKwYXKVx0e+ZcfQzQBLBLOk42fuC/J11MIqLgmVy9srgW9+4Ga0grr7za31RU+GR4O7Zdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZN+7upO9cA8l1lQXKS7XlQDPZ8Yd0hnq70JHPHaIa7NcbC51
	y9Iy0TJncNweFIuP1IGN7t+jFz+yBtTrbKdECasymFY6DFjgCAZcBOMJhWaE7fzBnZYSYHe7RmO
	X9cn9EucIaGPhg4BMcvuQ9a3S6i0eGeoW0wVRJXhUFr+P22efQUse5+HmQTMycIIViQ==
X-Gm-Gg: ASbGncsBDqtVRU7yTFZem9ZqGfoN4VQbKTRFEJgBbciaHVO8oEGIunv7IyNtCaqTnSw
	yxTtagyb83dmE1FnCgQItEaEn3+TP6ydxAzrnhQ19HCk0uSU9Cn0MjL3Thh/j1UfX2/p0uhVytW
	F3Zd6MxMFFEZeI48KymfXeQ6zuCSadbcdbK4qiSiMC2L9bfQq7grbURaYBrlljLQYrXD5snclH3
	AUuULw5AYjgvYQPEWw14mfmZJSkdVPNY8IIYQRrUoOXF8Mu1tXtHYsJGR1kra3M55Q61v39W0Qt
	Fqm7OWbzMW+iR1G+aADbUYnlb3mtBM73yxbVirb/0m/EWi8JYSqZMd8n0azlg6ap/n88pvhRlbP
	z6RuSTzzJBiD6l4mbmJOsR1l8C7eQ67QmvzYJwfGMCzzQtJ4mZf5q7uTKD+77Yg6NUqRavN562T
	pQ8mJLXZYHMD0v
X-Received: by 2002:ac8:5993:0:b0:4ed:7c9f:f2ef with SMTP id d75a77b69052e-4eda50259e3mr134140001cf.73.1762857535707;
        Tue, 11 Nov 2025 02:38:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF92xBApQrRVXtA9xV5EKzBgmcrn6Mw/FV9vZg9iCa0pvrqRSHArrA0GbGMmcTUfzEYQ0ESvQ==
X-Received: by 2002:ac8:5993:0:b0:4ed:7c9f:f2ef with SMTP id d75a77b69052e-4eda50259e3mr134139661cf.73.1762857535171;
        Tue, 11 Nov 2025 02:38:55 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a59e54asm4787836e87.105.2025.11.11.02.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:38:54 -0800 (PST)
Date: Tue, 11 Nov 2025 12:38:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
Subject: Re: [PATCH v3 0/6] media: iris: prepare support for video codecs on
 Qcom vpu4 platform
Message-ID: <3vbq76dpjnadfrnufojq4zqiv7p5p555rhxfx6yoncc354p3lk@ohcs3ldhuoao>
References: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4MyBTYWx0ZWRfX1V4hg1v4dGYn
 fyvLEyXBMmnwH5rDQsNuHao3WgjKH0m4DN5SoAlrb2+0Ek8PlglEn6S891vThS1+fbvpWl+6b8x
 1dydoTHTLxtrIxcwRWq/b9UCDRyr/3d9sxydCoEpBDYpJ04wCqK/1S4AROXxqEMbWdWYVWostO1
 QrrRJbhCeoRm7Mq01ZHJKC9USNpWewD6AvuQNM19r4MfvleKwqES/AhtmR/5XXGogGS1WiLfZy5
 5JJEQdUXhJc+Vf0h2kLKoP2qGaKcWatwEnLRXzYhOKgSzbp1ZpC8qtgQiIhMcakJuHIvY1fc2EC
 AdcWj6WmISFDad4h7P7htnGtMQvV3CuuAA2kI8ZOkS7WoqrwKH16+SrmQw/P/XiHUhEFLAFcMiN
 A2Z9gDXc9W5i0JT2uLp5jWg7Sng1QA==
X-Proofpoint-GUID: M1FJIAxOAP-eEHjKBtfyQQ31ByqKKSzg
X-Proofpoint-ORIG-GUID: M1FJIAxOAP-eEHjKBtfyQQ31ByqKKSzg
X-Authority-Analysis: v=2.4 cv=TfObdBQh c=1 sm=1 tr=0 ts=69131240 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FnzHA13sX9O2i_5sQrcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110083

On Fri, Nov 07, 2025 at 03:19:35PM +0530, Vikash Garodia wrote:
> Upcoming Qualcomm kaanapali platform have a newer generation of video 
> IP, iris4 or vpu4. The hardware have evolved mostly w.r.t higher number 
> of power domains as well as multiple clock sources. It has support for 
> new codec(apv), when compared to prior generation.
> 
> From previous version of this series, the kaanapali binding patch(#1/8) 
> and the compatible patch(#8/8) have been dropped. The discussion for 
> this is captured here [1].
> The series introducs buffer calculation and power sequence for vpu4. It 
> prepares for vpu4 when kaanapali is enabled after the binding discussion 
> is concluded.
> 
> 
> gstreamer test:
> Decoders validated with below commands, codec specific:

Why not just run the fluster testsuite?

> gst-launch-1.0 multifilesrc location=<input_file.h264> stop-index=0 ! 
> parsebin ! v4l2h264dec ! video/x-raw ! videoconvert dither=none ! 
> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> 
> gst-launch-1.0 multifilesrc location=<input_file.hevc> stop-index=0 ! 
> parsebin ! v4l2h265dec ! video/x-raw ! videoconvert dither=none ! 
> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> 
> gst-launch-1.0 filesrc location=<input_file.webm> stop-index=0 ! 
> parsebin ! vp9dec ! video/x-raw ! videoconvert dither=none ! 
> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> 
> Encoders validated with below commands:
> gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse 
> format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h264enc 
> capture-io-mode=4 output-io-mode=4 ! filesink sync=true 
> location=<output_file.h264>
> 
> gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse 
> format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h265enc 
> capture-io-mode=4 output-io-mode=4 ! filesink sync=true 
> location=<output_file.hevc>
> 
> ffmpeg test:
> Decoders validated with below commands:
> ffmpeg -vcodec h264_v4l2m2m -i <input_file.h264> -pix_fmt nv12 -vsync 0 
> output_file.yuv -y
> ffmpeg -vcodec hevc_v4l2m2m -i <input_file.hevc> -pix_fmt nv12 -vsync 0 
> output_file.yuv -y
> ffmpeg -vcodec vp9_v4l2m2m -i <input_file.webm> -pix_fmt nv12 -vsync 0 
> output_file.yuv -y
> 
> v4l2-ctl test
> Decoders validated with below commands:
> v4l2-ctl --verbose --set-fmt-video-out=pixelformat=H264 
> --set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap 
> --stream-from=<input_file.h264> --stream-to=<output_file.yuv>
> 
> v4l2-ctl --verbose --set-fmt-video-out=pixelformat=HEVC 
> --set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap 
> --stream-from=input_file.bit --stream-to=<output_file.yuv>
> 
> v4l2-ctl --verbose --set-fmt-video-out=pixelformat=VP90 
> --set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap 
> --stream-from-hdr=input_file.hdr  --stream-mmap 
> --stream-to=<output_file.yuv>
> 
> Encoders validated with below commands:
> v4l2-ctl --verbose 
> --set-fmt-video-out=width=<width>,height=<height>,pixelformat=NV12 
> --set-selection-output 
> target=crop,top=0,left=0,width=<width>,height=<height> 
> --set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap 
> --stream-from=<input_file.yuv> --stream-to=<output_file.h264> -d 
> /dev/video1
> v4l2-ctl --verbose 
> --set-fmt-video-out=width=<width>,height=<height>,pixelformat=NV12 
> --set-selection-output 
> target=crop,top=0,left=0,width=<width>,height=<height> 
> --set-fmt-video=pixelformat=HEVC --stream-mmap --stream-out-mmap 
> --stream-from=<input_file.yuv> --stream-to=<output_file.hevc> -d 
> /dev/video1
> 
> Note: there is a crash observed while performing below sequence
> rmmod qcom-iris
> modprobe qcom-iris
> The crash is not seen if ".skip_retention_level = true" is added to 
> mmcx and mmcx_ao power domains in rpmhpd.c. This is under debug with 
> rpmh module owner to conclude if it to be fixed differently.
> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
> Changes in v3:
> - Drop the binding and compat patch.
> - Address comments related to variable handlings (Bryan)
> - Pick the updates from Dmitry related to sort register #defines and 
>   connecting register and their corresponding bits operation (Dmitry)
> - Link to v2: https://lore.kernel.org/r/20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com
> 
> Changes in v2:
> - Dropped dependencies from binding (Dmitry).
> - Dropped optional items from binding (Dmitry, Krzysztof, Konrad).
> - Updated binding in sorted order and proper alignment (Krzysztof).
> - Fixed order of newly introduced kaanapali struct (Dmitry, Bryan)
> - Improved readability of buffer size calculation (Bryan)
> - Optimized fuse register read (Konrad).
> - Fixed order of vpu register defines (Dmitry).
> - Addressed few other log and commit related comments (Bryan)
> - Link to v1: https://lore.kernel.org/r/20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com
> 
> ---
> Vikash Garodia (6):
>       media: iris: Add support for multiple clock sources
>       media: iris: Add support for multiple TZ content protection(CP) configs
>       media: iris: Introduce buffer size calculations for vpu4
>       media: iris: Move vpu register defines to common header file
>       media: iris: Move vpu35 specific api to common to use for vpu4
>       media: iris: Introduce vpu ops for vpu4 with necessary hooks
> 
>  drivers/media/platform/qcom/iris/Makefile          |   1 +
>  drivers/media/platform/qcom/iris/iris_firmware.c   |  23 +-
>  .../platform/qcom/iris/iris_platform_common.h      |  11 +-
>  .../media/platform/qcom/iris/iris_platform_gen2.c  |  33 +-
>  .../platform/qcom/iris/iris_platform_sm8250.c      |  21 +-
>  drivers/media/platform/qcom/iris/iris_power.c      |   2 +-
>  drivers/media/platform/qcom/iris/iris_probe.c      |  20 +-
>  drivers/media/platform/qcom/iris/iris_resources.c  |  16 +-
>  drivers/media/platform/qcom/iris/iris_resources.h  |   1 +
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 199 +-----------
>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 358 +++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 342 ++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_vpu_buffer.h |  24 ++
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 188 ++++++++---
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   5 +
>  .../platform/qcom/iris/iris_vpu_register_defines.h |  61 ++++
>  16 files changed, 1026 insertions(+), 279 deletions(-)
> ---
> base-commit: f215d17ddbe8502804ae65d8f855100daf347061
> change-id: 20250924-knp_video-aaf4c40be747
> 
> Best regards,
> -- 
> Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry
