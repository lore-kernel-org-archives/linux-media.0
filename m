Return-Path: <SRS0=7WKT=3D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E75C33CA9
	for <linux-media@archiver.kernel.org>; Tue, 14 Jan 2020 00:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0ED214AF
	for <linux-media@archiver.kernel.org>; Tue, 14 Jan 2020 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578961224;
	bh=ty5zfQkiRhAx57Hwj6NCRKyc2kPTZbupHVXQsQn3t5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rjmATej5M49ic5OTbVsutQi3JM2MUBJP+rT8Ksf4ywIIzAGC/hxDY4hx8Iiz9FR2a
	 jxVJWxLRrgVnkLrecXr8A4qxYfOsRalmVtyiQaDv/qk2qnUmCZYj3kZYjxYUcNNsOZ
	 yPSKoXp7XifPHZaevarH65A04TRbJtrU9EAdQxnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgANAUX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:20:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46524 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgANAUX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Jan 2020 19:20:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id r9so10831300otp.13
        for <linux-media@vger.kernel.org>; Mon, 13 Jan 2020 16:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnCP/oi7Z0mxzEO5kxr1fVYeBOYXbt9IQu/uVhgHHc8=;
        b=s5r2Hqq9batISM7KAcrnVwm45ve2YCIXPishIyjftsY9Ou3vOJRvAHPhBdMw+mjbW7
         nYINuR2skVlofu04st/OP3QiEGoO/X7Wn/XF4kGR91jdltPDPHW3KBy/5UI+E8JPoOZC
         ILSm+5UUP++sOjun5gBzCU/uWCticGoUPrdEIq84W7yMarcGrkugy1gRXSWROCO8gHWM
         zRmdlxMGw1Nzr3f5esWa4lc/LSvX5AQ7YRmqJhSa6vUQHLg1lqNUe56YBFsiiJoxzWRx
         mNGePkPxuKPx1Ui08CJoRywHVGNvMuahQ8QC2lUGNwiv54L8WKV1KYdWw+dmcyWHWvO+
         NJTQ==
X-Gm-Message-State: APjAAAVbTk69I9iM68tn1VPNJOwZWtMpCZAe6ZvEovO074kJbTzYpF9D
        GS/AB8FFrc85K6ALqK12Qpwg4flQaA==
X-Google-Smtp-Source: APXvYqzFJbKp9cXI7VSw11xlEO8PZSI0Q75hyfN/b31BKsukE5fT/v+GS11DHA6E7j/jXEO3Ny6SuQ==
X-Received: by 2002:a9d:624e:: with SMTP id i14mr15392900otk.371.1578961222533;
        Mon, 13 Jan 2020 16:20:22 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e65sm4789029otb.62.2020.01.13.16.20.21
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:20:22 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219cf
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:16:49 -0600
Date:   Mon, 13 Jan 2020 18:16:49 -0600
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
Subject: Re: [PATCH v2 07/17] dt-bindings: atmel-matrix: add
 microchip,sam9x60-matrix
Message-ID: <20200114001649.GA11024@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-8-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-8-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 10 Jan 2020 18:17:59 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-matrix to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-matrix.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
