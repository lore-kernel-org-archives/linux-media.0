Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4F16DEB1
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742247; cv=none; b=m62Wiwbrm2Bd1CAEtBxZm3xU40qTAWBn8evePbBh3dNVFrCW4QY/gJ0Ka6kR3obnKZEd57dRFapP/LcL+fw96d/KMu0YFzVsXKSrVkPrm/pQkGfYkK7lBLxQcFxdxnLgv0aBfzdjdlv2kaRNfcr+lcatpN77YCRcKNyrQ0HHTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742247; c=relaxed/simple;
	bh=dDUr6RlWVp++AWWjuwzu9Ndht/5kl/qlNbxSBekCeaw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F4gDRC0ZjKMPRgutwkYjpsn2VucMpNe7REgsiGYoBDLiYkW7+aS089eTdWw+UQkGgM4wIC3i5W9DPdW9V7xpR5Ed4cCUn6BOs4E5ipy5qPwQKjoLKtBll2Aq0KNlGqPBO33xQRFcR1e6GMDztz8pSASQsa/yDKWjxqgwA9koWv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mkLjvxdy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I1a3J1JF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mkLjvxdy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I1a3J1JF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9DUUZ7736629
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 02:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFedLY6wqoSs/S6BwoIDBMsnBgrbfZK76Wkoc+0jWL8=; b=mkLjvxdyejPF1iT+
	lh+pa3mvmBFgma30YUCsNl6FAsmmoN1TdYa3yfe04wFyrLwzshyyJmfoo0iZ9NUI
	VHcuJk49k0zN/2O2npAnlRYXQ3M8yl24OAXWnClppwuRRpT4PLv3FsA88qbPuqQs
	VLZ0e6ud5Vs00vOy9YZb47Okqz5DXh39JrM9XpzqnG7fePL5VESwB9yIlvNQl/2F
	/8vodz16ezxNhhyxs5Df6sJS6H92+hMHdnYF4ycNIGCaoFVdgVJmzCVdxVh58XlK
	BchxiRxSi2jvXeb3pzhNz9HsGOf9TjFgKt5kJeDDHpAB9slDgsyzWk7UdBevu5uB
	008IQg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuek3f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 02:37:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2956510d04cso32062905ad.3
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 18:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762742244; x=1763347044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFedLY6wqoSs/S6BwoIDBMsnBgrbfZK76Wkoc+0jWL8=;
        b=I1a3J1JFWmsEE3u7dYesV7Q0QhVjDQZIQuPvsk8KYGbWc4SCbLR1ZXwU+iUlqmqu9d
         gqMBHYL9E/xYHSd3G6u8aOcYY8P11+4u9SZLC1JDvtUzAFuZP1GaRWsAdwUvKugrbcDN
         exevlbgb1bPHPksipTjlmuFPS/4St74mH8I8j67mjgt+QXJ/P2SeLjrT/5QOzddrG0gi
         cXfMAW1JX0tU6LKP+snfqfYGzALn1ulLsLy67mGDfXAwT7mSErDdRDxteStz0FCkMedx
         87B2TEMBKkFo5mU0BjvJOUvGJDPGnkWj72AvFlIAUXwqVBoKA12Ya+Wdxy2WC2iYSmrU
         cHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762742244; x=1763347044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFedLY6wqoSs/S6BwoIDBMsnBgrbfZK76Wkoc+0jWL8=;
        b=cqQcy6nEDRvPgTVk0JD9waGxFOM9KKWyOAiSJIy9zmI4uNic1OWPA7KVsveq/bgIKg
         Q7NV7Jg+bJVc/h4D5v0rO8zkDliFUwWmOTaLvJIkmM6xL4bOR8eMjkQTGtrpSjVQmhc8
         SXIeHpXGgwKVCYe1F7POPeXzAndfZ5OZYlbmjmBJ1Au/vl3sW2QClqK8NdeID+2VjZ5T
         iODaPK6qp0vLvwc9EIQhsbgczmClmhat4aW+WqWJ2tvnFGMeW+CvZTnX2STbW4MSHXnd
         U2uaUCCYdw0anGJFH1wpJNr7REZCc5dukwh2wZTUGs197Eo5yQtkLBmhauDUec50MDrj
         DBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7gNP8v25a+CRebkWilOfkeFKeh6kVat4/nq7JLZ3UCmZkqOj0jCqIvcOwVyZXGsJISAyfqRQNP3/BtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTR+XDc1uNzmcZgNxRWwO1Fm7IWkI12km7ChM9G9qa1jVCc6ds
	r49qxR3s6JNnQf7+Z1o8KbFYLVlk3AOGp/VwD48b7WqQO/tnBFCNiuDAXJErpT+I4clUH/6KZsx
	nrYNg7JMCwVv9q6ad0Vm2FVJu+AmaGifJkKNw7BoQ3Hxs2Tx/4dVM41TWfAnOyr23Ng==
