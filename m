Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17E2F532F;
	Fri, 13 Feb 2026 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969138; cv=none; b=tH2XIv6M+7XK0hQMhowUJUTRsKVSxnhoWgr1UKynX69IlwAqR6Bd4K9HRSR/3qrb8fxLczpXyRg0Beh+Z7+8n/uZGe1nwOoj9WizipnamAIX2DokAooQ18m5XhaFgn6WUMM2IYl776PgpYCJa8sCXuMetUNzS8t/jSSFi8NWJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969138; c=relaxed/simple;
	bh=UefBuSp8hc5xNGX436f+hEfJZc5QS43b+SrCXPfytKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq8lHvQfCX9v1tmrNZwdJNx4qYXdDBAo6tt+qBaLo+fS8ypFUdC/DTnEylwpqeUqZf9WE0ZRq52tEDGwvLVB0p/7WuMyOmOt2AWEoliYmlxOUi2xoM8cVzIOrpG1+0/sgDwYzk9rSgAWhWAmTXKO6L15SfPgl9oxn6uX9pGctzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X51X4gAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X51X4gAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2457EC116C6;
	Fri, 13 Feb 2026 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770969137;
	bh=UefBuSp8hc5xNGX436f+hEfJZc5QS43b+SrCXPfytKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X51X4gAuckniFmBn8+Z0Vkt9gmlv5zxA1umRA7wUuISNEbf15D5G9ITXD4KMdAqIK
	 n3Vf/vVQjhh5QFV/ZfVILdXQW8pAe6jb6Zwnf6p0S5KUPft56ZTn9Pf3Na2kU3HZhL
	 UMhTGVljOokCqeHEKn1TOSCXPdIuO7sXP5fmKyF5xphRfJs+ZXklbaDFF9vZSgVpEz
	 xXpLjCf2KedgM82O10+2cLpebioC7/8MhmEn0A3M8NCHN+8PfpKmDhGNiTfSiFZ3mL
	 6Nh5TXg3jho036ruD8x/r3tiP2WfkcYK3a/5gsRshR+kAkmsD7Tivi+XBU43tbrtBf
	 n8xvT9Il+kFKw==
Date: Fri, 13 Feb 2026 08:52:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Irui Wang <irui.wang@mediatek.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, wenst@chromium.org, 
	angelogioacchino.delregno@collabora.com, nicolas.dufresne@collabora.com, sebastian.fricke@collabora.com, 
	Tiffany Lin <tiffany.lin@mediatek.com>, kyrie wu <kyrie.wu@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Maoguang Meng <maoguang.meng@mediatek.com>, 
	Longfei Wang <longfei.wang@mediatek.com>, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 5/6] dt-bindings: media: mediatek,vcodec-encoder: Add
 MT8196 with VCP support
Message-ID: <20260213-didactic-whispering-impala-ea9e64@quoll>
References: <20260212100104.11863-1-irui.wang@mediatek.com>
 <20260212100104.11863-6-irui.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212100104.11863-6-irui.wang@mediatek.com>

On Thu, Feb 12, 2026 at 06:01:02PM +0800, Irui Wang wrote:
> Add support for MT8196 video encoder which uses VCP (Video Co-Processor)
> for firmware management. Unlike previous platforms that use SCP/VPU, MT8196
> requires VCP to load and execute the video encoding firmware, with the
> encoder communicating through VCP to perform encoding operations.

Again, read review from v2. Subject is still wrong.

> 
> Add the "mediatek,mt8196-vcodec-enc" compatible string and introduce
> the "mediatek,vcp" property to reference the VCP device, which is
> required for MT8196 encoder operation.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../media/mediatek,vcodec-encoder.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index ebc615584f92..4c8acebeb9d3 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -24,6 +24,7 @@ properties:
>                - mediatek,mt8188-vcodec-enc
>                - mediatek,mt8192-vcodec-enc
>                - mediatek,mt8195-vcodec-enc
> +              - mediatek,mt8196-vcodec-enc
>        - items:
>            - const: mediatek,mt8186-vcodec-enc
>            - const: mediatek,mt8183-vcodec-enc
> @@ -58,6 +59,13 @@ properties:
>      description:
>        Describes point to scp.
>  
> +  mediatek,vcp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Reference to the VCP (Video Co-Processor) device that loads and executes
> +      the video encoding firmware. The encoder communicates with the firmware
> +      through VCP to perform encoding operations.
> +
>    power-domains:
>      maxItems: 1
>  
> @@ -76,6 +84,17 @@ required:
>    - iommus
>  
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8196-vcodec-enc
> +
> +    then:
> +      required:
> +        - mediatek,vcp

And here still did not implement the comment. So basically you did not
implement fully v2 and v3.

And if something was not clear, you have entire huge Mediatek company,
with huge budget and enormous resources, to help you instead of pushing
something which ignores review THIRD time.

NAK

Best regards,
Krzysztof

