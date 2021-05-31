Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F1FC47096
	for <linux-media@archiver.kernel.org>; Mon, 31 May 2021 23:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A2361376
	for <linux-media@archiver.kernel.org>; Mon, 31 May 2021 23:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhEaXPh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 31 May 2021 19:15:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58268 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhEaXPg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 31 May 2021 19:15:36 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 06D5088C;
        Tue,  1 Jun 2021 01:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622502834;
        bh=wQUw5VwZtT+y284T9fA+KUU/zqOWc21ZLpDIQH4/bLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcTwO4JDC+Tk9caUXapOez6Dly68vT+0hbAjwknLJeCHkRPCSACXPNJjyBnBWobcx
         zCv2olVNk/DbvA2KxQwYVLAbfEeHoKLbw7I339IEo46aszIV1rxIV9tZd1RCd7savZ
         yxu7kInJGJetEPJhnxal8Cl+VjW8joPn6mfAbWfM=
Date:   Tue, 1 Jun 2021 02:13:43 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     pavel@ucw.cz, krzysztof.kozlowski@canonical.com,
        mchehab@kernel.org, paul.kocialkowski@bootlin.com, robh@kernel.org,
        shawnx.tu@intel.com, devicetree@vger.kernel.org, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: media: document SK Hynix Hi-846 MIPI
 CSI-2 8M pixel sensor
Message-ID: <YLVtp/CWouSuEdty@pendragon.ideasonboard.com>
References: <20210531120737.168496-1-martin.kepplinger@puri.sm>
 <20210531120737.168496-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210531120737.168496-3-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Martin,

Thank you for the patch.

On Mon, May 31, 2021 at 02:07:34PM +0200, Martin Kepplinger wrote:
> Document the bindings used for the SK Hynix Hi-846 CMOS camera driver.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../bindings/media/i2c/hynix,hi846.yaml       | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> new file mode 100644
> index 000000000000..26462f6b5e69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/hynix,hi846.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SK Hynix Hi-846 1/4" 8M Pixel MIPI CSI-2 sensor
> +
> +maintainers:
> +  - Martin Kepplinger <martin.kepplinger@puri.sm>
> +
> +description: |-
> +  The Hi-846 is a raw image sensor with an MIPI CSI-2 image data
> +  interface and CCI (I2C compatible) control bus. The output format
> +  is 10bit Bayer.
> +
> +properties:
> +  compatible:
> +    const: hynix,hi846
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Reference to the mclk clock.
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +
> +  reset-gpios:
> +    description: Reference to the GPIO connected to the reset pin. Active low.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Definition of the regulator used as 1.8V digital power supply.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    additionalProperties: false

You can drop the additionalProperties, the graph schema has
unevaluatedProperties set to false already.

> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            oneOf:
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +
> +        required:
> +          - data-lanes
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - reset-gpios

I'd keep the reset-gpios property optional, in case the signal is
hardwired.

I don't have access to the sensor datasheet, so I can't provide comments
on what may be missing. With the above two issues addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +  - vdd-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        hi846: camera@20 {
> +            compatible = "hynix,hi846";
> +            reg = <0x20>;
> +            clocks = <&clk>;
> +            clock-names = "mclk";
> +            vdd-supply = <&reg_camera_pwr_en>; /* 1.8v */
> +            reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
> +
> +            port {
> +                camera_out: endpoint {
> +                    remote-endpoint = <&csi1_ep1>;
> +                    data-lanes = <1 2>;
> +                };
> +            };
> +        };
> +    };
> +
> +...

-- 
Regards,

Laurent Pinchart
