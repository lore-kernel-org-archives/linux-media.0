Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03E46B5;
	Sat,  8 Nov 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762614048; cv=none; b=r+3jM5N1OjEcezKMWochwovuzypJc5ad3D95lgHxUaCx3UxBIWe3HG5HZEyEApNtT9e3pDYoCad18BfYAN341pTCXnVIKDjeNxw2K6VPQBOaCPPE8kDEd2GWHweBjqXtjHhWW3zJ3ceAwbxT9jQMu78pgKEA2bjUiw6aiMa8kQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762614048; c=relaxed/simple;
	bh=rOIndJ1Wdl2UV9V5RlsJkymyLOcj1m1V4i8uqdWluyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyaxlRWG3qb4aOtEwmCv9XyhP/pgSl0hQewR0iMealjnOBgj4jK50INwmXFg41y/p6+v+9efLknJEAGgqDn9cEyBljHsXWCGnRgXEbrgLcnluYanh0QEKM8+5JpUP3uvVr66ddPjow1j6e1lFxpq+NrRhnPhpJn+x6HV00ACGQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wR0OnXwC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wR0OnXwC"
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB58A63F;
	Sat,  8 Nov 2025 15:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762613925;
	bh=rOIndJ1Wdl2UV9V5RlsJkymyLOcj1m1V4i8uqdWluyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wR0OnXwCpxCWy0xX3HRb+afNMk2+8yFwIGqQf8lnJfXfiFj/3OQOlJrOGTfdigagO
	 1J2QMVc/nH0TGjKOl/D1CJYUuSVwrGpT+lVYbrN0vxtKpuY+koSyBObY9BmIplsmnM
	 uW9VvjcDS1VdMF+ktT903FFIiwNhUUhpmVz+sF3o=
Message-ID: <64952f5f-0f3b-48c4-9304-9080f9052db6@ideasonboard.com>
Date: Sat, 8 Nov 2025 15:00:38 +0000
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/15] dt-bindings: media: Add bindings for ARM
 mali-c55
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Anthony.McGivern@arm.com,
 nayden.kanchev@arm.com, robh+dt@kernel.org, mchehab@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 jerome.forissier@linaro.org, kieran.bingham@ideasonboard.com,
 laurent.pinchart@ideasonboard.com,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20251002-c55-v12-0-3eda2dba9554@ideasonboard.com>
 <20251002-c55-v12-3-3eda2dba9554@ideasonboard.com>
 <CA+V-a8sg4c697WTS=wXoWvgc_UCFM3+Qjh1br=rMm4F84NVw-Q@mail.gmail.com>
 <8c5a4c68-8299-4d8f-96b2-8db232df70fe@ideasonboard.com>
 <uxojb4xpict6ccxpgogzavufpx63uvqfpi6vrbllyr7jf3aga5@45c7i27yv2uh>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <uxojb4xpict6ccxpgogzavufpx63uvqfpi6vrbllyr7jf3aga5@45c7i27yv2uh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Afternoon Jacopo and Prabhakar

@Jacopo you asked below if I'd missed some questions from Prabhakar - I did! Thanks for pointing 
that out, no idea how I missed them

