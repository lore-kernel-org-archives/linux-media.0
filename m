Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F1230D0F
	for <linux-media@vger.kernel.org>; Sun,  9 Nov 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762723003; cv=none; b=FJ1wjdG/qLH0Qre3kGz5bsicLKiBYERlAG9V3iY2+OkHpagCNqTUWylYCB7AWj3QMcGmgglNxp5wfwajfyDA088dV+JKCZyV+r03c99N1rOyelv0LvoAXUIjS0wbeabv8jIXIZy6q1vZdNRazAEXAQ+GwbdL/B9agggSQznSY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762723003; c=relaxed/simple;
	bh=YKRFzAQU2yviHCep6w9J7Yc9MhUTG3/YbYdXnwDQk1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byokL/9KBl8Od/U5FTfc4PWhxwFtnE7AR1tJ9gpuhr68igyblKuHwHs2VNIyW9kaHvO8cwFxHtUOyhH28AS92TXDAV0ts8PD4FTrSzit2LAwCDLm0WvogEBQfe8b/Jl4juVeMy2jq02H972tUmddvXltMm+BR5QgmenWUFhilLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fOQyAIom; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iQmaMnr7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fOQyAIom";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iQmaMnr7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9FOoj9780133
	for <linux-media@vger.kernel.org>; Sun, 9 Nov 2025 21:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=y9+qULSDBdRkc52X/nmwRInE
	9RrGB/j6DPLmA8vUbxc=; b=fOQyAIom3Rs8eKzkvAyIAobupLsvhG2DgBKYl5jj
	z0gj/WYngV3/dgTvFnFIlPiOFsjUzRn40M1lMNg75vO2nkFuA7S2wBEkqCYEJtXq
	nF02lSodMkyGMIYbpG9OLMJIfmOjYDQPz/AWeYd2kldA/0FzvYr48uE5cVm5sKJa
	tZCTsHs16Q+wq8CzEEeyHADXRLlsAVxghNPWiwbyJO4CUH96+zZ0j7tlLDpaQqf/
	1NJrB3VW2c1YNNcRp6quF1Iu7X8o04vft2nLIS9Fp55B8hoICKzSNWRkq6w/BAx4
	wWQcVnVYwNkxtovA9q6k3u3ovphesBW/XT4xn14PQQPaKw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xw5amx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 21:16:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edaf614c7aso20127911cf.1
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762722999; x=1763327799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9+qULSDBdRkc52X/nmwRInE9RrGB/j6DPLmA8vUbxc=;
        b=iQmaMnr7SI7Hcc92iAMFbfUYr7aXYpt30bH/c7ub0AX5URpvmxsBh8WuHH4eFxx+sH
         XW0AJRQkFtHh4ljt47mHyps8hCA7ryRvY8T3HefjW+UDJ/BEairxUNSMpAC3FCP7trmg
         oHw8CbRPjDN63ihPN0+TH189ykdXwBsONDqYVFHIFIUTkZg6TsS2+SCgm6qI1ktEl8dY
         Z9/DUncX71TKtUjNEtudIKba/1RaQVM6xsDjBBQGT2msbvLnH1cnouirHmHhWFoSW/sE
         3UPVG5X86ibTlhy8syb0aGof2SArC9KWhHlgZtI+gEnR+KoB9KyvGge5J41irLXP/5Jh
         DmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762722999; x=1763327799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9+qULSDBdRkc52X/nmwRInE9RrGB/j6DPLmA8vUbxc=;
        b=L464/9UgDeTyUqGOZLIFwlCD6zS7jXrDHzQIrir7zJQWixLLCZD6/bxc6euvS56L9g
         C7Au+p+Cx72pCQVQNsnG0mNoCf9bC8j8RhMHxpJ2TvZc3xzQzIvqOGidWhdKKT2OO/1y
         DCeefXFVCwE5rBuxAJUh7rtrWhAsvy8Z92GvkkrfO7lMWqsoeeW6JdItOFYKGFdABoDw
         Qgw7frkJBWDA2kP5JXtUpUjn0XVRcWmSLIAirVHZNMZSa5o/9FwJHOwVQMP6h9rwGrN4
         Q7RNoYnHOUYVP0iKw3KO3JjvhleQyvZNXTmKvXcBgr2sBTngXq5med55IubpcS/f9ICO
         ojcg==
X-Forwarded-Encrypted: i=1; AJvYcCV8VGfeDmncYTNyHEL4OyLa4ohHQ7TOGt/9W+3w+lwT5QqNstbIqu3+H3w5vw3JFjQbvQuSHkvY9xxIqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwasPp4xzhtLaTYiBcyIsOi3SDLwpr/UDiHfDrZhRiipJDor7Gd
	aa1O4c0LbecEPjcTcI0Rm+tuYU6DlLX/QKCOcoT4kWR/gswtlE8JQiobjnlELZ9sf1AR+291Hgp
	SFeS5djKNIgO93R4fM51hNLJlVX2f6Eg2mGzW+iv7wMVOGuI4bG7gcWX8WKgNS6K5KA==
