Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499063090C2
	for <linux-media@vger.kernel.org>; Mon,  2 Feb 2026 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062917; cv=none; b=T1jsofge6XQax9ollcjBYqP2BiH8mVesYjp/BEyBsQuoaam68tsrJcOyJ8eR3W7G7sXJIWwlThCr58nwNfVvqHuVSCHTNAMGW6ApsAIbMSXDzqNDzwDh0kSe2AgLKhv4wzy2caNIyg072Fmy4+a3LDkg405NujqsAhBhME1Krwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062917; c=relaxed/simple;
	bh=z5ezqF8xkEHg+o9+YAyPSvw5wr+U/Be3CmkY2XvRh5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgUFj+YW2Mehva/FOYYgMu1zzKRud9GKtufIxe0loXz08hT8oeHmupPbELXT5ty1UjTd0LCK5BBaMzwoUuMVVwKQau9rNo0IOAJQXpglfHM+3h2eoLzmaYqqoJGjZLFcAxvrKuZogppBKGllGXmh7+Ig4eKQ8B/cQFMQaIL61a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBfHIbC2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBfHIbC2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so52114585e9.2
        for <linux-media@vger.kernel.org>; Mon, 02 Feb 2026 12:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770062915; x=1770667715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVWit5gEYvimCyPQVV7/Ca5DAiIkOlL8U62ipYN06HA=;
        b=JBfHIbC2RpATrchF9IYLlad83vMxnhG25aAt7mKSq04XxB0WJ9+yiAo7VSuqGmucoJ
         xp0r61ia7SMIglKB45Tw4xmAohAhlutireagpR0zQOXKJOJDpcKcMwRdzY/wFYxf7cAx
         +UKzssMrNuW4I/5uXqC24gn1ocb5oy3dOpKMxEJivxQSMhVo8iIhgszgsbGjgEu2Qk1I
         MSHkfKgj7gkGcDqvSyRX01SVePckkGg8LhGHuSaJWF33+9INCOqZuv8lAvSM402d/0EF
         JloiGO/ARyHOgYiSVcjW9v0OM5UBo7Us7Y7kdovc8BbrGP3wivbpXUVzyDpjuYkvODuy
         REsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062915; x=1770667715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVWit5gEYvimCyPQVV7/Ca5DAiIkOlL8U62ipYN06HA=;
        b=f0Kw504uFT7MesM0QoSMXYuGFzmhulejAFF1Uo22TMc2249dlfIuracR1VWFh2mC2C
         8i9LKbFC5ir9b+/lutu1trV84P/AloQl67cjX61ejfnkWKwL4TLFBrO4IJ0IntcYKP5u
         xpQof8InGa2Vpoa+xLVIbvxFtu+0PmoGNVLKPlAlwIA3YHf76CKl3VDb7PQK/o0YCA1O
         cUl6Zhl0sQOAzW7I0pjdRv+TONjwhHscfXqZKHHeObRaiuGyiRR3Z41UcULpCtH7PN/J
         crBIGnz7HZKOM5FRampUgw6sKdvTfZ/gA20FJ+/XuAw8kLNB+oX00hZeBuOfQ2Z2+XnD
         YGZA==
X-Forwarded-Encrypted: i=1; AJvYcCXDIAtcwj15TNGqL/Q4q2Q5rrjgHTDP+yuKHLDK7A8eAb1iOHANxZXokgPMj+rOCtAJqefPZbetkoJvyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiGhq3yaacYxuFJGfrg1NYxg5vEFxIVg/QrhFSp6KxlnClKgq
	jB7sU1pKk69BrqR2QfvdTrsUAHJSlcgmMC/KkaagIzs5kUxHPptN+VLVC4PZ/UqmN7o=
