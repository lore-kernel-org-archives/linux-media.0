Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30532471A
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865034; cv=none; b=WJGmxk57ZYhBbWtrk9XWKZ3YXdMJPGBcX69/m3e6TAUDvTH6iES29AlzlUyvavM7rPQYIHb/YoroDQVW0jlFvmW5UgrqyHoR716h7fxgb3s+bqVt4NUdi4XS1UV1l8NEtxJiErbxYAKUOCZXTyZ1szvDTJq44tw7WFlxn/lIyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865034; c=relaxed/simple;
	bh=Kj9udI5+8LrV+ir4kfGot1dJx+xvrAlxiebPOyOAxpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9Sn3/YUAJ5Q0LD76Hg3HtmIWAbtNY75WsEQ+CkPUR+phB0/4TDGr8TRr3ICNsmd4NoWtmCuRj/ddlD9rBC5Cl89p0r64EsryqmxQ+cGm0jNkyPDsmk/cUbjP+Cv83XCOgPoMF29p3Ke/kDg5sK0YoA9ONoparLC/WTrZutp/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1dLlr/F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IBxUAlGM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1dLlr/F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IBxUAlGM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGXOb2027911
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 12:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I27iL0xTukeBgsDvY2yAuEtDraoFnlxjI9IfkTZL9QE=; b=l1dLlr/F/G6JIrNd
	bT+d9arVh9SkBLjOAhujMu3H3USOSt8PgAfSKbJPohZRlhsZFHCSL0Ilb8XGRHVI
	eeXuGhbTggF07ZQ/P/PU2DBLPIGzMxwehq7e+3ul3eW2DvAytizxPAE2MaNptWNh
	suWGUs0z+ytVD4iqDSSr1HrAMSfRq4TrON/E9Vsj+jdgKfB+E2+WLjTbesUddGrv
	VrRShKq1WSw5e9N1raUQRNRUoxnyC50VmBKwt82H060StNZWVwboKMBJiOv8ceH8
	v7VCIwJcr6RWCK/JULr8f8q+4X54qxe3W1OOoS2WIP9pSm93VE54kWOYkq0KAL5J
	U3y8Aw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxqw18ek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 12:43:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34378c914b4so3480944a91.1
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 04:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762865032; x=1763469832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I27iL0xTukeBgsDvY2yAuEtDraoFnlxjI9IfkTZL9QE=;
        b=IBxUAlGMHEHLy+5c0vcvt6KqjiT2FZ8mpdCakpnf5vtDMVkXElRez1QcojplAbFzT9
         MmPOQPLxFKMi6w/nmWJ842uqQj787shZrCspMcLHrTXyhTfaTR6iipSphnUX95TGi4Q9
         BI4tmExvDJvb0/rcfgGi8idcsppvkXm2c0YdsFHMZqX/FpNEX0nTex1rvzhgIpZXziei
         XNrQ0hNkik2m+OvoLH+GfzDJ3gDoHfG/JsAF6wBPND9bXBZ9xZiCDaaG8lJ504Fqimue
         ptPJ6MuuOBkpMEw6MgJhY96gfiJH7lCKGMP05zsdiONYI9+wza5Ut6Z3t/Qx+7OQzobh
         buTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865032; x=1763469832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I27iL0xTukeBgsDvY2yAuEtDraoFnlxjI9IfkTZL9QE=;
        b=w/JrVeo7AGPTJhUyEK1a/f3JPMAYx60umLO6jRbNcvQwiUE2svD6UeqKkHl2+Gq8bO
         0NiwJmCYHvshqChTfHZ1eWzvuKUo8KpirSmGcr2YzXQqtWpP9Dk78aITAaRW22bV30Oz
         0uO/2M5ZIC08Uqpjz+b1hvhHC02M51zCg69GUbL2JhttoP6jAUfDIjrx96SibJZ4CzZd
         nYvE5ye/3CzNzhHbUaWM88Q4IuaAJH+pJVHistjq0iGfdYcAlexkH+hweGFAp9FbLSZA
         9aN8ZpVLI6fjxAZWScmlgYCHfLTPE6VLPe6b9s1GIv2EJwwRxhZs4gcaBFZajIwZNrAC
         QVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXquVnuitLJ8rOFerrnaklJzlz3wWw8IQNBmcuQXntX1LMXuPJfcLhe3urBsKOk0IuQrExWPa0cBxYbTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhnx4JEEKFrhytcGxHVhTmJTf3UAvKJNGV8nK9T9eM3OxAL9GF
	SUWP8y5fUxJ+jWEbuJE41VqHcU5ooowx01zRzefCoYxTQkkpPdPuy20eTAKo7EKtZE1yRUSyaey
	8/JQyXG7JcojD9eXEEXwz1Jum5XSkf2fXAKYx8fe3iuUNDZ9S7HyPSZx0aMKwu+KNZg==
