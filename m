Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC0217648
	for <linux-media@vger.kernel.org>; Sat,  8 Nov 2025 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762576185; cv=none; b=THlOPqZGgy/hy6jXeG0ogKQMWdCiWj+1OFRRr4tXCOvsdU4qEjAvBdW7Q+qWL2zkMgxPLhAJfovn1WCZBouKzPNV7Z+g934OqWWRiBGfJHdj5bEm1bbCufsWv2ZQHP3I6elUnJ3umhYo3XhiA+lh/zgi7KK7E7C1BsdK5+E8g/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762576185; c=relaxed/simple;
	bh=GrqF3Btt70TYVVkeKpPrI2n8V5I1xfOAi37SrsDWidA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgmCwdM7IhNJY+bFMcEt3hiPoKmsQ2ffizaHZfoCkCjgqBf1TPtMEcM9tMWdv7FIRoVgg32dNo5NdMe0nEqEwPLz0J6E2BBb1mnCWKeHdETSS50+RMySQbcMSvIxo6KQjvqH9gabh/13Ddi42e0ILjW1UberUHJYPK082RokMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVZeidxv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fwnxejIu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVZeidxv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fwnxejIu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A84QHPR827588
	for <linux-media@vger.kernel.org>; Sat, 8 Nov 2025 04:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MHKiEPMGJiDkpwGtmXYIoaq5aBgKnZRJk5urWtbVNhw=; b=oVZeidxvkX6GIxcg
	m88qoILeDD7B7WnGaTqh7W7Yu1ORb+kSCztbMeohV7AEUAJv87ilq98C7OmwgEQe
	fIEWUBMYrFw5jRiJXfDItJViZlIp9RXSFSwY1gjXpbWg/RCzDQ1Y0tpd9h3Z/Io5
	T3bT50euW5q79nQSdEqdEa0oqIQvIpyYg2jfXfv6hyna60qUbS6m43wI1w/QxfMC
	NyzKVlVSAaoYWvlnbjRTl1eHEMbOCIMKZQmywKrvNL/a2ZMGoaORhhLnICrJaRMg
	esUJHDn2OrtHj2XNIKTSCa2Ciey6GZz0bwr33eP2tu6+zCD/1J10V5p8TGzodckv
	1FTgJw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu9r04s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Sat, 08 Nov 2025 04:29:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b9c1b12c151so352177a12.2
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 20:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762576183; x=1763180983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHKiEPMGJiDkpwGtmXYIoaq5aBgKnZRJk5urWtbVNhw=;
        b=fwnxejIuJJS2GIgB2ZrdGhP9iDU/hHjho/wjwyrTOEUxoCsj669ZRPt3qeV/ARAs8t
         o2af3471qKpRrYvvj/iJNVo+J66DA8GjgxplHq6RRFCTL/d3NixDiGkBr+1CVc4tJihf
         9Ap9mmFpyE7g7+g0f2CRJp+01iXVIy6gZRHgF92v2Rq+UGdbiBxu+P5dL5Ch8aIv64+u
         1QS1RKmsnza9GC9NyKjhosxXH9O8LeoMZRcDyB3kCYzb/yv2jqst4jeSVmkwZVn9Vmeg
         E06qFkXoE264qAu5MDhAHxuut3GBW3HFwZK60IUslONaG7kOUlwOlq8BXT1Vxo1fPL7z
         RzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762576183; x=1763180983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHKiEPMGJiDkpwGtmXYIoaq5aBgKnZRJk5urWtbVNhw=;
        b=lpe0kdBYjaBGluG5DacQBB2OLs2evQrwDj0vKUezzEhn8gGX+lb3CDMmhzNbx0FCCE
         Ub3V3y7vyrHGYur2hkCil46KGYGw0D8aXq8c+5x8FHbkKncqkz6eEq84wIXHIbahBOhG
         6chUvo/FodWbPFm4OdwJMXatNMipbbgbHj889VMDQERsEPUPq8O7/ISW/W/Yqmshlrmc
         9iH8+rv9aFFg2SZikG0DvDxAAZzZO49pixwr365SYuk+ehnHopqyQZ5C09JKwIR5rnON
         pf3qGobXR6Q8u3fcf/rxWsb2Kl3ghprIIbrvO7n4pzv8+irK4MFWrXgSFkOyaKKBW6PB
         SAaQ==
