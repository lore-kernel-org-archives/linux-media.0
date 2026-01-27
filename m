Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4A1CAA68;
	Tue, 27 Jan 2026 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515649; cv=none; b=BUTyGvX9uad6aKDNWijjnGXF6ghDQLdh3mjIJCr5bZOG0aIGXUjBFoY1ES9xxWO3163rw0RsRaCWenEgyJ1TLzWHV2f/PLDRdzCLlgcma4YODHgZ395ZPFb6m6PYa7rcAcCwt9ewwyN9051oj15lnygsoVgRguNCWUepONlIKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515649; c=relaxed/simple;
	bh=iQwdKKLixb7SvytVlVxclzM1hBQ6drnDy7bqpBAZJAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTlb4PvU+JkNquBG3xtmdV3e1g8jc2ppnl3EdXs0ZlbkGfNpBJBvRkW3TyRw/ezZFQpn7YasbVpAyJdnkgdm6UxEkUKZ9SLRBdEwkHZZugpVCZQxYin7UImQ0w5ABZySCy5obpP85SIssaJQxyL0xAWTPRMH1U9SueIaLTmYuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jImLZCb+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jImLZCb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769515644;
	bh=iQwdKKLixb7SvytVlVxclzM1hBQ6drnDy7bqpBAZJAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jImLZCb+b5FuItJJDxwiMl1V5WBvIQrrt2p2NvSNCEBggCN6aTE7w0ifR8sYTnEAm
	 C7R64H6K1eiKOxAnofCeLdeeQBIAva2iJVQta17ecxXQRb0RmWtYN1Zs9U6y2Eeen+
	 OGcBljM1jdFMp6p6G9qijeAzuvsQfe6ZPdmCrpL9uXB2TlwouB9cv6wj0JwoS/1Wq8
	 E9Ntm2tUBNc9f+6L2jXsFyfUmGar7yNtcVYEnDCJQDhjNyqw/dAkYTKneOi3YK2PvY
	 7GEdeG4ngb/nHisDmoURhqx54CoGMyZScchVRYB+WBu6x7cZVwC8JCU2UB6toZhqvo
	 rkBq/Ic1oj2cg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8136217E0117;
	Tue, 27 Jan 2026 13:07:23 +0100 (CET)
Message-ID: <8f1fcdbe-c3fe-4e1b-baa6-cda7006c2863@collabora.com>
Date: Tue, 27 Jan 2026 13:07:22 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] media: mediatek: vcodec: Fix media device node
 number
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
 <20260127024248.18406-9-kyrie.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260127024248.18406-9-kyrie.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/01/26 03:42, Kyrie Wu ha scritto:
> change media register device node number to a correct value.
> The vfd minor is used to record the number of registered
> video device nodes. The mdev_dec.devnode minor counter is
> used to record the number of registered media device nodes.
> 
> Fixes: 41f03c673cb7b ("media: mediatek: vcodec: replace pr_* with dev_* for v4l2 debug message")
> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


