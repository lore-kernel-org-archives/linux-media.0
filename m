Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bZZYF839"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E006E8F;
	Wed,  6 Dec 2023 02:19:39 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id E4F1E6607343;
	Wed,  6 Dec 2023 10:19:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701857978;
	bh=yp0cMbMxUMjPOPkHoQ1JD3Ha3jH6vl6v0MY52LaELe4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bZZYF8391VFswugKIXEFFa1UH61k4XykSx+yzwELsxrUUP30pQKl+EtTtRKJPX9RK
	 Wqg5fN69/LvN6eiccyfTorfBBmBcRpFO92Ez0TOymnPbJr/HfzCc6FbPrvRD0Vl9kK
	 o2Wx0srI4rZUjEfYM0l3sQylf3DbIRP6hK8nE61AvYns4Eel1licNkLOCMeQUs5aKA
	 VvMmikrF6eUyXUNVEcddJcdhk41Ma9rmgKNlLAM84c0IJvBSUiRCX084Sket5aEchi
	 xpuChgKEgZxgdnhfrbYz0ukXikVkyrXfCs6t3A+ZJVRQcHX72U/pGbXWU2F6BsS/S6
	 LSUZxd3Vs9uxw==
Message-ID: <fe265655-3ebe-466d-875b-f74e57e0363c@collabora.com>
Date: Wed, 6 Dec 2023 11:19:37 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] media: mediatek: vcodec: Replace dev_name in error
 string
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231113123049.4117280-1-fshao@chromium.org>
 <20231113123049.4117280-2-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231113123049.4117280-2-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/11/23 13:26, Fei Shao ha scritto:
> mtk_v4l2_err() already uses dev_err(), so don't print the device name
> again. Print function name instead.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

