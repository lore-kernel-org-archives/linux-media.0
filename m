Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90435A142
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882802; cv=none; b=UIUq0wehLOc2WS/4Js02lIY2M6Ad2modrZPDVnuf8yqJGFW+0MBB3XwajFTkakT2IOELO4FIGj7TR4x7eXY2lC+MjcXzFSP771/A3gjWrmRCHKy1b17Om5pClIpC1BsV6ne8EWkNoMa2fMH1iFUwpdhJTyuyXFkqPDgTpNgF8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882802; c=relaxed/simple;
	bh=8rWFm5kx0uCTaC5/KSK33hm+h+JDdRob+P3tgSHU7xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqYJRBzbIMSl/sMFvaPCQMnXQBQrqImy7ViYpRaeVzV8TqqFLkbPDfvXtBHimzlOYJyNYMKkNr4XoBuluoWO7bzakdGrjp8Orf6PVi3j76i2JuIASN0oxYk6id0pQ5zPw7PAR3HBTOo+Zanr4yJwC3ml7EdkrPf4EKiX+hqWJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vIsLJ-0000lw-6q; Tue, 11 Nov 2025 18:39:45 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vIsLI-008EwL-05;
	Tue, 11 Nov 2025 18:39:44 +0100
Received: from mtr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vIsLH-00EYen-2z;
	Tue, 11 Nov 2025 18:39:43 +0100
Date: Tue, 11 Nov 2025 18:39:43 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/4] media: dt-bindings: adi,adv7180: add VPP and CSI
 register maps
Message-ID: <aRN039bNdqD8bySl@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de
References: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
 <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>
 <CAPY8ntAAbXq--N_=Lk-GeNMOt7Ucpm2zfkKOnvXB2bhY4i84zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPY8ntAAbXq--N_=Lk-GeNMOt7Ucpm2zfkKOnvXB2bhY4i84zg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org

Hi Dave,

On Tue, 11 Nov 2025 16:02:26 +0000, Dave Stevenson wrote:
> On Tue, 11 Nov 2025 at 14:50, Michael Tretter <m.tretter@pengutronix.de> wrote:
> >
> > The ADV7280 and ADV7280-M have up to three register maps for the VPP and
> > CSI. The address of these register maps may be programmed via registers
> > in the main register map.
> 
> AIUI all the ADV728x devices have at least 2 addresses, signified by
> the ADV7180_FLAG_MIPI_CSI2 and ADV7180_FLAG_I2P flags in their
> adv7180_chip_info structures.
> Is there a reason that you've restricted this to just the two chips?

I only have an ADV7280-M for testing. Thus, I restricted it to the chip
that I could test and the variant that's the same except for the CSI.

> 
> adv7281 - CSI
> adv7281-m - CSI
> adv7281-ma - CSI
> adv7282 - VPP
> adv7282-m - VPP and CSI
> 
> The adv7180 and adv7182 families are the only two which only have the
> single I2C address.

Are you suggesting to extend the binding to be able to specify the
addresses for the CSI and VPP for any of these chips?

Michael

> 
> Thanks.
>   Dave
> 
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
> > +
> >  examples:
> >    - |
> >      i2c {
> > @@ -187,3 +212,22 @@ examples:
> >                      };
> >              };
> >      };
> > +
> > +  - |
> > +    i2c {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            composite-in@20 {
> > +                    compatible = "adi,adv7280-m";
> > +                    reg = <0x20>, <0x42>, <0x44>;
> > +                    reg-names = "main", "vpp", "csi";
> > +
> > +                    port {
> > +                            adv7280_out: endpoint {
> > +                                    bus-width = <8>;
> > +                                    remote-endpoint = <&vin1ep>;
> > +                            };
> > +                    };
> > +            };
> > +    };
> >
> > --
> > 2.47.3
> >
> >
> 
