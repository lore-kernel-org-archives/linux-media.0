Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866FE311C3B
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349789; cv=none; b=uSwbuNcUL3SZLRK9Mr2cqbZv4ZAKIP3OQXfJOJucnzyCRrIQGg9YjCSH6WkdACsZxwFIQYoJVR18UQGYZQKzUE8F/vUg17p4IjFqIcJmr58bBf5tsbNomoGlkYIDzBum8ArDEhPgZ2YuCVXc6lu8BbsodovQTT3lRaFgckM1h3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349789; c=relaxed/simple;
	bh=N3LAI2VKe6lufJcVbjoPrMgXDFUHRU7jaI2Qd1R+9YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVll3MEhO/3LS4epGskh3b03EOH1K2sUo2YMWp5SgxGK18xNSBbqETaN+V0c6M2P7JVdkvHWhHgw18eRmicXfF0bJ1l7p81QcCxoV1yhiCbuftetcsJJ94E462eV1yxfQRs1HVCca/AWwMLUlW9fhp7DVhBZC4WXDoi10Ffx+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD3NYHnC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD3NYHnC"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429b7ba208eso4221168f8f.1
        for <linux-media@vger.kernel.org>; Wed, 05 Nov 2025 05:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349786; x=1762954586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL8OVjWdHUzrhq3ZN/d9whcVawdUbvhGs+dukUNE9D4=;
        b=dD3NYHnCuevkcLyFTCGKmf+TDHzNV68dYko3xhMX/EobSI1OFNx4C/Vu2pYLBvxdrP
         NBWmNUtqkwrwM2PMduHJZsM6hH5Plo7OY5aXc71F3SuGPo00dzQKZCpdD8GpStTurRW0
         12NlJb9/J5msPLiVDpXfuC3SgwQrVeyMi1Pk12Qo9D2Xs6OFWvh07OROGOvNc6ZGkXPS
         wLSuKCKdvzAFsmlfGsSBKiHmt6z0uNc/JNtye0D/o0preNGGis+nnk+dArIeWfI72HKJ
         q4k5/thyAryJZR0cw/VlNmHGoZwTB3A8ZEqG9QpuGGtZdlD+tAt6lvQuzrdDTZqD5uD/
         Da0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349786; x=1762954586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL8OVjWdHUzrhq3ZN/d9whcVawdUbvhGs+dukUNE9D4=;
        b=pFXc1FDi2+3sww4IF+IULUs4OiH9yzIxwk3wVjs2vNTRzxXoZGPLeFsu7unmZJpgsi
         ZX3QZ1Jj8mLDRJ550l/foyZscONDFEkaxUc2zFyzdPI/kR6SOHeYTnU2m1i463T0TzY6
         IyqNF3rAd6C4yBDcZGvSQviZMVRiOe4eOLlSA7bt4dBB8W8Eatefq4hpA+bXfODixZpi
         cfvPG5QoYoTAf8SHITq0daMQQPYbwAu5cMtNwxJmrq1tFZRTNoBYO0DPXW4NxS2To0kJ
         WX8WhCLaI3FDBF+ounWLVaqNfWe33EHzNmZXnmhS2nvVDQSaj7/WPv/hC9hsyGLv7aX/
         NNrA==
X-Gm-Message-State: AOJu0YylPgcKvKIWPu3AKmd9OgwkljKoNrC9UIV3Ya0TZcPC+134zxlp
	lDvabb78dKtNL38PSBvj0KWRuKf+/z3KHli2DTAxgwouAnuc1HoicRjic0cMnK+IXm7xeTGpzmJ
	VD0ZMDb6YXJyfses/hCnHkiGAUoOIwzk=
X-Gm-Gg: ASbGncvyzGgSheQM0dyBMgdSnpWRciBuXoklTY5nLjxj0Y5thkoTI08bUU4XNc7Iqtz
	a+pROrKfXfqPy6s6WZjBaTz6p6UCMtPT21zmf0iVxpVD6qWebeF7PYwfM/ken2UxS556WQjj3+k
	vloOQG2wtEk8YRnk7NaIBHc7Ca0HlaBaUO9nrImA2FEjNviU83F+yM7iaOn3arc3h1tcHFCUnHy
	Yh93NfbEHgIGmUc81X6kPMNtfQviQM0bHVRrhgIiXzi4zR7QAxNEnq3x+qKnGNGEQBj6wg=
X-Google-Smtp-Source: AGHT+IEFGUCq5pOwZYnXFWPhWJEW8IG4enihXYQYe3+bMQEFYIeVw6QpuN6H25Eqsp92tVyTuPD9IkJCxAS5BCgQOew=
X-Received: by 2002:a05:6000:22ca:b0:3e9:3b91:e846 with SMTP id
 ffacd0b85a97d-429e32c8357mr2860369f8f.10.1762349785766; Wed, 05 Nov 2025
 05:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-c55-v12-0-3eda2dba9554@ideasonboard.com>
 <20251002-c55-v12-3-3eda2dba9554@ideasonboard.com> <CA+V-a8sg4c697WTS=wXoWvgc_UCFM3+Qjh1br=rMm4F84NVw-Q@mail.gmail.com>
 <8c5a4c68-8299-4d8f-96b2-8db232df70fe@ideasonboard.com>
