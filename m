Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DBnLzbUD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFE010C0;
	Wed, 29 Nov 2023 12:03:32 -0800 (PST)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CA9FC6F0;
	Wed, 29 Nov 2023 21:02:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1701288174;
	bh=ePtEL68l/h8jIKMdH/KdbK5MnwM4St0aZoEyLqeClPQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DBnLzbUD+TsO+e3WV22AFZk957r5YVwhcXY4dY1FPHQKsbsJxpQb7dU/if/A/QVYJ
	 zhnTmz94ShZBArJ++gjeUqyOOQPUo4nBZDTaWZxRUa9X/4qzjZYWBH+Lh9uEhhrWhA
	 ONb1jj397BuL+UjLpNFxlX/RPjvX8cXbLn+xHBSI=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231129092956.250129-2-paul.elder@ideasonboard.com>
References: <20231129092956.250129-1-paul.elder@ideasonboard.com> <20231129092956.250129-2-paul.elder@ideasonboard.com>
Subject: Re: [PATCH 1/3] media: rkisp1: regs: Consolidate MI interrupt wrap fields
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com, Paul Elder <paul.elder@ideasonboard.com>, Dafna Hirschfeld <dafna@fastmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Date: Wed, 29 Nov 2023 20:03:27 +0000
Message-ID: <170128820728.3048548.3243837159240802893@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Paul Elder (2023-11-29 09:29:54)
> Consolidate the wraparound fields in the memory interface interrupt
> status registers, so that it can be more succinctly expressed by taking
> the stream ID (main or self) as a parameter.
>=20
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drive=
rs/media/platform/rockchip/rkisp1/rkisp1-regs.h
> index 350f452e676f..bea69a0d766a 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> @@ -172,12 +172,9 @@
>  #define RKISP1_CIF_MI_FRAME(stream)                    BIT((stream)->id)
>  #define RKISP1_CIF_MI_MBLK_LINE                                BIT(2)
>  #define RKISP1_CIF_MI_FILL_MP_Y                                BIT(3)
> -#define RKISP1_CIF_MI_WRAP_MP_Y                                BIT(4)
> -#define RKISP1_CIF_MI_WRAP_MP_CB                       BIT(5)
> -#define RKISP1_CIF_MI_WRAP_MP_CR                       BIT(6)
> -#define RKISP1_CIF_MI_WRAP_SP_Y                                BIT(7)
> -#define RKISP1_CIF_MI_WRAP_SP_CB                       BIT(8)
> -#define RKISP1_CIF_MI_WRAP_SP_CR                       BIT(9)
> +#define RKISP1_CIF_MI_WRAP_Y(stream)                   BIT(4 + (stream)-=
>id * 3)
> +#define RKISP1_CIF_MI_WRAP_CB(stream)                  BIT(5 + (stream)-=
>id * 3)
> +#define RKISP1_CIF_MI_WRAP_CR(stream)                  BIT(6 + (stream)-=
>id * 3)
>  #define RKISP1_CIF_MI_DMA_READY                                BIT(11)
> =20
>  /* MI_STATUS */
> --=20
> 2.39.2
>
