Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435C30F81A
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343017; cv=none; b=QuLY0bmL+jzJ3Ob58jo1wNd1qylPJbMi4TwJpwdxlUHFE1N47TbplPFdi3aDpjNjm9y7Kyr/yNTuNSHVQXemvIiUnkoBoi9G9ZlH0ZfdqEmJPvvBQ2HRUVvVedx4gRdTOQg8bxIgdtB3eZW7/xjcJY7bA16VHlnl02uPK2I5DNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343017; c=relaxed/simple;
	bh=BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erQWJ0hTaMXB2UNd4KzCuKwzDPIx+tWl9BsQfpFNbgxzmW/zjdnCVfQglmwJwHxqwmaXpAi/D9Q29uDoUzyXuz49RjBro+vPyHi5Tu7/e1Uo472icAbv+6wEorDgMa/jsAzSg5NOFzZlex3miCYt6e/CTYT6/4TPm4i3q7hxiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRYe8JjT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IkvOSa7r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRYe8JjT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IkvOSa7r"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58Rmm43117406
	for <linux-media@vger.kernel.org>; Wed, 5 Nov 2025 11:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=; b=XRYe8JjTZQm1XQ36
	tOSvxyaCtjVUS+hp0JU7p//fVMX4o814+BAQqNrsA/OAtHGZyUJBRdCsRgXMrQ92
	SWKAfVFYjftXjI1DEN7w12Hs0wqpeQuVd23XPILKiQv8XgfpcsKT6tw4arsBDu5B
	1tsyCDJ/uZLfkzHlXqZgU4RiMOPgkvSFgcWFFR3E1OHiRwXKT2RATUwViNnBrjwo
	imVZbC1C6wDZ88co3jBOqeEuuGqk1BvQC4kwmhkTFkt+P/rQs/rmxn5dkTqblIoI
	492cEHvrFBrIIbs3v1c1ApiSRId2Zb/TSg9lSTEkga3awJ28WKRKok5kWO6Q8b72
	8kh+xg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7sfdt3s8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-media@vger.kernel.org>; Wed, 05 Nov 2025 11:43:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aeb762bc40so334945b3a.0
        for <linux-media@vger.kernel.org>; Wed, 05 Nov 2025 03:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762343014; x=1762947814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=;
        b=IkvOSa7rdK/5qjP/opy4dQuLCC7xg9tY48bEIT/PGJL9k/2xkN7IxRjtWaR444rD+p
         tRwioC5M4JNfa+wQmttuPxudsPJgV0TGpEs2LkOoqZ5tLDeVe1G/dsNPckzXb5rk2QVu
         2fBtKUhJUTldzxSv9MmEUaR7DRmgzc0QxczEyMyWUhvsPZaiJfzMpElIHvlY6A+iY0EN
         sZvFlVWG1iacTXbPgGzVYsVcNCW3QZ/2yOIrwhf7Sm77hiRhymCLHd8BiQk1E3ew7PWo
         s2Z0R7Dp/Qhi1olSnPzKIoUHto4I2RCOGXaZr5/J3Pfsv6mfVbmlc/VqRTG4wvZ+9I0R
         /cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343014; x=1762947814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=;
        b=AsFywEskiyqvi/90PDr1BFsSpI3FKJiMH4TQRwVVHyDxTf2fGe6mOR/TvONkIUIz32
         NMHbaAut/w9X2PnFXT3QkvMf1ADHkpp8S5LeLFYWIlleEX6xZ0qbxLJ0IMxTdCO/wbRE
         N9qW3sdSKMjnhfIE1AzrPsWiEVWPWdwizB4q6Y/uHb3GVOLXiHV0lao9dguASjJCbGrt
         VXhqP2vuaO6LMYN9ndiXwM/zZObwaCAtT7fUzuHhlHyHVMFlnPY+gqyqXTqvABwAqdnQ
         pyNUThfpjXTHpT29BiAVQWoAMhoYPlNITswbw5xnAp0valTWkTB1uiYYPTPp82hq21fO
         bEgw==
