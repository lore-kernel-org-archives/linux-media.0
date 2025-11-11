Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE23311583;
	Tue, 11 Nov 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875187; cv=none; b=Nh/O7Wt01mwGRatW7kr8OUFHf/svqhgy+E56Hy9fRNRFMD9C2sDHlLyYvb4JgvGUIAAfxaZrKwf5RTS7dco0rblpvpJR71WbSSdh1KMU7suUGu7mvGrNG7+i2KAdsiFHG/J4rquWB1RYxGxs/kQiK4zBgBJzn+QBfr8lSMZ9Q4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875187; c=relaxed/simple;
	bh=slRYGEdUz+cCTYCi+O6BuYqZxoSPQzRf1x/9/Q1H89U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=p2kMImLdq3BgHbL3BUn2NlSlAqt5SoPcP5d8jp/vh5dr8ceRFapPOxMlzZT7YQLkhcm9ekrx6WUQ4zy0hiNdXbQmVkKJgjgCzx/CyPEBzoVrgh3E3PsqnHkjdcd9Byjaxv386cvcaJHvVzL8192BqJU2pn+fbaSbseYP58w7GIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW9Pk7X/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW9Pk7X/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEFFC4CEF5;
	Tue, 11 Nov 2025 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875187;
	bh=slRYGEdUz+cCTYCi+O6BuYqZxoSPQzRf1x/9/Q1H89U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LW9Pk7X/VR8fktzjZL/brfLt7gG70sR7Kcw6PvQNtc2TVX8l+2MlPvZhnj58wZpBJ
	 CVKrqO6lIR+9e/UVcKmz0OrQYq26+p+ILYI7xYsHGsUBzkqJ6poEvp7+hSRrD1SU6h
	 5m+SWnJ9sIgnBcjV9h+3I6Kq1hqF+nl82OeJcNHGWz4YL1ej6R7H3+YShAkzThW8Jb
	 Zp1KTilNbfIIaQmINSmwhpwlSW1hDmKbZVA60CpcBcGNC7DtinfAq8vKyUBA6BsgGN
	 DoE9RrqIyjyyhfqfN/6gQDHoVk8TgY2gPBmo1CuImBxeQvnABC2qSfZswIPKuAXp43
	 pbB/Dh6hf6M+Q==
Date: Tue, 11 Nov 2025 09:33:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 linux-media@vger.kernel.org, kernel@pengutronix.de
To: Michael Tretter <m.tretter@pengutronix.de>
In-Reply-To: <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>
References: <20251111-b4-adv7180-vpp-sub-device-v1-0-9877fe9f709b@pengutronix.de>
 <20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de>
Message-Id: <176287518543.2990003.9870195789780384180.robh@kernel.org>
Subject: Re: [PATCH 1/4] media: dt-bindings: adi,adv7180: add VPP and CSI
 register maps


On Tue, 11 Nov 2025 15:36:14 +0100, Michael Tretter wrote:
> The ADV7280 and ADV7280-M have up to three register maps for the VPP and
> CSI. The address of these register maps may be programmed via registers
> in the main register map.
> 
> Allow to specify the addresses of the VPP and CSI in the device tree to
> solve address conflicts on a board level.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  .../devicetree/bindings/media/i2c/adi,adv7180.yaml | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/adi,adv7180.example.dtb: composite-in@20 (adi,adv7280-m): 'reg-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/i2c/adi,adv7180.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/adi,adv7180.example.dtb: composite-in@20 (adi,adv7280-m): reg: [[32], [66], [68]] is too long
	from schema $id: http://devicetree.org/schemas/media/i2c/adi,adv7180.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251111-b4-adv7180-vpp-sub-device-v1-1-9877fe9f709b@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

