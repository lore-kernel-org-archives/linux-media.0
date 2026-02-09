Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B223446C7;
	Mon,  9 Feb 2026 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770646229; cv=none; b=DA9oUlizywee4v9qSsj2nR/yvlz16KpDQ1uf2es2ozNq1lHBUfKaGi8Ir0fXTTKKTkuTmJk8y5QjJYbWkAPD4vjIzhpl6hUY5t4K9emv9nYnnrvoIgUjrDxrKWqbQ6DHWKM7yxGIhbLRSogiZsJXyqmCdzodDsHvAPl/nS4Iu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770646229; c=relaxed/simple;
	bh=7sbwMdBPr5gGnzsAQAIIVH8IG/ORAL8YSQ7vWl4bZiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD/CImM/xZ/kf2QaC6su2mTzKo+ePcdlGtsT2P9CUSnHe91Y7BQCmtf8G5egEbY4shFTmcgzD9IugZhOQQ11o6HP9xCb1tjabc+98UgtgfIc2rlIX/JRzD1aBA86mrsCyaq3jBMvRBeq6Vdfd48pgMO6HIb210Pr9TC54cjbXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dObRy6nP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dObRy6nP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9800C116C6;
	Mon,  9 Feb 2026 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770646228;
	bh=7sbwMdBPr5gGnzsAQAIIVH8IG/ORAL8YSQ7vWl4bZiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dObRy6nPI+CtosubXE58YN/s45lr5BorMn0sMD+bFZ4DNLMXnrKHwOyyM1OugeRz9
	 kF4dFNRUWnNCUEHgi/IiyYjZxh7jekJI44v/JetlvZEGv0lB1d+khoBekfMwcoAwTq
	 snGvKg4zg8hm3NKXfamLDSlWPKMxd8kRaNwFfF3LHqgO6qVVnlVUTXjNRU7sw6es1u
	 8yb0h40+LcSJKCslHRfaS67o7Bl1eFzRePlyEeOSArCmqH6o3xd4ZOCc7sy4iQotex
	 pjETgY+5TrTLb++gVKRRJ7xgaG2xHd8S7lSFKj4DWcQl0T6QThvphzxcLERedHonta
	 Ze8MVntpnHGYA==
Date: Mon, 9 Feb 2026 15:10:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wangao Wang <wangao.wang@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: media: qcom,sm8550-iris: Add X1P42100
 compatible
Message-ID: <20260209-bulky-optimal-puffin-04c1f7@quoll>
References: <20260209-enable_iris_on_purwa-v1-0-537c410f604f@oss.qualcomm.com>
 <20260209-enable_iris_on_purwa-v1-1-537c410f604f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209-enable_iris_on_purwa-v1-1-537c410f604f@oss.qualcomm.com>

On Mon, Feb 09, 2026 at 03:39:03PM +0800, Wangao Wang wrote:
> Document the new compatible "qcom,x1p42100-iris", which uses a different
> set of clocks and OPP configuration compared to SM8550 and X1E80100.

And the device is or is not compatible?

> 
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,sm8550-iris.yaml           | 23 +++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> index 9c4b760508b50251ac467ad44a366689260bfc0d..0400ca1bff05dcef6b742c3fbf77e38adca9f280 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,qcs8300-iris
>            - qcom,sm8550-iris
>            - qcom,sm8650-iris
> +          - qcom,x1p42100-iris

And what about resets? Why do you take only one reset?

So the device is not compatible? Then should not be in this binding but
separate file.

Commit msg should explain this. OPP configuration is not even relevant
in terms of choices of DTS/bindings/drivers...

>  
>    reg:
>      maxItems: 1
> @@ -41,13 +42,16 @@ properties:
>        - const: mmcx
>  
>    clocks:
> -    maxItems: 3
> +    minItems: 3
> +    maxItems: 4
>  
>    clock-names:
> +    minItems: 3
>      items:
>        - const: iface
>        - const: core
>        - const: vcodec0_core
> +      - const: vcodec0_bse

What is bse? Maybe it is bus? See SM8750.


>  
>    firmware-name:
>      maxItems: 1
> @@ -115,6 +119,23 @@ allOf:
>            maxItems: 1
>          reset-names:

Best regards,
Krzysztof

