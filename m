Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02130EF85
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778562; cv=none; b=uFidEEalfVXps/kjEsmR5F4idqeKmjCDOBPWQoN9Aam3UofiDinrft1kUbdR/gZONlZsN/JRviH5wwoHVFSMjZyIG4tv9Alwl1h5ih9SALY6y3qwOiDd4klceUATrWIytagtlPf2eQTQcGjXP3t3R0j5cjvT14RBLXsTWt3uMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778562; c=relaxed/simple;
	bh=oycCGrJnIys6pRkKgZL7qnTNFiPgdJ8eOZ85qTOqp34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUbYpgMyUqsspRXduDH2Woat3XnfD/czUcj7yJ8w64KxhITcAtE6jshtHkzqZOiNANUHme8uTZufZM2yX0DeOkZugNWRVrcvrQXeh75oPOaU4TI7DX3mDS6R2cxrC/2a0NL3/YCKGnVWPmLbsyNFQbM7k/3DYngJfS+k1J4XIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=audW4yck; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cVbC36I1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="audW4yck";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cVbC36I1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA997Yb1809060
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 12:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Szk5oQu0JKW4WvvkHevPC12l
	/Yr8odd2nrlXcJxADTI=; b=audW4yckeo0wqh+AJZjiTxCg7F/UhqXY05X88YPf
	9no+NBEnjCJfkDUdXK8AcHfS6DETCyDMdzMZ8il8GcwZcHglTKCHJUr1bGaa1nNy
	So1707lPFWixkzktIb7+quL+AuQvc+n0/wdoVtJ5YbR6VTVrhsAiXPGeT+jSG/BD
	7LmGvMOh4VzwVOjKXwtifxs7V6EyrU/B2pAYWTSnjDBw+udssJHMnjgFjCtUkGE7
	N3ckxKxKCq0rcWZwsm5HaaQQL+eQuuUyM/IDoEASUU+o9ftiYlMHKb3V9KG9Qei0
	owybqnBgH4hGBLpKHLjhv2BM27m9f6quZiL1DqgfiVaQww==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1hvm2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 12:42:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso86658561cf.2
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 04:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762778559; x=1763383359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Szk5oQu0JKW4WvvkHevPC12l/Yr8odd2nrlXcJxADTI=;
        b=cVbC36I1a3rZ7LW9nbyBZ+OQZfHmiPf84+leq40dg0TfhZ5Ql4z84W9sKAloA1erac
         75JCETO+pIS3lsVFI1B4D/D6mBFDZRFJFMDJleoXrrfxUyCEKkUUzS3Abrlg+hGdeXmt
         j8jTQfbex1iSBxBSshykeSOMNPqDb4Xjz9Ds5JCYdPGNWy11byZP/18HAJXHKmdDRfvj
         vNZswcPofTZ96q5vGMej6AyK4s2KJpr4rQoiDY3e9DsoGshPfaK28v9mmpyanS9WCSY0
         EH0E4KN+SSGvCbPwaEtNhPBdDGzt+4aG/qdnIwT2nr24tA1mnHY8aTr1CtBCvJC8p69I
         1YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778559; x=1763383359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szk5oQu0JKW4WvvkHevPC12l/Yr8odd2nrlXcJxADTI=;
        b=Ib/l3RMJMbYAkjYdHvahsQJc7jsCSY6avj1GvOvPp4S6RIsILfrr6DusoolIB6qZDJ
         a7JPpyAMUh7CefSB2A+Bkclv50+WpM0tPZDTrYoEhycNEPTxyjK2XJ9o5QBrejj+7dVy
         6Y1H+AQfwmny6HlEvTLKbj76y7EfKPIYt5ES2Tr4eCTv6j1XHvPNfwDHAjKwFcWi9KYf
         9EKZZlzSZ6UFFL2M3qeoRXna1FTjiEedpI8m70zim7cDFovdS8CfSpNomO9T8h1PFZDb
         BiCW/ftBFAb/Xp4oZmR1VrqaL8OdmwbvEfeq5o7Vut8Al8Z0kJLAEmuHYWS7UPYuRi1F
         tbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1iU1OuV1tmB51ES1sAxQn4skaAqGkrhgoYig5pmJFXH70E+3jzQwLdGQzdafwAcjYtrq2ztC8QTf5HA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbLRIPt1tXvWz4kMpPVdYXMbq1H6TcVJR+VT3ebJazEJ9K8K4
	nyzkgX1LMfZDKqxGwlPtVTuDXkM1mvBF2C7U6WtRctWTnH36g2KjnQkU8cTiqAC6ta4x80KEHx2
	fWtoenDCwyxqbqEAZW52wAA5zwe7dcW+GorFx+D5fJyitcAkH6eOhw5inpwcZ+5Wk7w==
