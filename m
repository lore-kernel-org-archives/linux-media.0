Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD828695
	for <linux-media@vger.kernel.org>; Fri, 24 Nov 2023 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEECBC433C9;
	Fri, 24 Nov 2023 13:13:54 +0000 (UTC)
Message-ID: <6f78f835-d20c-4648-9f5b-2f0216cdd875@xs4all.nl>
Date: Fri, 24 Nov 2023 14:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: wave5: add OF and V4L_MEM2MEM_DRIVERS dependencies
Content-Language: en-US, nl
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: sebastian.fricke@collabora.com, nicolas.dufresne@collabora.com,
 linux-media@vger.kernel.org
References: <20231123220841.909656-1-deborah.brouwer@collabora.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231123220841.909656-1-deborah.brouwer@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Deb,

On 23/11/2023 23:08, Deborah Brouwer wrote:
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> Hi Hans,
> Sorry about that - can you please squash this into the series?
> 
> Thanks,
> Deborah
> 
>  drivers/media/platform/chips-media/wave5/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/chips-media/wave5/Kconfig b/drivers/media/platform/chips-media/wave5/Kconfig
> index a3b949356cd5..77e7ae5c8f35 100644
> --- a/drivers/media/platform/chips-media/wave5/Kconfig
> +++ b/drivers/media/platform/chips-media/wave5/Kconfig
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config VIDEO_WAVE_VPU
>  	tristate "Chips&Media Wave Codec Driver"
> -	depends on VIDEO_DEV
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV && OF
>  	select VIDEOBUF2_DMA_CONTIG
>  	select VIDEOBUF2_VMALLOC
>  	select V4L2_MEM2MEM_DEV
> 
> base-commit: b17289d8fcd5c5fe59118586256682ffc5d2fbaf

Thank you for the patch. Note for the future: fill in the commit log
next time :-) The checkpatch script failed on that, always remember
to run that!

I added a commit message myself this time since I wanted to get this
warning fixed, so no need for a v2, it's now merged.

Regards,

	Hans
