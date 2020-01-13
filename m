Return-Path: <SRS0=VeA5=3C=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF50C33CA9
	for <linux-media@archiver.kernel.org>; Mon, 13 Jan 2020 23:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6187A2080D
	for <linux-media@archiver.kernel.org>; Mon, 13 Jan 2020 23:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578959108;
	bh=ekpsGuHx8XGU6flbs8e8D7XDFTMebDIjmH8ohTnK4Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IMgjAzdz3EvLYC6/oblwKw9SAo/q0WFpU17P7cmd2j/YhJPQA6D45TSWmm6SjQFUW
	 lIla94FQW8MjVJoMF36rE+dQ/KUQlDJFYbH3NYUGw98u6X8+h5aEhTvNx5ia7e8GaV
	 YTHQG/FlScoLuGwJ1tXActw926eJDQQlRrU+Kfrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgAMXpH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:45:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46033 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgAMXpG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Jan 2020 18:45:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so10065853oie.12
        for <linux-media@vger.kernel.org>; Mon, 13 Jan 2020 15:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyL/JS9B7rUgj8Iql4HM1FyxI7CsxZnIzSDjO8scpzY=;
        b=QMVVGt1RDylyz7XPBeMkHueOV1t9eFBzce4VNHDTCVGw+jOBCBoYiCAAsXGClU+4XG
         huAlDZUplIgHrG6VCAs7VKNPd1AfI8w49teGYpXiD8T9HP6ZQyJCr/ublGnMOc4boFV5
         FJeIU9Et0WGyoGigq50BEhSQOsXzam0z6TGseegg/JYOABhuKE/96OzIfkkJamPqk2pw
         DCBE9y2EA1UAViJZAdAgnhVqsUySlNIoKNUThIPbJ4N2UE6TlhPv1+u1hWB/ng3tJnHq
         XbvGpq8GSFBVERDxnyyay0JKkEBDRdS/s0CQBufw+ycgEkDla2Iy9iXpMfxyR0vs0fa4
         Hgvg==
X-Gm-Message-State: APjAAAX7uJ1jHSQ6eSLoOkV7rcDOOOyAhiNarQC+B7cwXlnqC/Nvi8CA
        zqI+xDNpUpSyN2T6RBEdcBcv9bj4Vg==
X-Google-Smtp-Source: APXvYqy44QQF4qhImUGb2gnf2ZcfA6S0OS9KBBd3PTKAjfJ41HLXDIgxZjOPJiuzhm/RY/+4KE3hVw==
X-Received: by 2002:aca:e106:: with SMTP id y6mr15074215oig.131.1578959105307;
        Mon, 13 Jan 2020 15:45:05 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n22sm4773730otj.36.2020.01.13.15.45.04
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:45:05 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a32
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:23:23 -0600
Date:   Mon, 13 Jan 2020 17:23:23 -0600
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
Subject: Re: [PATCH v2 03/17] dt-bindings: atmel-can: add
 microchip,sam9x60-can
Message-ID: <20200113232323.GA31125@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 10 Jan 2020 18:17:55 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-can to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/can/atmel-can.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
