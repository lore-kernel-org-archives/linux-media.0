Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464D3491D5;
	Tue, 27 Jan 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515651; cv=none; b=CssbRWgijRxSSARJOQWttCXy/DHHcHlfztnviLURU32NaNfrZ6ZZLTpOOP9h25KIClqVnq2qv75T7+cPiRBt24XCAFSkqlVJme7EL2ARwOEKoVVs8+lkCF1RzmP1MQC7zFiQPwOPK7rh/Pw7gnsw47B+3GzX+w5LKSyHkC4qJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515651; c=relaxed/simple;
	bh=BLXhitwnd07aNFjvXRncMmc27buRbiQMkveA+n5QO5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9mCvDtsTV7elikCiPQi8nNBNefh+Dx1XOrdKa0qW1D+ur6A9COXNYmR0VC1RAGrlRN3wGKI59diT99wCNzjd8iRwHuYwZ9LVVe2TBprD/6N1eUh+TcP2Wsw3NdhYZdBiDYhoDb7ip5TxrN60hoDMPqctzR4Mx0u60aRvv6Vpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ISIkEdZC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ISIkEdZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769515646;
	bh=BLXhitwnd07aNFjvXRncMmc27buRbiQMkveA+n5QO5U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ISIkEdZChC+RirxyDFLqhjI0OQDs91Y/qvz7rubSFkNUv1vvbjQIgkRQeCHP7DX7n
	 4s6nDhJlpigPwiwyWGFAvE7kKiZAGoX/jcXhmnUW/88fFVN4WQsvO9iVCuhp0xBXwa
	 slFAzmP1znQ7FKMAObhEQNS/XGCtQ/0AB8q41bbYwrJMElCOttKNVPi5OOkUoFkrpA
	 uHvTehsWaLYyy2856a3x7aVPuuS+5s0H8d+51rPR96wENH9BOJ8VyMNZr5oDZT9leV
	 GxJ/KtPx/SjuDSUbFeafjBgUy1uflmz8FlXW7jQl8ERpK4JuQ19vXO3C0/rwe6HA2N
	 h0xWnZMqWH8wg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 015E117E0E3D;
	Tue, 27 Jan 2026 13:07:25 +0100 (CET)
Message-ID: <4a6e111d-49ef-449d-af9d-b0bd4fb468a5@collabora.com>
Date: Tue, 27 Jan 2026 13:07:25 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] media: mediatek: vcodec: Add Decoder profile &
 level Initialization
To: Kyrie Wu <kyrie.wu@mediatek.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Nathan Hebert <nhebert@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Irui Wang <irui.wang@mediatek.com>, George Sun <george.sun@mediatek.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
 Yilong Zhou <yilong.zhou@mediatek.com>
References: <20260127024248.18406-1-kyrie.wu@mediatek.com>
 <20260127024248.18406-6-kyrie.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260127024248.18406-6-kyrie.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/01/26 03:42, Kyrie Wu ha scritto:
> This commit initializes codec profile & level for VDEC. It sets
> default values for H264, H265, and VP9 codecs across multiple
> chipset configurations.
> 

The previous patch "Refactor decoder profile and level handling" will break the
driver if this patch is not also applied at the same time.

The change looks good, but you should squash 05/10 in 04/10, and assign the params
that you're adding here along with the refactoring, so that you get one single
patch that, if applied, doesn't break anything as it doesn't depend on additional
(future, as this is number 5) patch.

Please squash

Cheers,
Angelo

> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> ---
>   .../vcodec/decoder/mtk_vcodec_dec_stateful.c  | 12 +++
>   .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 84 +++++++++++++++++++
>   2 files changed, 96 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateful.c
> index 8ddb61670dc6..a47906b9d717 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateful.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateful.c
> @@ -619,4 +619,16 @@ const struct mtk_vcodec_dec_pdata mtk_vdec_8173_pdata = {
>   	.is_subdev_supported = false,
>   	.hw_arch = MTK_VDEC_PURE_SINGLE_CORE,
>   	.chip_name = 8173,
> +	.h264_params = {
> +		.level = V4L2_MPEG_VIDEO_H264_LEVEL_4_1,
> +		.profile = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> +	},
> +	.h265_params = {
> +		.level = V4L2_MPEG_VIDEO_HEVC_LEVEL_4,
> +		.profile = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE,
> +	},
> +	.vp9_params = {
> +		.level = V4L2_MPEG_VIDEO_VP9_LEVEL_4_0,
> +		.profile = V4L2_MPEG_VIDEO_VP9_PROFILE_1,
> +	},
>   };
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
> index a1f419202a24..b571c4ed3f79 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
> @@ -830,6 +830,18 @@ const struct mtk_vcodec_dec_pdata mtk_vdec_8183_pdata = {
>   	.is_subdev_supported = false,
>   	.hw_arch = MTK_VDEC_PURE_SINGLE_CORE,
>   	.chip_name = 8183,
> +	.h264_params = {
> +		.level = V4L2_MPEG_VIDEO_H264_LEVEL_4_2,
> +		.profile = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> +	},
> +	.h265_params = {
> +		.level = V4L2_MPEG_VIDEO_HEVC_LEVEL_4,
> +		.profile = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE,
> +	},
> +	.vp9_params = {
> +		.level = V4L2_MPEG_VIDEO_VP9_LEVEL_4_0,
> +		.profile = V4L2_MPEG_VIDEO_VP9_PROFILE_1,
> +	},
>   };
>   
>   /* This platform data is used for one lat and one core architecture. */
> @@ -869,24 +881,72 @@ const struct mtk_vcodec_dec_pdata mtk_vdec_8188_pdata = {
>   	MTK_STATELESS_DEC_DATA,
>   	.hw_arch = MTK_VDEC_LAT_SINGLE_CORE,
>   	.chip_name = 8188,
> +	.h264_params = {
> +		.level = V4L2_MPEG_VIDEO_H264_LEVEL_5_2,
> +		.profile = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10,
> +	},
> +	.h265_params = {
> +		.level = V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1,
> +		.profile = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
> +	},
> +	.vp9_params = {
> +		.level = V4L2_MPEG_VIDEO_VP9_LEVEL_5_1,
> +		.profile = V4L2_MPEG_VIDEO_VP9_PROFILE_2,
> +	},
>   };
>   
>   const struct mtk_vcodec_dec_pdata mtk_vdec_8192_pdata = {
>   	MTK_STATELESS_DEC_DATA,
>   	.hw_arch = MTK_VDEC_LAT_SINGLE_CORE,
>   	.chip_name = 8192,
> +	.h264_params = {
> +		.level = V4L2_MPEG_VIDEO_H264_LEVEL_5_2,
> +		.profile = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> +	},
> +	.h265_params = {
> +		.level = V4L2_MPEG_VIDEO_HEVC_LEVEL_4,
> +		.profile = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE,
> +	},
> +	.vp9_params = {
> +		.level = V4L2_MPEG_VIDEO_VP9_LEVEL_5_1,
> +		.profile = V4L2_MPEG_VIDEO_VP9_PROFILE_1,
> +	},
>   };
>   
>   const struct mtk_vcodec_dec_pdata mtk_vdec_8195_pdata = {
>   	MTK_STATELESS_DEC_DATA,
>   	.hw_arch = MTK_VDEC_LAT_SINGLE_CORE,
>   	.chip_name = 8195,
> +	.h264_params = {
> +		.level = V4L2_MPEG_VIDEO_H264_LEVEL_6_0,
> +		.profile = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10,
> +	},
> +	.h265_params = {
> +		.level = V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2,
> +		.profile = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
> +	},
> +	.vp9_params = {
> +		.level = V4L2_MPEG_VIDEO_VP9_LEVEL_5_2,
> +		.profile = V4L2_MPEG_VIDEO_VP9_PROFILE_2,
> +	},
>   };
>   
>   const struct mtk_vcodec_dec_pdata mtk_vdec_8196_pdata = {
>   	MTK_STATELESS_DEC_DATA,
>   	.hw_arch = MTK_VDEC_LAT_SINGLE_CORE,
>   	.chip_name = 8196,
> +	.h264_params = {
> +		.level = V4L2_MPEG_VIDEO_H264_LEVEL_6_0,
> +		.profile = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10,
> +	},
> +	.h265_params = {
> +		.level = V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2,
> +		.profile = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
> +	},
> +	.vp9_params = {
> +		.level = V4L2_MPEG_VIDEO_VP9_LEVEL_5_2,
> +		.profile = V4L2_MPEG_VIDEO_VP9_PROFILE_2,
> +	},
>   };
>   
>   const struct mtk_vcodec_dec_pdata mtk_vdec_single_core_pdata = {
> @@ -910,6 +970,18 @@ const struct mtk_vcodec_dec_pdata mtk_vdec_8186_pdata = {
>   	MTK_STATELESS_DEC_DATA,
>   	.hw_arch = MTK_VDEC_PURE_SINGLE_CORE,
>   	.chip_name = 8186,
> +	.h264_params = {
> +		.level = V4L2_MPEG_VIDEO_H264_LEVEL_4_2,
> +		.profile = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> +	},
> +	.h265_params = {
> +		.level = V4L2_MPEG_VIDEO_HEVC_LEVEL_4,
> +		.profile = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE,
> +	},
> +	.vp9_params = {
> +		.level = V4L2_MPEG_VIDEO_VP9_LEVEL_4_1,
> +		.profile = V4L2_MPEG_VIDEO_VP9_PROFILE_1,
> +	},
>   };
>   
>   const struct mtk_vcodec_dec_pdata mtk_vdec_8189_pdata = {
> @@ -928,4 +1000,16 @@ const struct mtk_vcodec_dec_pdata mtk_vdec_8189_pdata = {
>   	.is_subdev_supported = true,
>   	.hw_arch = MTK_VDEC_PURE_SINGLE_CORE,
>   	.chip_name = 8189,
> +	.h264_params = {
> +		.level = V4L2_MPEG_VIDEO_H264_LEVEL_5_2,
> +		.profile = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10,
> +	},
> +	.h265_params = {
> +		.level = V4L2_MPEG_VIDEO_HEVC_LEVEL_4,
> +		.profile = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE,
> +	},
> +	.vp9_params = {
> +		.level = V4L2_MPEG_VIDEO_VP9_LEVEL_5_2,
> +		.profile = V4L2_MPEG_VIDEO_VP9_PROFILE_2,
> +	},
>   };


