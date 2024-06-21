Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61BF16D9BC
	for <linux-media@vger.kernel.org>; Fri, 21 Jun 2024 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957260; cv=none; b=fFX/5QeSkrs3sZOL7Ncfcg2l01eiCi4h3bsQgvUKKKPVVr2iqEjKINYPzOROzISsWgKDoO1WWfYcRm/yb0tmKv+ff9WRh6W3FyyF11v6EVm1eczzZFvCLx8dD9w4JPYMcIt7WjafBdGZSYD66V+OpDq834GcbtF/CxqymIVYsig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957260; c=relaxed/simple;
	bh=cYL+H7AGAnrPAHYPKdXPj84OKuI8WX6V4GQiyS46RLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3LYCSdhvo6vbkvo6r9i6DXTI/cbeFLFdGVCvWvysM45kqRswIjbdftqeeTMeaAlNB6n0dI16kb66U05cl6NhOp8VQKEpn9UJehvzW4hSoHQ865vlA+JLNFz6bpYGjWmo+6sm4F7Jzd9TOdhj8TIFWKSBhnPDW5i9XVeOqbFx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=OTtOWskP; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="OTtOWskP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718957244;
 bh=Q5m7FnmD+I8+3SbjaKEWhSpPiVLp9WYZo7V5c0qQxQs=;
 b=OTtOWskPel11nlSanZ7f3BkGw7zdVol4KcbryrXqTREz5rFzYx2tBMpgai1Cdco3T5+FYPEli
 v0YFUGe8ZYrglfsCCz51/ld0UiEPpuO1rqV6KhwTntw8uvQjAwPQpiV5FrDDYVQ+yAh41xrmqCg
 fAUH1D8q4kxNeyJM7fzfUIgBMNJ7ltXr4v9eHR6mcogHLIg098VY0CH9Pz4tfGXWfWIEAnnCQJz
 RaRzAy9QEYs2cALhHlk3l/u4rlHLAumrO3lpQo8oZkGFFNrSrFcsMZMOau0KltlT+Rf3nFB8t/y
 eD0pDubCa6UwQFE//6quHQrYs4cdCVNKqlylkC/LEo1w==
Message-ID: <ee0d649b-9293-4bb7-9042-1a697cefb610@kwiboo.se>
Date: Fri, 21 Jun 2024 10:07:16 +0200
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Add rkvdec2 Video Decoder on
 rk3588(s)
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Dragan Simic
 <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>, Andy Yan
 <andy.yan@rock-chips.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Daniel Almeida <daniel.almeida@collabora.com>, Paul Kocialkowski
 <paul.kocialkowski@bootlin.com>, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Alex Bee <knaerzche@gmail.com>,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev
References: <20240620142532.406564-1-detlev.casanova@collabora.com>
 <20240620142532.406564-5-detlev.casanova@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240620142532.406564-5-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 667534bb7560ce51b8f276cf

Hi Datlev,

On 2024-06-20 16:19, Detlev Casanova wrote:
> Add the rkvdec2 Video Decoder to the RK3588s devicetree.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 48 +++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 6ac5ac8b48ab..9c44c99125b4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -2596,6 +2596,16 @@ system_sram2: sram@ff001000 {
>  		ranges = <0x0 0x0 0xff001000 0xef000>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> +
> +		vdec0_sram: rkvdec-sram@0 {

The node name should reflect the purpose of the node, not sure rkvdec is
a good purpose, cache-sram/codec-sram/sram-section could be a better
node name.

node name pattern: ^([a-z0-9]*-)?sram(-section)?@[a-f0-9]+$

> +			reg = <0x0 0x78000>;
> +			pool;
> +		};
> +
> +		vdec1_sram: rkvdec-sram@1 {

The binding for sram mention:

  Following the generic-names recommended practice, node names should
  reflect the purpose of the node. Unit address (@<address>) should be
  appended to the name.

so the unit address should be @78000 and not @1. For name see above.

Regards,
Jonas

> +			reg = <0x78000 0x77000>;
> +			pool;
> +		};
>  	};
>  
>  	pinctrl: pinctrl {

[snip]
