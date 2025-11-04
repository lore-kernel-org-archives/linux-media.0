Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBF2D47F6
	for <linux-media@vger.kernel.org>; Tue,  4 Nov 2025 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284381; cv=none; b=BgtwAdXiAhfpkQ9kDYDruHjhDOAMSPGS80lCsSk2HxH0HftsD8zeYCP/kFHTsEULSlVNEeSUyU9GznLISkUfOb6z6t+yPJTl2VwksDDo7agDeo3mwyP5gtdrNxUXaNJHeCuB5H1LoHOgKpVn4CCcK1aARhuHjP0065NldyQIUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284381; c=relaxed/simple;
	bh=cCkLeU8n/VC4gjMMSvE8Q9FQGCPzymEWRBS/d9chZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GllDeyynUgLFU8/j9aHKtr27PaokeddHL9+wh0HqmKlqexd5lbxficMnLh8XyhHTGuz5XspWyq4wtr5BwqxcXqrvXbBexR5NOtuuTFMiZdxmapVVVTkncwjEK8sFPD3XT4KIe6lX5IFSRaj5UaH6SoK5cmzjX2v35WCT+XphIr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Br/CW/Tf; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Br/CW/Tf"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-891208f6185so547134485a.1
        for <linux-media@vger.kernel.org>; Tue, 04 Nov 2025 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762284378; x=1762889178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3vZ52GkNsJGLOkvon3L18RWVKcEn1c510aPuA199YI=;
        b=Br/CW/TflUHqW09MD8LVZEVmTCEpByqeZHXbQmDqLNS3W7/P5QMsLqXUYUPvpa00O/
         NDbeKxURSRAOEgZlt4pyN7AoCusEuXP7xgt69+GEqYsa5zkF1QDghaXdoYgbz0DWHmSq
         U9OeOmRjTDCIT0/cBPF/t3LUA1zcAtJYiTLN0gEIejp0Ov18P4I2koBnQy6dI54enVuc
         QyQX43ev4/pqNhdtIzyRUoDdKf6k1sRujr/hJGrkQZGhZ3OH+U3yhJimlpvTSAlkgBve
         sPmwUqWOuz/s/qZcYM4qKj2PZVpK1eQqqu4mmee1GT71ewrvnKTZdaqwowoBMd35XkLE
         eoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284378; x=1762889178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3vZ52GkNsJGLOkvon3L18RWVKcEn1c510aPuA199YI=;
        b=D/bu3QA0sO9StKPYQ/gS4mHeyH5q1jsijQQomPOj3sCig2+3jiG0kfdO+3tV8eUYlj
         5bnHte5rl97NEpvy/p72C2a/sOJUmGaZZ8YoAewp9lCXN/xTqbfrvOzdbX8/lUyrSx4b
         RSHxXpVNsKOo6DZyvqorOk2dcGjaOIRlr4gEviTAvoUyXYJhBiH/qml712tWkA4Au0hg
         Y0tEeBj+g2tiHBhHuX0WJwDWFI5DrAPKeLhzeFXfxiSG6vDVCaAJyAMrIvkK72wNQCiC
         ucFNfG+Dntr90YmyuTWjGZlSAH5Q6yygfbd5noT4yUl/NXqWti3ZauGaL1LrKbrsyhx6
         A/rA==
X-Forwarded-Encrypted: i=1; AJvYcCUlN+IRVArachPcHLOXMUvxRYfHSHzJBKvGT2Zq/Z4hoM6XqZdQ2ArWgnHMhUD/uuIO2jvb5sOTzVlu3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxypirWted+wXW+BkSg7r0wWXJPKqu+Tt7IfbUrUF0eVbJWPc6k
	mquOD/oTTqwD5JJTaH/zE9KB0R81eftwLjousgkbSAKmlDQG8wRBT1dRQE6Pm5YvAQM=
