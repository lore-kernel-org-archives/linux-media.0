Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440310F1;
	Sat,  8 Nov 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762614974; cv=none; b=EnLLBvxCIbEp8m+mN649m/AJlulHjRZLvgb8tRCYNhAkmkT/iUOJF+7XQtTZO6pkcn6KlINVRQxAYoIr9mEanyjogYpZg5Z5mPJimCWQF7UWcCa3MA9ERrPyxceNlPtyGzHu2i2nVWUxorq7YEiRPx+gb9mOkzlj9MSuUGrhlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762614974; c=relaxed/simple;
	bh=3qjL7RCdBSO1FNRsQ4bSgdzjhQnDKxvb9nUhhd5pNvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKzj9E4OIrnv/0MiE10URgqovUBELWTF34vW1NGr/DVyOI/t5SNOj9BVbXFXopHHcjcCUs0v14SoFC8EmxLadpVI/dVOUgjBSOAmS2WI21Szx5nM8QvQfO8QGkTVt/IHhl/q2B8JH2r/QEdUb0HFyIQeT6FBDW89jjj/lcUJ2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PqHMAxcW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PqHMAxcW"
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id ACE8ADD9;
	Sat,  8 Nov 2025 16:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762614852;
	bh=3qjL7RCdBSO1FNRsQ4bSgdzjhQnDKxvb9nUhhd5pNvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PqHMAxcWSZxJKrfD9cbo5g0/XyiJdb0yD5qOcYcs/Mjtsb/95Ji9lLTjrtbglHIaL
	 cSwDqSy/E7Nl/tVG4OLvwNKwP94wMG7RB2SeVawdmXUYPih4jWK1jotzU3XyzboHYG
	 EwRhvkonof8JsrpXurRvEAhkuMcNLuzU1lQ3L6QE=
Message-ID: <37015806-bf91-4e31-9550-50d17062b1e4@ideasonboard.com>
Date: Sat, 8 Nov 2025 15:16:05 +0000
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
 <CA+V-a8vey1y0QAxk7vYNHzPHrOrQ4uTpjf4LCb9wSRRCT3v3Qg@mail.gmail.com>
 <pwnwqoghzznwp5faozxhsjzfd6qx3xeqvwcmk4zpkcgmmbtetu@vafr5viwhizp>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <pwnwqoghzznwp5faozxhsjzfd6qx3xeqvwcmk4zpkcgmmbtetu@vafr5viwhizp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jacopo, Prabhakar

