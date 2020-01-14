Return-Path: <SRS0=7WKT=3D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002F7C33CA9
	for <linux-media@archiver.kernel.org>; Tue, 14 Jan 2020 01:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C511321556
	for <linux-media@archiver.kernel.org>; Tue, 14 Jan 2020 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578963607;
	bh=ICuLmJcd5MuUF5ih4nNV4O+uuHngWapP4XE/nqFRloI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bgIVMTfCxZi4RacpJaJuOb5G/Ps2rPObeHVkvHxudg7VRbDTUp3yfh39a5vpVXQu2
	 diG75+ely61Vznv+ojGiVTG24kK4WqqXYKIh7oQpGzeGktX40tFjLa1h2uxc6xMhkt
	 +GwnCkKriUvB4DjmbgeKQnvJvLaVYsOdkFdCAslI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgANBAH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:00:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38550 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgANBAH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Jan 2020 20:00:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so10222754oii.5
        for <linux-media@vger.kernel.org>; Mon, 13 Jan 2020 17:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qSm233hBzLTG9G2DIy5d4ytValKHnVbjxr5pAXtlvA=;
        b=OlqLXInLhA+JFLnOrrAN4fu7/fUt0e86m4v3fFLKsiKrHHztMcXPl098KuwezpS0tA
         6wl14UzoZDKZ3/HcN7ZYmBysiHRLLmY8iD4CUxIZIx2pI7hSxCzKMbqNiTYV2ggbdGJk
         J5Iwu2lL6cIcxrrEDZ6yxGk/HjlbqApOD7RV89pLtlXn0gXfaUrvo2sT6KzX8TRJdFwS
         DspLgocc+NZWXs967l0Bgvd/rFY0HUKkS4bjPOTYqkwQzGLwr0KX6mPTd4G3CbLvrUnJ
         7OyICEMzk/u4HqOfbloTy4/CHCjwaFDndi2VmlejnCRJw//aBV++jh5OO7riSI/F0Wia
         CiYA==
X-Gm-Message-State: APjAAAU8+zOs2yd+qgwAHIOpUD+nhKmXsZtPMbPwzQ6oZu0Vra50dYnH
        my1hmQ5hyP/Q5tR4JhoH7b/hQKfSHA==
X-Google-Smtp-Source: APXvYqwnA2vPMUqk3L+8uvPZd2atOiNLfYth0E+AHrPBTBH8xxYJQi7l+HfflROkhilTDLVNqzln2Q==
X-Received: by 2002:aca:3cd7:: with SMTP id j206mr15426651oia.142.1578963606211;
        Mon, 13 Jan 2020 17:00:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y196sm4105281oie.1.2020.01.13.17.00.03
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 17:00:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d1
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:21:19 -0600
Date:   Mon, 13 Jan 2020 18:21:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 12/17] dt-bindings: atmel,at91rm9200-rtc: add
 microchip,sam9x60-rtc
Message-ID: <20200114002119.GA18003@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-13-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 10 Jan 2020 18:18:04 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-rtc to DT bindings documentation.
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Hi Alexandre,
> 
> I kept this patch as in v1 (same for patch
> "dt-bindings: atmel-tcb: add microchip,sam9x60-tcb").
> I'm waiting your response to this version and take an action aftewards.
> 
> Thank you,
> Claudiu Beznea
> 
>  Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