X-Gm-Gg: ASbGncuod6pH+icSEj3kxo6X+6nfBIYjs/ulW7qWmw8SWQu1krszvsdeM1yf8j+7v2K
	WdDZA7wHIORFA8fi8uK5S4vcjaZkdwEddGlmMGoQD/IFyajcuyy4xhI2pptyJ93MZ9KUKZ8j/+w
	2FodkWuk9ZTpYIjr34P/8ILR3LppV4MIpyaFsfiEj1m1wdGLfX4jgqaV/slR2WmZU51uzBdp4dF
	a4BVNT8DZ7YGYzBW7q3P8g0hTvySquxKOz/mzrxIghYmcviOAUW3rVdePsqJtijifm15REqgcUi
	TJXVzN3unbt2auPbaPC+merQvHmBz/Nc8GrhXD7eU7K7Z+FyXbFPzkJagJTROsT7T/RDkTd7kVB
	idsRAQFwvyZO2IXgdW61HuyJeZ1jiP8ivqyujxWh6tx63d0svxYPMFatFIt2XmNzFtvCxDlm2vN
	OasBf9kp44E+HltcIaqGbEpCTjjAOz4CZbFwxmO40pCqwi1Q==
X-Google-Smtp-Source: AGHT+IFUVGYM+r9VlnujjXwSiyntNScv3JSZn85Gft/uvY+ZvhCxVbalAnSefdp5Rhr2H4+z2gOTFg==
X-Received: by 2002:a05:620a:2a06:b0:86f:aee8:fcbc with SMTP id af79cd13be357-8b220b9ef27mr103417385a.79.1762284377655;
        Tue, 04 Nov 2025 11:26:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f7bb3e33sm250495385a.39.2025.11.04.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:26:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGMfY-000000073Bk-1Ldv;
	Tue, 04 Nov 2025 15:26:16 -0400
Date: Tue, 4 Nov 2025 15:26:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v6 00/11] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <20251104192616.GJ1204670@ziepe.ca>
References: <20251102-dmabuf-vfio-v6-0-d773cff0db9f@nvidia.com>
 <aQpRz74RurfhZK15@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQpRz74RurfhZK15@Asurada-Nvidia>

On Tue, Nov 04, 2025 at 11:19:43AM -0800, Nicolin Chen wrote:
> On Sun, Nov 02, 2025 at 10:00:48AM +0200, Leon Romanovsky wrote:
> > Changelog:
> > v6:
> >  * Fixed wrong error check from pcim_p2pdma_init().
> >  * Documented pcim_p2pdma_provider() function.
> >  * Improved commit messages.
> >  * Added VFIO DMA-BUF selftest.
> >  * Added __counted_by(nr_ranges) annotation to struct vfio_device_feature_dma_buf.
> >  * Fixed error unwind when dma_buf_fd() fails.
> >  * Document latest changes to p2pmem.
> >  * Removed EXPORT_SYMBOL_GPL from pci_p2pdma_map_type.
> >  * Moved DMA mapping logic to DMA-BUF.
> >  * Removed types patch to avoid dependencies between subsystems.
> >  * Moved vfio_pci_dma_buf_move() in err_undo block.
> >  * Added nvgrace patch.
> 
> I have verified this v6 using Jason's iommufd dmabuf branch:
> https://github.com/jgunthorpe/linux/commits/iommufd_dmabuf/
> 
> by drafting a QEMU patch on top of Shameer's vSMMU v5 series:
> https://github.com/nicolinc/qemu/commits/wip/iommufd_dmabuf/
> 
> with that, I see GPU BAR memory be correctly fetched in the QEMU:
> vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 0", offset: 0x0, size: 0x1000000
> vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 2", offset: 0x0, size: 0x44f00000
> vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 4", offset: 0x0, size: 0x17a0000000

Great thanks! This means we finally have a solution to that follow_pfn
lifetime problem in type 1! What a long journey :)

For those following along this same flow will be used with KVM to
allow it to map VFIO as well. Confidential Compute will require this
because some arches can't put confidential MMIO (or RAM) into a VMA.

Jason
