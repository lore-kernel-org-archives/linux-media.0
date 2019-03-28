Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A16C4360F
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 08:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCDE217D7
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 08:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfC1I70 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:59:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37949 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1I70 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 04:59:26 -0400
Received: from litschi.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe6a:8db5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1h9Qse-0001XT-CC; Thu, 28 Mar 2019 09:59:24 +0100
Date:   Thu, 28 Mar 2019 09:59:22 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, robh+dt@kernel.org, mchehab@kernel.org,
        tfiga@chromium.org, dshah@xilinx.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] media: dt-bindings: media: document allegro-dvt
 bindings
Message-ID: <20190328095922.6602559b@litschi.hi.pengutronix.de>
In-Reply-To: <e61aebce-8be4-7f6a-6d9b-69c5e4db14d2@xs4all.nl>
References: <20190301152718.23134-1-m.tretter@pengutronix.de>
        <20190301152718.23134-2-m.tretter@pengutronix.de>
        <e61aebce-8be4-7f6a-6d9b-69c5e4db14d2@xs4all.nl>
Organization: Pengutronix
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:feaa:14ff:fe6a:8db5
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 27 Mar 2019 13:57:10 +0100, Hans Verkuil wrote:
> On 3/1/19 4:27 PM, Michael Tretter wrote:
> > Add device-tree bindings for the Allegro DVT video IP core found on the
> > Xilinx ZynqMP EV family.
> > 
> > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > v3 -> v4:
> > none
> > 
> > v2 -> v3:
> > - rename node to video-codec
> > - drop interrupt-names
> > - fix compatible in example
> > - add clocks to required properties
> > 
> > v1 -> v2:
> > none
> > ---
> >  .../devicetree/bindings/media/allegro.txt     | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/allegro.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/allegro.txt b/Documentation/devicetree/bindings/media/allegro.txt
> > new file mode 100644
> > index 000000000000..a92e2fbf26c9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/allegro.txt
> > @@ -0,0 +1,43 @@
> > +Device-tree bindings for the Allegro DVT video IP codecs present in the Xilinx
> > +ZynqMP SoC. The IP core may either be a H.264/H.265 encoder or H.264/H.265
> > +decoder ip core.
> > +
> > +Each actual codec engines is controlled by a microcontroller (MCU). Host
> > +software uses a provided mailbox interface to communicate with the MCU. The
> > +MCU share an interrupt.
> > +
> > +Required properties:
> > +  - compatible: value should be one of the following
> > +    "allegro,al5e-1.1", "allegro,al5e": encoder IP core
> > +    "allegro,al5d-1.1", "allegro,al5d": decoder IP core  
> 
> checkpatch give me:
> 
> WARNING: DT compatible string vendor "allegro" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.txt
> #2714: FILE: drivers/staging/media/allegro-dvt/allegro-core.c:2636:
> +       { .compatible = "allegro,al5e-1.1" },
> 
> I think you should probably replace allegro by xlnx.

The video-codec and the firmware is actually Allegro IP. Xilinx
integrated the IP cores into the SoC with their "VCU System-Level
Control" module, which uses the "xlnx,vcu" binding.

I would rather add "allegro" to the vendor-prefixes.txt than replacing
it with xlnx.

Michael

> 
> Regards,
> 
> 	Hans
> 
> > +  - reg: base and length of the memory mapped register region and base and
> > +    length of the memory mapped sram
> > +  - reg-names: must include "regs" and "sram"
> > +  - interrupts: shared interrupt from the MCUs to the processing system
> > +  - clocks: must contain an entry for each entry in clock-names
> > +  - clock-names: must include "core_clk", "mcu_clk", "m_axi_core_aclk",
> > +    "m_axi_mcu_aclk", "s_axi_lite_aclk"
> > +
> > +Example:
> > +	al5e: video-codec@a0009000 {
> > +		compatible = "allegro,al5e-1.1", "allegro,al5e";
> > +		reg = <0 0xa0009000 0 0x1000>,
> > +		      <0 0xa0000000 0 0x8000>;
> > +		reg-names = "regs", "sram";
> > +		interrupts = <0 96 4>;
> > +		clocks = <&xlnx_vcu 0>, <&xlnx_vcu 1>,
> > +			 <&clkc 71>, <&clkc 71>, <&clkc 71>;
> > +		clock-names = "core_clk", "mcu_clk", "m_axi_core_aclk",
> > +			      "m_axi_mcu_aclk", "s_axi_lite_aclk"
> > +	};
> > +	al5d: video-codec@a0029000 {
> > +		compatible = "allegro,al5d-1.1", "allegro,al5d";
> > +		reg = <0 0xa0029000 0 0x1000>,
> > +		      <0 0xa0020000 0 0x8000>;
> > +		reg-names = "regs", "sram";
> > +		interrupts = <0 96 4>;
> > +		clocks = <&xlnx_vcu 2>, <&xlnx_vcu 3>,
> > +			 <&clkc 71>, <&clkc 71>, <&clkc 71>;
> > +		clock-names = "core_clk", "mcu_clk", "m_axi_core_aclk",
> > +			      "m_axi_mcu_aclk", "s_axi_lite_aclk"
> > +	};
> >   
> 
> 