X-Gm-Gg: ASbGncvh1zLTeerIgWheUPtbfRsbif6Fx99cGiCDrgW5XW3Fp7X4ebFjLDKhAm5CGvh
	7g4rZ3j7RT9hMovDs2feHwcGa25wFZFuJDYH96kWhJP2mcN6yfsUaEbdKe1pOEY+0sR8TMXZfjV
	o3tiWYgmPaRVoqMzssDPYRfGEyJxxJPB4GrkI9gyHpPDxUjwHUD3g/1RUG1WAx2FNMrG386vQ/j
	AomxqksVrqHsN6wjttZcTGzmaxNmpjm2U6hKLAT6v9Pt3PCK2Vjfg87/B934pCTaxK2v/Oylylm
	kphnw/zjWKVBxIL9m9++dfTO3GKdRrSapN1eLf0IPKYaybYWeImfvmguBvLZIRrmUrEaB0LyGX4
	VmorZW1vkvhbFjiwMTwyym0sEsiakVE52NA==
X-Received: by 2002:a17:90b:3506:b0:33b:a906:e40 with SMTP id 98e67ed59e1d1-3436cb735e0mr14270797a91.2.1762865031654;
        Tue, 11 Nov 2025 04:43:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNsRrK1r+sGPayL7tZtRhHjpLvw+oRyJ5XgJB73fyN46t2ckrkv9C6hFrZnt1U5fCf/suKyA==
X-Received: by 2002:a17:90b:3506:b0:33b:a906:e40 with SMTP id 98e67ed59e1d1-3436cb735e0mr14270754a91.2.1762865031138;
        Tue, 11 Nov 2025 04:43:51 -0800 (PST)
Received: from [192.168.0.171] ([49.205.253.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm21198626a91.7.2025.11.11.04.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 04:43:50 -0800 (PST)
Message-ID: <2d56fc4b-6e3c-4f83-aab1-c48db3b8bb2d@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 18:13:44 +0530
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] media: iris: prepare support for video codecs on
 Qcom vpu4 platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
 <3vbq76dpjnadfrnufojq4zqiv7p5p555rhxfx6yoncc354p3lk@ohcs3ldhuoao>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <3vbq76dpjnadfrnufojq4zqiv7p5p555rhxfx6yoncc354p3lk@ohcs3ldhuoao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwMSBTYWx0ZWRfX/0SHC8om6e3g
 B43PK29uSWgKz3RLCFy4S3VCobLvIP3XtxW+EBcFeIEi+FOYr8Rfar7bfYrFTPRe1Zm/LZJ3Tx2
 XX1hCkz1MHs8zP9DND8ax5TXCMHmNCOygJFgPjfFh0IV+caP5JoxWW+WFniCmcJAiA+NWbNoVg5
 F1W8iro0Os6LSRb578MgY/DrWMoVNFkvf1o/S7ZtxHHs3yO+jwTGhqYjnC6jTAAjoe7jbpJUM05
 ZxPXjiYMnuvgBM9ONbyuWPVciXVhtTjEzU+IFNuc73U/EnXdNLGIIQp0C2zH60utIS2HDI2iF4u
 Emwfj86al63F+cetyM8AUJXVgmlccfedkSQxvT8qEHEJbEZD6C4IzGCykJyLEqOlYKO/8WiNAbN
 ex7IEbQ44Kes8OqpeZqp+qntlJ3PNw==
X-Proofpoint-GUID: vCim5gjuufE1OSrksZlpuZ37Cqus8-_K
X-Proofpoint-ORIG-GUID: vCim5gjuufE1OSrksZlpuZ37Cqus8-_K
X-Authority-Analysis: v=2.4 cv=CeIFJbrl c=1 sm=1 tr=0 ts=69132f88 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=qKS+5dAnvCMTy05vH4hvkg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2OoCl90f4T1uiMieyDQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110101


On 11/11/2025 4:08 PM, Dmitry Baryshkov wrote:
> On Fri, Nov 07, 2025 at 03:19:35PM +0530, Vikash Garodia wrote:
>> Upcoming Qualcomm kaanapali platform have a newer generation of video
>> IP, iris4 or vpu4. The hardware have evolved mostly w.r.t higher number
>> of power domains as well as multiple clock sources. It has support for
>> new codec(apv), when compared to prior generation.
>>
>>  From previous version of this series, the kaanapali binding patch(#1/8)
>> and the compatible patch(#8/8) have been dropped. The discussion for
>> this is captured here [1].
>> The series introducs buffer calculation and power sequence for vpu4. It
>> prepares for vpu4 when kaanapali is enabled after the binding discussion
>> is concluded.
>>
>>
>> gstreamer test:
>> Decoders validated with below commands, codec specific:
> Why not just run the fluster testsuite?
> 

yeah, fluster can also be executed. Individual codec commands were 
explicitly called out incase someone wants to run standalone gst pipeline.

>> gst-launch-1.0 multifilesrc location=<input_file.h264> stop-index=0 !
>> parsebin ! v4l2h264dec ! video/x-raw ! videoconvert dither=none !
>> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
>>
>> gst-launch-1.0 multifilesrc location=<input_file.hevc> stop-index=0 !
>> parsebin ! v4l2h265dec ! video/x-raw ! videoconvert dither=none !
>> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
>>
>> gst-launch-1.0 filesrc location=<input_file.webm> stop-index=0 !
>> parsebin ! vp9dec ! video/x-raw ! videoconvert dither=none !
>> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
>>
>> Encoders validated with below commands:
>> gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse
>> format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h264enc
>> capture-io-mode=4 output-io-mode=4 ! filesink sync=true
>> location=<output_file.h264>
>>
>> gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse
>> format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h265enc
>> capture-io-mode=4 output-io-mode=4 ! filesink sync=true
>> location=<output_file.hevc>

Regards,
Vikash
