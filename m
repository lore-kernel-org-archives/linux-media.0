Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89B338F4D
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440650; cv=none; b=UcVAbjbWoulmbA6AOteHiLYcI0HPher54GXLTnu9+FqaPc+yXo37pCMWifxa2AmmQyNb7bDlsILMKiuuaB4LeoLU1Yg+CtSjcrKWPG/FwTBW3Er/mNJ3NOlpqzmbDaOs8HYlYKtH9xxdlldHXBpEorsKMFpETL+8HikHX+AyABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440650; c=relaxed/simple;
	bh=LWM0l4vzzbacqdnVzpCnRRUWEOcQxOAdXEAdjEcgw4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dG8bE48AnLveVyuVLY5OOdBt9nSAHUjL20tXWKWyjk/NKtkPOWhS+6PhRsYbizGqwqice2bEXDQmUMXYS29ztFd/xxtZEPBJwK4+P41kqWg5dI7gnUBlQAK3MJNqawGb0QhS5SYpmvnIQ9pundkyifZZJ0MurA5xqa2B+laOXjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aiWKQcAF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AinBshkz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aiWKQcAF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AinBshkz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6ASsd73749048
	for <linux-media@vger.kernel.org>; Thu, 6 Nov 2025 14:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+c/QOz5FWP7I3LmCV+SwCpj23lo4cqX+0KR+4hGKgwo=; b=aiWKQcAFWqcZzvGc
	YiTfnQU70O1Cm/+AL4xg3JhPMxgPcSzp0HFbt6WJ/luulrbH34FYMgJDW1pPCStD
	AtDY6gnb1jjAKwE6dE92jvyiCCqyxl5YnGBrhVCDf4nku7sogirG9efGnsBAAcJN
	4OOSEb1kpJerjBaOGBjhQdaUtdsh2Lt//LokUKGQqFQEPXlspYSueLJiIkyT2waK
	pfgwEN8HtDdtlFuRJxnGfls1QMgSg5jtt1rfkBglCT4kly38SgbKi1EFIfcRlaZV
	uXRU4aiXYpTd3goEZpZDho6lyP8b2GY8HH1AcoV36l2fsdt4lq83bSFh02MIjFI2
	tzvvhw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8sy6gphb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Thu, 06 Nov 2025 14:50:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3418c17d21dso1150990a91.2
        for <linux-media@vger.kernel.org>; Thu, 06 Nov 2025 06:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762440646; x=1763045446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+c/QOz5FWP7I3LmCV+SwCpj23lo4cqX+0KR+4hGKgwo=;
        b=AinBshkziaDfbl7t6QLG0GowA5fREtn+pIr6VSJJAfCcXr/bUFM10l3M0s0JYl1XsO
         7QS1Z0zSpKYOjvWdEuLH1XJFxVMPJ7V5agSoAsL2i9qufdeJOyswuPUWMVKaXdOYzvK7
         e8qRKbzLzgXE2+XVrST7TsG+hhvtdXB1YeruIubujm/eWg5a4+pwYcb1bS5QJl4mVUBU
         6Hl25fmfRNDQSzPIoktzqasNfkDxG5Kc7juSHQpuffK0Z0IRL0tIfeFPuIstqQi24oo5
         sOzpYWf7jSkzu8GNumwS0cQ969Msw0p2Mwxv9ChLytr2oFqeMMLHLE3CWZTN/v9UaXMW
         rDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440646; x=1763045446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+c/QOz5FWP7I3LmCV+SwCpj23lo4cqX+0KR+4hGKgwo=;
        b=eZrGV4fLJk8WHaWYoT00LFZ+CIC1IlcWLBPFXMgYQ0iN++YKC4uILAgAxW2pMq5D6m
         bhvu5aHDqMl+I47n1IsrFrEyyzR7QyENLt5kTGFvRuuwSGrsL/mDfxJA1alkRQm1+cOg
         EFvTQfAmRVvYgmcx4ugTMNSHZiv2BmoWnJXM/3WeNNm+YlLzIonlwlizuUlhZv8IRUyV
         fgfaHbNgvqP3rWMWpcjJzlViM+wqfo7PtcInI9zyukU8iZxqajPaUjEJ3bhBepWeva6M
         ehDGJZLuYvS4/sDzupBF1Zsjr8V158tAtX958PUDHYN7Ir28+CO6kibAMTUQmpvXqdGs
         w6CA==
