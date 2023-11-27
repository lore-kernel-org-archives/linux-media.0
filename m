Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="czEqT7ZH"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D8187;
	Mon, 27 Nov 2023 15:58:04 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C17729B;
	Tue, 28 Nov 2023 00:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1701129448;
	bh=U9y1YDE528p6y1Og3kHcLIJQXvMtN8MeA6nLOYOLgYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czEqT7ZHmVdBcMHIxABodpJmff1xu7FjiqtZNAueh64G8vlhM8RiQ3KxI7fYtOI4C
	 UF62wCF8R4iWb0rRnSImVV2XYag/3+a04ILQe9hmZ3We/zEpr09sqouDEq7Mnk9H1x
	 E/dtTCBhnlNPvUfyKpRuUbBxtGEvgJ3dqC087LMg=
Date: Tue, 28 Nov 2023 01:58:09 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sakari.ailus@linux.intel.com, rfoss@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	mchehab@kernel.org, devicetree@vger.kernel.org,
	linux-media@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] media: dt-bindings: media: Introduce
 MEDIA_BUS_TYPE_DPI
Message-ID: <20231127235809.GC25590@pendragon.ideasonboard.com>
References: <20231126125320.4024456-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231126125320.4024456-1-festevam@gmail.com>

Hi Fabio,

Thank you for the patch.

On Sun, Nov 26, 2023 at 09:53:19AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Commit 18860529a599 ("media: dt-bindings: media: video-interfaces: Add
> new bus-type") introduced a new bus-type for DPI video bus.
> 
> Introduce MEDIA_BUS_TYPE_DPI into video-interfaces.h to complete
> the list of video interfaces.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  include/dt-bindings/media/video-interfaces.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/media/video-interfaces.h b/include/dt-bindings/media/video-interfaces.h
> index 68ac4e05e37f..0dace694a18f 100644
> --- a/include/dt-bindings/media/video-interfaces.h
> +++ b/include/dt-bindings/media/video-interfaces.h
> @@ -12,5 +12,6 @@
>  #define MEDIA_BUS_TYPE_CSI2_DPHY		4
>  #define MEDIA_BUS_TYPE_PARALLEL			5
>  #define MEDIA_BUS_TYPE_BT656			6
> +#define MEDIA_BUS_TYPE_DPI			7
>  
>  #endif /* __DT_BINDINGS_MEDIA_VIDEO_INTERFACES_H__ */

-- 
Regards,

Laurent Pinchart
