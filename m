Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2A2EBDF0
	for <linux-media@vger.kernel.org>; Sun,  9 Nov 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692166; cv=none; b=glDFvMpnz0XtRM1B6NbwOfJqYjQ/V8fxH0cAv3nx4M4P23lgZFzlCeHeTF/7PQI33XIhW9D7+a8WlEwRKn7p8O12/VPi1LOt5ZB79KSk8wXXOYZy0ekGIQxlL8F+XNeLrKFzzaZRf0hUmLeCT1UwjZonHGPC2akefWm646I2VuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692166; c=relaxed/simple;
	bh=6TOHpgpqHJ5WgnknUzBZQ+Cb+5OFiDU38P5bXDVOJnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyoTUptV1jseSPkbA8AIyrMHIckIZyTF0RwUQe3NuVWRQvqpOgxi4BUkBZ9nI6rPvl4rUxq4pBIp0gOBRCmR1MceU3k+Zl8QPy3VIaQLxt2vP1Hs55xPP3cLx4vaGmJ7/zSXmMGm+kx62Eym614cIMLIwP0Mgk/I6ShwOsBpalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNryNons; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNryNons"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b729a941e35so249798566b.3
        for <linux-media@vger.kernel.org>; Sun, 09 Nov 2025 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762692161; x=1763296961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXaxtSEsQGvchBbil4q1XD2yo5gxFEG8Hu3hgTDWe1I=;
        b=vNryNonsftE4jxNo0F1H7ZDzVR2tKZIJan+FzQLQhasqwpJmkGZPpW3VPMZB8gIMV/
         BxRRrRIwWCYxwTVo9zpNaPcXxhOeTsn3LM55+b2cI9w/QwXr4TFFlOuGGytpnIO7B2kt
         HkWKgyzkjwmsvuTcisz7aezSaY9mVdWA1O1rNQlQ8Hareby7TMqd8fHbXuvQWFiCyfVq
         pa8HV328a9oz2glV95iI7M/MvLXlxFAV8bKyijbYQ0/eBjIYEyjo+HCkYqAGPGORUhak
         Ia++lRvQiFQWZxVu9KYEddSTY+Kb2WcP3xPe+vNLViI0bqn3Eye+m/98Rzkgn8XsKS+4
         FC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692161; x=1763296961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXaxtSEsQGvchBbil4q1XD2yo5gxFEG8Hu3hgTDWe1I=;
        b=XjVuYMuWPl8KsP3rkciyeV5OghaueHRA2dGhCd87cZjK0hkElJgxyDHWba12uitR/y
         sUq8VFQp/+utSTFzC90nXZK9fhitEC2qg4LE5XqUYsp1B7bLOYsVuZIWnGoJa7oXq0RR
         3YtV+SYTHTD1SOZCm38eOLBlAGs5nT5W4ujnH9IacFSJ5wL51F3KKIVvOeEaUHUvSU3s
         5zWhgkmJgfejVSs74I9MN3lQatzwjPyFC/qkApv9L6nqnSug+y8KlcjPPwjZRBZ563az
         20gzX1dkVJtn21nIwFZXahCOrBEWH1lLADrDfdOuUKLJ2LWlSURyftAO3K7DJAP+wA2p
         SPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFyjZdoJfBsRbTHJ7yym9+aXDiLkGDP0+bj23Y8CtHFt26lrMZPXGU+68FVSNdOYhLXjwBV++tgEidYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4AkKGzBacGWNZYafIMmP1la0HIYwfy5xYxei3dX7joslZDnz
	TOPJVj9ytfFgNbzH0R7C+Z4iQJRSBdIGVP+Mm/UBZ3NOMD63+l35Xxxd5JEo9242n88=
X-Gm-Gg: ASbGncuFAifepsUN3ht/HIh0sJkE52h5bGxl1egMWt/bzQy+QJccgXuUpZcU3DWSsO/
	lfkSaogRVKKH/zcTfuEZijko7gGaVZyZbACAI/KT5qLrqlF+QuxHhjZ5b6Sxlzm+aSOOhHdpJIw
	E7ee4FxvCnl/bkePZBLahtKctmQp+Zz7CT/o/83rH3o+AVekCBt+9ekCQLDp6NzElEqcJF6aAU7
	vQl4eWr26dBqIBjkrFc5L6JTXdOH8UlLgP8gQ5sNmr6FJe2GZinMBzyWShsMYGhVnHHYIlw0/zz
	CEaDMrzLUgtz4aTJXVfLUveTiG2F6QHpHlXGL0C0aZAJdPkMMFYgCScC0CRmoAPhymw2cUW5U9X
	hE7Xw9vWNOFIL2YCizFioTBLK7hzbb6CoRBmx2uUNltUUpgYuu9E6Nb+L06cHuzu7SqYC8fHpou
	AkhQg5g4n4FeBXaVk778hoJB0wIp2yXKfUVu1+y7sopMFPwnzxvu1cE+zoN30jn2fTgt5elsP2E
	1VdKTp3xhDExRNORWr+LHoBKNkBq0he8E19/RF+3ey/7GGEPjhQolriYD9G1Sg6Lg==