X-Gm-Message-State: AOJu0Yx30H9svC6n+/s8/Qbu+28d5P3U0n+oym4QHWZAuXcLek4oenlU
	i7piv2PZCmTsnvk91EP+3hlbD47yynmcQY9vFKC5LSsb8LGlD4nZd921XZy/3OxiqHQVpB1wL9O
	5/Msl5ZvMfzCKnHBOOuOAR95DPfgQVyHm/qNjBStN/tyTIM4C/vvuCG8MlZLuzebWZQ==
X-Gm-Gg: ASbGncs0NWOXgRTnU2cTzXKdlD3IiEtPYqJYAeAT6utZSmBnLWxbARTZWTlhsuGoix8
	Zt/6xvMVh+Ajp9H3YwlMvu/OykAO1f/qbapJSlh15W30j1TkY53hbfSMeStjgteZZx0U2DOyV/H
	hswwEoY5FIagCYuXDlKMdlQEPSERK8ckl/RQI9NWdxHz/DaZQP4GpqrLXquH75eBX9Bg6sA+8kW
	vKx11BzcBJ8D0xOrfmQex3ejArjk/viSK9RbAJTyGxOxe17PgrJXq8VDXOtQtsveYB74uQiynRI
	0wHrTIGvbBWUz/vszLIIerVdR7Mp0jcv6SnzVYkQFs4S6PHjOsZf4tYQrGEqzw/vmKieuZUoNn9
	j6KQzidioA7WyLvVDq4g91HCLvYcpfAVJCz4gKB8ZRjvufrHYAvG8m9UCGxEaVg==
X-Received: by 2002:a17:903:230f:b0:295:70b1:edd6 with SMTP id d9443c01a7336-297e5643e76mr8706655ad.3.1762576182866;
        Fri, 07 Nov 2025 20:29:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3sfbuDhDXySXPAVcfmEF/y2AIuNMy7+QjiPXwwDd2S9+fLZylcYi6yhb2l9ZzI+uh+oI6JQ==
X-Received: by 2002:a17:903:230f:b0:295:70b1:edd6 with SMTP id d9443c01a7336-297e5643e76mr8706485ad.3.1762576182355;
        Fri, 07 Nov 2025 20:29:42 -0800 (PST)
Received: from [10.110.21.199] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c73382sm75330285ad.69.2025.11.07.20.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 20:29:42 -0800 (PST)
Message-ID: <47a16514-9cc1-46c9-b0d8-029c5bc44638@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 20:29:34 -0800
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251103-av1d_stateful_v3-v4-0-33cc1eaa83f2@oss.qualcomm.com>
 <20251103-av1d_stateful_v3-v4-1-33cc1eaa83f2@oss.qualcomm.com>
 <6198674a-2af0-4906-9ffe-bc10e68eb5c5@kernel.org>
 <19cdb1996557824554789dccc805014b0fa2deda.camel@collabora.com>
Content-Language: en-US
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
In-Reply-To: <19cdb1996557824554789dccc805014b0fa2deda.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vYEzC4p1_x5ey5axTVgjYfVT-FzEN27l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAzMyBTYWx0ZWRfX/WmX6K2pX2Kw
 6hIfivDc+L91Dm7nV8PBMfi4XoomhNDNnfya7bU0P0nXBo8vlFDGaHqLmBeFo5dhzCT+rFPTYKx
 iVPxjNe2ZOfcv9cE+/nJpLdVMBrFU2/8jwvBVnaCsRoQ1G6sg7t1zj6NzUEF7BJaTW2hhwzhSiy
 fqJG1SllT46gxwE0iUD1ZZuSL6QHeVZOIz+CU3lM3vPpJmArTIQryS1rqr7Nwn48N0EUKjDrpSE
 MeTLUYujyNsUWPq2a1TIm2CZ9IHvLmVXo1uaexk2o3/cjKf1Ep4yqvfsFE+QrnnFAh2YTNVSDMW
 7VqoqoXwJ7K7RGsaSlH2AWrb/qhp4UAxQsLzNfdH2nilKkxQNd5ez3hr2VFj8Y344e5g943My8B
 mGvZggjImtUXEShTRMDwZlCdxauiqg==
