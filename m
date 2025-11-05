Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D6520B800
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311430; cv=none; b=aZPQRsDSbGY+4wD6OyL9M+8HBu823fJGZek3+9ctYnjviPBTiUxnjXfnewGJvI6xNjoeUJINQwPWgXATvNghzThIz7uKmRWazULnBAjZG8d42JQ1slRFhUSfzrqnFUelW7hX0Lg1so1AvHstnWabeytFuFgGvjTMGgwDMmxd+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311430; c=relaxed/simple;
	bh=/xGLt1M8kqid+LM9NaX2QqSx9NUMXvIrQuDmRDm8RG4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f9+ZS5PoambfN4Ee9Y8ahgWwGOSUrbjtc6mvUuE3ef/fHNef70LIxsnEgVYS7OIOh9nvNG6o9AyW+29GsSCkWC9OFkC7+oYpytaK8XxIN+HG2/aUYem1Jp4MQb8VQ+e5yp83/k0zZ1JDMoSYROsgdlL1CyrhVn2I1wu9iEBBVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ESaHGw9t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Up8JH04v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESaHGw9t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Up8JH04v"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KgJp53050165
	for <linux-media@vger.kernel.org>; Wed, 5 Nov 2025 02:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Id0Enz3QtMwKYEBuECkWjlnGm5hIArkDcvoo96ONleE=; b=ESaHGw9tgpqQKC9T
	hkzvwioH4rQ0+QPyzXOTEoFQc7WStD3ljw99GW1+/MsdH8Rke6z0RysIqPh0G8GB
	/RqmXHcAW5j+IASLUa4Q8/EjkPZ+TP7gs/fVxuy4yYSAGkx3/r4b6KIjWPgiBnnS
	fyfDwJ8j3Nm7Mow06sg/AcHAynTL2nmb3+L4eF5zZGRBUH2hCepl6sDzLO/YOGa8
	GRiUsIUFZeycx6/C+5lg+vq1+zePMc3vT9DSnRWpErbSjfi7PKENhsvwYbpz6zSM
	Kbidsril2EdpEaIS+EUCxe5R1M3tS8Sdbh5Zyh35ZXZ3iRJnkT2dTNrxBNUxL7ll
	FOeoRg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ex7ttkb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Wed, 05 Nov 2025 02:57:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294a938fa37so125422175ad.2
        for <linux-media@vger.kernel.org>; Tue, 04 Nov 2025 18:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762311426; x=1762916226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Id0Enz3QtMwKYEBuECkWjlnGm5hIArkDcvoo96ONleE=;
        b=Up8JH04vyydkI51ocr1zFJfA/kfleMULrla98Ay/a/FOFnH6gbIQjo24TTHVLEA7/j
         +wpQkygM57gaiiE7llxi9XkwLNnveJzn0MnhmVPeOcM13FU7jlrgwSQct+FaDAROmMYi
         p6PY77JN+rjdcuNc55JXiDeWQ3bEDJgjmjyTB1X1SpO4CX/hqT/pl3RmvLUZ9Be+FgqW
         6g9IKAMHCIvjyMkIcP0cetwSeUkFxvNkiuDfQMWRV3zbsJpGNC7V7P5hpLm7JH67pUl8
         jHM7kmNF6JWZVuhQpVbiQLOgjdeKjDHgcma659ub55i4RZs6FloDzvF2KDWqz76HGJcU
         oE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762311426; x=1762916226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Id0Enz3QtMwKYEBuECkWjlnGm5hIArkDcvoo96ONleE=;
        b=Hsy+rxHO+s4Q/32snoVADdW3jiQVRPjyM0do44hVomG/O2bvZAGBsNZcU5jRtPwsxZ
         1Dr9LnIKaM4SfkVA/Um5kUhqW2i+WkRJlNQEnjVvAedo37niJawWw4MH0f0l6/sb7FX1
         Q0qb86kZy01DckqHU/u/gAigfPoezGShx+Y2zDalq5f2tLf4+BIy1UKVixYyNwYWqNYq
         2rNxlz4Rhgv9PwG4ZEpfIBvO/CE5NluqNgzO6rnK5AenZVMpVJWX2qdFK8GFFqbdLUub
         3nhuTrC0PAJAyu3QRGUjh5nwCtzhocpQZxJ66bGpikk+0iMG6efwLmFXWYWq+xjZL9Tv
         BA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRPMRkPiWKmhXnn2pwajhh06k/TKqFYRIzmQfbj/uNZvDYaN8Dcoyl1jkTgE65TOjQae2Gux0QKtj9yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWYKD9sdRhOxh/fsRzo5K0bh3dG/xyHk5uSQGyMPb2g+q05vea
	gXGkU8ZVGe/59FIqEI+fx7of/HToBLtlBPa8lFtSMwozx2OtEBVkIyd01jyX5Sxoz+JIluCv7wB
	LzaGPZoV1dwN34IElqWH/bjjDPMKGOdyb0ptB4xATU+JJ5LiVKOlsQnqnCscyOhO4zA==
