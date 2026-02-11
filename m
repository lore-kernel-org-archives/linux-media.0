Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425FF1E8329;
	Wed, 11 Feb 2026 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770791618; cv=none; b=ahyoRfGDX1IWAUkOSlQEl2Slp1HlSSRKJ/4MDMRia/8qyYwVMu8p3O9wnj50Vn0284jEKv1Dfl6+1EPVReaOnQjgTUr8tiz2GecUSw1xHb9xm6tL4/33eb4hB2ggTyFKg8YKo8w0H/Tu0S+WmFLgnb9JRPTUublvLeCL8hpGWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770791618; c=relaxed/simple;
	bh=XddYwKWvWxeFWm2+5c3Jwb+Tiu5ZT9PPFTcLqhLE0PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbpLX7xv51YD72ktkYm3l+9pb2ZrbM901QAr6i8q6PkWccTcEyLdb5x2nTcELlG5S1TBC1eQ05xB2SUNYy88ZU5saXObK73TGZHcJENCur2uUlcWVXzNYjNdklIgra5Ir9wEYYocLg68Trof+3q5UOjoaVqAknDv2iXWwxkHrZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhKSoC6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhKSoC6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53300C4CEF7;
	Wed, 11 Feb 2026 06:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770791617;
	bh=XddYwKWvWxeFWm2+5c3Jwb+Tiu5ZT9PPFTcLqhLE0PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhKSoC6G5WlZEUdcANoPXq2fz5kud/Cq6WxKGkb6dZE+EWaCSnTF+L5Qh60jNPILd
	 k1HmeQj+di5yBVQQUlU5xiMeZDd9IOfF1GMVqSRl+6Am9t0edOy1bQyvyEPzNIzeMA
	 qS0KfxWDGuyo/FhHUXoF7cuXoejU++AnfpaJ2yPrJlquaRHKcOiDKMhNhG1FSzYIis
	 H7saib3OPyTwvo63AxAVqsL9X/o4+BASr54BUbUh2c1UqQK8GkyrtNhv5HyoI+TdXr
	 q98cGxMgP9KDN2yg9UZbRWrXzCpVQ2FHxwfpOkRb52ZK+NS6R6eFZF8u56JYAVytCP
	 yzErVmb+5egtQ==
Date: Wed, 11 Feb 2026 07:33:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: =?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Nathan Hebert <nhebert@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 01/14] dt-bindings: media: mediatek: vcodec: add
 decoder dt-bindings for mt8196
Message-ID: <20260211-premium-heavy-puma-bb8e7a@quoll>
References: <20260211054149.27249-1-yunfei.dong@mediatek.com>
 <20260211054149.27249-2-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260211054149.27249-2-yunfei.dong@mediatek.com>

On Wed, Feb 11, 2026 at 01:41:28PM +0800, Yunfei Dong wrote:
> Add decoder document in dt-bindings yaml file for mt8196 platform.

Getting to bingo, two out of three redundant terms how to call DT
bindings. Drop YAML.

A nit, subject: drop second/last, redundant "dt-bindings". The
"dt-bindings" prefix is already stating that these are dt-bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Write concise messages. "DT bindings schema yaml text file in kernel" is
not concise.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

