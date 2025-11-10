Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0C20330
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742111; cv=none; b=UO1MuDsKdsLjHUXG3DwfVUhe3HITjQ93wPvKuqq65JUD4lACUdIzEkXswwLXywbRZgmf4s4TXci1nRWZkabq6HFq7Gukr8PbsZSomht8Wn0Mn5FZjbnFZWnW26a+oOSEI2J9q0T2kandsN7qKheoKZYRRrMXBnhlZ6023+j4Qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742111; c=relaxed/simple;
	bh=FWvVEmepI+ORVK/x9yXbzQd4Ox1Gvv7bysnMPtT2MKA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j8PZ0glv8vrbExQeJwWHFqirgZwZtK1gEOfPobjczGuQbHxk23lQePynXHLP2M3CYQcY2h2NlrxfTlRXn5doo0hbAF4LsYM55yQK4i2nEDkIW982tX7uwgUqUkiRft8PJHyhvyfYx6oUZVPG86rqwYwotMAiVQelkLz+59jqero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XunadcEX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IbMV/9Sw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XunadcEX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IbMV/9Sw"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9DUUYo736629
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 02:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K5D6ZGrmC52DvawP2bZ8gsaexpKm30yHpnNBshUX6AA=; b=XunadcEXMce98rG6
	uzR2LNXD8LpoFfMu48X0p4DtmAbM2Qq4rZC7EfxSBuSwpgdhWx1UFyV4x383J/3J
	B/vzaJnq1Yv/0FCbJUfbkRDh9F/kGVcjI/+mTeIrlA0BTEJ3FTfzE9+d3CPnl0vr
	Rr7gKVC0ezu8MC5iDvbeumf0kQTEH33EUMgZK5XOQUqCel3RoyizbIqVKQ+kDYlb
	jO1e+BhOt9SxwKWpNEWpoZC1CdZIU3+0yoAJXrVIFnS4mcHdIP4gUFvnrbsbDuGQ
	rlbv0VoUJGYHXDYs1QMprY7B6rrhBD4fmXioxQDcbPiwEvvFJxwp5cyAXz2AP43E
	eUgIDw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuek38q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 02:35:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b95d06db747so2040588a12.1
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 18:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762742105; x=1763346905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5D6ZGrmC52DvawP2bZ8gsaexpKm30yHpnNBshUX6AA=;
        b=IbMV/9SwNoX1K6cZDI6eieeuPJ2eX9dKryUybyFlbL1mGHaUWXkyD8Z0u/7pVWkHQO
         +hugrKDpgEVUGJVhCo2JDDigAe62mbTmUqenG6XmXTuPkHLVMKCr9KrfhZqKZv7Sg3Gt
         N9T4SS9xJqQW21IykKmpnnNxQCeWSJFC+KQYgRpCNI7NhMF9fm8voSn/91YeV4qd8/Pp
         IVx3IJttpEB4JElpE7pTDW54JOn1o0NEA++OruTy9GG1L3L4DyQS2gXUUDSbfJe9+kma
         InPHikudwd57ZgfBfx6IfPSAq1/YTSa6kOyiDjwrd8kK5PD+YzOefqJ242vPBK71pqsL
         SsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762742105; x=1763346905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5D6ZGrmC52DvawP2bZ8gsaexpKm30yHpnNBshUX6AA=;
        b=Zqt0aUviqA57glZ6Ypp4DplsEM6h/pQPfa6abGkAaQ/uf77oTv38Adhj+PqhkRg12Z
         IOTognIbvQnN+ggpL+r6YBpSm3JWJuE3ojx0hJaGk3jb2D3/XanTyiCJnIU+0hEcaHDU
         iwgNWd5k04Plsh/R1qHtbK5yZgHyiSG74SV3FNdcvub86Md0+JA15vUdlDi9IS7NbQDX
         t7wRq6pi9ZsoPnDNtADtXzZQRDR5gOsFabRDYCI/18qQf+5AoDtWBp4b7iLv6H5GOEaO
         whfGB0ZeNz9TfJsJupBAxH/n1qYFucx11H2gtvYvsct5oBSMNRGtnt09me0cA/jL1yc2
         4CPA==
X-Forwarded-Encrypted: i=1; AJvYcCVMkbPHJcbg7xPyjWhmZ2YBjZqV01TFDKBO2jna8hY8hEtQiMFcuDYRKyy0fjXFPXPIIgJzAdqymL2uPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YGptlayR/RRLwto9gaolgoHq7loPq3eR3qGnmSRPzV3rA1ad
	9J5+JKa5uqNFsMzzt6wbTuPKcp4yH0rux7BgreSVcMG3hIgMmVZ0+8eWIVOGkAcj/yfo8Tx3q+g
	L0xvgpy2dh4AYKI54q5y0cCxVV/wMjB/eLufYneYHhMZfno9M7X+1Ev+OfVcLGH4WlA==
