Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2229BDB3
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795313; cv=none; b=al9baVAZhv/uldDPAqDqrNoQnusz+kjfsAiAPXG4L5kow97UGL1HDDCBRijeFhFLfmiEpJCHsN7Smk1MGdf6WGuPJ5GojBXvlXaAqW0Ob+Nm4S8Rkqo/ZU8awwB8M5YzVapi/8hTrwRyyehftiZo1PZhpg1ISsL2qhkaKndsMNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795313; c=relaxed/simple;
	bh=oOyxVfvfN2aRyBhPTf8mwV/DdTCr77BufMFYqC2fNCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNzkyV/FjsIdIUCcZ32KjA3Mn8uAEfOsxzr4+58MsDkd5fUdDFXPPHRBoI6grjGeZSdng7aoyPIjKYanQi6px7azDo+z5bvqCT3xUbj7pT+8lx6owJafg3aEiZ7i82P4z91FAMADsPwGODSSLaUZPb5FzxvRouEL3xYn23s1LPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZTRkEkpy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bit4ocRV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTRkEkpy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bit4ocRV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACN34A3306996
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 17:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KzEs6QNzdu2qhytoCaWZmKH/MfHn62bBmZSzoL1GAIY=; b=ZTRkEkpyQ7iLYLgt
	qDVsqFH8TuTytvJhA44WRofEY6PBkIhpGlUf0J84hEpxvdCDSf/285d4P0LLnmRQ
	OomSLvt1DEmF414KzoyWR6g3rXb+Eu/59P7O2bUvxtxji/1uJL14sRS/kLwXlf1t
	QqYA0gEPP439zPTXFcCPoINFRd7EHHmZKqVMK95Ou1YBmo/+Wo5r/qLY1K5+8g+6
	udshw6HQf1j2Yp2Rt7Tbz4ZTg+qBmkCGwlgat2hRmbr9kiY3+YsrgdNaE0TDOi1B
	NHI7f5rJJNzRXaq2zlY9zEwv8FUD75CZgvyKVy69vytG9Sk8IQCpQ9xqb6N9kXI7
	I6QQTA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abg0q8whn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 17:21:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2964dfacb68so10882535ad.1
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762795310; x=1763400110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzEs6QNzdu2qhytoCaWZmKH/MfHn62bBmZSzoL1GAIY=;
        b=Bit4ocRVDSlvLZ/1Yo8bF+J24api2iA048nUIjdZf4DjQP3ezXYOVuMTmsPFZakCDe
         wUvDDjwD6qHr2WrfFpTYdUqcmPdQbZ80ETfe3QaXDWbKNUUWQsnCGZYRwl81yHzU1lJX
         IL77GUU+3Nh2IW3wd4utYVh7IFYWW6rpxIkVrq8hrNS75aHurJ+APM9DDDL2EK8uxqBj
         5StQA/6MeAE7CFJLnqXjv+8zhkFYZOc1/DC8a7EhCPo4AGyBOYvXVXrCKpp7nPTXqozh
         U7fnE+yh3As3S07zkubdCT8fpeSCH2B9WUKSq8gPnG+5Q3XybLHt8YJBDf7+E3SZs+kQ
         mSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762795310; x=1763400110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzEs6QNzdu2qhytoCaWZmKH/MfHn62bBmZSzoL1GAIY=;
        b=i08EXSJanniHfCW8gGTN/8tjd0eGe3QrLk7v+iiHjnDXLEph+DW34Ptt86ZLUV/pNL
         rILJssZP6wleFtw3OLCgxaR2KIkWoghsyhNbzOP5Q/R6CyMEq7XWgXZBqCgWcpcdqS2k
         /0xDl4ZMvH/ddrL5KErngpPjXI4rm1mF3vbGL3saigRVm2ZhJkmJigA46f3kxQDx95mz
         1ivU5zNUyCqXxsxCb3gUs6ZQYIkn+/G3kYXrWQoUr+smSDTqC/+UgUP/k5jfS6+9V22f
         gcv4c0Vu/HwAvId67TytyaWP6mg0B9WBo02G2GPGPYFecYwrxZi8r/OKGrpPwws3Z1WI
         lKSA==
X-Gm-Message-State: AOJu0Yx5HGaam5NC9hCCR034LgS44M1qZYJcuJzJ9wHVB1OrDFBkeAF7
	CiPlOJLmiKcPBN/cSIpNhZ0HwyNpHMpfKXDQuHPNgyx/KI714rRoR0k9kadOBfod8+oIZ6Km56e
	swwqF2WIcS1EEUymkr+UsrEMvVzMnn45eHIq2zihbrMvZA1MW7rEeunICbN3SuyTGhplmVhB8LM
	gx