X-Gm-Gg: ASbGncuxSya8VC1CjLR8xVDAUognnkXhhtKGeDc8ycL7vJ7K50JPlg/hzwnOpmfVxCe
	ZwoOIUBJFIFStICbX4zR4y1cSkEgCTg09MJa4ohdRRCiYUybgDxZs+j+BV5TOb2oN47T5xlQdnT
	yIobR0Y5hgSAUeapk80hgMF40jFQjE1ZAiyANMOWm9AvR1tA0MOx/YZMDM2julIzMDcPpqFjcrN
	DHUQXHrJfUlhn49PKKnQuGVq378z8P7eIIrYwILvkcAR/Am/PzWazCxuQe+9cAytAh+u1x8NcNs
	LsVvLefpMTx4QCLnVYuAtVCaTzmyRYAgMxiZhl0daJPK1+6DbY+GTooOiSMjnL4f60d93upa1ho
	1FutNy6QL1UY5lQ563v5f32AmXiBZzFgc1GqlzQQlyW/6UZHCsdN+4DXpGErqy/iZyekH4GSdtI
	t/70qiJL+ZeoCC
X-Received: by 2002:ac8:598b:0:b0:4ec:f1a4:5511 with SMTP id d75a77b69052e-4eda4fc3b6amr92542081cf.65.1762778558868;
        Mon, 10 Nov 2025 04:42:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVDggml7PAVV7SI4AjXNrlbgrxoxEoX+ZodOTGQvFGPNu6EQkyCxkyyGJCj9juxzvgZ2KRjw==
X-Received: by 2002:ac8:598b:0:b0:4ec:f1a4:5511 with SMTP id d75a77b69052e-4eda4fc3b6amr92541681cf.65.1762778558271;
        Mon, 10 Nov 2025 04:42:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a5964c5sm3925508e87.101.2025.11.10.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:42:37 -0800 (PST)
Date: Mon, 10 Nov 2025 14:42:35 +0200
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
Message-ID: <vt77gtk5fjwd4z4g5ppuwa7552y27nydnniikz64khzgif4qbg@rbzu3alfbg6x>
References: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
 <2uvinljz3gevbusjrz3bzi3nicelv3t6a64gliv4mdv6cbllvp@fz3qbyukypho>
 <220c9fe4-00b4-3b42-0e80-8730a6388bde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220c9fe4-00b4-3b42-0e80-8730a6388bde@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMSBTYWx0ZWRfX0uG8rroy0bRm
 lAUghfp1qBYXUNyOvYW8bMZTOvgJtfyjfGM9as3e0gNC71hBZ3hYWEFvg0uuU+Cj98zCCqDV/zf
 wU2M6flWHvPSFDhtWLzLeP+4m9ZxWgIF+EaEut9PhBcd6BaddxrFE9MTp9cJcxObnWC99ZZt7PR
 BvxA937KY62MtYatRVr+wBEDtQPhDTndTD/u7X6oSzRJ349lsBB5DOZOa7Ni+NOcb6RWDVHO1bu
 azMRvcSqJY4s3c2fAWvKLLlWlwxBnQo/D1dU1140p9MZqBKF2U3AggBMCbp3UWL5qkTdBNSbud6
 vXRF8fMKACPoU5YV/oxELpQF9xbh4hxtHzvCf4TGL+KvIF0UHC2Bgsrb02CZjqPhS/WjTsM17ps
 SAaStJUFs8jw+wC3iUJKEC8RKXEP8w==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=6911ddc0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bl5V-8u5B6lULHSYCfAA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: X36ykxPWeNVFttngB4fPmPZiVxA3-bZH
X-Proofpoint-GUID: X36ykxPWeNVFttngB4fPmPZiVxA3-bZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100111

On Mon, Nov 10, 2025 at 02:31:20PM +0530, Dikshita Agarwal wrote:
> 
> 
> On 11/10/2025 2:46 AM, Dmitry Baryshkov wrote:
> > On Wed, Nov 05, 2025 at 11:17:37AM +0530, Dikshita Agarwal wrote:
> >> Improve the condition used to determine when input internal buffers need
> >> to be reconfigured during streamon on the capture port. Previously, the
> >> check relied on the INPUT_PAUSE sub-state, which was also being set
> >> during seek operations. This led to input buffers being queued multiple
> >> times to the firmware, causing session errors due to duplicate buffer
> >> submissions.
> >>
> >> This change introduces a more accurate check using the FIRST_IPSC and
> >> DRC sub-states to ensure that input buffer reconfiguration is triggered
> >> only during resolution change scenarios, such as streamoff/on on the
> >> capture port. This avoids duplicate buffer queuing during seek
> >> operations.
> >>
> >> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Val Packett <val@packett.cool>
> >> Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> >> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> >> ---
> >> Changes in v3:
> >> - Fixed the compilation issue
> >> - Added stable@vger.kernel.org in Cc
> >> - Link to v2: https://lore.kernel.org/r/20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com
> >>
> >> Changes in v2:
> >> - Removed spurious space and addressed other comments (Nicolas)
> >> - Remove the unnecessary initializations (Self) 
> >> - Link to v1: https://lore.kernel.org/r/20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com
> >> ---
> >>  drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
> >> index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..7f1c7fe144f707accc2e3da65ce37cd6d9dfeaff 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_common.c
> >> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> >> @@ -91,12 +91,14 @@ int iris_process_streamon_input(struct iris_inst *inst)
> >>  int iris_process_streamon_output(struct iris_inst *inst)
> >>  {
> >>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> >> -	bool drain_active = false, drc_active = false;
> >>  	enum iris_inst_sub_state clear_sub_state = 0;
> >> +	bool drain_active, drc_active, first_ipsc;
> >>  	int ret = 0;
> >>  
> >>  	iris_scale_power(inst);
> >>  
> >> +	first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
> >> +
> >>  	drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
> >>  		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
> >>  
> >> @@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
> >>  	else if (drain_active)
> >>  		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
> >>  
> >> -	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
> >> +	/* Input internal buffer reconfiguration required in case of resolution change */
> >> +	if (first_ipsc || drc_active) {
> >>  		ret = iris_alloc_and_queue_input_int_bufs(inst);
> >>  		if (ret)
> >>  			return ret;
> > 
> > I will repeat my (unanswered) question from v2:
> > 
> > After this line comes manual writing of STAGE and PIPE. Could you please
> > point out where is the driver updating the resolution in the firmware?
> > And if it does, why do we need to write STAGE and PIPE again?
> 
> Sorry for late reply,
> 
> During streamon on the output port, the driver sets the resolution in the
> firmware. However, during Dynamic Resolution Change (DRC), the resolution
> update originates from the firmware and is communicated to the driver. As a
> result, the driver does not proactively update the resolution in the
> firmware during DRC.
> 
> STAGE parameter depends on the resolution, the driver must update the
> firmware with the new STAGE value after a resolution change to ensure
> proper operation.
> 
> On the other hand, the PIPE value is independent of resolution. It is
> typically updated to 1 for interlaced content, which is identified during
> the sequence change. Currently, the Iris driver does not support interlaced
> content, so updating the PIPE value during DRC handling is redundant.
> However, this update is harmless and will be necessary once interlace
> support is added in the future.

Ack, thanks for the explanation.

-- 
With best wishes
Dmitry
