Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D62BEC44
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885517; cv=none; b=MnkyWELCxegcCIv66ci2DpUoArlFEty6ZG756bV+VMcZ/ffoi/tICpEKExWzfCjeHNcZZr6slsjkTSz7g4c6/bf7Ct+3B+UkktHu4jr42u6pf/e7aIfCCGHp6vmCKZPiW6V3OhZBJfez1ks85TmczY+sUvxQZf8Q8xqH4OG27fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885517; c=relaxed/simple;
	bh=uW3fdIJNojLg1+r7dEjr0CmWmSrdydlYHz/58yZZms0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KAEuLd137ciqEoxEIOUnZn69bqfoc4PhqZxh254CRayRMJGNNKvJYDGqbspR4+deIPuFYeBRbF3E5uxW73NtG/UN0Hhy9hUYoD2qJKZCQ7XOHt2gHoeQ0UsuPO3IRJmXiLRqfPfbrTK+7XsrE37LmcUWNqoT0I9xib5VPGE4Xj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=imoqJCvp; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="imoqJCvp"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78677ff31c2so142887b3.2
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1762885514; x=1763490314; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbaypeAc+LAHLf1nSdqKLcHPmc0bIEfuTiR1igXjF8A=;
        b=imoqJCvpoiAdl0EzWdphTSkKzxGeq2ss7g6JmYtimRnrOnq+5Ed+Xws7q6SAOLcHxq
         huKZmH+ijTNRwSTtSA7+5iMW1ROGcOn3EUbjJ/FkfyOC5EVZMy5HvTaM0fN0BCWckLeV
         TW5wE9JxVVsac6nE43Q8uJc0nMvRnARleDNVAfrmLwIO8oDSRRT1lDp6L4rTwa2qCH9O
         wWidjI4c+IUrhFmPNECjZKSReVZJvWDIyiSlo+RXGzUfKoRGOUAzFGhWtpUY+ryNCTqu
         qRLYX3/25rC88WbSX8j0V2rgwJWItINnuBwOEGg3+OCx0SnnczVRQIV8oIuF4Yy8iHTf
         IKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762885514; x=1763490314;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbaypeAc+LAHLf1nSdqKLcHPmc0bIEfuTiR1igXjF8A=;
        b=dNHcowmVAjtiufepXIGlfoYrzqrUklasuOGXku/gx9yKShnPNDW46MZ4wyV3RJ59au
         Lv3Y/azgPL+mDsNNGDVptMwjB3ET2dyTrnfEZo10Mpi66F5MjJU5X4+hBgeNQhArcUeZ
         ks0F2sWKDSL1BhMlRxKPCAnLe3Y/Z0zyYtoc2hRoPWQ6TU/AJOWV4zhPz4dXS0ATKhIN
         P560tPZGrw5ulRmeZMKVQ/gBDETdV+46o57jsNAQE1IGjFN3LLK06YQQ/n+qNbgvwrhV
         a9qTaKpWW46np567yeiakSXBZxrjw+/E8cpoH3ESVJDa2+RcH0W1oZLFuoze97J7Caem
         G2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUUdkBf5Gv7xV5GeamkLMp74F6Ar+qZxC9uPJ/IgCReytVtD10SDRZyw1OagCUtqC3+ZLvKN/zJBMXYnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLygcOdq4n2SXTmEYnTyDL1UqejzbCqGtKilGj+3bejeBvh0YB
	HGIsrnLzP6iPapZ/mfWdwsTNX7nVnZtQXvZ5XHal6wKZpEXrQAzQK2CeIb8OGEW/qgrCPnuFy7O
	jYCc1w/Sqvd5dIrZ55aBXG2UEXuYt0HAHyeHSWbwWGA==
X-Gm-Gg: ASbGnctA2nTGg2jlBydZ+r8P/yeJr3ppMnvk7Qkea/cQHAfJ9+U92JRQQF5HcqwUCtp
	kICEsv1sIPCl1UNFP+6QFQekDWH805FzcEV4h4weRBv6bXvdklQcZ6hUFck6e16WNFStN3CtUsL
	pT6ZvE+Tqbah9boHMM1uFzdZmyTFJkaN6ynoFZLjg2qZjYg8KTYRcBuSEjhaYg1dVVLDBPYIBIY
	SBY9+S22PDWWXZuJPmz9R7LG9YneQuUYuMcGABInniUDOyWYoG+4XZGyQvObDNm+0uultS9DGxb
	mNCtIdALWX3/tFcbb7BysL2mluY=
