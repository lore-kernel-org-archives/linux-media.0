Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2923D3300;
	Tue,  3 Feb 2026 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135715; cv=none; b=anz1WDac29Q9dK/gO7IblXtjXdyoqyNVGWWXe38FGb1YvLcz8scXBqpI+Uxqo9+i20OjtvFbIu1P9SE/XA3KF2M67ptZn/s5SPMkeuRUFYbhRZHrKLSuyDWlTmqThDkUBL8CdJS/Jh96P62KYcx7w8xz/aYa2cUuOGYeE2BV1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135715; c=relaxed/simple;
	bh=rViw38hzsFzwfp5AkYCV+UOVkhK0MIHotHybYBycIpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2ZJf6ZdN3uhx4ZAutXg7D7OaUepqet5Cq8XNf9NIZL5RNPbUmiF032Fy9FFjxePwBPDo8BwYoEluRZ6QmZ6Uw6yx+Gig2e3fChGtMe77JuxcX7q8yF9jT9MjYNXe3DcRHKtgOvFC8jAb9kf+IZBahaQvpL+7bQhC/pLAYhpJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ib3nm4tT; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ib3nm4tT"
Received: from LAPTOP-N070L597.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 32fb5e6d1;
	Wed, 4 Feb 2026 00:21:41 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: andriy.shevchenko@intel.com
Cc: andy.shevchenko@gmail.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hansg@kernel.org,
	hverkuil@kernel.org,
	jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH v3] media: atomisp: Fix memory leak in atomisp_fixed_pattern_table()
Date: Tue,  3 Feb 2026 16:21:40 +0000
Message-Id: <20260203162140.3891753-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aYIPg22Z-GDOy1fG@smile.fi.intel.com>
References: <aYIPg22Z-GDOy1fG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c244f467103a1kunme69920582c4f55
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUNJVhpLGRlCT0tPH0lKSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ib3nm4tTJZm5YYCwvQw0aC7p5ARSH5NKoM7ow8PvfQmpnYlV7YpGKjRU9H4TVpeJSo7wAZIrYhvSHQq3lDJ38t65o21/UZVhFw7gRyYXvRfsRZO+kWntIvhH0yUGb+yyc8ptmkWtWZsfxRZSt2h1+ZaO5bgxzYfWLTxHLazbVss=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=8KEZcYErh+xZg9qg77kJUS1/v839M5oAG507BjX2Sg0=;
	h=date:mime-version:subject:message-id:from;

On Tue, Feb 03, 2026 at 05:08:51PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 01:56:59PM +0000, Zilin Guan wrote:
> > atomisp_v4l2_framebuffer_to_css_frame() allocates memory for
> > temporary variable raw_black_frame, which must be released via
> > ia_css_frame_free() before the function returns. However, if
> > sh_css_set_black_frame() fails, the function returns immediately without
> > performing this cleanup, leading to a memory leak.
> > 
> > Fix this by assigning the return value of sh_css_set_black_frame() to
> > ret. This ensures that the error code is propagated while allowing the
> > execution to fall through to the ia_css_frame_free() cleanup call.
> > 
> > The bug was originally detected on v6.13-rc1 using an experimental
> > static analysis tool we are developing, and we have verified that the
> > issue persists in the latest mainline kernel. The tool is based on the
> > LLVM framework and is specifically designed to detect memory management
> > issues. It is currently under active development and not yet publicly
> > available.
> > 
> > We performed build testing on x86_64 with allyesconfig. Since triggering
> > this error path in atomisp requires specific Intel Atom ISP hardware and
> > firmware, we were unable to perform runtime testing and instead verified
> > the fix according to the code logic.
> 
> > Fixes: 85b606e02ad7 ("media: atomisp: get rid of a bunch of other wrappers")
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> I haven't suggested this patch. I only provided a hint on a better
> implementation, so there are no grounds to have this tag to be here.
> 
> Replace that with
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> as current version LGTM.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Hi Andy,

Thank you for the review and clarification.

I apologize for the misunderstanding regarding the Suggested-by tag. 
I will remove it and apply your Reviewed-by tag in the next version.

Best regards,
Zilin Guan