X-Authority-Analysis: v=2.4 cv=ZPXaWH7b c=1 sm=1 tr=0 ts=690ec737 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=apL-334RAAAA:8 a=KKAkSRfTAAAA:8
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=OyDfNFrtaf6QVTBVua8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=eWIHaOtA_ULHaMmHwLHW:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: vYEzC4p1_x5ey5axTVgjYfVT-FzEN27l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080033


On 11/7/2025 5:41 AM, Nicolas Dufresne wrote:
> Le vendredi 07 novembre 2025 à 10:25 +0100, Hans Verkuil a écrit :
>> On 03/11/2025 14:24, Deepa Guthyappa Madivalara wrote:
>>> Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
>>> Video4Linux2(V4L2) API. This format is intended for AV1
>>> bitstreams in stateful decoding/encoding workflows.
>>> The fourcc code 'AV10' is used to distinguish
>>> this format from the existing V4L2_PIX_FMT_AV1_FRAME,
>>> which is used for stateless AV1 decoder implementation.
>>>
>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
>>> ---
>>>   Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 8 ++++++++
>>>   include/uapi/linux/videodev2.h                              | 1 +
>>>   2 files changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>> index c7efb0465db6480fe35be8557728c196e0e530f4..0c70410ffd4d58e0719d3cf13ad336c97b454ae9 100644
>>> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>> @@ -275,6 +275,14 @@ Compressed Formats
>>>           of macroblocks to decode a full corresponding frame to the matching
>>>           capture buffer.
>>>   
>>> +    * .. _V4L2-PIX-FMT-AV1:
>>> +
>>> +      - ``V4L2_PIX_FMT_AV1``
>>> +      - 'AV01'
>>> +      - AV1 compressed video frame. This format is adapted for implementing AV1
>>> +        pipeline. The decoder implements stateful video decoder and expects one
>>> +        Temporal Unit per buffer from OBU-stream or AnnexB.
>> OK, but the next patch says:
>>
>> 		case V4L2_PIX_FMT_AV1:		descr = "AV1 OBU stream"; break;
>>
>> And Nicolas said here:
> Hmm, good catch, we had quite a bit of back and forth actually on the subject.
> The discussion went toward that this is OBU Stream format, but it is conceivable
> to enable Annex B support in the future using a control. That mandates that OBU
> stream must always be supported for that format.

Thanks for the comments. I had a similar understanding as Nicolas.
To keep things clear updated v4 to just have OBU Stream.
Thanks,
Deepa

> I'd drop the "or AnnexB". Then I'd try and harmonize how we write OBU stream, I
> prefer without the -.
>
>> https://lore.kernel.org/linux-media/544147436308901fba85d6de48380c0c1eea7c67.camel@ndufresne.ca/
>>
>> "Perhaps "AV1 OBU stream", so its clear its no Annex B ?"
>>
>> So if this is just for OBU streams and not Annex B, then the description is wrong.
>>
>> Since I'm no AV1 expert and have no idea what the difference between OBU and Annex B streams is,
>> I can only comment on what looks like an inconsistency.
> Annex B is very unlike H.264 annex b. Its adds a wrapper around time units,
> making it faster to walk through displayable frames when you have the ability to
> skip bytes. I've only ever seen it in tests vectors so far. My impression is
> that we'll never have a hardware that requires that.
>
> Nicolas
>
>> Regards,
>>
>> 	Hans
>>
>>> +        The encoder generates one Temporal Unit per buffer.
>>>   .. raw:: latex
>>>   
>>>       \normalsize
>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>> index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..cf0b71bbe0f9d397e1e6c88433a0fc3ba11fb947 100644
>>> --- a/include/uapi/linux/videodev2.h
>>> +++ b/include/uapi/linux/videodev2.h
>>> @@ -775,6 +775,7 @@ struct v4l2_pix_format {
>>>   #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>>>   #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
>>>   #define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
>>> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '0', '1') /* AV1 */
>>>   #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
>>>   #define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
>>>   #define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */
>>>
