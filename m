Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009122E92AF
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806245; cv=none; b=jVxp3YFOa2Wne39+HgxhvrHpNFjwB5l7+B64vW/eVp2BDWkpcf5D6+Kl4X3DUeBxhOXwfLdGFq1bNx4+Lo20I3cQGhffZW9ULQUn7lj6wlF7JEuQ/o8IFJeOjCyQe8/bLqNNClf4YbextmzYcId3Bz58EvTVuvwpALOFNJrtuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806245; c=relaxed/simple;
	bh=avENlQ35BzgI6tLMYtHuimKSX5F3uSHgrD8IvoL218c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DI87Dr2EWYQgpWtGP2XW7thZvSnlnxkENo3Zyo8Hn6jdPYrAKM1JwDfrlNKerUykAHe8gWhuDVXrGukmhLXFYRRWqQu8agjO2rxdHdkX3NbZz/5MMNpHuTjJAf4bLECa1egSLyLBWERL23n1iHxfQFLtyhlPXAgp08lVUxOhQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mts42I+x; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mts42I+x"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-378e24c1c0aso2089731fa.2
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 12:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762806242; x=1763411042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaNjgHiC4lYNLgJR1dvbSFLh/5KALMDQ9SZCFN88ta8=;
        b=mts42I+xAsgv8eZE4+D5iwBfrt6505Gw+8ie43Jwc4Uzp8+eVtfzmeMalW/SBDv1pl
         qyxEiUxi3qo6goc42iJ9vLKPEh6hGdcH3tBlkI7vnceyhz5Q9jAENVhhDY+FTgRkUw6k
         DhVBDZ+ZwRtwyOu21RIMMBAtv3DuMV6FPLuMq5HjKfCW77HLhO8WycCrjy6f1exvn8EE
         N9Hf0poSaaHl8rIusXBOvtFAL5YGqInPg9XbMI0C/vtNP8NOYUgF80uvujHE8T0CFuq7
         ogybdERSxRHTkOOK3JaOCB/1r9uZp7+gHGIruaO0e5nfH9R0D81R9NuZqv5oyGRDf/iU
         ERMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806242; x=1763411042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GaNjgHiC4lYNLgJR1dvbSFLh/5KALMDQ9SZCFN88ta8=;
        b=vDtjcvzmcLXbQMHpz05OMCwjZSlJAEKNntDvQGT0PRIourtim0hmTKv5fNh40iMR7K
         J/wVmXGHi0uP3XJEeTiIybdylO7AHLRFvRPwyX3hri1j4mCK3FsX5UoXI+sdDJ67vsaq
         mKZNkOMRrKmlYPhzj3WeCJb8RuOm0QKLGKXdXGalt2IVQ1ERC+3rO6iTFXu1mRi9yjpm
         X6BZSMCbH52J2Fb/gf0HMOQphYV6I7cYerkmwqKp/VdwQat5b8PbVR7c2cx0rY90GRq8
         XI0z5a6w+7LgP+8+52LS17zPBC/xl9Rpp0N6IhDh5ayRZK0dRHVZYg+0TipCkxIWqBTN
         +Sbg==
X-Forwarded-Encrypted: i=1; AJvYcCUyoLv+pFrl6T3Q7NWznsBgR2FgRutvnIxz/QyKYt7iHC0uqzAr57IYpLpOC5cfNuHDGb4Tb4w6o61Hlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+dGRgdnt87j6w/Gt5SZXmHzkf1DpKwxHBq9/+bvcKxNqVC67D
	KBGoo4TXsYKAVc0nTMNiIYgO2Hwp/XuXYpG3SYEEw9SJNJjtDwKdSurHQ8Lr9M0pAZo=
X-Gm-Gg: ASbGncvzZ4zSxZBHQMVHy2BynEr+HruW97w7vsie92pDZRW+aZ6Nf1+x8yEtCk887c/
	1VuoYgGXKJy7BeBCNFzW3IAZHqxMcxlLXXnv7P6WRI/o+AO02RAmtKJq052ZeQrLk8eC7KHVpUo
	9wsPYvBlAy6qIZhlyrywFaM8sgXFtk3WYBdYn9RMLiAwHzRy/kQ5qZ2z8ilRszh1jrOg5CNVFFq
	gOExOjKUwB+BoVxkRRhJ6oAmmrTldGHDa82LBuXM1QDpQdMbvXvh40xOwPfP3/IwBHbJLILZYfr
	XR0nh1znDtjtGAar40+VAIJ+vkWB4/7N8/eawdj21BITuCOCq1BF4BxVPpeEFZEvpozE3BpuOHo
	5U69XB5CyCKokqItdCysiNoeeDLwAKmQvLlxVN2PrZ1TLyvdIAdNCcY9MoUovPwcNlTg+c/tT/5
	jqAWIzoh1HXEku1LT8sAt30HF9Dk6Dw4+cM9csNzI34M7ilmOPa83R/r8=