On 08/11/2025 13:14, Jacopo Mondi wrote:
> Hi Dan
> 
> On Mon, Nov 03, 2025 at 04:17:24PM +0000, Dan Scally wrote:
>> Hi Prabhakar
>>
>> On 28/10/2025 18:23, Lad, Prabhakar wrote:
>>> Hi Daniel,
>>>
>>> Thank you for the patch.
>>>
>>> On Thu, Oct 2, 2025 at 11:19 AM Daniel Scally
>>> <dan.scally@ideasonboard.com> wrote:
>>>>
>>>> Add the yaml binding for ARM's Mali-C55 Image Signal Processor.
>>>>
>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Acked-by: Nayden Kanchev <nayden.kanchev@arm.com>
>>>> Co-developed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>>>> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>>>> Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
>>>> ---
>>>> Changes in v12:
>>>>
>>>>           - _Actually_ dropped the arm,inline property mode, having forgotten to
>>>>             do so in v11.
>>>>
>>>> Changes in v11:
>>>>
>>>>           - Dropped in arm,inline_mode property. This is now identical to the
>>>>             reviewed version 8, so I have kept the tags on there.
>>>>
>>>> Changes in v10:
>>>>
>>>>           - None
>>>>
>>>> Changes in v9:
>>>>
>>>>           - Added the arm,inline_mode property to differentiate between inline and
>>>>             memory input configurations
>>>>
>>>> Changes in v8:
>>>>
>>>>           - Added the video clock back in. Now that we have actual hardware it's
>>>>             clear that it's necessary.
>>>>           - Added reset lines
>>>>           - Dropped R-bs
>>>>
>>>> Changes in v7:
>>>>
>>>>           - None
>>>>
>>>> Changes in v6:
>>>>
>>>>           - None
>>>>
>>>> Changes in v5:
>>>>
>>>>           - None
>>>>
>>>> Changes in v4:
>>>>
>>>>           - Switched to port instead of ports
>>>>
>>>> Changes in v3:
>>>>
>>>>           - Dropped the video clock as suggested by Laurent. I didn't retain it
>>>>           for the purposes of the refcount since this driver will call .s_stream()
>>>>           for the sensor driver which will refcount the clock anyway.
>>>>           - Clarified that the port is a parallel input port rather (Sakari)
>>>>
>>>> Changes in v2:
>>>>
>>>>           - Added clocks information
>>>>           - Fixed the warnings raised by Rob
>>>> ---
>>>>    .../devicetree/bindings/media/arm,mali-c55.yaml    | 82 ++++++++++++++++++++++
>>>>    1 file changed, 82 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/media/arm,mali-c55.yaml b/Documentation/devicetree/bindings/media/arm,mali-c55.yaml
>>>> new file mode 100644
>>>> index 0000000000000000000000000000000000000000..efc88fd2c447e98dd82a1fc1bae234147eb967a8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/media/arm,mali-c55.yaml
>>>> @@ -0,0 +1,82 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/media/arm,mali-c55.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: ARM Mali-C55 Image Signal Processor
>>>> +
>>>> +maintainers:
>>>> +  - Daniel Scally <dan.scally@ideasonboard.com>
>>>> +  - Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: arm,mali-c55
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: ISP Video Clock
>>>> +      - description: ISP AXI clock
>>>> +      - description: ISP AHB-lite clock
>>> As per RZ/V2H HW manual we have reg clock looking at the driver code
>>> it does have readl. IVC has reg clock if IVC driver fails are you
>>> still able to read/write regs from ISP driver?
>>>
>>> I think we do need to pass reg clock too.
>>
>> Yes - but I should clarify that the names are from the arm documentation
>> that we had when we originally developed the ISP driver. The RZ/V2H
>> documentation treats the ISP and IVC as one block that shares 4 clocks and
>> resets, but when we originally developed the ISP driver the platform we used
>> had the ISP implemented as an inline configuration (taking data directly
>> from a csi-2 receiver without an IVC equivalent), and the documentation
>> detailed just the three clocks and resets. The dtsi changes for the
>> RZ/V2H(P) [1] assign clocks 226, 228 and 229 to the ISP which are named
>> reg_aclk, vin_aclk and isp_sclk in the renesas documentation.
>>
>> The IVC gets pclk, vin_aclk and isp_sclk.
>>
>> [1] https://lore.kernel.org/linux-renesas-soc/20251010-kakip_dts-v1-1-64f798ad43c9@ideasonboard.com/
>>
>>> Also for IVC we do have a main clock (which is a system clock).  Can
>>> you please educate me on what is the purpose of it. Just curious as we
>>> pass to IVC and not ISP.
>>
>> The IVC uniquely gets the one called "pclk" in renesas documentation, with
>> the description "Input Video Control block register access APB clock".
>>
>> Thanks
>> Dan
>>
>>>
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: vclk
>>>> +      - const: aclk
>>>> +      - const: hclk
>>> Not sure if we want to have the same names as IVC or vice versa.

I'll respond to this in the other thread to keep naming discussions all in one place

 >>>>>>> +
>>>> +  resets:
>>>> +    items:
>>>> +      - description: vclk domain reset
>>>> +      - description: aclk domain reset
>>>> +      - description: hclk domain reset
>>> Same query here, wrt register reset.
>>>
>>>> +
>>>> +  reset-names:
>>>> +    items:
>>>> +      - const: vresetn
>>>> +      - const: aresetn
>>>> +      - const: hresetn
>>> ditto naming.
>>>
>>>> +
>>>> +  port:
>>>> +    $ref: /schemas/graph.yaml#/properties/port
>>>> +    description: Input parallel video bus
>>>> +
>>>> +    properties:
>>>> +      endpoint:
>>>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - interrupts
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - port
>>> maybe also resets and rest-names should be part of required properties?
>>>
> 
> Have you missed this question from Prabhakar ? What do you think ?
Oops, yes I missed it, and yes I agree, I'll add them.>
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    mali_c55: isp@400000 {
>>> we could drop `mali_c55`
>>>
> 
> I think we should

Works for me

> 
>>>> +      compatible = "arm,mali-c55";
>>>> +      reg = <0x400000 0x200000>;
>>>> +      clocks = <&clk 0>, <&clk 1>, <&clk 2>;
>>>> +      clock-names = "vclk", "aclk", "hclk";
>>>> +      resets = <&resets 0>, <&resets 1>, <&resets 2>;
>>>> +      reset-names = "vresetn", "aresetn", "hresetn";
>>>> +      interrupts = <0>;
>>> I would have a non-zero val here.
> 
> With the right include you could even use the actual value from the
> dts:
>                  interrupts = <GIC_SPI 859 IRQ_TYPE_LEVEL_HIGH>;

Works for me

> 
> Please make sure to run dt_bindings_check if you do so
> 
> With a few questions clarified, if you resend and drop the label here
> (you can even resend this single patch as v12.1 if it's more
> convenient)

I'm told that that works poorly with the tooling, but I can re-submit the series as a whole - I was 
just waiting for the v4l2-isp to firm up in case that necessitated any changes.

I think this driver should be collected for v6.19.

That would be nice!
> (Do you plan a v6 of the IVC with the small comments from Prabhakar
> addressed ? Ideally we want it to get in at the same time)

Also yes, I can do both early this week

Dan

> Thanks
>    j
> 
>>>
>>> Cheers,
>>> Prabhakar
>>>
>>>> +
>>>> +      port {
>>>> +        isp_in: endpoint {
>>>> +            remote-endpoint = <&csi2_rx_out>;
>>>> +        };
>>>> +      };
>>>> +    };
>>>> +...
>>>>
>>>> --
>>>> 2.43.0
>>>>
>>>>
>>
>>

