Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCD2D46B4
	for <linux-media@vger.kernel.org>; Thu, 12 Feb 2026 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770901170; cv=none; b=TpyAm9cewTTuVr6gNUKYe+0rOxm5T8EQLWt4EKV6sSdvfV07ZzXHEr+DIPLGufXDXsfMMwKAp9CC10+VlWwPQ56r6RVyAtUUlo7yxcGhS2F/EOrv28lWD6Tmc8UllpO3vR8d/wD69FlwhrNQsnIrkXNOVLCko+cteI4yNzxCny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770901170; c=relaxed/simple;
	bh=hKm6UG355NcmHoXuK7RCiJgmqW4+Cd+FFx9LvN0aXko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdyBcjAQY9xtKjXyoqQSRzlbeHBpbREwlm8FEAA5Ab16vjPZbnS64JAHUmP/4mUz7dpUgCQTtc4r5epsYYaPMxrjjq75Nv0VFtFmghRXJuTyKQP+fl2wqYa5+JfZj24637bHWA5B0dmt3OX+LhdubeRH/39QtPlnHNqe+7tgBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=U+901ms3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U+901ms3"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4E236E70;
	Thu, 12 Feb 2026 13:58:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770901119;
	bh=hKm6UG355NcmHoXuK7RCiJgmqW4+Cd+FFx9LvN0aXko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+901ms39uBqAbTboT8e3cRkQzSFHQ0Wp9s1F0JEkDn/BQBGjZOZfzl9Wy0rIjjw3
	 2uY6kveNifrufSc68ErEw1Ww2QPV3sIS0HN7haeF71TQnqcnAvsGYJmiHNDUzr9XcF
	 w3P4ypnFxri8YoTzX/fdwBtgBYuWNBzKT7yRYme4=
Date: Thu, 12 Feb 2026 14:59:25 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org
Subject: Re: [yavta PATCH 1/1] Print integer menu items also in hexadecimal
 form
Message-ID: <20260212125925.GC2631855@killaraus.ideasonboard.com>
References: <20260212124324.1877305-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212124324.1877305-1-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Thu, Feb 12, 2026 at 02:43:24PM +0200, Sakari Ailus wrote:
> Print integer menu items also in hexadecimal form for better readability
> on some controls.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  yavta.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/yavta.c b/yavta.c
> index f2d5ea325072..d4c7216ef3de 100644
> --- a/yavta.c
> +++ b/yavta.c
> @@ -1471,8 +1471,8 @@ static void video_query_menu(struct device *dev,
>  			printf("  %u: %.32s%s\n", menu.index, menu.name,
>  			       menu.index == value ? " (*)" : "");
>  		else
> -			printf("  %u: %" PRId64 "%s\n", menu.index,
> -			       (int64_t)menu.value,
> +			printf("  %u: %" PRId64 " (0x%" PRIx64 ")%s\n", menu.index,
> +			       (int64_t)menu.value, (int64_t)menu.value,
>  			       menu.index == value ? " (*)" : "");
>  	};
>  }

-- 
Regards,

Laurent Pinchart
