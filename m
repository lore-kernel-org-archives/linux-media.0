Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2633290E
	for <linux-media@vger.kernel.org>; Tue, 20 Jan 2026 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933104; cv=none; b=a7m0rJPc7k51Mg5E+N60xfI4i6uFlg8I7GroskIV29wilPP8FH5L3mpgZfl2regBZcsExLTkeDYOLRXyxFCikJvLGVc3OX4bgRiwlE/iEDYf2xG4LTzDUVHoFIFE4LlY1naCusQrv0cr0JC9ZIad7AfuLHZb5HzvxvSzI1NAkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933104; c=relaxed/simple;
	bh=1L7c8BdoqxZUQDENcVXtZThUOiLDYDJQMPX7ZV7N9xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN/rEZgT3qqbdSWi6TlpIYa+DuWmjm2rLnmTZoG+rttQzOKYiwuXHIfHNZvhdl6yCKe4nJvLZFcZdwaobNdaqVZdwpjaOTBibkRwlkgUsE9GLuPRCALbeNn7ZR6KIWApY/LT8dUK6Oap+zDYP7xXOXTOCmToqbt+Z5QV6qJnV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=avpr/md1; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="avpr/md1"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8946e32e534so4134436d6.3
        for <linux-media@vger.kernel.org>; Tue, 20 Jan 2026 10:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768933101; x=1769537901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjKhtF6uFrGGz9QpG86rUrUwPRn2VxIJfZmcip97T7s=;
        b=avpr/md1vuSh2XL2Y1i36eqW+S83q+obfD0emf4zuMUEOWTKUhGkHKL1kBuO/4AA4f
         W9QufuzqG/TYMXy3og4z2kGtwGKV6nxnJ599X4VsETaXHkxFuSyJeAJPy26BrRWxaYVH
         2XIWwSgQ7fawTZyHicTOzhS5EVRGiuoLmnZtDhzqtv8DWHSTgohszhgj4n1+u72Lh4lw
         McOIfV4bDsOfoP/QwKkT9K+9HEZb4y97ZRuhH17MhsjemlTigU+kSy0f7hP8/HTCALEV
         aFeOFilo/nvQBPaZQGrgLZ67PtGeO2rVh+hM9q1PGU4SW9YhZQR2tif19DBqz2VAN6Hb
         s+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933101; x=1769537901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjKhtF6uFrGGz9QpG86rUrUwPRn2VxIJfZmcip97T7s=;
        b=qbFnbLTzSbsU43S+eVXyoWKDgagD6RaoggojJOGnqMv5fPiqqqYHNkb6HJ52+OdpXn
         8bNfwwcxk5xD1fyxPEk8BvHC/vrZto8eNMaH5BxpEBzP/2pHuwoaZxFm5zQW/OQc0Y70
         tgzI9b3USYuVPw40ZPQDbDVZgGHOLx2rk0fUaDO4g9bWVhws1HNn/iqV4lhZCkh6cO39
         uPt1+C70suJavPRPXmPyZrZ56Xb5EQte/hwRRgDtf5kdsE2y18PUfXkRLnWtW6h/cTzk
         yd5FS7SCN2HxZOMGSQvWh7Ins7pI7oQZlxRhBPo9RVrnI9PinjKlYdXU3W0uzzo/UpDo
         JBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVO+nweVKMqoff0hS+yeBZM3gwRNXTCT9PI4Zc/Gz7PlNoZ7zN+lq8/TJQ6TXtbwt0ifrCoktRmetJVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2x8sM2jQoz028oLLBQ5XsLX0whW38lxSXZIZPE7vvZeHkK7It
	YW3yo+WWDu8+C2/aabc6au9bYG4sQNi/5tF3cNAt/dxgLXoo/OKUxp5lajGCbX6BuqA=
X-Gm-Gg: AZuq6aK26CX87x/R0q1kaEvIO/nLRwrY8W+xuOrlG+mAwhJLVkfcQCP5nGFFguUScNV
	qLtPmY36VubPTld8zTcsFWbHqW3vU0oysR9IpYGkox8vNWAqD1UaWSd3J9bQr2K6Q1Mo1h5MRKQ
	j7yO09LeI8sqoy4t55SCJqSJE8EXEk34jhThLXO/PzuQAgYgLnVJwkHRZbC7T6jZHXTp+QMcY93
	+Wp9Q1EeQ89c3egcnk0rN6wljzXXDIczSjL3NGjEnFcDz34jzPxmB8CPvHcoWCjhGsCcm+SCirt
	3yqAFu1Q2ganyRnV1VUoDMG+AjSKFzzM2EgYBbHU8jvY/avc2Yf+RCr1l0AbGJg88wCDczkk2m+
	cb3MWu1USeca6D4BhK3Xl6c4F5K2iT8xm4/iWcEuPuRb1e06rfPVHFaZMzDOfSvm69FCgda41lF
	Fa+34nUmRilXE6XWf0Iov1X2AH5iw0WK1Qj2NDOPtHc8bZqZ58hJRKHEwrltClh/ZQNhY=
X-Received: by 2002:a05:6214:1301:b0:88e:6db7:f999 with SMTP id 6a1803df08f44-8942e0c342cmr235499176d6.6.1768933100910;
        Tue, 20 Jan 2026 10:18:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e535dsm114108506d6.4.2026.01.20.10.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:18:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viGJ1-00000005aZS-41Vi;
	Tue, 20 Jan 2026 14:18:19 -0400
Date: Tue, 20 Jan 2026 14:18:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA/mlx5: Implement DMABUF export ops
Message-ID: <20260120181819.GT961572@ziepe.ca>
References: <20260108-dmabuf-export-v1-0-6d47d46580d3@nvidia.com>
 <20260108-dmabuf-export-v1-2-6d47d46580d3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-dmabuf-export-v1-2-6d47d46580d3@nvidia.com>

On Thu, Jan 08, 2026 at 01:11:15PM +0200, Edward Srouji wrote:
> +static int phys_addr_to_bar(struct pci_dev *pdev, phys_addr_t pa)
> +{
> +	resource_size_t start, end;
> +	int bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +		/* Skip BARs not present or not memory-mapped */
> +		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> +			continue;
> +
> +		start = pci_resource_start(pdev, bar);
> +		end = pci_resource_end(pdev, bar);
> +
> +		if (!start || !end)
> +			continue;
> +
> +		if (pa >= start && pa <= end)
> +			return bar;
> +	}

Don't we know which of the two BARs the mmap entry came from based on
its type? This seems like overkill..

Jason