X-Gm-Gg: ASbGncuSo2pDScouRirUZky0E8srBfKhZ/vXRwRpIhKq4Jiw4KDmMwgqveyyA5d0RvA
	/BplXN/OQmLlWtbk04TLiEjtkaS1TeqtKr9Pf6xTMj5ElIZMhM1I4ul1sAe/7Uunlti0XCiD4wx
	JpkzTqL9Z6lbZfAL1eEbUL0C/81+i0f0EGBbQhxexz/m6PDeKyCsZlK31lnqQF6KeAIjyTvAVuZ
	lb7qwerF91LOSEupeqcELV9cAvQrLstKnzCj3cnLQSjXFXvvkTFdKLZfOL2doDbYLxbRfeD8dOm
	3PN3Een0gQn2+IXC5AbRfOGqbg0hyUxFjQiR4nuLvLRKvuY39y53oIVCGPS6a0/5fiXEI259BIB
	WMNuj7qO1TIUtYPRaMct7BY42BM2xCNw1KJq6WlKDzVnk+YEEpZdjWzMVsMB54bTOPUSjDQ==
X-Received: by 2002:a17:903:15cf:b0:288:e46d:b32b with SMTP id d9443c01a7336-2962ad1ef65mr22622115ad.17.1762311425609;
        Tue, 04 Nov 2025 18:57:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmn8PlqOZibBgWAikhbFKXMfNC3CBi1fZULnHntTnSKn2o8RRQsfXr3d5z9bpodnixlYrrcA==
X-Received: by 2002:a17:903:15cf:b0:288:e46d:b32b with SMTP id d9443c01a7336-2962ad1ef65mr22621835ad.17.1762311425118;
        Tue, 04 Nov 2025 18:57:05 -0800 (PST)
Received: from [10.249.21.117] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a381edsm43541075ad.71.2025.11.04.18.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:57:04 -0800 (PST)
Message-ID: <e924f9f9-88b3-4c0f-a326-80cd80abc765@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:57:00 +0800
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: wangao.wang@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
Subject: Re: [PATCH v3 1/5] media: qcom: iris: Improve format alignment for
 encoder
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20251104-iris_encoder_enhancements-v3-0-63b0c431b4d0@oss.qualcomm.com>
 <k3umzf0z69-Hbh7jbT-Gjp4pyquNAYVC3VfIXQcdVZstI5FTtcGU_NEgb8l796Z3Cr6Dz0DQ0BoVQQPd4fr6sQ==@protonmail.internalid>
 <20251104-iris_encoder_enhancements-v3-1-63b0c431b4d0@oss.qualcomm.com>
 <0735f540-8085-440c-9c0f-7ac23b52b838@kernel.org>
Content-Language: en-US
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <0735f540-8085-440c-9c0f-7ac23b52b838@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxOCBTYWx0ZWRfX5sScfrRKRWUR
 RWS7bjVyEWerOZMb17EYmVb5xGW6DdwRldcAvjPvTy6fqL+P/WFT66uAYTu7ayV0VpngfPBtf5X
 TLaUrCZ4lWcyx2dCbXHSzr+ztx21EWyKKB4irc4fD0phq+U5h5kVT5gyR07CjmI2axbwRV7YEM9
 z0yQL7Mgy9ygWQLHLKOnTfpK1wmSWcLXLZ1mrlp6+aDJ7pZhA7NXnxZ7ckz01yVSBVrCzm0lvoo
 q2B5AHhNux1cSUBIR1nzeqc7Csu3QGZ2ofNljzX7etmthSGxoLoOd7w0Uj5OiZYhCKJH/9/9CjJ
 X/GFQmZe/foBsOf1lNXGgc41Q86OL04+BacqUbdWW+GoFLsMb5toOSi/0O8n2pZwKBvzktS1+58
 BwL+vKbCc74uAI6NuFFhRy/KZfFKbQ==
X-Proofpoint-ORIG-GUID: iVsywHldbSVnalj9gq_ltEnBNTEtGtj5
X-Proofpoint-GUID: iVsywHldbSVnalj9gq_ltEnBNTEtGtj5
X-Authority-Analysis: v=2.4 cv=auy/yCZV c=1 sm=1 tr=0 ts=690abd03 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ozsb_Tqo4S_mXzr4DdMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050018

On 2025/11/4 18:39, Bryan O'Donoghue wrote:
> 
> To me reading this patch you seem to have three or four different 
> alignment changed bunched into one.
> 
> I would prefer to see more granular and specific patches for each change.
> 
> Please break this up into more bite size chunks.
> 
> ---
> bod

Yes, this patch does two things: first, it uses the actual YUV 
resolution for raw resolution instead of the aligned one; second, it 
improves the handling of crop_offset.

I will split it into two patches in v4.

-- 
Best Regards,
Wangao

