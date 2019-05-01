Return-Path: <SRS0=DGSE=TB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEA4C43219
	for <linux-media@archiver.kernel.org>; Wed,  1 May 2019 22:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BB92075E
	for <linux-media@archiver.kernel.org>; Wed,  1 May 2019 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556750716;
	bh=kGpzZQ402f0euG989lQtR2yLWWqvUbRk0UqvhfNw41I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jKeAFd0FP/uhAdUXUVLKPXowWfKtUD52+TuVVDoVFGM+y36mJkHx3Y3dFZDpovg+6
	 yruMlbuH6SXmj3L1QGKJn7TNoewDq+oVrdVCJoL5p+mC77XuHj6n06SQYNQqJNqAKs
	 xHvW3cDOmeuHfMdo4d2LpgUFxEGqmE1d8LgeB1gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfEAWpP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 1 May 2019 18:45:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40902 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEAWpP (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 1 May 2019 18:45:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id w6so379957otl.7;
        Wed, 01 May 2019 15:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b4eTdXWrNh3DXxF20Y/xFu+EwX4anaVGTC9t/+J/+Ag=;
        b=mzlWIHz6kQ1fcbhhf1MuI1972wKcFJzu/wlxm76ZqqCtHDXyHPZggFI0mnYoqAxYMw
         0CoHHdzXo8Nvoc9m6kJdQgceXqv9xPBFqboW3K2eIRGYCz/DwfDYBsNdwWF7tk5NpBFx
         wFOHX0a2BHYEfwSRe7REis/+aWc79qd3Aro9bcFpyv3jXrlFS27SfG2876uBwvoQ/zB0
         cNZYXZRUlmzPVuzk+QPbjNlJRntX+Sv/+ed/YjWWVlnpHFEfo5xeLI2U9upbC4ve2atk
         cNxUZaDNFjhfMtNKxDI3u2NecDQECV5ecX9Lb0nZIiQYNl32HLqj5Bdu/Zi2x9kptnKK
         i2kw==
X-Gm-Message-State: APjAAAXu1BolCLGHa40dHZBVWE63Q0j+Ysl0EMTFog6KaXf7hEaC+n5o
        ZoIxJvft5hRx9f4L75oWqg==
X-Google-Smtp-Source: APXvYqx5w+AQiMs8ivRbF7xmZwHoV0ksJWr+KP9nlrArRn0R40gUkAg8crBaRaZ0pNk6tcRrvUCV1A==
X-Received: by 2002:a9d:7401:: with SMTP id n1mr329353otk.226.1556750714180;
        Wed, 01 May 2019 15:45:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w5sm10599530oib.6.2019.05.01.15.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 15:45:13 -0700 (PDT)
Date:   Wed, 1 May 2019 17:45:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jerry-ch Chen <Jerry-Ch.chen@mediatek.com>
Cc:     hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        tfiga@chromium.org, matthias.bgg@gmail.com, mchehab@kernel.org,
        yuzhao@chromium.org, zwisler@chromium.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Sean.Cheng@mediatek.com,
        sj.huang@mediatek.com, christie.yu@mediatek.com,
        holmes.chiou@mediatek.com, frederic.chen@mediatek.com,
        jungo.lin@mediatek.com, Rynn.Wu@mediatek.com,
        linux-media@vger.kernel.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, shik@chromium.org,
        suleiman@chromium.org
Subject: Re: [RFC PATCH V1 1/6] dt-bindings: mt8183: Add binding for FD
 shared memory
Message-ID: <20190501224512.GA4287@bogus>
References: <20190423104505.38778-1-Jerry-Ch.chen@mediatek.com>
 <20190423104505.38778-2-Jerry-Ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423104505.38778-2-Jerry-Ch.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Apr 23, 2019 at 06:45:00PM +0800, Jerry-ch Chen wrote:
> From: Jerry-ch Chen <jerry-ch.chen@mediatek.com>
> 
> This patch adds the binding for describing the shared memory
> used to exchange meta data between the co-processor and Face
> Detection (FD) unit of the camera system on Mediatek SoCs.
> 
> Signed-off-by: Jerry-ch Chen <jerry-ch.chen@mediatek.com>
> ---
>  .../mediatek,reserve-memory-fd_smem.txt       | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt
> new file mode 100644
> index 000000000000..52ae5071e238
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-fd_smem.txt
> @@ -0,0 +1,44 @@
> +Mediatek FD Shared Memory binding
> +
> +This binding describes the shared memory, which serves the purpose of
> +describing the shared memory region used to exchange data between Face
> +Detection hardware (FD) and co-processor in Mediatek SoCs.
> +
> +The co-processor doesn't have the iommu so we need to use the physical
> +address to access the shared buffer in the firmware.
> +
> +The Face Detection hardware (FD) can access memory through mt8183 IOMMU so
> +it can use dma address to access the memory region.
> +(See iommu/mediatek,iommu.txt for the detailed description of Mediatek IOMMU)
> +
> +
> +Required properties:
> +
> +- compatible: must be "mediatek,reserve-memory-fd_smem"
> +
> +- reg: required for static allocation (see reserved-memory.txt for
> +  the detailed usage)
> +
> +- alloc-range: required for dynamic allocation. The range must
> +  between 0x00000400 and 0x100000000 due to the co-processer's
> +  addressing limitation
> +
> +- size: required for dynamic allocation. The unit is bytes.
> +  for Face Detection Unit, you need 1 MB at least.

What's the most?

I don't think you really need reserved memory here if you don't need a 
fixed address. The size is not that big that a contiguous allocation 
shouldn't be a problem (though with IOMMU you don't even need that). 
'dma-ranges' can be used to set the kernel's dma mask and ensure a 
range below 0x10000000.

Rob
