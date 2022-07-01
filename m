Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712FDC433EF
	for <linux-media@archiver.kernel.org>; Fri,  1 Jul 2022 20:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiGAURu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiGAURp (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 1 Jul 2022 16:17:45 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6215732;
        Fri,  1 Jul 2022 13:17:44 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id k15so3294800iok.5;
        Fri, 01 Jul 2022 13:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L+J73+vdV/PGctyRmhCgIGT9iR/WXHXxzhXGHKHUvwY=;
        b=3yUT0hAin7BfWJN6lCoPk3WIkf8JJ5OpdL9jCYJYvzpkqpF52imgcCwNP1KPCsdZEK
         lqsnYZqY+3k9gd5BEEIoWwNeDPEAUMxqEh0N0Eo7WERshRhjETW7AOTLJ1xkwNg/eTAw
         PvkSqLWLObXQbxmSMP42IpOqjVZGFvsl6WAW9pAI61k8JuqMYWEPaYfXKDpdd0FFSuga
         /gUk3oSMzt7n4TwxweDSC9M8pPLVkaFXqPFyIOrDw9CX1VkkuYjrAL4csBeQUGNd9ZS+
         E+QkXz8TwZKhUZXMBrRtRnv3gkhu6YcIeyhSVSeajCV6zpmLwiabgi2PPKw0OMOaQDwV
         WzMQ==
X-Gm-Message-State: AJIora97xivKQ+FNSiAkNjB1khGuXtskTTDewMV94uYg9g+QH4Ogb534
        HtGwCoYPhm2r3Tj2Y6rAYg==
X-Google-Smtp-Source: AGRyM1sVN6vixZJkx0n3n55NBj1VVJZFB80abfEjRsMa+IerrCpMxFINUJUSe7TfvsJe3mf+nfyCmw==
X-Received: by 2002:a05:6638:380e:b0:33c:bbf7:56c0 with SMTP id i14-20020a056638380e00b0033cbbf756c0mr10243381jav.71.1656706663566;
        Fri, 01 Jul 2022 13:17:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s21-20020a6bdc15000000b0067533ab9404sm7279557ioc.16.2022.07.01.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:17:43 -0700 (PDT)
Received: (nullmailer pid 1450120 invoked by uid 1000);
        Fri, 01 Jul 2022 20:17:41 -0000
Date:   Fri, 1 Jul 2022 14:17:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 42/55] dt-bindings: media: rkisp1: Add port for
 parallel interface
Message-ID: <20220701201741.GA1450061-robh@kernel.org>
References: <20220630230713.10580-1-laurent.pinchart@ideasonboard.com>
 <20220630230713.10580-43-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630230713.10580-43-laurent.pinchart@ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 01 Jul 2022 02:07:00 +0300, Laurent Pinchart wrote:
> From: Paul Elder <paul.elder@ideasonboard.com>
> 
> The rkisp1 can take an input on the parallel interface. Add a port for
> it, and update the required field. At least one port is required, and
> both may be specified.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../bindings/media/rockchip-isp1.yaml         | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
