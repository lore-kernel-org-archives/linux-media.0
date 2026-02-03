Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD831A567;
	Tue,  3 Feb 2026 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124952; cv=none; b=qke8062MNiUlcGwmIRU2g+O9QeCtC7zYvUXuqotLCu0YAoY0zSDWLsvDQVXyAZ6fyw/uwk3ccTdOPmYVr/w0i3/EDaHvwf6YafTYLz9dBMBjd7yO3xl7eqVPG5mjB0pW2DI/oEWgjr91CbdF8soe38IkYPgFPdW4UEXGVzomlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124952; c=relaxed/simple;
	bh=PZmraO2yMUYH3pSo8Dp9C/bbcclbR1JKuRMVLr/Q/Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbfhcGHBxVyhKT1neRgUdnoZivi2dH527/MX6WjANy80ufw5gqqf5mOGpgNcy2bSA26ZbnG0rOWDgEgz/p1PVHe/WYl4Md61uUXioWfhijH18OogK6N24+1lVhai6RWueszkY6A04u60t9OiMOH7wB+Z62uvFNx7+kybnQruiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from [192.168.4.18] (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 1056C8CA3F;
	Tue, 03 Feb 2026 14:22:20 +0100 (CET)
Message-ID: <116261f9-5e75-46ad-9d2b-598b744ef258@gpxsee.org>
Date: Tue, 3 Feb 2026 14:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/20] media: pci: mg4b: Use IRQF_NO_THREAD
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
References: <20260128095540.863589-1-bigeasy@linutronix.de>
 <20260128095540.863589-21-bigeasy@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
In-Reply-To: <20260128095540.863589-21-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Tested-by: Martin Tůma <martin.tuma@digiteqautomotive.com>

