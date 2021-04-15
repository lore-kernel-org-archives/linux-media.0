Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CFC433B4
	for <linux-media@archiver.kernel.org>; Thu, 15 Apr 2021 20:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DA360E0C
	for <linux-media@archiver.kernel.org>; Thu, 15 Apr 2021 20:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhDOUhq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:37:46 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42903 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbhDOUhq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 15 Apr 2021 16:37:46 -0400
Received: by mail-oi1-f177.google.com with SMTP id n140so25591982oig.9;
        Thu, 15 Apr 2021 13:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ohiEbSgaFrM/ICsd6CedVVm17ut2y+hUZeHNOcTvM1I=;
        b=phBBMSyP6trg3M2gWf4qxgwkDxvRxaYOhnCscinYoWc7J1dLxpE8C6AsmqYtOBS9W9
         /Hvfd4fsvlPRcf4TQg0BWx0S1g5clNYEqYtuSAI7EKarLv3K48jkcm2c2hPiMfHr7esg
         0Hrct/lEwQgk68vqCWdW/nc1N+mOiy4cn/qnYE46O+vGYaroryKVdYchyPCX+NFnod40
         3W133+ohxzCJvhWEarNg3TaNhd/3NxdsdFTCJUFMpHL9hGt+GOeGq7kic1CRx1KnGbYV
         vWiPuM4ZAQAUmg9vYpg/DM2iRCF58ZECDACOUOvFKqK9oVWJvlXGgPnlONZ9/LUyywJV
         nyGg==
X-Gm-Message-State: AOAM530mWTRIzYTcsavu3cGVvkQhJIgi3McLp6gaO2e4rLjEOaeIGKcA
        LSVgi8vWeSE5dmse/p3o3A==
X-Google-Smtp-Source: ABdhPJzFHiPKVOh2fbJf8yK1iNazrCGGStLTahbzD+gt4N9J8esCtmWsD4vjGwt4xiQGfHNgLchRCg==
X-Received: by 2002:aca:ab44:: with SMTP id u65mr3811548oie.173.1618519042754;
        Thu, 15 Apr 2021 13:37:22 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o10sm887962ote.5.2021.04.15.13.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:37:21 -0700 (PDT)
Received: (nullmailer pid 1841581 invoked by uid 1000);
        Thu, 15 Apr 2021 20:37:20 -0000
Date:   Thu, 15 Apr 2021 15:37:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     krzk@kernel.org, linux-kernel@vger.kernel.org, mchehab@kernel.org,
        linux@rempel-privat.de, festevam@gmail.com, shawnguo@kernel.org,
        arnd@arndb.de, matthias.schiffer@ew.tq-group.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org, leoyang.li@nxp.com,
        s.hauer@pengutronix.de, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        olof@lixom.net, prabhakar.csengg@gmail.com, linux-imx@nxp.com,
        s.riedmueller@phytec.de, krzysztof.kozlowski@canonical.com
Subject: Re: [PATCH v3 1/4] dt-bindings: add dasheng vendor prefix
Message-ID: <20210415203720.GA1841552@robh.at.kernel.org>
References: <1618459535-8141-1-git-send-email-dillon.minfei@gmail.com>
 <1618459535-8141-2-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618459535-8141-2-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 15 Apr 2021 12:05:32 +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Add vendor prefix for DaSheng, Inc.
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> v3:
> - move v2 patch 4 to v3 patch 1
> - add 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>'
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
