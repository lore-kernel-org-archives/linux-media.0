Return-Path: <SRS0=nxNx=DG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE4C4727C
	for <linux-media@archiver.kernel.org>; Tue, 29 Sep 2020 20:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253AB2076A
	for <linux-media@archiver.kernel.org>; Tue, 29 Sep 2020 20:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601410181;
	bh=2STnF9yRqUw/eX3gJ0OWAVffksY/LuIwI4RIEzbqSQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qbAMPk5fQPmv2+cf6LJ7gfiaGZh8igqDUwNea+fHUHoyRR5pffNCJtWV25ujZds6M
	 bnD0K4i2TEQoigexkiO8GGCCgZHE9bcDT8W3hb+FmFtjsw09FsnrD29b/uPXAehGZy
	 NwmY6dbn4ZjPTwUyZ85PkL56mrt8Tcez8h2XiQos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgI2UJi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:09:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33670 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgI2UJi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 29 Sep 2020 16:09:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id m12so5764835otr.0;
        Tue, 29 Sep 2020 13:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X9aOhCfi/B0xKU7dFMYaHxapvSEYg4wg92gtMCjdiuc=;
        b=krU0jnhhuRXccprCk4kTMEQSLXlk3PPsubLiP7l/5phcIlQ1ek/JjNSALnb7Jmu15j
         hZciV5V56RHFTMoGofqPq88k1s6RSg7UYa9TnAtiKZEJ3dkh0eR1q8cxfUUu1PqZS4E4
         CHtSu8pkSi0vPPbFhgzhVJIEr8J5TwnHJRTbxDs5l5u2xAWR4JWXvm3/dQAf9GTK7aXY
         K26xv3TymCG8saU6sxnThIypyXqoeVaQsOtkHynptfioKZk/aqLFDo3RKXcSxOA5JonE
         zdIDjbS+4RRm6UEixAcUiRu8dhodoljxh/LZQVqPA+OUj7xPIQzNCuSHxTZpcaWGsQ2U
         kTog==
X-Gm-Message-State: AOAM531HMjErdwBoFXES2ObKWBo53PkowrpJQpCsm4YzaONOtfihPzgA
        utp//39Msk+wjPZyF0om9w==
X-Google-Smtp-Source: ABdhPJzp8TFuyuQd5hO7MbiTMambrzGZvIEVSIVQ3GM76JDqG28K8jX4ZtTpslQS3ksa/Cw6876jxA==
X-Received: by 2002:a9d:50a:: with SMTP id 10mr3786384otw.207.1601410177211;
        Tue, 29 Sep 2020 13:09:37 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q81sm1225520oia.46.2020.09.29.13.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:09:36 -0700 (PDT)
Received: (nullmailer pid 1080265 invoked by uid 1000);
        Tue, 29 Sep 2020 20:09:35 -0000
Date:   Tue, 29 Sep 2020 15:09:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: media: Add bindings for the Amlogic
 GE2D Accelerator Unit
Message-ID: <20200929200935.GA1078747@bogus>
References: <20200928161411.323581-1-narmstrong@baylibre.com>
 <20200928161411.323581-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928161411.323581-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 28 Sep 2020 18:14:08 +0200, Neil Armstrong wrote:
> The GE2D is a 2D accelerator with various features like configurable blitter
> with alpha blending, frame rotation, scaling, format conversion and colorspace
> conversion.
> 
> This adds the bindings for the GE2D version found in the AXG SoCs Family.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/media/amlogic,axg-ge2d.yaml      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
