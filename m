Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB12253FF
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762319318; cv=none; b=eR5t77tXgAu0i+ZIOXdRDicaP21DaoYX5HuqQDbMFrMQqtg7TbbwVJzMR5AAGt5x9CQ4YrklXMfrEZVLhT7ljRjb6pxdCUGMXwYXY9sY7R1BhWKGYtrHl6xn5v3AXASRWEOq9QwWMhvc18gynqEntfF5CKxpvfljdpX8tbVtX94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762319318; c=relaxed/simple;
	bh=ZLxacbLuQxz/voZj91PU/bqTYS133MHwUUk7V4QIsbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8fcn6YF6i+DEw19pT5KFzSqIIusAvrTN+vV/SBCMBG86LuBP6RmhrAVZkkmaGosWnPdqqpD2wkQo7NOqHcFroee+ZbgApDCkx2kZp6rZKu6QOKubWrGKAvfASwytJwRLDLW6wLGiG4oUsviZNPeCAo2MPWaVkmIbwCzddfYZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IEZiqO6B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R16SCrXe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IEZiqO6B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R16SCrXe"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A54Y6O04011438
	for <linux-media@vger.kernel.org>; Wed, 5 Nov 2025 05:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YzLEDQq95zD2/GHSDMakutle0k08PLdJJOX6so/zkoo=; b=IEZiqO6BguiCTMzu
	ZOujd2PNN8do7HXmjmd2v1f2AcGhKUOy7/UaAaBzSMNurZoEmlCdDTV3KFHBjNu4
	y0tqDFpAVZDKAy/sNq/9Ou/En3LxuFDOV9vSurtA9tqACVJEl8cJU9tYTiNpG5Wv
	YOMJz73LvRlg5uPUOfXO/eQ53T7TtJiW3UN1/g4el0/jRxkMcdhEyeaxlBivYe5P
	HtVa++bKrio4Ncv/kb+QM1aAQDjdy2SWYwbTeoD3v0m66fajsBQAP6xPjN2pHsnw
	Xpl5QjaVN3yBr73YECqs6TsBkdf+7U1rCOZk8yryUIIY6I22PZbygbHUzrovr4Vz
	g4GHjg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ynwr2ay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Wed, 05 Nov 2025 05:08:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-286a252bfbfso156410955ad.3
        for <linux-media@vger.kernel.org>; Tue, 04 Nov 2025 21:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762319314; x=1762924114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzLEDQq95zD2/GHSDMakutle0k08PLdJJOX6so/zkoo=;
        b=R16SCrXex1KBFbDXOc4WINQ9EhuTaQ+CyR2BBDz1bia2X13JqYmZ8rJo2bZT6N4REM
         ghAUXiuszf2VddbgwXufrCgjsMzFbNJ1OKpOmja0dHbNaaoOGuv5fHMUwfbEBqr6ZWjn
         OTZNOBAzE57IVeoaygaWJfZYvEyllS+56RhsShSn8hXBLd3Rug4E1Pxm8orjqQmhmGeV
         QrAejI068rGbuL8Z0/qJXwBTFWgVPb1nVNwXoq2TsZZ0dDSBcSw1xMz5gFVfI8hI5wy3
         yY8VkLYDHSqmQtRlf7iD7e5MGH40gEZCS6gVhKUkuAdSSemqmBnGOmv2KqGp84SP9PHC
         3IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762319314; x=1762924114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzLEDQq95zD2/GHSDMakutle0k08PLdJJOX6so/zkoo=;
        b=W0pJ+1rGLCr4lrEGl7o51trC7NxgQ+hZuiXAjDFc5lnnji7qBkijmiVE0d58iAU3+V
         mPgUCqj0RI3Lkqo1e049zO+wbrURpIbNrITbCUrVKP6WojtFXoF0C5ocQnUvaMH6Mf+6
         /7BOmjeT27upXSBEEFNZkTuP7TPyHaa6nNnzvoWalgCPXyXagmlxKDSdh8Xh/wywTg60
         ksv/Bfnh9gQEgpyv3OY7VrdjMb0vCFuFnigCLg1jPRum3G/7RmdMwVRiYKgRfixHwD/7
         57YZrrb8ZepDVF3d+593covcUIukWGULMvvSEpazE7+geTrE62ITM1nbcBC19vTZi+7a
         ApZQ==
X-Gm-Message-State: AOJu0YzBuW6PzMKEL1t3Pd8Wz1IFqRTKhsoBSD4IcItkPCLFVsGN5190
	s8uoYk/ttt2V40cqvu0SppXejmQ9YV0WM/Jj2x5pJ2sxZxrSkqENRMp2yDpFz8eQRkXOdkbQKvX
	yHpOtjUFFYRp0P1pft0yzdOmInSqn+J8fJAjTxeY476qQ5mSBXRDHk7ozdFs0jXCVuw==
X-Gm-Gg: ASbGncuWYyCCLb3/Yf0q/aLkWZ0daT4pWsVCPXYdtRllkj5k+kxEy5i0xE+ixVt4E/i
	XxyGYqOaEDgEI7KoFkQm4gyAYDRNrNZ1txspLwZsoZgnXwWqGj22/kP5hle+n4dFZ2IAa6kdzof
	BkMGxOI8ft+LSeuhozseoPdMLsXfzd82avj1/dJusbcJRZi/rJbShtUfPMU45LslK29UgzyEFi6
	V/mtjaP9c1+PI5H29q1jFFHDPulx+Y3ZhHKbHxMvdYvMieaT7RtGxgxdbCOcdE/9oqLC0FhkKBI
	Fg20xdSzld72XbcPG5hMy8YYN13bMS62nXRDUrZc3xls3AktkrmT9vbOFriI8o2eV2q9OQfkScu
	jafJNjRyBxMqA5Txtz7p2x6ZXPRaBH2k=