X-Gm-Gg: AZuq6aLgRtXshEZFk7k7sa/cevbG7djtab+ocHnVfCKTBmtyHKc5TwgEaYhxkzhOH2O
	yxtdUD9i83zmErCAkieWfD/l2krk0hLFdO6iNZJviDds8m8/AxuZoU1XFfAylR4BV0V/4PUmUz2
	3C8GnsELKAxZJwdO1LjeAzG8yHQEhenfFT+IUaEYi6DEDzNkdN9m5ocqYlzjPF7lezwUX9jI5Pu
	PwXUR1hMohHq6cjv5wk6nr64QmSNrOTMOxq27lwt4EOx4bJax1jVMsBLsqQPASiP/K6RfHwa/cE
	TzO+y7muqjxuyWTvwPFJjmbprbR9Kw1M47fXILPK8Y2ULzIAPjbedFXTsrFmphCR1+Vorr5Twnz
	EF4zvHZ4oJGPhS7xJElP73q3iC5NcNgkGHZpqJN05zV63EYEy5DssH4xPvVu+18h0OC1yNAkKVe
	7a4rnDVBECgpzJzNvE
X-Received: by 2002:a05:600c:a08c:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-482db493a7cmr155741285e9.18.1770062914672;
        Mon, 02 Feb 2026 12:08:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce70sm47807259f8f.27.2026.02.02.12.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:08:34 -0800 (PST)
Date: Mon, 2 Feb 2026 23:08:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bogdan Sandu <bogdanelsandu2011@gmail.com>
Cc: gregkh@linuxfoundation.org, bingbu.cao@intel.com,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, mchehab@kernel.org,
	sakari.ailus@linux.intel.com, tian.shu.qiu@intel.com
Subject: Re: [PATCH v2 4/4] media: ipu3: use BIT()
Message-ID: <aYEEP0m-1_xAXZZV@stanley.mountain>
References: <2026020258-very-numbly-b36b@gregkh>
 <20260202175033.8640-1-bogdanelsandu2011@gmail.com>
 <20260202175033.8640-5-bogdanelsandu2011@gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202175033.8640-5-bogdanelsandu2011@gmail.com>

On Mon, Feb 02, 2026 at 07:50:33PM +0200, Bogdan Sandu wrote:
> Prefer BIT() macro over manual bitshift.
> 
> Signed-off-by: Bogdan Sandu <bogdanelsandu2011@gmail.com>
> ---
>  drivers/staging/media/ipu3/ipu3-mmu.c | 2 +-
>  drivers/staging/media/ipu3/ipu3-mmu.h | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/ipu3/ipu3-mmu.c b/drivers/staging/media/ipu3/ipu3-mmu.c
> index cb9bf5fb2..95ce34ad8 100644
> --- a/drivers/staging/media/ipu3/ipu3-mmu.c
> +++ b/drivers/staging/media/ipu3/ipu3-mmu.c
> @@ -21,7 +21,7 @@
>  #include "ipu3-mmu.h"
>  
>  #define IPU3_PT_BITS		10
> -#define IPU3_PT_PTES		(1UL << IPU3_PT_BITS)
> +#define IPU3_PT_PTES		(BIT(IPU3_PT_BITS))

IPU3_PT_PTES isn't a bit, it's the number of PTEs.  It's just shifting
because it's a power of two and that's how you calculate power of two.


>  #define IPU3_PT_SIZE		(IPU3_PT_PTES << 2)
>  #define IPU3_PT_ORDER		(IPU3_PT_SIZE >> PAGE_SHIFT)
>  
> diff --git a/drivers/staging/media/ipu3/ipu3-mmu.h b/drivers/staging/media/ipu3/ipu3-mmu.h
> index a5f0bca7e..990482f10 100644
> --- a/drivers/staging/media/ipu3/ipu3-mmu.h
> +++ b/drivers/staging/media/ipu3/ipu3-mmu.h
> @@ -5,8 +5,10 @@
>  #ifndef __IPU3_MMU_H
>  #define __IPU3_MMU_H
>  
> +#include <linux/bitops.h>
> +
>  #define IPU3_PAGE_SHIFT		12
> -#define IPU3_PAGE_SIZE		(1UL << IPU3_PAGE_SHIFT)
> +#define IPU3_PAGE_SIZE		(BIT(IPU3_PAGE_SHIFT))

Same.  This is a size, not a bit.

regards,
dan carpenter

