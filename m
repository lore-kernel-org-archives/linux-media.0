Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEA3081D7
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774677; cv=none; b=qKNRRhHEy0RSf/BisP/HFzGVgIVxkp1lE/AmK6eV2zLW/8n1Z9X5OiEi07IL/Xjh1SWhwpxNaLEw10zXaMaE3eD4c5nWnRixMq2qw0TwwnxaPvtTTU9lVizqwgiAz9eYN2uba0lctgdzjooknJqj4QVrZPFsCYBOza/LXAT76ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774677; c=relaxed/simple;
	bh=bYvCRDJ8Gv1dOfdRqfRo9yHHV4IK3gLVIJ6PseVpKNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7iNLLWPdr1mlzVNPoh0FaUHTm507GaYcO1GJisAxIoTozyN9YY4WV1tAEnZPbhZ4eURmmLSl+hgCLvSeZqz4rlRFmledK9JovtR5gDWZIbrawPJtFSIYFBxj20+KR/AoLzPwLhjuYnBESHC7LeZkOc3glvZH0orq1YTp3x1uJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GK4xGvDu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK4xGvDu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b32a5494dso601946f8f.2
        for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 03:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762774674; x=1763379474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbIPi1f3TQjYD0qdQrLeTSWV5sgjs9x+ZurWSxF6us4=;
        b=GK4xGvDuKd3J3N0sFhw+qRe8dRFQj5wcWAsGkekk3jTlXEPJBJCtpwGfDw61uAmiTJ
         TJqDU7HOfO+3wwsSW/zBox6lNgj++WhnkbuVx+kbIpPH5aFq/PyjZmG9OcgHmPw6DPHQ
         taa8VW8ykh0uk9ehI4Uu/NThH21j5xy94btfr8F/IMC/mCNzwNsNJ88Svspja7jzgGkp
         0Y5UOXzBYVEPmrMOF2Z1lux9cQ1xmp1QglCEnaLnl67dm5bP9AOuu1lxqJv0nQ60Sn3J
         pa9VC0QTkqrDzgjJjX8UpN+nrMivCynm72+Y9wCFdbdKiE1JyHwXS16I/VEIAx1zJKlb
         sq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774674; x=1763379474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbIPi1f3TQjYD0qdQrLeTSWV5sgjs9x+ZurWSxF6us4=;
        b=NkpW3+w1EJyRkk9Irkl3FQ2kezwPzRjX9n8OiiFKvBE43rxPSurTBhQ5R8/fsgKya+
         sr9XJvOaAzurQOPhWljjcu0PDVfhGlqRcqwmxYvA922FCwh8d3CigAtlA5BSvWPApJJf
         PnX0+E4wWr0lASoNh8TqvP+GCSN/MnxvCl4JYwrbEeJOWTcAU8K6O631y3tSBeAO0xPm
         fWPAiSlJBg3uw2i8rFKts4v8OBhmnmUqzdqRdu6QycEGDXiQQ8t8bK32BcYhQN1x1Hac
         536gDsZBCgAdl+iCVKbBUC5yHqW5SOEva50JRjDuPMOHi0ufshHqx/+NtloHcLcLWIef
         mK4w==
X-Forwarded-Encrypted: i=1; AJvYcCUwaCaEqhpvoDmo+n7v8Q/HknP6HorgK4lzPqg5Cl6KYGPkk+UFZT/6ZK2q3xtjyllqdjkXUufgeJNjCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YkQLGPlqj86KksEDoDWj2wUpQCJdxSN5WF5DLI5Q0uPjx2SN
	uMs31eZTb7iLZApLuNaL8on+NDzd0R0ZtIA31vNcEWqYSpl+H+Figkk34902TXQXZQs=
