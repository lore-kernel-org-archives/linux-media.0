Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9E3469F6;
	Tue, 27 Jan 2026 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515652; cv=none; b=r3Vq2+hXBDR7YC/qEe0FXCTgK1UExe/aN4Nsy19K77jv0iblZoUODObUwSi7cFdawQHa1PybpmDFEw/qnK+Xaf4/VD/g3OvNmQNKMS43T6NUjkOVdMNbATDb8X5OvctbAlAdPxtxFPESuslFvnhwdyeHBURkgZWN11F2bCqZNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515652; c=relaxed/simple;
	bh=YMRoOevOWD9pKhdw5PEjA52OtjLoz2jFT9eMv3XFUTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEYg5GIrzsJmohN2lq1Vud9Iy573kGCZbu1w52gM3xI44YWbEAMwhb1WRmYozU/AcTcx106KpDjTGbAt6l2+9w1wPVX1hgmMRu4wNFe1Q7zXGXf4bXLL8jhdGe7apHrV+cFWc5JdMepZS7ivq2HuWsM4x44xEJv7SQXTJ25DqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=glkAlzvZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="glkAlzvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769515648;
	bh=YMRoOevOWD9pKhdw5PEjA52OtjLoz2jFT9eMv3XFUTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=glkAlzvZAIODFiIKidjF26isiWlNbcTAQuFtZf+E4jX69olM39MB4ADjyBGbhq0Ac
	 TGwvJ+LOED6YZuhZvdc2KeqcHFJBqhhECirTayHRqp/awJbopILVdMScer5k1xZ0oz
	 LkXaxcKrUBdj5KMyLzZM3kw18ldugbtwEF3dy9Uy4UG1NxTr8uVQsOeJMoWpA74ZPI
	 pVn4hUcNbQbhXvZ2Wlwy6Y3TsMnuEe5f0kV4WazlJz70UIeprM7yTKnOse6gacMSQv
	 lStWtHf/sIBgjoUaj9msp36xFYpKF3DAtWnLHM9labIGcAFsqkDxr/s1SATE0AUlSH
	 zIZjxafrNce0A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 43B3217E1352;
	Tue, 27 Jan 2026 13:07:27 +0100 (CET)
Message-ID: <18cf66f8-fb1d-465c-9c58-774a1ac86901@collabora.com>
Date: Tue, 27 Jan 2026 13:07:27 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] dt-bindings: media: mediatek: decoder: Add
 MT8189 mediatek,vcodec-decoder
To: Kyrie Wu <kyrie.wu@mediatek.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Nathan Hebert <nhebert@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Irui Wang <irui.wang@mediatek.com>, George Sun <george.sun@mediatek.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
 Yilong Zhou <yilong.zhou@mediatek.com>
References: <20260127024248.18406-1-kyrie.wu@mediatek.com>
 <20260127024248.18406-2-kyrie.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260127024248.18406-2-kyrie.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/01/26 03:42, Kyrie Wu ha scritto:
> Add compatible for video decoder on MT8189 platform. Compared with
> former ICs, the MT8189 decoder use iommu to instead of smmu, and
> use scp architecture, the frequency is only 406MHZ, and cannot reach
> more than 700MHZ. It used only one clock. At the same time, the decoder
> supports the vp9 decoding protocol for the first time in single IC.
> 
> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