X-Google-Smtp-Source: AGHT+IH8eu2yFwyQ/7LEhVqdgKoEtPLjRlteAv+Gq5Xpiwbyk2U8UW/TW9k1sGKDpmscx/ao2kCmVA==
X-Received: by 2002:a05:6512:3c8c:b0:594:2d0d:a3dc with SMTP id 2adb3069b0e04-5945f1dc4f9mr1551360e87.6.1762806242080;
        Mon, 10 Nov 2025 12:24:02 -0800 (PST)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-594549b4cd1sm3681566e87.8.2025.11.10.12.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 12:24:01 -0800 (PST)
Message-ID: <df209178-2871-4317-bfb6-d6605fb9f19b@linaro.org>
Date: Mon, 10 Nov 2025 22:23:52 +0200
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/8] media: qcom: camss: csiphy-3ph: Add Gen2 v1.1
 MIPI CSI-2 CPHY init
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-1-165f7e79b0e1@ixit.cz>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20251109-qcom-cphy-v1-1-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 11:39, David Heidelberg via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Add a PHY configuration sequence for the sdm845 which uses a Qualcomm
> Gen 2 version 1.1 CSI-2 PHY.
> 
> The PHY can be configured as two phase or three phase in C-PHY or D-PHY
> mode. This configuration supports three-phase C-PHY mode.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 64 ++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index 619abbf607813..f28c32d1a4ec5 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -144,6 +144,7 @@ csiphy_lane_regs lane_regs_sa8775p[] = {
>   };
>   
>   /* GEN2 1.0 2PH */
> +/* 5 entries: clock + 4 lanes */
>   static const struct
>   csiphy_lane_regs lane_regs_sdm845[] = {
>   	{0x0004, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
> @@ -218,6 +219,69 @@ csiphy_lane_regs lane_regs_sdm845[] = {
>   	{0x0664, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
>   };
>   
> +/* GEN2 1.0 3PH */
> +/* 3 entries: 3 lanes (C-PHY) */
> +static const struct
> +csiphy_lane_regs lane_regs_sdm845_3ph[] = {
> +	{0x015C, 0x43, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0168, 0xA0, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x016C, 0x25, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0104, 0x06, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x010C, 0x12, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
> +	{0x0108, 0x00, 0x00, CSIPHY_SETTLE_CNT_HIGHER_BYTE},
> +	{0x0114, 0x20, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0150, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0118, 0x3e, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x011C, 0x41, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0120, 0x41, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0124, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0128, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x012C, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0144, 0x12, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0160, 0x02, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x01CC, 0x41, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0164, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x01DC, 0x51, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x035C, 0x43, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0368, 0xA0, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x036C, 0x25, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0304, 0x06, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x030C, 0x12, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
> +	{0x0308, 0x00, 0x00, CSIPHY_SETTLE_CNT_HIGHER_BYTE},
> +	{0x0314, 0x20, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0350, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0318, 0x3e, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x031C, 0x41, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0320, 0x41, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0324, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0328, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x032C, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0344, 0x12, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0360, 0x02, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x03CC, 0x41, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0364, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x03DC, 0x51, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x055C, 0x43, 0x00, CSIPHY_DEFAULT_PARAMS},

You may find it be more structured, if the array is split between
0x01zz, 0x03zz and 0x05zz blocks by new lines, each of those three
blocks is a configuration of one of three lanes in total.

> +	{0x0568, 0xA0, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x056C, 0x25, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0504, 0x06, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x050C, 0x12, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
> +	{0x0508, 0x00, 0x00, CSIPHY_SETTLE_CNT_HIGHER_BYTE},
> +	{0x0514, 0x20, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0550, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0518, 0x3e, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x051C, 0x41, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0520, 0x41, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0524, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0528, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x052C, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0544, 0x12, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0560, 0x02, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x05CC, 0x41, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x0564, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> +	{0x05DC, 0x51, 0x00, CSIPHY_DEFAULT_PARAMS},
> +};
> +
>   /* GEN2 1.1 2PH */
>   static const struct
>   csiphy_lane_regs lane_regs_sc8280xp[] = {
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