X-Gm-Gg: ASbGncvRboVQMnXXeZtFEeQ4Otd8kM60ZHl69OjKDe9PWCXwAyAJWMOV34E7t+AS0qr
	ia0SwWaVZOOynMfb/OTEz+YfUJtajIFylCbosvI2DF7FTPEuwv3sbiKXNQIyCcpWkIgHa/4Ofl9
	WlhoxKnN9UK0KeBnPJTv6Kohpnsl+oJFHtIA1UDMDQVHstc1F7eauQT7MdsxekyUoaBXI0cRmMe
	/GGsrv6VnNfFbeqIkkpU6wOD8+q1gQHB5/eUvOqFLzubGXz25fyqKvLfxdqcnzZ/5oxr4BCppuh
	wczMtn4PhzBW7DU/sxXTk0vcBF5BSmMJVzPIWjxnYJxgbsKAdOF4/LknSPaHrNkjMhH+2V4G6de
	aBx6ygqqJTrvkF6fjJdn8DWHnk+rrUtqH6RvZifC2MsYZ9lVUIQmx4z6Vf53V6xPNl6bYOHAIhX
	0R3qZVhdjOGPogqLk2XkiRXXxlaV8ZYjfsRl4Xpde3L7dslKdIs/oz
X-Google-Smtp-Source: AGHT+IHA0EBLJZJ+ndV4OQ/knM5PV3CmaEKbnGaPdN8RNMmCv96/hD4FMnZxtX3a7xuoueGlr3MwOg==
X-Received: by 2002:a05:6000:613:b0:42b:39d0:638d with SMTP id ffacd0b85a97d-42b39d06632mr2610262f8f.28.1762774674004;
        Mon, 10 Nov 2025 03:37:54 -0800 (PST)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677abeasm22015186f8f.33.2025.11.10.03.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:37:53 -0800 (PST)
Message-ID: <c65411c8-fe15-4cc4-9236-2232c55e4b86@linaro.org>
Date: Mon, 10 Nov 2025 11:37:52 +0000
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/8] media: qcom: camss: Prepare CSID for C-PHY
 support
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-4-165f7e79b0e1@ixit.cz>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251109-qcom-cphy-v1-4-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/11/2025 09:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Inherit C-PHY information from CSIPHY, so we can configure CSID
> properly.
> 
> CSI2_RX_CFG0_PHY_TYPE_SEL must be set to 1, when C-PHY mode is used.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss-csid-gen2.c | 1 +
>   drivers/media/platform/qcom/camss/camss-csid.c      | 1 +
>   drivers/media/platform/qcom/camss/camss-csid.h      | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> index 2a1746dcc1c5b..033036ae28a4f 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> @@ -183,6 +183,7 @@ static void __csid_configure_rx(struct csid_device *csid,
>   	val = (lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
>   	val |= phy->lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
>   	val |= phy->csiphy_id << CSI2_RX_CFG0_PHY_NUM_SEL;
> +	val |= csid->phy.cphy << CSI2_RX_CFG0_PHY_TYPE_SEL;
>   	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
>   
>   	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index 5284b5857368c..68adea33cc719 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -1287,6 +1287,7 @@ static int csid_link_setup(struct media_entity *entity,
>   		csid->phy.csiphy_id = csiphy->id;
>   
>   		lane_cfg = &csiphy->cfg.csi2->lane_cfg;
> +		csid->phy.cphy = lane_cfg->cphy;
>   		csid->phy.lane_cnt = lane_cfg->num_data;
>   		csid->phy.lane_assign = csid_get_lane_assign(lane_cfg);
>   	}
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
> index aedc96ed84b2f..a82db31bd2335 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.h
> +++ b/drivers/media/platform/qcom/camss/camss-csid.h
> @@ -70,6 +70,7 @@ struct csid_phy_config {
>   	u32 lane_assign;
>   	u32 en_vc;
>   	u8 need_vc_update;
> +	bool cphy;
>   };
>   
>   struct csid_device;
> 

I'm not convinced you need another flag for this. It should be possible 
for the CSID to get a pointer to the PHY and interrogate the encoded mode.

---
bod