X-Forwarded-Encrypted: i=1; AJvYcCUvopNDnkzFILCSO9YPnYfTvbehJeC2S7oN1lmAK9hZHzTJsTpYKO7m1Bp+FybtLRTWI0RvbQfwxy1oCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQMgysG75w0cAoaLvzL2vp7GKqrydqNWUq/TC5C5OOJ/Y6MSI
	6gmYTXdCRnYFVZjT/v4N8MfQMNJPhE/gsa2LRgsHlxKLTlAlGvPNzRX5YM+p5au7kIcUBAv1mzR
	a0XBedy4WL8IMeBE4P/jf0B9BPOlLSDMKYMr9KFptlMoiVNHtECEd7/Ey+AS9+AvL/g==
X-Gm-Gg: ASbGncuEWgj7g5fjIWmA+nKrDyFvnRpE1dPQvNIlaI6RrohfVm+fp34gDFbl//PHA0M
	ooLTVQnxm5Jyil41cv1ir/UAsKHUCP7riWwpgjMwH8aU8XEnW7z7hNCsaAFCF6rNDfNUZX1jIWe
	qEsujEfUHdLB7T1/QxYebKI4mMCQbLhOIZ6gizfGPkmuDHrEDXlCCSgQORSw5UTqN4MINL6jSEx
	J8psdv2D/7s4hrCsuTumqSBG/fxd/znzTbvN8hBJ++9CJOd2y9www0WwUctbELHAOLss6asQL0W
	9oJvMkeeHT7rLSjnpkuQDq5n9Iy9PBesh0EcXUObw5M9bLQDU64FbPWnnxDfhUjhK1q+cga+CMc
	i9LtLpTS2T3YtznTstvb+x7L86E3SmmHlog==
X-Received: by 2002:a17:903:240e:b0:295:3a79:e7e5 with SMTP id d9443c01a7336-2962ad88638mr95158345ad.34.1762440646348;
        Thu, 06 Nov 2025 06:50:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDRjrSPgAtrWEFqUDfncKSqQ+S6NIN3iMJTRreo40l/2rWNYrrLBKk8fycn3wYrt9sMYdptw==
X-Received: by 2002:a17:903:240e:b0:295:3a79:e7e5 with SMTP id d9443c01a7336-2962ad88638mr95157765ad.34.1762440645836;
        Thu, 06 Nov 2025 06:50:45 -0800 (PST)