X-Received: by 2002:a17:903:2f0d:b0:295:5da6:600c with SMTP id d9443c01a7336-2962ad82c96mr30566245ad.2.1762319314103;
        Tue, 04 Nov 2025 21:08:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlmvWlejzOce9x3PYRY9I6nscXjGyndEIJCdx2Acn0wOKG3S9Y8LppenmzOFA37pWzKim+pg==
X-Received: by 2002:a17:903:2f0d:b0:295:5da6:600c with SMTP id d9443c01a7336-2962ad82c96mr30565765ad.2.1762319313379;
        Tue, 04 Nov 2025 21:08:33 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019729b5sm45894205ad.10.2025.11.04.21.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 21:08:33 -0800 (PST)
Message-ID: <9164a3fc-5d9c-eeed-2194-68e9b30a3f11@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:38:30 +0530
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: iris: Refine internal buffer reconfiguration logic
 for resolution change
Content-Language: en-US
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Val Packett <val@packett.cool>
References: <fvBCdCb-T9Aph_ehFVcrbBvq0WKOiNeL6BBlMNHABJCm52zzKRfEc5UpSLKfUqgzIYpKyJ1faCTYq111P2LAVg==@protonmail.internalid>
 <20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com>
 <d6004442-fba0-4896-95e1-04a0c6b1dd7b@kernel.org>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <d6004442-fba0-4896-95e1-04a0c6b1dd7b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAzNCBTYWx0ZWRfX6Z+hd0aZXDgm
 b/huaIDtVA+BGc5lHr6SHVdYgDuo3/SI8fvise71UZYsyfuy3r1p3VmxNY+TxY3BZ1yPQ+MQBdc
 icFQNtDFaWgd4a8t96K3yqGECXMk+y9wkz2hdk8Nctzp8BAEoC2qh4cuulMgsgvfbGk1O+SWqNt
 9ah8UtkahxfNOvG426qrHA7LOlpBF71fkE7HyoVuVTlXmMuV7v42iBWMdxV3flMBSoToKJIwES/
 qiCfAMjjzoNkNXMXzNHSQ6Am11O2M5+AyWPbO/IXh98IcQilLFLNvpWt8meMellSgN53g8Abot5
 U1P0Q6a7DTI9kOsNVctXJt67q3kB0x40O7hAm0d7/viQPZG26kSgFcOZQnCLmNcwXlDuY+54mJf
 igjF/9UklFyscrbEMOOauJtkZ02DDg==
X-Proofpoint-ORIG-GUID: DO4iQtaePQ5tsA9621iEqASxwtR7dT4D
X-Proofpoint-GUID: DO4iQtaePQ5tsA9621iEqASxwtR7dT4D
X-Authority-Analysis: v=2.4 cv=IpETsb/g c=1 sm=1 tr=0 ts=690adbd3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=3zkTN5IfQL9Zhd8BRpoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050034



On 11/4/2025 3:47 PM, Bryan O'Donoghue wrote:
> On 03/11/2025 11:05, Dikshita Agarwal wrote:
>> Improve the condition used to determine when input internal buffers need
>> to be reconfigured during streamon on the capture port. Previously, the
>> check relied on the INPUT_PAUSE sub-state, which was also being set
>> during seek operations. This led to input buffers being queued multiple
>> times to the firmware, causing session errors due to duplicate buffer
>> submissions.
>>
>> This change introduces a more accurate check using the FIRST_IPSC and
>> DRC sub-states to ensure that input buffer reconfiguration is triggered
>> only during resolution change scenarios, such as streamoff/on on the
>> capture port. This avoids duplicate buffer queuing during seek
>> operations.
>>
>> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in
>> dynamic resolution change")
>> Reported-by: Val Packett <val@packett.cool>
>> Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
>> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_common.c
>> b/drivers/media/platform/qcom/iris/iris_common.c
>> index
>> 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..21e176ce49ac2d2d26cf4fc25c1e5bca0abe501f 100644
>> --- a/drivers/media/platform/qcom/iris/iris_common.c
>> +++ b/drivers/media/platform/qcom/iris/iris_common.c
>> @@ -90,13 +90,15 @@ int iris_process_streamon_input(struct iris_inst *inst)
>>
>>   int iris_process_streamon_output(struct iris_inst *inst)
>>   {
>> +    bool drain_active = false, drc_active = false, first_ipsc = false;
>>       const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
>> -    bool drain_active = false, drc_active = false;
>>       enum iris_inst_sub_state clear_sub_state = 0;
>>       int ret = 0;
>>
>>       iris_scale_power(inst);
>>
>> +    first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
>> +
>>       drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
>>           inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
>>
>> @@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
>>       else if (drain_active)
>>           clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
>>
>> -    if (inst->domain == DECODER && inst->sub_state &
>> IRIS_INST_SUB_INPUT_PAUSE) {
>> +     /* Input internal buffer reconfiguration required incase of
>> resolution change */
>> +    if (first_ipsc || drc_active) {
>>           ret = iris_alloc_and_queue_input_int_bufs(inst);
>>           if (ret)
>>               return ret;
>>
>> ---
>> base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
>> change-id: 20251103-iris-seek-fix-7a25af22fa52
>>
>> Best regards,
>> -- 
>> Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>>
> 
> This is breaking in CI
> 
> https://gitlab.freedesktop.org/linux-media/users/bodonoghue/-/commit/3d6c2dff61e37bd36eeb677c061ebcf64945060a

Made a mistake while posting the patch, I will send a v3 with fix.

Thanks,
Dikshita
> 
> ---
> bod
