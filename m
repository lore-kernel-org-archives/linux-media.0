Return-Path: <SRS0=lOn+=T7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C82BC04AB6
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 16:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCBC26BD7
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 16:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEaQRE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 31 May 2019 12:17:04 -0400
Received: from retiisi.org.uk ([95.216.213.190]:50500 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfEaQRE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 31 May 2019 12:17:04 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id ABA8A634C7B;
        Fri, 31 May 2019 19:16:58 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1hWkDC-0000Lt-QG; Fri, 31 May 2019 19:16:58 +0300
Date:   Fri, 31 May 2019 19:16:58 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     dongchun.zhu@mediatek.com
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, bingbu.cao@intel.com,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, sj.huang@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        louis.kuo@mediatek.com, menghui.lin@mediatek.com,
        shengnan.wang@mediatek.com
Subject: Re: [PATCH 3/3] media: dt-bindings: media: i2c: Add bindings for
 ov02a10
Message-ID: <20190531161658.2y2amfngbhfbllj7@valkosipuli.retiisi.org.uk>
References: <20190523102204.24112-1-dongchun.zhu@mediatek.com>
 <20190523102204.24112-4-dongchun.zhu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523102204.24112-4-dongchun.zhu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dongchun,

Thanks for the patch.

On Thu, May 23, 2019 at 06:22:04PM +0800, dongchun.zhu@mediatek.com wrote:
> From: Dongchun Zhu <dongchun.zhu@mediatek.com>
> 
> Add device tree binding documentation for the OV02A10 CMOS image sensor.
> 
> Signed-off-by: Dongchun Zhu <dongchun.zhu@mediatek.com>
> ---
>  .../devicetree/bindings/media/i2c/ov02a10.txt      | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ov02a10.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov02a10.txt b/Documentation/devicetree/bindings/media/i2c/ov02a10.txt
> new file mode 100644
> index 0000000..fdc2904
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ov02a10.txt
> @@ -0,0 +1,43 @@
> +* Omnivision OV02A10 MIPI CSI-2 sensor
> +
> +Required Properties:
> +- compatible: shall be "ovti,ov02a10"
> +- clocks: reference to the xvclk input clock
> +- clock-names: shall be "xvclk"
> +- avdd-supply: Analog voltage supply, 2.8 volts
> +- dovdd-supply: Digital I/O voltage supply, 1.8 volts
> +- dvdd-supply: Digital core voltage supply, 1.8 volts
> +- reset-gpios: Low active reset gpio
> +
> +The device node shall contain one 'port' child node with an
> +'endpoint' subnode for its digital output video port,
> +in accordance with the video interface bindings defined in
> +Documentation/devicetree/bindings/media/video-interfaces.txt.
> +The endpoint optional property 'data-lanes' shall be "<1>".

If the sensor only supports a single lane configuration (one lane), you can
omit that property altogether. Is that the only possible configuration for
the sensor?

Please also wrap the text at 80 characters, not 65 or so.

> +
> +Example:
> +&i2c4 {
> +	sensor_sub: sensor_sub {

camera-sensor@3d {

> +		compatible = "ovti,ov02a10";
> +		reg = <0x3d>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&camera_pins_cam1_mclk_on>;
> +
> +		clocks = <&topckgen CLK_TOP_MUX_CAMTG2>,
> +			<&topckgen CLK_TOP_UNIVP_192M_D8>;
> +		clock-names = "xvclk", "freq_mux";
> +
> +		avdd-supply = <&mt6358_vcama1_reg>;
> +		dvdd-supply = <&mt6358_vcn18_reg>;
> +		dovdd-supply = <&mt6358_vcamio_reg>;
> +		pwdn-gpios = <&pio 107 1>;
> +		reset-gpios = <&pio 109 1>;
> +
> +		port@0 {
> +		   ov02a10_core: endpoint {
> +		       remote-endpoint = <&ov02a10_0>;
> +			   data-lanes = <1>;
> +		   };

Tabs for indentation, please.

> +		};
> +	};
> +};

-- 
Kind regards,

Sakari Ailus
