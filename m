Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEBF2C0287
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763012569; cv=none; b=FPuxtV8ZeBd8xZ0xlGRoh8U/yQTymYoSMGFZl3f1H4mAV954ttrbdZD80yMtfQ/f/WfJap7yBI8V4RAOlsCyhLxwC9sa0hIk7PuqfMoZRrB3nsxbQ6sEhAzWiW3opG89vG8mlhxIIvVR2FObIrtse167Yz9YTp9qWio8UnmyTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763012569; c=relaxed/simple;
	bh=9f9xlKVZCbRqxlzVaK57ePi8HPm9U3/1ja+f+S2iVOc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k8g3OB35pXc/jXtagYH1fnEllgy+UUL9vf8QsalcxUUIOK6YEe4IoZecCESeuLybbCM++IfTdibYPvF+xcmAK3ThXuvT2UNu0JElVEU+WZibzO6dDtt2dUhD6pUN9PkCYUzLQZlCNPvc5yapxMa2aLB365h4vEwXMWMANgtDCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DAXUcinP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HejxzWPx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DAXUcinP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HejxzWPx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD11K0I3117982
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 05:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j35KoHy0NLm6BEo/3wH8JmtcrDtVvenYAA553qoWcfg=; b=DAXUcinPKBCllZ7r
	rmiLSTs5mgWNCZ4CzOEedk8G7rYQh4P7KDcMvDznErwYCjmvV9mq5Qf4opYzj+9v
	9WffbImPFNjN1nPI2hw6aQ2/wjLAQSzUoeZZDo8be17tsBJ0DBESyV0d4LNBV4GQ
	seLPYX1px+YWEdSLovbymhdMbjovgplOXYjlSVvqQlm297REPBCpM36+/ESdfdcS
	JESYCHemoQxqhqOcVW6XgJJhmbKcg0AzAQsLoepS3p6oDmAa6VB0zc5O2Dm3igpc
	XN2peSp2FpTTdMknD4bBLMl84S8wXmgpOzGyV5XXDRLdy/qM0HK08RNe9OyaVdBJ
	fajFlA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuhg2m5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 05:42:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-342701608e2so607813a91.1
        for <linux-media@vger.kernel.org>; Wed, 12 Nov 2025 21:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763012567; x=1763617367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j35KoHy0NLm6BEo/3wH8JmtcrDtVvenYAA553qoWcfg=;
        b=HejxzWPxth9cDVtoS+SPqRgCvLCZqWTOdqmoszq2+Xp1WefTKf7sc6roQ0b6F4qyBV
         AXMiMRYjzgiRaYxA2grAUGOBUPuFx2KrZOT2aONaPACeWlnZww9c1qTHzhYJ/xSJou19
         rmg3e/DplP+l3wRB0KgMHasa2V8HTtoiwsyqhgJWp86io3wMLFe6fE5JGjlPfnYWJlzV
         MzHZSKNx6FHNyyk81zXnNU98EvevPuVr56pJjN5pWoNBLsDJbZqST2cF8SXjXz9JwsmI
         Ojxyb9NVvLhZ+UW5wJwx1RwxdmU7PD8qocrC3wnVFgLXnj+Rcc5UxjMia2Xk1VUMiHDs
         GBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763012567; x=1763617367;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j35KoHy0NLm6BEo/3wH8JmtcrDtVvenYAA553qoWcfg=;
        b=mWvAfLWNeXo9o0i8x2GFBgamP0P/6VZnnaqhvE3zowUG3eupTsp8dclcjqKSyQb6F8
         4hMGByfab8oepSL/hlDQP8qsNJ2/Z8zGccm1BLikwFLkm6VWvzobM8HA9VoByiMAMMk2
         rvg54DzRospf819SzUivQlrhwKo57ZEEJyqtOlwyHSoauysh4p9dnftelUIqa5CY9Ol6
         9ChR426YIl2iTK89Qt9KzF9Au9d7X1IHVdrLdnDEts+UHbWqsa8ff+I7iYWGz2JAgxYu
         G26JtVtpm9oBXnUKlcGvfRmWYiXze54iMk6cn4lWdGVzPRWuvXJ7fUnqm34LJVYiHFam
         UsDw==
X-Gm-Message-State: AOJu0Yw1VtjuYjZAmBK6010mySdfHI3iCN+4ZJgFCBluJvAtuhAXwMHI
	ZbiBJR3QQoTX1QNmOwD8q98zgGmvPsC+suSdrUXHM1PaHxareqGd24epUFg3g5e4hRG6dFG5E25
	vnHM/r5CTc4PssSofdFc3F8SkNqA5PX3lp98GNutcp2PLOObBNJoSo96XC231K0Drag==
X-Gm-Gg: ASbGncv/pC0pdCQe3V/0f7fWKV0Ow8GnK51WswfSeBAflGS5q/SUzF/QKJAq7FWtS7a
	A6P8WfvatS0gChpCufRLE93/mdh0KYK22+Yg1L4D5kc/YzurHfcBPV3TMY5R7sVURTSLcszKlr6
	21ydsMuUgdlurLAC4tyXzLT5DlS2jhdb8BaeXLxLVoess+majcboEw3wbkl9r8rgLOPmBh5NonA
	6XQ3gyJARIVFCocRd7hR3syflSP3WcxwIzoM/Kgwv0ZBJRjYhHdlX3XeA/TlRNG0CQ7gnWmMP0S
	BoXtBJdJaStxaFMi22nOt2lojZjNk7tMxkR66tKw4dz2CvGdEPR9Es+QxGCgy5/uGacWVb7dcS4
	UoIrJs1Sk1W0kV0vtofVgVWRToWcaUbY=
