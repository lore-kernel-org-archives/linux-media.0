Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2C1D86FF
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876968; cv=none; b=UL1izE5qEVZLRzsbrG1MUCeys3ciEl2UptVl/SLrI1NH1zrD+bPHWuWZUvIkfZaxAiUBI5kpePP7zBc1kJv7ZUmrt7PPqW7G4xS9zvqOUe6W0VV8uABfaA94xV+1QAE+R0DIQtLlKuToVN33ez8CXhXClt8eWpMsVMI0HAYgNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876968; c=relaxed/simple;
	bh=MQijt4CwckEgJm6q4AxePYM79/LzCpf3iwRr0lRZsZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqhFi6/1XSsQBYCVo8i2J0ERjwkQQAYCS63Yb32CZYAp9QimvWnH0KLJRM+zshvh87RdCLt/r+MvE1w/Myj49LI5wB2ExIdl7QkHkAwSUz6QeAa+3zDP2FxXDw0GTiAlNNbXW32VZrD+sgMJ24ciTXZrUeco4k8obGTyftiiSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=pz7LyHwH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="pz7LyHwH"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7866375e943so36902267b3.0
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1762876964; x=1763481764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7VGf93EH4RNxVnue1hBByCb93RrqwGsGg2pi+iF8gn8=;
        b=pz7LyHwH4YJxk66i6NYCBO3VixcyIRjWatJYjkzHQNr5WpGZstcoHWiAYij83hbHvX
         sSg2/gey/XNV60LGs4DMl2jkungdkJaBXZovX8UMfz1p0BSVkQaiuTYr3WS3toEH25j0
         9SmBQirO9PZZxXq19or7i5YoHJ5pVjJJVmxnNiJhHi0N+sq5h8GVudE2ZigW1+1hQta/
         EKzC7rpMf+jcGCXjoObIu3Hd5cnNWM+WhAV7hm1gQwmWUsHGg9/AvQIRB2kx8nf/mXs4
         rNoJdjcLjCVz50auXyXjHiIZcA4h9pjJGVMXJrjcBjF601a7l7Qb3SMJgHjVUztwxjdH
         +FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876964; x=1763481764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VGf93EH4RNxVnue1hBByCb93RrqwGsGg2pi+iF8gn8=;
        b=e/XXqcj7K4fXX02OPpkD7dC4B1QFBQ201DJ9Hm6Aprd6hznoBj59GHn2AS0SaaCJc+
         0aH2VUmUxsxlrfY49nb5FAZ+3HeDjB1YUmg+YtGmyorUtTTNwSeUnZ8ihkDVESlPDws9
         kAuTkadfr9Qx7ENaXJnBUEGUZzc+VqTQUG7ijX4k8aAXmsVxiKDsY9/mt/fCwXvXipeH
         xxw/EHdgv1k45xE3Z+rPfH5lIo+33Pujt+PbX9DrvD6E8XUT3bwOlp5C3YvebHZaKDU1
         ad2hO6PaCidhAG8jo0300jKreyqxFxwFPo74chKPstmyWFqIFzlwAdnAMEO8cAVSl3jt
         2Rww==
X-Forwarded-Encrypted: i=1; AJvYcCXF4ULVhW9yi9sLtfckiyh//QHkPmfsGqG8bSPRSGIWAumJnT1AaZQNcx2PbRqoXKPdkdCR0ReIDdnfxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPU18o0IpgNVvrcfmNXdgFpANIHwlobuKEyfcBJ9KjOZS4fMW
	QPNNp51sPjndjxe5eNwdDyedMQqc0vpD/+5NaLL3HxRKpajZX8dMYjTzTSUiEnDxCT+6LysZvED
	PCmP/0QIYWnmeeBbE7kbzFgfCmlYIDJMjHVHrxW69VA==
X-Gm-Gg: ASbGncvCTihecUTorC31HuF8QXMPOTs2U0H89WNyO26RxRjqHBiZ9mHKirh7O9w6k/q
	QheWoZna46TD8KrKlxSMGhPzMz6rn6RKHddLEEUCVU1CsZ4Uqj/t2L+JlVTQTYxSKtOmi2OkIKo
	VlzA+LSTG9LJyHLDuFilEAYgASWSY8BCyok6nAqylAQHxl6Ugqw3HFbY06Itu1VTdisx4Y1yjWD
	5wHqiQYJaZxB9uy5Cozew6+41t5EsrBNKEWydynchvzbvNUOhlAPi1SoBvp5N2/MPqqZQ5pewvK
	ixs29uhfwT50ipSywTt7INGHqX8=
X-Google-Smtp-Source: AGHT+IHxVfzcMnjoT9N0Epbh4e69UMgZVPS9gWPURg0lmuKfEkoOqup3rLUdLbDvLJaDIqxZPliyLE1m1nVnk7BWeFE=
X-Received: by 2002:a05:690e:165a:b0:635:4ecd:5fcc with SMTP id
 956f58d0204a3-640d45b7544mr8090631d50.41.1762876963963; Tue, 11 Nov 2025
 08:02:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
 <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>
In-Reply-To: <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 11 Nov 2025 16:02:26 +0000
X-Gm-Features: AWmQ_bmAIYxWZ7diJ1TLx2sT3u4adg74eDkUo7h0AihqpsN2m5_Gy1r6II0S33E
Message-ID: <CAPY8ntAAbXq--N_=Lk-GeNMOt7Ucpm2zfkKOnvXB2bhY4i84zg@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: dt-bindings: adi,adv7180: add VPP and CSI
 register maps
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

Hi Michael

On Tue, 11 Nov 2025 at 14:50, Michael Tretter <m.tretter@pengutronix.de> wrote:
>
> The ADV7280 and ADV7280-M have up to three register maps for the VPP and
> CSI. The address of these register maps may be programmed via registers
> in the main register map.

AIUI all the ADV728x devices have at least 2 addresses, signified by
the ADV7180_FLAG_MIPI_CSI2 and ADV7180_FLAG_I2P flags in their
adv7180_chip_info structures.
Is there a reason that you've restricted this to just the two chips?

adv7281 - CSI
adv7281-m - CSI
adv7281-ma - CSI
adv7282 - VPP
adv7282-m - VPP and CSI

The adv7180 and adv7182 families are the only two which only have the
single I2C address.

Thanks.
  Dave

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
> +
>  examples:
>    - |
>      i2c {
> @@ -187,3 +212,22 @@ examples:
>                      };
>              };
>      };
> +
> +  - |
> +    i2c {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            composite-in@20 {
> +                    compatible = "adi,adv7280-m";
> +                    reg = <0x20>, <0x42>, <0x44>;
> +                    reg-names = "main", "vpp", "csi";
> +
> +                    port {
> +                            adv7280_out: endpoint {
> +                                    bus-width = <8>;
> +                                    remote-endpoint = <&vin1ep>;
> +                            };
> +                    };
> +            };
> +    };
>
> --
> 2.47.3
>
>