X-Gm-Gg: ASbGncuEevWEVC4J05Rk/mFoqS+Zm/3w3/MEluE8idJF/CAp3c/J9sOa8ta5mJri2R2
	cwJHk6u8dUGYSlaHJpqmk8YHKdZTRmWhC/+M/p1H1GS8Y4sadl69VBUZJdK9gycqLWhIzuLlD9l
	wwy5xSC6dP7vpsfcOmKbbP73S4BlHR8StFF1LwRBMBNd6ZeIkkjgiGjtSNOmEDaErZbnxfXfXdP
	U1aDI6h63+4hifFeAlGhRzYqqzhQMFE2w4Qf67OUEs1eMrcqTzAs6zJHPpLtXUIiGua1pVFgbBG
	GNsEnRWB5WXreXtx2wobl5ky9IWucQl4Yra53JIqQlUNWbttMysBwwatSafknrG4hxmqhSRDzBt
	dUY8/RcUB8nfVfDf7ibBnSI+GPQAH8Mdw6pYC57C6DiF9ppqga+k14V1jD+k51w==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr65139915ad.7.1762795309724;
        Mon, 10 Nov 2025 09:21:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELGhkx48AwbIGq6vB2KJ644Ff+ve66z22iNyFkftsJjOkeg8StfG0sIWyldz8RRpbhI3STtQ==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr65139755ad.7.1762795309239;
        Mon, 10 Nov 2025 09:21:49 -0800 (PST)
Received: from [10.110.83.178] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682bfsm155611875ad.4.2025.11.10.09.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 09:21:48 -0800 (PST)
Message-ID: <33fcfc82-14c9-49fb-89b7-657b7ac640a2@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 09:21:41 -0800
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251109-av1d_stateful_v3-v6-0-4a9bde86025a@oss.qualcomm.com>
 <20251109-av1d_stateful_v3-v6-1-4a9bde86025a@oss.qualcomm.com>
 <2a458127834680ea8e4bc74639536a20494f1357.camel@collabora.com>
Content-Language: en-US
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
In-Reply-To: <2a458127834680ea8e4bc74639536a20494f1357.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D6JK6/Rj c=1 sm=1 tr=0 ts=69121f2e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=lfnHfZgCvS1hSVXH-IcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0NyBTYWx0ZWRfX5b1FmC2e8eAh
 q5xlYqQkCeyAs46A8ySfZJ9NPA370z0DxX4cJu9fpLGuE0WKI3lv4EiRD4jBvJcyox6HID/2u6s
 JE6W+TIGbKTBiC0OX1BAoEMzy53oq7b48bvmSQDi+ObV3Zj9X85FfzXCiyVvwlwGItwWVMwAFDi
 D7BBOOdCGjxkWMlrVOwsBwnMEF0w3TUiof+PIb5nF7LxVC31NkK/4++zHET1XpD8UVlmiVDFiJS
 BhPHADy0Ast+Yg3PGnR3AqBL8533fBlF8LRxlJlbu2K7hoArxiOOIZEEouwycgQDp+/YwfX/0f8
 VArW2KeAmDL3+79BoJPLbftI8Vf9Smrg9Wfx9/YiICGhzAJV59TLD1j8WkN4CMsGqzjA3eQhYL7
 7DcLy+q54ZHiCzRn5E5QpQtWPBSPUQ==
X-Proofpoint-GUID: wp_bsdMCsLWAsY9hupCMKHfO5c7rSt6p
X-Proofpoint-ORIG-GUID: wp_bsdMCsLWAsY9hupCMKHfO5c7rSt6p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100147


On 11/10/2025 5:59 AM, Nicolas Dufresne wrote:
> Le dimanche 09 novembre 2025 à 21:05 -0800, Deepa Guthyappa Madivalara a écrit :
>> Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
>> Video4Linux2(V4L2) API. This format is intended for AV1
>> bitstreams in stateful decoding/encoding workflows.
>> The fourcc code 'AV10' is used to distinguish
>> this format from the existing V4L2_PIX_FMT_AV1_FRAME,
>> which is used for stateless AV1 decoder implementation.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
>> ---
>>   Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 8 ++++++++
>>   include/uapi/linux/videodev2.h                              | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> index c7efb0465db6480fe35be8557728c196e0e530f4..6ca63f35b801b8aae142b69eddfaa549a5568a3f 100644
>> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> @@ -275,6 +275,14 @@ Compressed Formats
>>           of macroblocks to decode a full corresponding frame to the matching
>>           capture buffer.
>>   
>> +    * .. _V4L2-PIX-FMT-AV1:
>> +
>> +      - ``V4L2_PIX_FMT_AV1``
>> +      - 'AV01'
>> +      - AV1 compressed video frame. This format is adapted for implementing AV1
>> +        pipeline. The decoder implements stateful video decoder and expects one
>> +        Temporal Unit per buffer from OBU Stream.
> This should be something like, "one temporal unit per buffer in OBU stream
> format."
>
> Nicolas
Updated in v7. Thank you.
>> +        The encoder generates one Temporal Unit per buffer.
>>   .. raw:: latex
>>   
>>       \normalsize
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..cf0b71bbe0f9d397e1e6c88433a0fc3ba11fb947 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -775,6 +775,7 @@ struct v4l2_pix_format {
>>   #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>>   #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
>>   #define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
>> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '0', '1') /* AV1 */
>>   #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
>>   #define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
>>   #define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */
