Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7832F291A;
	Wed, 12 Nov 2025 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934717; cv=none; b=q14mIVrt4OqZEkNAYkKQsKbl3h7p6eXqXcu42c2DU0QP63IEqrgck4mHaWwOMC6L2HUNVWR0gM9PHDNzSN7rI77OAdHLX/0s4PBBx8/hDrrgIZry5Xcf8x5Q6Ok4MsJhFGJVLHz7OGE5WpkMi5CGWCtjCnklaaF2WU8B2oKIVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934717; c=relaxed/simple;
	bh=M4J+gQk8xotogYCiprgbfusjrFcWpbeOaHPeTfzJ70k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wa7BRE5Hxfv1ltPrmfQUGef+y9CnAuQIDL/Yj4GDds+fD7KLuIYE5LBq940o/bBnUZuDQgsCUayB96oegXU7T9OZ0o/zp8zP2al+Wp/S/ngHtZsbKTaR8ZNrEsorX093RlQo5633qNgsEJqm7ijWgxHqVCbQ+IEd+TC7YuclhjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWdYTU1I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWdYTU1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6879FC16AAE;
	Wed, 12 Nov 2025 08:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762934717;
	bh=M4J+gQk8xotogYCiprgbfusjrFcWpbeOaHPeTfzJ70k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWdYTU1IPIv8+OpNEJiSqmPxITlZs1QKt2etc2+NZVA3NPr5MS0Ai+ZlIzI0Ck7cT
	 aTflv6JmVVpKIJjlK8WU2aTEP7IyLqIyKvDUAHU3ZdTeRNLOlIE76S8v65fBQrYhit
	 VR6maVP9Rnax0nMGdB8q4JNBZLaGZc73i0wQWDuAExAJDkpj601LRz0UwcO8d+5A7B
	 zd5N6sZomATgGUA/9czmo1UEvQKbeI7rmv7hhdx+p6PFTiRcWfjhYUGBOe2WTEMAw4
	 rbI4cZJqRZrwXVbT4yJTI6wCV8znIfpJwSny40sP3jVzvwTetFnp64w3aFxGBkmTTf
	 q72GrRprDEB9g==
Date: Wed, 12 Nov 2025 09:05:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 1/4] media: dt-bindings: adi,adv7180: add VPP and CSI
 register maps
Message-ID: <20251112-burrowing-funny-cobra-19705d@kuoka>
References: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
 <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>

On Tue, Nov 11, 2025 at 03:36:14PM +0100, Michael Tretter wrote:
> The ADV7280 and ADV7280-M have up to three register maps for the VPP and
> CSI. The address of these register maps may be programmed via registers
> in the main register map.
> 
> Allow to specify the addresses of the VPP and CSI in the device tree to
> solve address conflicts on a board level.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  .../devicetree/bindings/media/i2c/adi,adv7180.yaml | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml b/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
> index dee8ce7cb7ba..4bbdc812442b 100644
> --- a/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
> @@ -138,6 +138,31 @@ allOf:
>        required:
>          - ports
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adv7280
> +              - adi,adv7280-m
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 3

This does not match top-level.

> +          description:
> +            The ADV7280 and ADV7280-M have up to three register maps, which can be
> +            accessed via the I2C port. The main register map, the VPP register map,
> +            and the CSI register map. The main register map is mandatory. The other
> +            register maps are optional and the default is used unless specified.
> +
> +        reg-names:
> +          minItems: 1
> +          items:
> +            - const: main
> +            - enum: [ csi, vpp ]
> +            - enum: [ csi, vpp ]

List must not be flexible. What does it mean "optional"? The device has
them always or you disable them via some sort of efuse/OTP?

Best regards,
Krzysztof

