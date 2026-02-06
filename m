Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D51286D5C;
	Fri,  6 Feb 2026 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770411064; cv=none; b=sQiRd8NoBVkmbIHdAT29tmCe6Bsbi43n2mPjBw6Oth12yPE5XknCMUEaFENgmr0Vf7uK68RZ7SW0ugd/aaBCKWKFS1vEBZdNAy6n4lKD45V0JCEPIoKnRrFzKz12CLc2NbRp/zIG5Iy5sdkCeUr1AZiGFrPp2Bw9Jq+qVkl55gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770411064; c=relaxed/simple;
	bh=8HbIYuSYMKTE3k/M9Jzlj2eAn/mGL/5476qJtR0rpvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8YG0HIZFk0D41UjFmdR7tsSs5/uJ7YFcHu842XaP7vPBFa0RWJ4Q/9lQNQAa9EPHp/xIeJnMuxgC8EUCx0ABQ53lGqV7aBF8o83xaiuOAghWFwaVvaHBkXTsqja9I/I62a/2YBJpMxtLv7DxxwJ2qJDXIOLjCvveNNW/gVtloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CjmAqriU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CjmAqriU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770411062;
	bh=8HbIYuSYMKTE3k/M9Jzlj2eAn/mGL/5476qJtR0rpvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CjmAqriUH6Hg2qSkmjQpbTYFfQP+khhX4zoGz5mXdSmlxf+6ZpqMgBD836w/SDsK1
	 PgkTzDmZhuTLqYdhWIekPQJAKTQauz31SwTpP1LiWl+2vzU4QkqOCoueQTgsoCF/Mo
	 ylplhDDAr2GD704dgdBrlJPhmc/88x1d4SXHfx3RNIAXLIkmZbbK4b36H8cIVdxhcC
	 hr+nPKNqI29a+2e6ttc4OwJuKMAHrvnW/aiIgVh7AUZbit67NVLX4I4u8sdJuHnbw0
	 eeWvYU88rhZJZeaVdyxKlP4t1MUEkqw33OW5K4lhWCutAYPVJGtitIKLPhGgi7OkHh
	 CtOOSqqvN45Vw==
Received: from [10.40.0.100] (185-67-175-126.lampert.tv [185.67.175.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9517417E1299;
	Fri,  6 Feb 2026 21:51:01 +0100 (CET)
Message-ID: <1a25302d-2483-4cf5-8994-9de41ea9ab6a@collabora.com>
Date: Fri, 6 Feb 2026 21:51:00 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 00/11] Add iMX95 neoisp driver
To: Antoine Bouyer <antoine.bouyer@nxp.com>, julien.vuillaumier@nxp.com,
 alexi.birlinger@nxp.com, daniel.baluta@nxp.com, peng.fan@nxp.com,
 frank.li@nxp.com, jacopo.mondi@ideasonboard.com,
 laurent.pinchart@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260123080938.3367348-1-antoine.bouyer@nxp.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20260123080938.3367348-1-antoine.bouyer@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Antoine,

On 1/23/26 09:09, Antoine Bouyer wrote:
> [...]
> This series is posted as RFC because extending the v4l2-isp interface may
> overlap with ongoing work. If similar development already exists, I am
> happy to rebase or adapt the series accordingly. If preferred, the series
> can also be split into two parts: the v4l2-isp rework and the Neo ISP
> driver introduction.

I would be a huge fan of this split, at least when you submit the first
non-RFC patch series.

> 
> [...]

Thanks and best regards,
Michael