X-Gm-Gg: ASbGncuO0sSVgjlJ5svusXRQ1JKFlyfqYlS+jY3iTD836kwOmax6xIfnYr5fOcA2tni
	uGmwqxqHYYzJbRwNL6oXIAfAXaFfY9SijkkkdpYFNIvZ6NCvYEoGxumKTneaOT7+6R1uI9K/0t1
	RoF9mLn79mCdCitG5X7SZCFeMjxBPhunKHzIkQAKXUSLLH0to4aTJ1qCPtXaw44PZZ4qw4h+sK8
	6bD6zyuwmQgOGxYZikKNcaMBvHS6AlXtacIapNFWz5v7j4u/C8hXCcC5RR+au9zMKL32VGVmPbP
	MFcmxZf34iGaSX6EILW+rlI1KbtD9bwi6leSxEl1oP2rd9ujgW5i6oseHrsKar+Z6p3XQXgGdeT
	MGzsmklZhfzW9OfchCSqArZ3BbTtxN10q/FRm6UYmM3JPQpbhHteB1SDAuXHomg51gZir8A==
X-Received: by 2002:a17:902:cf42:b0:295:5668:2f26 with SMTP id d9443c01a7336-297e56c9ebfmr95693355ad.46.1762742243691;
        Sun, 09 Nov 2025 18:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUHXymZR9rRNblimju8QZIyozw3WayNgOSOEEBRKq6hlsqJaliQCDAqvcNklp9aQ1xLQ/O4w==
X-Received: by 2002:a17:902:cf42:b0:295:5668:2f26 with SMTP id d9443c01a7336-297e56c9ebfmr95692955ad.46.1762742243195;
        Sun, 09 Nov 2025 18:37:23 -0800 (PST)
Received: from [10.249.28.136] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c9c310sm127743155ad.87.2025.11.09.18.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 18:37:22 -0800 (PST)
Message-ID: <46637f07-f6dd-4a9d-aa52-0ba12b571c29@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 10:37:19 +0800
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
Subject: Re: [PATCH v4 2/6] media: qcom: iris: Improve crop_offset handling
 for encoder
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20251106-iris_encoder_enhancements-v4-0-5d6cff963f1b@oss.qualcomm.com>
 <20251106-iris_encoder_enhancements-v4-2-5d6cff963f1b@oss.qualcomm.com>
 <1728c571-1e25-59e2-beae-124d9976fb3f@oss.qualcomm.com>
Content-Language: en-US
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <1728c571-1e25-59e2-beae-124d9976fb3f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDAyMCBTYWx0ZWRfX4dttUwHK90u3
 OMNcNVE8BdOECHtU9rnFs8NFHH+qk3eAQ7iRlEotMkGsb05lFeljgu/1wY5+wBFc23zmVfiVRUo
 xyv3HRidhNvJNL9GAd8rfS0E29IVIQZOOaTLCUPMTCxT/ReF+rBsC05O0lzTlH0bIO0DfuodAuu
 rM6IMmRe5p3PDUgjzyWPtwsTHC+JhiUs2SYui5rD3cZnMeJWmTHJBcedHZlFPKokb/hzZy6TGYD
 oeFTprrKrZi7bB69fJlX/qTgzrlWu+LWIJ61mbcg/n4uLGSFwXiTgTpVZ58Rw95XzhHEJM9tCKT
 VSXJ1ZBcK6ea92On2mcqWT6qXROnByvz7OX6c4vX0l6sdzPtrSuIVS2BiIRDapqUeLJVcwQfohl
 krxWAaE6jP2CGa5XPTpiz7LpIrSmYA==
X-Proofpoint-GUID: RoiLvu2bEdRL2R5n3GdnpB5m4TaeZVT-
X-Proofpoint-ORIG-GUID: RoiLvu2bEdRL2R5n3GdnpB5m4TaeZVT-
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=69114fe4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0ZktX4uVc-4WF-759KIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100020



On 2025/11/7 18:25, Dikshita Agarwal wrote:
> 
> 
> On 11/6/2025 9:00 AM, Wangao Wang wrote:
>> The setting of HFI_PROP_CROP_OFFSETS for the OUTPUT port is correct,
>> but on the CAPTURE port it is used to inform the firmware about the
>> ROI, so crop_offset needs to be handled accordingly.
>>
>> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> 
> Does CROP use case work with just this patch and first one?
> 
> Since you are enabling different features in your series, pls make sure
> features are working with individual patches.
> 
> Thanks,
> Dikshita
>> ---
The crop for the input port works correctly with just these two patches.

-- 
Best Regards,
Wangao