X-Google-Smtp-Source: AGHT+IENKoAaMYCpquqLORFICuxP93xzbU3KBb6gWvvqfSpI7tXUE7Swy7LtzA/UFFK4KqGX4Fsd5A==
X-Received: by 2002:a17:906:f58e:b0:b70:fede:1b58 with SMTP id a640c23a62f3a-b72e028b9b0mr497726566b.2.1762692161300;
        Sun, 09 Nov 2025 04:42:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6? (2001-1c00-3b8a-ea00-4729-b0ef-dcc4-b0b6.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bcd59sm784848566b.53.2025.11.09.04.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 04:42:40 -0800 (PST)
Message-ID: <fd0a3ac1-1a6a-486f-ab0f-e5cd69f8127e@linaro.org>
Date: Sun, 9 Nov 2025 13:42:39 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 7/8] media: qcom: camss: Account for C-PHY when
 calculating link frequency
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-7-165f7e79b0e1@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251109-qcom-cphy-v1-7-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 11/9/25 10:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Ensure that the link frequency divider correctly accounts for C-PHY
> operation. The divider differs between D-PHY and C-PHY, as described
> in the MIPI CSI-2 specification.
> 
> For more details, see:
> https://docs.kernel.org/driver-api/media/tx-rx.html#pixel-rate
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss-csid.c   | 2 +-
>   drivers/media/platform/qcom/camss/camss-csiphy.c | 6 ++++--
>   drivers/media/platform/qcom/camss/camss.c        | 7 ++++---
>   drivers/media/platform/qcom/camss/camss.h        | 2 +-
>   4 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index 68adea33cc719..9fb5834b28e2b 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -545,7 +545,7 @@ static int csid_set_clock_rates(struct csid_device *csid)
>   	fmt = csid_get_fmt_entry(csid->res->formats->formats, csid->res->formats->nformats,
>   				 csid->fmt[MSM_CSIPHY_PAD_SINK].code);
>   	link_freq = camss_get_link_freq(&csid->subdev.entity, fmt->bpp,
> -					csid->phy.lane_cnt);
> +					csid->phy.lane_cnt, csid->phy.cphy);
>   	if (link_freq < 0)
>   		link_freq = 0;
>   
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index a734fb7dde0a4..61f2b2ac3f159 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -144,8 +144,9 @@ static int csiphy_set_clock_rates(struct csiphy_device *csiphy)
>   	u8 bpp = csiphy_get_bpp(csiphy->res->formats->formats, csiphy->res->formats->nformats,
>   				csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
>   	u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
> +	bool cphy = csiphy->cfg.csi2->lane_cfg.cphy;
>   
> -	link_freq = camss_get_link_freq(&csiphy->subdev.entity, bpp, num_lanes);
> +	link_freq = camss_get_link_freq(&csiphy->subdev.entity, bpp, num_lanes, cphy);
>   	if (link_freq < 0)
>   		link_freq  = 0;
>   
> @@ -270,9 +271,10 @@ static int csiphy_stream_on(struct csiphy_device *csiphy)
>   	u8 bpp = csiphy_get_bpp(csiphy->res->formats->formats, csiphy->res->formats->nformats,
>   				csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
>   	u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
> +	bool cphy = csiphy->cfg.csi2->lane_cfg.cphy;
>   	u8 val;
>   
> -	link_freq = camss_get_link_freq(&csiphy->subdev.entity, bpp, num_lanes);
> +	link_freq = camss_get_link_freq(&csiphy->subdev.entity, bpp, num_lanes, cphy);
>   
>   	if (link_freq < 0) {
>   		dev_err(csiphy->camss->dev,
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 549780f3f948b..248aa6b21b5ad 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -3912,20 +3912,21 @@ struct media_pad *camss_find_sensor_pad(struct media_entity *entity)
>    * camss_get_link_freq - Get link frequency from sensor
>    * @entity: Media entity in the current pipeline
>    * @bpp: Number of bits per pixel for the current format
> - * @lanes: Number of lanes in the link to the sensor
> + * @nr_of_lanes: Number of lanes in the link to the sensor

Missing cphy doc comment.>    *
>    * Return link frequency on success or a negative error code otherwise
>    */
>   s64 camss_get_link_freq(struct media_entity *entity, unsigned int bpp,
> -			unsigned int lanes)
> +			unsigned int nr_of_lanes, bool cphy)
>   {
>   	struct media_pad *sensor_pad;
> +	unsigned int div = nr_of_lanes * 2 * (cphy ? 7 : 16);

What do the magic numbers 7 and 16 mean? It would be nice to describe these.

Kind regards,
Casey (she/they)

>   
>   	sensor_pad = camss_find_sensor_pad(entity);
>   	if (!sensor_pad)
>   		return -ENODEV;
>   
> -	return v4l2_get_link_freq(sensor_pad, bpp, 2 * lanes);
> +	return v4l2_get_link_freq(sensor_pad, 16 * bpp, div);
>   }
>   
>   /*
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 9d9a62640e25d..0ab908b0c037f 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -162,7 +162,7 @@ int camss_enable_clocks(int nclocks, struct camss_clock *clock,
>   void camss_disable_clocks(int nclocks, struct camss_clock *clock);
>   struct media_pad *camss_find_sensor_pad(struct media_entity *entity);
>   s64 camss_get_link_freq(struct media_entity *entity, unsigned int bpp,
> -			unsigned int lanes);
> +			unsigned int lanes, bool cphy);
>   int camss_get_pixel_clock(struct media_entity *entity, u64 *pixel_clock);
>   int camss_pm_domain_on(struct camss *camss, int id);
>   void camss_pm_domain_off(struct camss *camss, int id);
> 