In-Reply-To: <8c5a4c68-8299-4d8f-96b2-8db232df70fe@ideasonboard.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 5 Nov 2025 13:35:59 +0000
X-Gm-Features: AWmQ_bkQ07gnEJ1TplADVmVgYPnAor3xF3-AhJKu46RGz6HGiG28aqTfQRb9Z0M
Message-ID: <CA+V-a8vey1y0QAxk7vYNHzPHrOrQ4uTpjf4LCb9wSRRCT3v3Qg@mail.gmail.com>
Subject: Re: [PATCH v12 03/15] dt-bindings: media: Add bindings for ARM mali-c55
To: Dan Scally <dan.scally@ideasonboard.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Anthony.McGivern@arm.com, 
	jacopo.mondi@ideasonboard.com, nayden.kanchev@arm.com, robh+dt@kernel.org, 
	mchehab@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jerome.forissier@linaro.org, kieran.bingham@ideasonboard.com, 
	laurent.pinchart@ideasonboard.com, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Mon, Nov 3, 2025 at 4:17=E2=80=AFPM Dan Scally <dan.scally@ideasonboard.=
com> wrote:
>
> Hi Prabhakar
>
> On 28/10/2025 18:23, Lad, Prabhakar wrote:
> > Hi Daniel,
> >
> > Thank you for the patch.
> >
> > On Thu, Oct 2, 2025 at 11:19=E2=80=AFAM Daniel Scally
> > <dan.scally@ideasonboard.com> wrote:
> >>
> >> Add the yaml binding for ARM's Mali-C55 Image Signal Processor.
> >>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Acked-by: Nayden Kanchev <nayden.kanchev@arm.com>
> >> Co-developed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> >> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> >> Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
> >> ---
> >> Changes in v12:
> >>
> >>          - _Actually_ dropped the arm,inline property mode, having for=
gotten to
> >>            do so in v11.
> >>
> >> Changes in v11:
> >>
> >>          - Dropped in arm,inline_mode property. This is now identical =
to the
> >>            reviewed version 8, so I have kept the tags on there.
> >>
> >> Changes in v10:
> >>
> >>          - None
> >>
> >> Changes in v9:
> >>
> >>          - Added the arm,inline_mode property to differentiate between=
 inline and
> >>            memory input configurations
> >>
> >> Changes in v8:
> >>
> >>          - Added the video clock back in. Now that we have actual hard=
ware it's
> >>            clear that it's necessary.
> >>          - Added reset lines
> >>          - Dropped R-bs
> >>
> >> Changes in v7:
> >>
> >>          - None
> >>
> >> Changes in v6:
> >>
> >>          - None
> >>
> >> Changes in v5:
> >>
> >>          - None
> >>
> >> Changes in v4:
> >>
> >>          - Switched to port instead of ports
> >>
> >> Changes in v3:
> >>
> >>          - Dropped the video clock as suggested by Laurent. I didn't r=
etain it
> >>          for the purposes of the refcount since this driver will call =
.s_stream()
> >>          for the sensor driver which will refcount the clock anyway.
> >>          - Clarified that the port is a parallel input port rather (Sa=
kari)
> >>
> >> Changes in v2:
> >>
> >>          - Added clocks information
> >>          - Fixed the warnings raised by Rob
> >> ---
> >>   .../devicetree/bindings/media/arm,mali-c55.yaml    | 82 ++++++++++++=
++++++++++
> >>   1 file changed, 82 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/media/arm,mali-c55.yaml=
 b/Documentation/devicetree/bindings/media/arm,mali-c55.yaml
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..efc88fd2c447e98dd82a1f=
c1bae234147eb967a8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/media/arm,mali-c55.yaml
> >> @@ -0,0 +1,82 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/media/arm,mali-c55.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: ARM Mali-C55 Image Signal Processor
> >> +
> >> +maintainers:
> >> +  - Daniel Scally <dan.scally@ideasonboard.com>
> >> +  - Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: arm,mali-c55
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    items:
> >> +      - description: ISP Video Clock
> >> +      - description: ISP AXI clock
> >> +      - description: ISP AHB-lite clock
> > As per RZ/V2H HW manual we have reg clock looking at the driver code
> > it does have readl. IVC has reg clock if IVC driver fails are you
> > still able to read/write regs from ISP driver?
>  >
>  > I think we do need to pass reg clock too.
>
> Yes - but I should clarify that the names are from the arm documentation =
that we had when we
> originally developed the ISP driver. The RZ/V2H documentation treats the =
ISP and IVC as one block
> that shares 4 clocks and resets, but when we originally developed the ISP=
 driver the platform we
> used had the ISP implemented as an inline configuration (taking data dire=
ctly from a csi-2 receiver
> without an IVC equivalent), and the documentation detailed just the three=
 clocks and resets. The
> dtsi changes for the RZ/V2H(P) [1] assign clocks 226, 228 and 229 to the =
ISP which are named
> reg_aclk, vin_aclk and isp_sclk in the renesas documentation.
>
> The IVC gets pclk, vin_aclk and isp_sclk.
>
> [1] https://lore.kernel.org/linux-renesas-soc/20251010-kakip_dts-v1-1-64f=
798ad43c9@ideasonboard.com/
>
Thanks for the info.

> > Also for IVC we do have a main clock (which is a system clock).  Can
> > you please educate me on what is the purpose of it. Just curious as we
> > pass to IVC and not ISP.
>
> The IVC uniquely gets the one called "pclk" in renesas documentation, wit=
h the description "Input
> Video Control block register access APB clock".
>
Got you.

Cheers,
Prabhakar
