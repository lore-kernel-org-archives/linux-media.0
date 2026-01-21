Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7C39341C
	for <linux-media@vger.kernel.org>; Wed, 21 Jan 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001537; cv=none; b=NqeyTwX4x5t7Uqbp2c4mpDeNOCnroJDxA2BXOCg5cPjo9PaEV/glJkCJDi9A5sVKxIfEps2NBOjDZ7OUF0zSNZU+kbarvFVOBda2KzP92PwJxpstxzGkXmEJRJs7M9WWsaV0Qs3N9wTrkmRi7HqH1KzqdLwp/RSzO2DgkTiw80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001537; c=relaxed/simple;
	bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppPIsvIdHi7Hw0yqXuS5jL9BVejDIMrLdczJzluUXMYK8CzOJhDn4vknkGMKq6evkgjK8uQhg52Yl8WAX6AxztDkdscDfvGq6znmO5LCQ+iW31nC+IULk57vLTYntQvEA/tVJ9Mg4MA9O93GicNc1947bDtau7rPnNLBf/5NV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=auPHecAk; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="auPHecAk"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c538d17816so846594385a.0
        for <linux-media@vger.kernel.org>; Wed, 21 Jan 2026 05:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769001534; x=1769606334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
        b=auPHecAk2iN7ZabTIQ+tkLxDrluU4dCEBlYYIhuQln6eF1Bfx+8IsONn1dD3HP+pHo
         kiQR9I91Kuww1yFWj/b0sWSrQM/cMs+blizM0NWisDQRXI35HMLsNrpnQCOrCyVfikCe
         vtv9530cVL0Vy6XHmSQ+tPLww/3r5qwJOlToD/xpraBS24TriW5VROoubZgfTjSQRAzZ
         HFsaGYZ98Y19cSGkjjghhtYs4sRPm+TZkcQlwRwb8NXzyuUBw1jY450cHKzizuLt8uvP
         gpEw2V3dp6/9VWMVd7WI8vOGqrUW48hHbYOZvkGvapFeCU43rqCSgClWfcYHPf9PznOv
         KKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769001534; x=1769606334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
        b=rqXyrtdYvyveHbXwnJg86ANwABO0KuIjZMJ7DXUrQewqn55oVI6iXP4TFrbJ4uTOKf
         sXduWlsROvtRZgsSMXpMh7RH66yW+lACyYa5IirSBRmsof+5Y0n1tw9MdYZ7YA5Shjdp
         ooBFtN2Fwq3Bh3P3C1A2fczaDkRlDRd9WWpS8Zb1G6245ORp06zFTfb9R5d5N8jF53SQ
         oaKpP+OTrAvFUq9m2uPN/nQFfBiglUGj0mG5EUbEKP5IwfA0sWbjAw4loafV0SeFKp9l
         01NKkvleMOU3seP0l4WJWtCtjkLBbXN58OOLts/YEORaYmEwIpJsewAuC4YRfksarAlc
         WxTg==
X-Forwarded-Encrypted: i=1; AJvYcCUWbqO8N8uM1l5TwHvJmLO3wGe7Zbj8bLwhhbSX/8NO2s7ri1R/Y3AXuGlNvMqBtet/FYPdl9whypHyZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynkPAa1AETFH9keRJj/z3fllhzB6u49s6DNg39yyb8/xJ0KwLT
	foFBPjayTr2Y4C4Pxwg7cLjFZ/VUhCvKrniK9vS6YO2RnQ+Fd0KbZFjelMPJCGtmbiY=
X-Gm-Gg: AZuq6aJba/YGit+6HAlxSbqtV7V6C7Gu0UcGLkdysX7zpUOvG5aJUZoVImy/dUOfyoy
	DDr1hF5TRfuqM7F9fnWXZG76T6jNnC3NwVqvOZI43s2enEkv+rK2sp5at97MYl9D/9lwKe2FAgL
	ybqeNlLPxTSJ2c4bDlQlsBjpMWlGJ4JwO4Z7JG7WeibyGDCon6+dTbJqq1BXQQWNz/IYZn1at5N
	3z9EgO09Lw2v8/QEPFj4iN4kl6Q69ODms2zqu71dz7p8xVbaA2o78qnvNA8TZ3E5W8O6UKx+3V3
	+WRHKFFUhIzzTWZzQ+ljkTh0rSz9HHtA/3+Un6EACuw9ZpwBWrxwQczhxN2EYZPhZqoTHOCkmkd
	p7NFESPzkTwcGcyG4plBZDTMq0VDwFVy/2540jCJkW40arJGVnxu/cejgcp5lEpIhg2GEVXilHo
	iaEAsPJcmCMveNoWyKuOTRvZMM+bW6CxWN5h9bGA182cFLbuUWOZnZ7ui2tSPi3qSO7Yk=
X-Received: by 2002:a05:620a:a819:b0:8c6:aaf3:cb44 with SMTP id af79cd13be357-8c6aaf3cd9bmr2247463385a.4.1769001534382;
        Wed, 21 Jan 2026 05:18:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ad820sm1209794385a.10.2026.01.21.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:18:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viY6m-00000006DUF-3lkE;
	Wed, 21 Jan 2026 09:18:52 -0400
Date: Wed, 21 Jan 2026 09:18:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dma-buf: Document RDMA non-ODP
 invalidate_mapping() special case
Message-ID: <20260121131852.GX961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>

On Wed, Jan 21, 2026 at 10:17:16AM +0100, Christian König wrote:
> The whole idea is to make invalidate_mappings truly optional.

But it's not really optional! It's absence means we are ignoring UAF
security issues when the exporters do their move_notify() and nothing
happens.

Given this I don't want to loose the warning log either, the situation
needs to be reported..

Jason