X-Gm-Gg: ASbGnctoo82VRi04CFtfn7UjiKcc4BkLBrqPzJHYKsT1YalpBmIbOQs3kSuk8GLuBOk
	qgD95MlaKv+JW8ALF/racDWP4nKcJ8f33SQ4dSx4lh8Iv/vN+OFlVwHU27rLxo1OJnHUPHhLFZ6
	pOVMg3I+QAQcPnRR7s6SBMcjwMht/aNz6Ef9al9rBseAoiR/rPlCyS39p9O3Bhis0kY9bk4FY67
	bXypevwb2XtA7uDyLAHJeGxjHEfOxCFCKkrbScdrs66Jji95FrmrypeGWKYbeBR1ICuXo+dXoVs
	98YQS6A1KJ9KWRMkbs80jrszEoNnCN8woLZ0FV1Bdd/eVe0ilH7H6a/BFyk9hjymMYfkPbVGRH3
	zDAWVnHjyGIqi5QhcNdMefNg0Eb44ZV3TqJ2+eHD6dtXKLaBraZYgMvnxLg1fdNFNEaHLzg==
X-Received: by 2002:a17:903:37d0:b0:297:f2c6:8e05 with SMTP id d9443c01a7336-297f2c68f6bmr61548825ad.6.1762742104870;
        Sun, 09 Nov 2025 18:35:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH97XC5ddthR7Ydja0T+XyG+55lI/1s75GAyjkmHkqkHI4eZFrTDzVTzip2JG43DVoRzGmkpA==
X-Received: by 2002:a17:903:37d0:b0:297:f2c6:8e05 with SMTP id d9443c01a7336-297f2c68f6bmr61548585ad.6.1762742104386;
        Sun, 09 Nov 2025 18:35:04 -0800 (PST)
Received: from [10.249.28.136] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c27a999sm3185823a91.4.2025.11.09.18.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 18:35:03 -0800 (PST)
Message-ID: <e72f3d55-9d1a-4e10-b9f6-5f1162064982@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 10:34:59 +0800
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
Subject: Re: [PATCH v4 1/6] media: qcom: iris: Improve format alignment for
 encoder
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20251106-iris_encoder_enhancements-v4-0-5d6cff963f1b@oss.qualcomm.com>
 <20251106-iris_encoder_enhancements-v4-1-5d6cff963f1b@oss.qualcomm.com>
 <df169cde-39db-ec6c-7294-04939575498b@oss.qualcomm.com>
Content-Language: en-US
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <df169cde-39db-ec6c-7294-04939575498b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDAxOSBTYWx0ZWRfX3hcRM9UXqvqA
 SUsoyEjRHr5SNYhGkU4W0qZugMRfOKxLXXDeSlPyo8nCFJGkFtqbJxG8/Fe3KMVBjuQ+YftGOtu
 0IzOTZjIO9oAVilJxRpNwG/9ipu+S90kizD7+sNn+Sx670WdUyUtGQsVVjn6hhtKQxIh25/9s9Z
 CeTZrXYBXI83HS9UVyMMu1WzoFbWSxra0k5nf5TZ8Y3iLVm78IyddwZk+vC0yE0kDa0TBxO2c5o
 mACvJgfqQ+2XonjIhsVPyWW4vIiKvEUxxg0SvsRQOkztNz5f3ohiJMp8avVr+zdvWLJtXBhNSGc
 N/paPwfbNalzmgphiq96+SBWqyMEJdrhyIX/dxxWVLy3cdnV0M2qWVx2BqlYaML/RwX5u97G1fR
 D82Xg1zi5CV9cc6w7UY4+8NoklGsPA==
X-Proofpoint-GUID: qtkwlxl2IfD64wZRum-3ZJxgP3SKK1B0
X-Proofpoint-ORIG-GUID: qtkwlxl2IfD64wZRum-3ZJxgP3SKK1B0
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=69114f5a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WNGIKuW-4MPZ4T8x7xwA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100019



On 2025/11/7 16:42, Dikshita Agarwal wrote:
> 
>> @@ -231,8 +230,8 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>>   			top_offset = inst->compose.top;
>>   		}
>>   	} else {
>> -		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
>> -		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
>> +		bottom_offset = (inst->fmt_dst->fmt.pix_mp.height - inst->enc_raw_height);
>> +		right_offset = (inst->fmt_dst->fmt.pix_mp.width - inst->enc_raw_width);
> 
> This should be move to 2nd patch where you clean the CROP offset property
> setting.
> 

It will be modified in v5.


-- 
Best Regards,
Wangao