X-Received: by 2002:a17:90b:4a4d:b0:33e:30e8:81cb with SMTP id 98e67ed59e1d1-343dde14c3bmr7033661a91.13.1763012566516;
        Wed, 12 Nov 2025 21:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoM9MhsGjcXIqkVWSplmBV/oMf6YSS84+iAzFRhBT/s38HoF8LNn+xpaidqFEkl7wac5sn7Q==
X-Received: by 2002:a17:90b:4a4d:b0:33e:30e8:81cb with SMTP id 98e67ed59e1d1-343dde14c3bmr7033629a91.13.1763012565977;
        Wed, 12 Nov 2025 21:42:45 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4adbc0sm1030525a91.3.2025.11.12.21.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 21:42:45 -0800 (PST)
Message-ID: <a9aadabe-6e69-b3d5-fddb-259c46620172@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 11:12:40 +0530
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/6] media: qcom: iris: Improve crop_offset handling
 for encoder
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
References: <20251110-iris_encoder_enhancements-v5-0-1dbb19968bd5@oss.qualcomm.com>
 <20251110-iris_encoder_enhancements-v5-2-1dbb19968bd5@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251110-iris_encoder_enhancements-v5-2-1dbb19968bd5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NbnrFmD4 c=1 sm=1 tr=0 ts=69156fd7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rhzUNvTo7kGCKO17w38A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: vPuoNMkYxniVujNqoibI_1ne3oA8ajCm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAzNyBTYWx0ZWRfXyHaBsSffNv6J
 ZA+yHQQdvEASNFSyqEkV5erRPM1H5PsROuNWlPkr1FjT3l+02dp2hNavvOCnDptwn9KXbhKPPKd
 cDElTTB7PBPoC4IlioQxfDfIJO6IxvuMxHBtI/74jQsnQ0PisRaWcLzT/rJ5g+V1QsgV1QmD6iN
 qTAKEa3jwu42NISDmC2/5GcBSqcC2L+U2a9i3x/XqQwaDpVUjY/ObtBi+fj7ymFF6IkwaRXW9nx
 Dm5wzyVx8Vlr4MJSOLDkTEzBRDMZA4EeK/omyO1XrmyMv/eNUxfKpp5BFBeazWVi9Do8BQUBuEo
 hBGPcl/G+h9byNnZ7qbX2ggd4vGms+1mbQwafg5lwN/JFMZQo/hGvZWjpmJcMtApTx14jBhfGID
 9ohQi3pPdh4tYYKflRKk/VbhfhlwYQ==
X-Proofpoint-ORIG-GUID: vPuoNMkYxniVujNqoibI_1ne3oA8ajCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130037



On 11/10/2025 3:53 PM, Wangao Wang wrote:
> The setting of HFI_PROP_CROP_OFFSETS for the OUTPUT port is correct,
> but on the CAPTURE port it is used to inform the firmware about the
> ROI, so crop_offset needs to be handled accordingly.
> 
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>  .../media/platform/qcom/iris/iris_hfi_gen2_command.c | 20 +++++++++++++++-----
>  drivers/media/platform/qcom/iris/iris_venc.c         |  4 ++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> index 48962d2e4962935bbc24244edfbbdcd42dab151f..30c0cbe22d1d34b5bbbc6bdbd3881dd43a6ff647 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> @@ -215,7 +215,7 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>  	u32 port = iris_hfi_gen2_get_port(inst, plane);
>  	u32 bottom_offset, right_offset;
>  	u32 left_offset, top_offset;
> -	u32 payload[2];
> +	u32 payload[2], codec_align;
>  
>  	if (inst->domain == DECODER) {
>  		if (V4L2_TYPE_IS_OUTPUT(plane)) {
> @@ -230,10 +230,20 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>  			top_offset = inst->compose.top;
>  		}
>  	} else {
> -		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
> -		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
> -		left_offset = inst->crop.left;
> -		top_offset = inst->crop.top;
> +		codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
> +		if (V4L2_TYPE_IS_OUTPUT(plane)) {
> +			bottom_offset = (inst->enc_raw_height - inst->crop.height);
> +			right_offset = (inst->enc_raw_width - inst->crop.width);
> +			left_offset = inst->crop.left;
> +			top_offset = inst->crop.top;
> +		} else {
> +			bottom_offset = (ALIGN(inst->fmt_dst->fmt.pix_mp.height, codec_align) -
> +					inst->fmt_dst->fmt.pix_mp.height);
> +			right_offset = (ALIGN(inst->fmt_dst->fmt.pix_mp.width, codec_align) -
> +					inst->fmt_dst->fmt.pix_mp.width);
> +			left_offset = 0;
> +			top_offset = 0;
> +		}
>  	}
>  
>  	payload[0] = FIELD_PREP(GENMASK(31, 16), left_offset) | top_offset;
> diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
> index 50a3eb975a2523abf1c2df128a66a762a1ed35c6..7ad747d2272f029e69a56572a188a032f898a3fb 100644
> --- a/drivers/media/platform/qcom/iris/iris_venc.c
> +++ b/drivers/media/platform/qcom/iris/iris_venc.c
> @@ -62,8 +62,8 @@ int iris_venc_inst_init(struct iris_inst *inst)
>  
>  	inst->crop.left = 0;
>  	inst->crop.top = 0;
> -	inst->crop.width = f->fmt.pix_mp.width;
> -	inst->crop.height = f->fmt.pix_mp.height;
> +	inst->crop.width = DEFAULT_WIDTH;
> +	inst->crop.height = DEFAULT_HEIGHT;
>  
>  	inst->operating_rate = DEFAULT_FPS;
>  	inst->frame_rate = DEFAULT_FPS;
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita
