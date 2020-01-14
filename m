Return-Path: <SRS0=7WKT=3D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD5C33CA9
	for <linux-media@archiver.kernel.org>; Tue, 14 Jan 2020 00:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90685207FF
	for <linux-media@archiver.kernel.org>; Tue, 14 Jan 2020 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578961818;
	bh=qMV9t6yq7xpLcOxvDk7MIU+TGS/TsLnI3P1Rd0BbMos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YxCib3/g3jxDs58UdIyeSidqCnsgilY+0txkTVMIz9NA/KAJlO9fxoyMSPsSb7DEO
	 cliDRyoKWOMIkLhI5eCndjIdtrSP/CFyNVtVS/MHd2kwi+1RtyyNNnpr+h8Qy2r/87
	 gvUL2smIQnBPuKzRXtbb/6jn3/gqVkdVhIRLVsis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgANAaS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:30:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44371 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgANAaR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Jan 2020 19:30:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so10147349oia.11
        for <linux-media@vger.kernel.org>; Mon, 13 Jan 2020 16:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z4zWbyVluCegWLV1bmjQGYNlUCTLZBFCektijqCqk8g=;
        b=mvgRGV0QdcdvfOmyVcE2KVlJGpWIRHgGjxuM1YLQLbfpfhJF4h8NH8dBKBK2/2u0yh
         8qa6YQIIWvV9JIYS4KHvJ4Ry6li7zHr9uVfE3YmXwPNQAbmeRCIPdQ2tkRvpKq/mgZnX
         FHfjEHTVUmV2MiDSyM6c8p73WPuVDmVE37FJ4RxrJ9gpMGuQBSieClWaC+PhsTYni7nc
         7tT4LoUhfHIML7bYzSgsfXGwWeVToJS3JF0akZYpT7b5duFj8lwQY85kEsLt2pH3p1xB
         8z1utDFnWbBfKu1YpTKffF4u+/6IHxlxyjwhZsSBW7Z0n09/zvk2aa5KkWKFy57L3r8k
         D/xQ==
X-Gm-Message-State: APjAAAVGS/lYKh0IGMbYRZDLfTGcwa3u97Ec1BKxJZxqUHdAWrJsDwxr
        YvVRYPh7YCqpz5wQbsRHOsZLM4lzkA==
X-Google-Smtp-Source: APXvYqzdY360gPsL0+c8bTHhbJYe+orte+PC8914vegPn2Na6ygQR0JeUOr0nQGireNFi7y6RbcLXw==
X-Received: by 2002:aca:d806:: with SMTP id p6mr15170180oig.17.1578961815776;
        Mon, 13 Jan 2020 16:30:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u75sm4076384oie.15.2020.01.13.16.30.15
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:30:15 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d0
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:20:42 -0600
Date:   Mon, 13 Jan 2020 18:20:42 -0600
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
Subject: Re: [PATCH v2 11/17] dt-bindings: atmel-gpbr: add
 microchip,sam9x60-gpbr
Message-ID: <20200114002042.GA17036@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-12-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-12-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 10 Jan 2020 18:18:03 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-gpbr to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-gpbr.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
