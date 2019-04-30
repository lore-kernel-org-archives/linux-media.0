Return-Path: <SRS0=ibS4=TA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE7C43219
	for <linux-media@archiver.kernel.org>; Tue, 30 Apr 2019 01:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D372147A
	for <linux-media@archiver.kernel.org>; Tue, 30 Apr 2019 01:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556586982;
	bh=ACeAsSW2vZW4le9vdO1FtYREbkdPZuX6+943hx3wgZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IJKVpfhvKMz9gtr/s7CmKzVVmv9+6NsatA6eFT+9gB4kbfkEyFmHpNF8blA+FXbZo
	 zx8+lITgH0o+pbhXyrMXxWAITqBmSOYpKWFbOLFc5z1Kg0tuWXfnrqEdPuoOIOEnmI
	 9iksArkFD7yGGlAptDZdEf0kegInSnbH7tKP+jps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfD3BQV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:16:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43049 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbfD3BQV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 29 Apr 2019 21:16:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so10425227otq.10;
        Mon, 29 Apr 2019 18:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SQZxWQDZW8/QOAQDuwFNwl//qikn1cHVqQ6ue/TM68k=;
        b=l+ArXMZi2Lu82FEyXXDdcwQ3jx7dNKCnNAfkctvxz1NOQGdjzjhOsH9FmxRTXE8uoh
         xVipLHSUYNoEdy9DVdJ6gaA0/t4RV0oHR+s10uJShnbXxsCdqCgWjiEwrx/zIn3gVFpI
         U491Nofj2Wi2Mut70kdk6ozkpyo4P/oItkzm2ke1FXAe3EIsjhn5BKHl53vz/qQj3PwU
         eSy7jAYRYc+io20qeYyAggiXeeVrvPN3w0CwvanGlYSqawEwopQdrdsvMhpwyohNYJGP
         405BCLE/oY2dFtY5PStq2Tg1oQtRk3EX7ACmBvlN7rt0D5jd7EaAUecDn08mPT5YWkh+
         03jg==
X-Gm-Message-State: APjAAAUEEYhexd+PIbldO2qB/owkZfnzRFqtvXf4yFdzqkJWeJI2Bm/q
        N+ROgfUur+VBEd1Mo39e0Q==
X-Google-Smtp-Source: APXvYqxSqUjuRyMgW1bUn+uBZ/b9Nz+CnOlelgEI3LlYald3OCQLZm1tFowOlbDv5zDh0+v4cWxXUg==
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr89131otp.234.1556586980916;
        Mon, 29 Apr 2019 18:16:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h23sm16727340oic.10.2019.04.29.18.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 18:16:20 -0700 (PDT)
Date:   Mon, 29 Apr 2019 20:16:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frederic Chen <frederic.chen@mediatek.com>
Cc:     hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        tfiga@chromium.org, matthias.bgg@gmail.com, mchehab@kernel.org,
        yuzhao@chromium.org, zwisler@chromium.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Sean.Cheng@mediatek.com,
        sj.huang@mediatek.com, christie.yu@mediatek.com,
        holmes.chiou@mediatek.com, Jerry-ch.Chen@mediatek.com,
        jungo.lin@mediatek.com, Rynn.Wu@mediatek.com,
        linux-media@vger.kernel.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, shik@chromium.org,
        suleiman@chromium.org
Subject: Re: [RFC PATCH V1 3/6] dt-bindings: mt8183: Added DIP dt-bindings
Message-ID: <20190430011619.GA22170@bogus>
References: <20190417104511.21514-1-frederic.chen@mediatek.com>
 <20190417104511.21514-4-frederic.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417104511.21514-4-frederic.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Apr 17, 2019 at 06:45:08PM +0800, Frederic Chen wrote:
> This patch adds DT binding documentation for the Digital Image
> Processing (DIP) unit of camera ISP system on Mediatek's SoCs.
> 
> Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
> ---
>  .../bindings/media/mediatek,mt8183-dip.txt    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8183-dip.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8183-dip.txt b/Documentation/devicetree/bindings/media/mediatek,mt8183-dip.txt
> new file mode 100644
> index 000000000000..0e1994bf82f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8183-dip.txt
> @@ -0,0 +1,35 @@
> +* Mediatek Digital Image Processor (DIP)
> +
> +Digital Image Processor (DIP) unit in Mediatek ISP system is responsible for
> +image content adjustment according to the tuning parameters. DIP can process
> +the image form memory buffer and output the processed image to multiple output
> +buffers. Furthermore, it can support demosaicing and noise reduction on the
> +images.
> +
> +Required properties:
> +- compatible: "mediatek,mt8183-dip"
> +- reg: Physical base address and length of the function block register space
> +- interrupts: interrupt number to the cpu
> +- iommus: should point to the respective IOMMU block with master port as
> +  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> +  for details.
> +- mediatek,larb: must contain the local arbiters in the current Socs, see
> +  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> +  for details.
> +- clocks: must contain the local arbiters 5 (LARB5) and DIP clock
> +- clock-names: must contain DIP_CG_IMG_LARB5 and DIP_CG_IMG_DIP
> +
> +Example:
> +	dip: dip@15022000 {
> +		compatible = "mediatek,mt8183-dip";
> +		mediatek,larb = <&larb5>;

> +		mediatek,mdp3 = <&mdp_rdma0>;
> +		mediatek,vpu = <&vpu>;

Not documented.

> +		iommus = <&iommu M4U_PORT_CAM_IMGI>;
> +		reg = <0 0x15022000 0 0x6000>;
> +		interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&imgsys CLK_IMG_LARB5>,
> +			 <&imgsys CLK_IMG_DIP>;
> +		clock-names = "DIP_CG_IMG_LARB5",
> +			      "DIP_CG_IMG_DIP";
> +	};
> -- 
> 2.18.0
> 