X-Gm-Gg: ASbGncuSy/Zvx4HIze4waPW7HENLOPaT6fFT5232sFuKNWRTM77/AoXRM1CxIGSrN4f
	YBShIfX0Ew/RHRdOgvxEKdHo0PT0xTOA3EnpzLjNfniOaGizpG/7YzlyJme5fXKJoi1Ps168zGu
	Sp07iYEi7ZMZp+WrS3vAPgufLLf5BDdhHtIoTj+jXznYKOsx96rnjS/LHgMzW5k3wvl9c25G9Qy
	M6aXkP/jPMxeDPg49x81Xtj+fMQOo+Fkw8VFSzJjsQcjVRxWtWWFb1l6DrrA5+1b9FYxqPWlukE
	NHS9NKL90KUE1ML7RIhxnsvClyvX6M9IEnXhPaHJnd67k1vuxqupDvoHCy+47M0/jxUaetaneuJ
	o7cfcnwiSkHeAWKEadErtsuMFhA3NYAoQIRw9Ic9BW7TrsrRiBzRyBCoythE+2XI+e0IYbxRHRY
	lsCV0WhdyAgPcY
X-Received: by 2002:a05:622a:201:b0:4ed:b55b:674d with SMTP id d75a77b69052e-4edb55b6a65mr26511551cf.59.1762722999272;
        Sun, 09 Nov 2025 13:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH8BiFfw+ts2f53C6zCXeNgfkClVAFT63zGR6OYEJ0OIG9wp5dnSJCliqhgGeg5aYM484U5w==
X-Received: by 2002:a05:622a:201:b0:4ed:b55b:674d with SMTP id d75a77b69052e-4edb55b6a65mr26511301cf.59.1762722998839;
        Sun, 09 Nov 2025 13:16:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a01a029sm3324582e87.35.2025.11.09.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:16:36 -0800 (PST)
Date: Sun, 9 Nov 2025 23:16:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Val Packett <val@packett.cool>
Subject: Re: [PATCH v3] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
Message-ID: <2uvinljz3gevbusjrz3bzi3nicelv3t6a64gliv4mdv6cbllvp@fz3qbyukypho>
References: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: uBB3xLgqQ7NIJ6HeXTk6FDsctrnk63aq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE5MCBTYWx0ZWRfX8ZCAEz7L6djj
 Qzdv/GnexHmtdwAga19PEbZzaaUNNjiG10pDVM8D6vi+QPbu0+bwBKuozcIvmauLM2bAn5q506E
 X4mSWdztMtON6/utQWbkmvPte0jxZpa9gAFCCCU+wHz7Enmanw4KrHLkEnpzGoprl3TaUHbNLk6
 bl3bL+I9TgrEs4g5gV6UTGYYsv0X0MenkjClAhrl0iZk7Ccn9mPimVmX0PdM7geeHDyH3uYRUUO
 1arNAsv6voBSFJtTDmKrn9TGmYoOrtG08vZUiznK4EbsDslcEBF1sFYlyntLLUavo2kPYTYAaU5
 Lf/zoe62T80Ovpat1JRvXda2z7HmGuhb6cSgun9qwUxvOc7IdCmdqp2A1NgPhMftbIXG1sdWhX3
 7LJ106qluM5j8fyBbFLm4cRq+xN5gA==
X-Proofpoint-GUID: uBB3xLgqQ7NIJ6HeXTk6FDsctrnk63aq
X-Authority-Analysis: v=2.4 cv=FoQIPmrq c=1 sm=1 tr=0 ts=691104b9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=K7FOPutcZWfKzoRN3qAA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_09,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090190

On Wed, Nov 05, 2025 at 11:17:37AM +0530, Dikshita Agarwal wrote:
> Improve the condition used to determine when input internal buffers need
> to be reconfigured during streamon on the capture port. Previously, the
> check relied on the INPUT_PAUSE sub-state, which was also being set
> during seek operations. This led to input buffers being queued multiple
> times to the firmware, causing session errors due to duplicate buffer
> submissions.
> 
> This change introduces a more accurate check using the FIRST_IPSC and
> DRC sub-states to ensure that input buffer reconfiguration is triggered
> only during resolution change scenarios, such as streamoff/on on the
> capture port. This avoids duplicate buffer queuing during seek
> operations.
> 
> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
> Cc: stable@vger.kernel.org
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---
> Changes in v3:
> - Fixed the compilation issue
> - Added stable@vger.kernel.org in Cc
> - Link to v2: https://lore.kernel.org/r/20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com
> 
> Changes in v2:
> - Removed spurious space and addressed other comments (Nicolas)
> - Remove the unnecessary initializations (Self) 
> - Link to v1: https://lore.kernel.org/r/20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com
> ---
>  drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
> index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..7f1c7fe144f707accc2e3da65ce37cd6d9dfeaff 100644
> --- a/drivers/media/platform/qcom/iris/iris_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> @@ -91,12 +91,14 @@ int iris_process_streamon_input(struct iris_inst *inst)
>  int iris_process_streamon_output(struct iris_inst *inst)
>  {
>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> -	bool drain_active = false, drc_active = false;
>  	enum iris_inst_sub_state clear_sub_state = 0;
> +	bool drain_active, drc_active, first_ipsc;
>  	int ret = 0;
>  
>  	iris_scale_power(inst);
>  
> +	first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
> +
>  	drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
>  		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
>  
> @@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
>  	else if (drain_active)
>  		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
>  
> -	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
> +	/* Input internal buffer reconfiguration required in case of resolution change */
> +	if (first_ipsc || drc_active) {
>  		ret = iris_alloc_and_queue_input_int_bufs(inst);
>  		if (ret)
>  			return ret;

I will repeat my (unanswered) question from v2:

After this line comes manual writing of STAGE and PIPE. Could you please
point out where is the driver updating the resolution in the firmware?
And if it does, why do we need to write STAGE and PIPE again?

-- 
With best wishes
Dmitry
