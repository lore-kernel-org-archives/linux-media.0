Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14F2264B8
	for <linux-media@vger.kernel.org>; Wed, 12 Nov 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940382; cv=none; b=aZpleMPiWGBbhADevC5YJ96Tkxqcyfwj2YfTP07Gx3oK2lz/jj5Xf/eiTQKICwfncwpLYH8Su/o44Kdc9IAdBNOogzQV8YxA0ivyWv3F3IjuzmVBrO5gN0+Ody1hcINAv4pVWQXYaiIcw1eXfus66VlDhPffw+leEk05gno8Kdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940382; c=relaxed/simple;
	bh=66XheiQirvHXrjkJwKOPTc9T1NbjeqEOaPeXSvH9nhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNqZtbiYynGy75JCQSCSNo3v06/+D+u/eaLt9GpIpiRLQnXS4MO7ec5r7/EIKQwaHYRqXfTy0TVDBWGHVbvvyKQloQ0xJDyFCp18YzNnR3G8mY8mLX6/WSjnpcWyfm8ri4CSbi70Th3egsvCE59eulPtfcJEwKJT8soEJdCnrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vJ7K5-0002jm-Ln; Wed, 12 Nov 2025 10:39:29 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vJ7K4-0003l5-3A;
	Wed, 12 Nov 2025 10:39:28 +0100
Received: from mtr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vJ7K4-00GQes-2j;
	Wed, 12 Nov 2025 10:39:28 +0100
Date: Wed, 12 Nov 2025 10:39:28 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/4] media: dt-bindings: adi,adv7180: add VPP and CSI
 register maps
Message-ID: <aRRV0LXnoU4gjBgE@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de
References: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
 <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>
 <20251112-burrowing-funny-cobra-19705d@kuoka>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112-burrowing-funny-cobra-19705d@kuoka>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org

On Wed, 12 Nov 2025 09:05:14 +0100, Krzysztof Kozlowski wrote:
> On Tue, Nov 11, 2025 at 03:36:14PM +0100, Michael Tretter wrote:
> > The ADV7280 and ADV7280-M have up to three register maps for the VPP and
> > CSI. The address of these register maps may be programmed via registers
> > in the main register map.
> > 
> > Allow to specify the addresses of the VPP and CSI in the device tree to
> > solve address conflicts on a board level.
> > 
> > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> > ---
> >  .../devicetree/bindings/media/i2c/adi,adv7180.yaml | 44 ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml b/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
> > index dee8ce7cb7ba..4bbdc812442b 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
> > +++ b/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
> > @@ -138,6 +138,31 @@ allOf:
> >        required:
> >          - ports
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,adv7280
> > +              - adi,adv7280-m
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 1
> > +          maxItems: 3
> 
> This does not match top-level.

Ack. If I understand the error message by dt_bindings_check correctly, I
have to move the default from the top-level to the else branch of this
conditional expression. Right?

> 
> > +          description:
> > +            The ADV7280 and ADV7280-M have up to three register maps, which can be
> > +            accessed via the I2C port. The main register map, the VPP register map,
> > +            and the CSI register map. The main register map is mandatory. The other
> > +            register maps are optional and the default is used unless specified.
> > +
> > +        reg-names:
> > +          minItems: 1
> > +          items:
> > +            - const: main
> > +            - enum: [ csi, vpp ]
> > +            - enum: [ csi, vpp ]
> 
> List must not be flexible. What does it mean "optional"? The device has
> them always or you disable them via some sort of efuse/OTP?

The flexible list is inspired by the binding for adi,adv748x.yaml. It
also has a main device and several optional slave devices, which remain
at the default address if not specified in the device tree.

The optional register maps depend on the variant of the chip, and the
driver may or may not use them. In case of the adv7280-m, the driver
currently always programs a hard-coded default address into the
hardware. Making the csi and vpp register map addresses as optional
would allow to preserve the current driver behavior in these cases.

I think this is necessary for backward compatibility.

Michael
