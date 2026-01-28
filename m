Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC629C321;
	Wed, 28 Jan 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598662; cv=none; b=Tf3ZXL0P9g42thM8zStn8M39hMvY0FmsTESjjryusg+XlCfKBtn4oFhFdiJhlufRkgawvRdefkZAaumI1DtkteEXcHgbSzjEDz96t77KbHhkNpeIoNtLKUGkLaAx8DoLZ+QZVrUeOglQLvxXMxQnrGi3dKYYwGbgt6UogPQ2w5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598662; c=relaxed/simple;
	bh=BN8fQ9YVEym8ygJeP51C2VimQDGbsVVTE7ntVYo1amI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swsbDoBR/yJVl8bjFeCZwDC+mWQVENzFX4IE/7a2QMrQl18s3S3xZW6MkTuDCylM+a/em2bHNE1Sip9b48pNhwghsLDBDKBrOpbQMm8n8RhDFMLzWJv98qgbiuei5F8VS+jze6nhCps8E4+IikNpqiXKuFb4PuEwz7+0+KiACa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky7ipQWA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky7ipQWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDCBC4CEF1;
	Wed, 28 Jan 2026 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769598661;
	bh=BN8fQ9YVEym8ygJeP51C2VimQDGbsVVTE7ntVYo1amI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ky7ipQWAtHbkj8GR4blUtbRzhglh9HvAYn3lMnuN6KlRJjmb2Xfg8jc8bsqKH7Wo+
	 TUlIJ4iXbrx0FzijurxUxam1HW/u6ZklZS3ylVUu82uMeCtAEFT926cfaqjTevfiec
	 Z2vcg3i6ey1uangKNPOLA875RGSP8oA5xYSdCnyJBmxIC8TfQggW6zuEcsaND3L1hS
	 Dh5bOsVCTZ9B2dTNmMYzoVTGUVzaH7q0VtMGvuVCHX4eX59zMlE97y6LMYMVJqRi8a
	 EgOAiA2gq9hnrqlEuGBsdbg/ZTFXn0u/3Xcg/JiZA+VhECFL+V/8k49oLst3pPZP1T
	 wYl5N2jR0p+ew==
Date: Wed, 28 Jan 2026 12:10:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Douglas Anderson <dianders@chromium.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: sc7280-chrome-common: disable
 Venus
Message-ID: <20260128-magic-nebulous-prawn-c7b3df@quoll>
References: <20260127-venus-iris-flip-switch-v3-0-7f37689f4b39@oss.qualcomm.com>
 <20260127-venus-iris-flip-switch-v3-1-7f37689f4b39@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127-venus-iris-flip-switch-v3-1-7f37689f4b39@oss.qualcomm.com>

On Tue, Jan 27, 2026 at 02:23:00PM +0200, Dmitry Baryshkov wrote:
> Iris driver doesn't support non-PAS/TZ setup for setting up the Iris
> core. It's expected that the ABI that is going to be used in a long-term
> would be different from the defined venus-firmware subnode.
> 
> Granted that the SC7280 Chromebooks were cancelled before reaching wide
> audience and granted the feature ABI changes, drop venus configuration
> for SC7280 ChromeOS devices.
> 
> Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Acked-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 11 -----------
>  1 file changed, 11 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