X-Gm-Message-State: AOJu0YxCalmw6rIwpwqpeH16A3h04Cu42Py7qqm+61qIJDff93+yflH2
	6QqwhdgJ/M41YIiY81G8Gwf6kNAp34nsmkAbW9TXW2NCTBYU5Sk4BsHwb6cb7/NKRsHdOYC6fAN
	ZVvVMPOBirlRwzz0I8v6Ne+/woZqnbkpd3izIc7nVhl2CEgbOTgmCSETZsshes8vowA==
X-Gm-Gg: ASbGnctKeArDIkAN3SQGBfwusgHkvScytuC/1/S+CneYVMa4MI0Pqq5FKUbUBgwyERC
	KGrXcwB/fS9QsSrc9NkFwUkkVstBSNRf1O3WgybDecGwGKl4y0fwHlSB5FyYV8+iQctO6wCIW8M
	jeDIKQ+T8+p1Z/b+LWnHJF54vHaljMPfrMUk3sMpeQ4kwpiGF6CZeyd9OQebYVsO+P7UVv3Ta37
	FRPJXcmK9pgkW59r93jrEv0YcaeSX04TBCY3xMqbO8nlCpy3QfVqD59HDQpPKxY0EnNZuWuzLGY
	sIkht2Bp5dINM40AWunaFklu7cLceEomG0gO5v+GiTpmRNT0eEiFj7XcJ4Uu8gZzawJWZJ1whsi
	mnh3xicdF065o0btPiCmbxgbs0DzkrAzS
X-Received: by 2002:a05:6a21:338a:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-34f86114a51mr3703184637.54.1762343014256;
        Wed, 05 Nov 2025 03:43:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq1fw6AQRlBdqYRnyUSOmKR0xWysU4bHGiCWZGyF2QQLzwtoZWe/qua4VlMjRvlHnlxSRLyw==
X-Received: by 2002:a05:6a21:338a:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-34f86114a51mr3703149637.54.1762343013781;
        Wed, 05 Nov 2025 03:43:33 -0800 (PST)
Received: from [192.168.0.171] ([49.205.248.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f765eda9sm5265961a12.18.2025.11.05.03.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 03:43:33 -0800 (PST)
Message-ID: <ba589a5d-65b8-4980-937a-29598e891dd8@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 17:13:27 +0530
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Val Packett <val@packett.cool>
References: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Jf1sDlvOBAwPd31-2Fs4IEaG9QDh_B3o
X-Authority-Analysis: v=2.4 cv=MMFtWcZl c=1 sm=1 tr=0 ts=690b3866 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=AzyGrR4UViKNxLVuAS9Z9g==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=srhs0GdQF8B2Dv3X-aYA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: Jf1sDlvOBAwPd31-2Fs4IEaG9QDh_B3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA4OCBTYWx0ZWRfX73sJ7AikpNo1
 0JuJ7/P2TwJUxditFNXjX7hfsrZcUyM5uBrgdYTTqR0QCBd1HMzE6SVfUWrczPiCbSRzZwlFIKx
 yNe4aAcd+V4R0ydeREMOXAu/QNVgQg8QQvF18ept0UAQWSvUHdhAKXtrEv8GNfPlxunlAuudJb+
 J+ND38r1XdkQ/AxG1Llk2l00EdYlwZLPKk3BqH621cjdkwXx/R/fpIl1IV3x33bURC7NEGLA1rK
 yi6MBWr6zb7MoX10QDBHT8r1rO1sUbyaO3A8kX9Qu/jAjEvXx+Nttom7pW5eBIvJi5XUMNV/xDH
 zGIUbVvLsH8WUcB6Xg9em5p+kQsMAXn0BumWIaSyueiDaosS84TWCZ0GcsYfr1H3NCXswtoau9b
 93JsbGaWQpaKxjN61AEH+vP1+xnNLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050088

On 11/5/2025 11:17 AM, Dikshita Agarwal wrote:
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
> Cc:stable@vger.kernel.org
> Reported-by: Val Packett<val@packett.cool>
> Closes:https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> Signed-off-by: Dikshita Agarwal<dikshita.agarwal@oss.qualcomm.com>

Reviewed-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>