Received: from [192.168.0.171] ([49.205.253.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b90asm31242295ad.23.2025.11.06.06.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:50:45 -0800 (PST)
Message-ID: <fdf4c469-d276-4f64-b13d-5266cca7235c@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 20:20:38 +0530
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
 <20251017-knp_video-v2-1-f568ce1a4be3@oss.qualcomm.com>
 <c9d8f76a-513f-4a09-bba4-cb8f0df1d2fe@kernel.org>
 <034bf6f4-0a49-4973-8536-28526b3409d1@oss.qualcomm.com>
 <9c920cdf-1985-4656-bee2-8bfacc15bfa9@oss.qualcomm.com>
 <24719933-d81f-41cb-aabc-e28f018b156c@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <24719933-d81f-41cb-aabc-e28f018b156c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AYu83nXG c=1 sm=1 tr=0 ts=690cb5c7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=qKS+5dAnvCMTy05vH4hvkg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=9_Y8sxrH3V15ADIk1vQA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDExNyBTYWx0ZWRfX5vJXZauOn5w8
 aNoN+6E5pY1guyNR6Y8u1VluWJsdugW2cFmiuxnhQGaOoZ3fQyFAFzcsDvIDz6hP/vz1sBCaKlc
 MVa616ekElkfDBh9q61iNEas5dEJbAg1GinX+y4b/y27pnG/tlYyvExEeRPPfZed52dRQTrLjtX
 hnhjhi1xuGdfQk5eEUuTCD4/yBptkMcAffkp5kRzL2ds0YadyBBqw1eYI+nrG8nQiW6oCEE/+hu
 /fxBAfeXU86UfDC8KER9DRQxeE0GxzxARJN8duDzpDe2eelFlVEGttE39xsT177H0iezyPndp4I
 JbH7JkZTL0asWBTv/TXzTupotLLYWoobrThsfFqbaeoI7F0SC+THHXFw+ODfCTHQcIdX5ypdSJ4
 O04IZHMeMKoOpah4XJvKOFcG3ETNmA==
X-Proofpoint-ORIG-GUID: Hw1gJsLEY6XnZBSUeChMtbmxCKxlAcMP
X-Proofpoint-GUID: Hw1gJsLEY6XnZBSUeChMtbmxCKxlAcMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060117


On 10/22/2025 9:58 PM, Krzysztof Kozlowski wrote:
> On 22/10/2025 17:36, Konrad Dybcio wrote:
>>>
>>> [    1.361157] pc : qcom_smmu_write_s2cr+0x64/0xa4
>>> [    1.361165] lr : arm_smmu_write_s2cr+0x2c/0xbc
>>> [    1.361168] sp : ffff80008005b8f0
>>> [    1.361169] x29: ffff80008005b8f0 x28: 0000000000000000 x27: ffffc7f252f45320
>>> ....
>>> [    1.361195] x2 : ffff800081200c48 x1 : 0000000000000048 x0 : ffff800081200000
>>> [    1.361198] Call trace:
>>> [    1.361199]  qcom_smmu_write_s2cr+0x64/0xa4 (P)
>>> [    1.361203]  arm_smmu_master_install_s2crs+0x7c/0xac
>>> [    1.361207]  arm_smmu_attach_dev+0xb0/0x1d4
>>>
>>> Could you please suggest on listing the iommu items ? I did not find the
>>> relevant references in other bindings where flexible iommus is being listed.
>>
>> Krzysztof would probably like to see what I believe someone else somewhere
>> sometime suggested in the iommus discussions (sorry it's not possible to
>> keep track of it all), where the DT can list every possible required iommu
>> sid, but the driver ensures only the ones that are necessary are utilized.
>>
>> This will require big changes to the iommu framework though, I'm afraid
>>
>>>> I already asked this.
>>>>
>>>>> +
>>>>> +  memory-region:
>>>>> +    minItems: 1
>>>>> +    maxItems: 2
>>>>
>>>> Same comment. I already asked this about iommus.
>>>
>>> Same here, there aren't any bindings which lists for flexible memory-region.
>>> Please suggest if there are any such references.
>>
>> Similarly, we can define the additional memory region that's necessary
>> for $reasons and leave it unused in the driver (actually I don't know
>> why there may be two, but let's assume it's a QTEE/noQTEE detail), because
>> for the hw to operate, it must be set up by some entity in the system
>> either way (i.e. the memory is reserved even if it's not done by Linux)
> 
> 
> Another point is pretty obvious: if one claims that
> iommus/memory-regions list is flexible - some elements are optional -
> then clearly there is a distinction which elements are mandatory and
> which are optional. So there is difference between elements of the
> array. If there is a difference, they all must be explicitly listed,
> like every other list (clocks, resets etc) property. Writing bindings
> doc also defines this rule.
> 

I would like to describe the video bindings covering all the interfaces, 
including the secure stream ids. For this to do, i would have to wait 
for [1] to conclude. Will put up a new revision on this series, to 
exclude the binding patch and the one which enables kaanapali. That way 
we can have the driver prepared for vpu4, while kaanapali binding and 
patch to enable it in driver can be raised separately later once [1] is 
concluded.

[1] 
https://lore.kernel.org/all/cover.1762235099.git.charan.kalla@oss.qualcomm.com/

Regards,
Vikash