On 08/11/2025 13:07, Jacopo Mondi wrote:
> Hi
> 
> On Wed, Nov 05, 2025 at 01:35:59PM +0000, Lad, Prabhakar wrote:
>> Hi Dan,
>>
>> On Mon, Nov 3, 2025 at 4:17 PM Dan Scally <dan.scally@ideasonboard.com> wrote:
>>>
>>> Hi Prabhakar
>>>
>>> On 28/10/2025 18:23, Lad, Prabhakar wrote:
>>>> Hi Daniel,
>>>>
>>>> Thank you for the patch.
>>>>
>>>> On Thu, Oct 2, 2025 at 11:19 AM Daniel Scally
>>>> <dan.scally@ideasonboard.com> wrote:
>>>>>
>>>>> Add the yaml binding for ARM's Mali-C55 Image Signal Processor.
>>>>>
>>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> Acked-by: Nayden Kanchev <nayden.kanchev@arm.com>
>>>>> Co-developed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>>>>> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>>>>> Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
>>>>> ---
>>>>> Changes in v12:
>>>>>
>>>>>           - _Actually_ dropped the arm,inline property mode, having forgotten to
>>>>>             do so in v11.
>>>>>
>>>>> Changes in v11:
>>>>>
>>>>>           - Dropped in arm,inline_mode property. This is now identical to the
>>>>>             reviewed version 8, so I have kept the tags on there.
>>>>>
>>>>> Changes in v10:
>>>>>
>>>>>           - None
>>>>>
>>>>> Changes in v9:
>>>>>
>>>>>           - Added the arm,inline_mode property to differentiate between inline and
>>>>>             memory input configurations
>>>>>
>>>>> Changes in v8:
>>>>>
>>>>>           - Added the video clock back in. Now that we have actual hardware it's
>>>>>             clear that it's necessary.
>>>>>           - Added reset lines
>>>>>           - Dropped R-bs
>>>>>
>>>>> Changes in v7:
>>>>>
>>>>>           - None
>>>>>
>>>>> Changes in v6:
>>>>>
>>>>>           - None
>>>>>
>>>>> Changes in v5:
>>>>>
>>>>>           - None
>>>>>
>>>>> Changes in v4:
>>>>>
>>>>>           - Switched to port instead of ports
>>>>>
>>>>> Changes in v3:
>>>>>
>>>>>           - Dropped the video clock as suggested by Laurent. I didn't retain it
>>>>>           for the purposes of the refcount since this driver will call .s_stream()
>>>>>           for the sensor driver which will refcount the clock anyway.
>>>>>           - Clarified that the port is a parallel input port rather (Sakari)
>>>>>
>>>>> Changes in v2:
>>>>>
>>>>>           - Added clocks information
>>>>>           - Fixed the warnings raised by Rob
>>>>> ---
>>>>>    .../devicetree/bindings/media/arm,mali-c55.yaml    | 82 ++++++++++++++++++++++
>>>>>    1 file changed, 82 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/media/arm,mali-c55.yaml b/Documentation/devicetree/bindings/media/arm,mali-c55.yaml
>>>>> new file mode 100644
>>>>> index 0000000000000000000000000000000000000000..efc88fd2c447e98dd82a1fc1bae234147eb967a8
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/media/arm,mali-c55.yaml
>>>>> @@ -0,0 +1,82 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/media/arm,mali-c55.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: ARM Mali-C55 Image Signal Processor
>>>>> +
>>>>> +maintainers:
>>>>> +  - Daniel Scally <dan.scally@ideasonboard.com>
>>>>> +  - Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: arm,mali-c55
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    items:
>>>>> +      - description: ISP Video Clock
>>>>> +      - description: ISP AXI clock
>>>>> +      - description: ISP AHB-lite clock
>>>> As per RZ/V2H HW manual we have reg clock looking at the driver code
>>>> it does have readl. IVC has reg clock if IVC driver fails are you
>>>> still able to read/write regs from ISP driver?
>>>   >
>>>   > I think we do need to pass reg clock too.
>>>
>>> Yes - but I should clarify that the names are from the arm documentation that we had when we
>>> originally developed the ISP driver. The RZ/V2H documentation treats the ISP and IVC as one block
>>> that shares 4 clocks and resets, but when we originally developed the ISP driver the platform we
>>> used had the ISP implemented as an inline configuration (taking data directly from a csi-2 receiver
>>> without an IVC equivalent), and the documentation detailed just the three clocks and resets. The
>>> dtsi changes for the RZ/V2H(P) [1] assign clocks 226, 228 and 229 to the ISP which are named
>>> reg_aclk, vin_aclk and isp_sclk in the renesas documentation.
>>>
>>> The IVC gets pclk, vin_aclk and isp_sclk.
>>>
>>> [1] https://lore.kernel.org/linux-renesas-soc/20251010-kakip_dts-v1-1-64f798ad43c9@ideasonboard.com/
>>>
>> Thanks for the info.
> 
> I won't question the Mali clock assignment as I don't have the
> documentation you mentioned.
> 
> But looking at the patch you shared
> 
> IVC:
> +			clocks = <&cpg CPG_MOD 0xe3>,
> +				 <&cpg CPG_MOD 0xe4>,
> +				 <&cpg CPG_MOD 0xe5>;
> +			clock-names = "reg", "axi", "isp";
> 
> Mali:
> +			clocks = <&cpg CPG_MOD 0xe2>,
> +				 <&cpg CPG_MOD 0xe4>,
> +				 <&cpg CPG_MOD 0xe5>;
> +			clock-names = "vclk", "aclk", "hclk";
> 
> It seems the IVC-only clock is
> 
>          <cpg CPG_MOD 0xe3> "reg"
> 
> trying to match the clocks here with the V2H documentation and the
> above names
> 
>          clk     IVC             Mali    RZ V2H Doc
>          0xe2                    vclk    vin_aclk   Video input data AXI bus clock
>          0xe3    reg                     pclk       Input Video Control block register access APB clock
>          0xe4    axi             aclk    reg_aclk   AXI to AHB bus bridge AXI slave cloc
>          0xe5    isp             hclk    isp_sclk   ISP system clock (pixel clock)

No I think it's:

clk	IVC	ISP	V2H doc		Desc
0xe2		vclk	reg_aclk	AXI to AHB bus bridge AXI slave clock
0xe3	reg		pclk		Input Video Control Block register access APB clock
0xe4	axi	aclk	vin_aclk	Video input data AXI bus clock
0xe5	isp	hclk	isp_sclk	ISP system clock (pixel clock)

So the IVC needs 227, 228, 229 and the bindings name them reg, axi and isp. The ISP needs 226, 228 
and 229 and the bindings name them vclk, aclk, hclk. If we want to rename the ISP's binding names 
then 228 and 229 become "axi" and "isp", and we need a sensible name for the "reg_aclk" from the 
Renesas documentation..."ahb"? or "reg"?


> 
> I would only question if the IVC shouldn't actually only get its reg
> clock as the other 2 are mandatory for the ISP even when integrated
> inline without an IVC.

In my mind, given that we're treating them as separate devices, they ought to be fully (if 
worthlessly) functional independently. If the IVC gets only its reg clock then it will not stream 
until you power on the ISP separately, which does not seem right to me.>
> I guess the question is if there are other IVC instances not paired
> with a Mali ISP in other SoCs ?

Good question, I too would be interested to know.


>>
>>>> Also for IVC we do have a main clock (which is a system clock).  Can
>>>> you please educate me on what is the purpose of it. Just curious as we
>>>> pass to IVC and not ISP.
>>>
>>> The IVC uniquely gets the one called "pclk" in renesas documentation, with the description "Input
>>> Video Control block register access APB clock".
> 
> Let alone I find 'reg' better, but if the documentation uses 'pclk'
> why has 'reg' been used ?

I used the documentation names for the ISP, but Krzysztof later convinced me that following the 
documentation names isn't the best approach given it doesn't really tell us anything. The "reg" was 
because the docs describe that one as the register access clock.

Thanks
Dan

> 
> Thanks
>     j
> 
>>>
>> Got you.
>>
>> Cheers,
>> Prabhakar
>>