X-Google-Smtp-Source: AGHT+IH/WEZ5YOvre83bEWsrI64IAmk0Xmrg/suPeYhWUxruEL1V+Ky/0K3tNxGTbF2OBLUFVsPG8mza82okHXcaBGM=
X-Received: by 2002:a05:690c:7108:b0:787:f5c5:c630 with SMTP id
 00721157ae682-787f5c5ce8cmr58641017b3.41.1762885514479; Tue, 11 Nov 2025
 10:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
 <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>
 <CAPY8ntAAbXq--N_=Lk-GeNMOt7Ucpm2zfkKOnvXB2bhY4i84zg@mail.gmail.com> <aRN039bNdqD8bySl@pengutronix.de>
In-Reply-To: <aRN039bNdqD8bySl@pengutronix.de>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 11 Nov 2025 18:24:56 +0000
X-Gm-Features: AWmQ_bnP3AdTyCu95ZcqXIRrbj6nzHhQqcYccZgtVweCzPdCw7EcgDuP6gytZ78
Message-ID: <CAPY8ntDEdiYMPHgWcX_UkL_jEi=8kK+oT4R6C6kF6vnUgb17jg@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: dt-bindings: adi,adv7180: add VPP and CSI
 register maps
To: Michael Tretter <m.tretter@pengutronix.de>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

Hi Michael

On Tue, 11 Nov 2025 at 17:39, Michael Tretter <m.tretter@pengutronix.de> wrote:
>
> Hi Dave,
>
> On Tue, 11 Nov 2025 16:02:26 +0000, Dave Stevenson wrote:
> > On Tue, 11 Nov 2025 at 14:50, Michael Tretter <m.tretter@pengutronix.de> wrote:
> > >
> > > The ADV7280 and ADV7280-M have up to three register maps for the VPP and
> > > CSI. The address of these register maps may be programmed via registers
> > > in the main register map.
> >
> > AIUI all the ADV728x devices have at least 2 addresses, signified by
> > the ADV7180_FLAG_MIPI_CSI2 and ADV7180_FLAG_I2P flags in their
> > adv7180_chip_info structures.
> > Is there a reason that you've restricted this to just the two chips?
>
> I only have an ADV7280-M for testing. Thus, I restricted it to the chip
> that I could test and the variant that's the same except for the CSI.
>
> >
> > adv7281 - CSI
> > adv7281-m - CSI
> > adv7281-ma - CSI
> > adv7282 - VPP
> > adv7282-m - VPP and CSI
> >
> > The adv7180 and adv7182 families are the only two which only have the
> > single I2C address.
>
> Are you suggesting to extend the binding to be able to specify the
> addresses for the CSI and VPP for any of these chips?

Seeing as the driver change implements that, IMHO the binding ought to match.
I can test adv7282-m for you if you want. I'd be very surprised if it
didn't work with the entire family, and as setting the additional
addresses is optional it's unlikely to cause an issue anyway.

  Dave

> Michael
>
> >
> > Thanks.
> >   Dave
> >
> > > Allow to specify the addresses of the VPP and CSI in the device tree to
> > > solve address conflicts on a board level.
> > >
> > > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> > > ---
> > >  .../devicetree/bindings/media/i2c/adi,adv7180.yaml | 44 ++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml b/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
> > > index dee8ce7cb7ba..4bbdc812442b 100644
> > > --- a/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
> > > +++ b/Documentation/devicetree/bindings/media/i2c/adi,adv7180.yaml
> > > @@ -138,6 +138,31 @@ allOf:
> > >        required:
> > >          - ports
> > >
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - adi,adv7280
> > > +              - adi,adv7280-m
> > > +    then:
> > > +      properties:
> > > +        reg:
> > > +          minItems: 1
> > > +          maxItems: 3
> > > +          description:
> > > +            The ADV7280 and ADV7280-M have up to three register maps, which can be
> > > +            accessed via the I2C port. The main register map, the VPP register map,
> > > +            and the CSI register map. The main register map is mandatory. The other
> > > +            register maps are optional and the default is used unless specified.
> > > +
> > > +        reg-names:
> > > +          minItems: 1
> > > +          items:
> > > +            - const: main
> > > +            - enum: [ csi, vpp ]
> > > +            - enum: [ csi, vpp ]
> > > +
> > >  examples:
> > >    - |
> > >      i2c {
> > > @@ -187,3 +212,22 @@ examples:
> > >                      };
> > >              };
> > >      };
> > > +
> > > +  - |
> > > +    i2c {
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +
> > > +            composite-in@20 {
> > > +                    compatible = "adi,adv7280-m";
> > > +                    reg = <0x20>, <0x42>, <0x44>;
> > > +                    reg-names = "main", "vpp", "csi";
> > > +
> > > +                    port {
> > > +                            adv7280_out: endpoint {
> > > +                                    bus-width = <8>;
> > > +                                    remote-endpoint = <&vin1ep>;
> > > +                            };
> > > +                    };
> > > +            };
> > > +    };
> > >
> > > --
> > > 2.47.3
> > >
> > >
> >
