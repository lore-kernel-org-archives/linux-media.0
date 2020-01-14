Return-Path: <SRS0=7WKT=3D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE334C33CA9
	for <linux-media@archiver.kernel.org>; Tue, 14 Jan 2020 00:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79E0207FF
	for <linux-media@archiver.kernel.org>; Tue, 14 Jan 2020 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578962014;
	bh=w6b7zxtaX1JNVVh331GpaaL1Tljp48nC2gXOjBChnjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v76OJaqcuEMkSJ4Zjl6s7Ayc3jLOFI9/6B5g517J7KJ9/LLHd2lUsLEhK+ULFdc0O
	 tX78PoIIcl4t83LZK6vUiU11vRtNZT4DxEe1vNbt1eWK8DgyFV7/NhVi0xAH9DW8/t
	 YGRQLwn/MM8A6xC39oYfLFcluuScYnfUtax/N1hE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgANAde (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:33:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40032 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgANAdd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Jan 2020 19:33:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id c77so10171897oib.7
        for <linux-media@vger.kernel.org>; Mon, 13 Jan 2020 16:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXJN2b85yGTyfLCLDYBimi22Hg8WM/nHD10wRzYfTm4=;
        b=o8ClfA1Qic1lTju1HcObpg2mlyFITFOItpQt3Pyz3QW83KcsYHFIaCUGQBWKYL7Ma3
         crP4YUshOkP+ht2xfWg3ZNtoKRZxiVaTt6jV+2WezxzLFXZbdmgfgjQnofcADw2nDdsV
         HDuWajInq/1bkvpmF9H8d/dsnDoHHZAd0TZo6OpmOW9XAo1PPDrrV0HqTFVHUFfYjqx0
         /3x5IisoK4pW3kb4UBXmtXzX9+I0mwdEWv7cj6nHMtGcegTKGi0OJsT7ignUXGHEM44m
         cCQxy+VhrE1y9Vmh8sm6wsPkD3/ithMNrwJkpLOO5/MXiKviMpZBZxEjOwPs/hRjODks
         E5HA==
X-Gm-Message-State: APjAAAUq9lfM6vSNsrHBHps0qdMN7C6RffNX202hB/ImQZjPIUetRf0k
        9D93+L3jySqcqRsQL1wYvX5F7ns=
X-Google-Smtp-Source: APXvYqyVgT4QKyDkM2aqdz2Govt798PD5ql2F9CRjZecqBGCbMlQ70aGZg7IIc12kyW8UukgaCwJxQ==
X-Received: by 2002:aca:be57:: with SMTP id o84mr15096438oif.138.1578962013434;
        Mon, 13 Jan 2020 16:33:33 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p24sm4758224oth.28.2020.01.13.16.33.32
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:33:33 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:33:32 -0600
Date:   Mon, 13 Jan 2020 18:33:32 -0600
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
Subject: Re: [PATCH v2 15/17] dt-bindings: arm: add sam9x60-ek board
Message-ID: <20200114003332.GA3401@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 10 Jan 2020 18:18:07 +0200, Claudiu Beznea wrote:
> Add documentation for SAM9X60-EK board.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
