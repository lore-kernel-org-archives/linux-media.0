Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F62D061D;
	Sun,  1 Feb 2026 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769933416; cv=none; b=TUDtKSzSX+eHjHB3ZqQztXVLFINy1UU6zdOjBrmZY/tHZXlhfBt7gwhxfx3tkf++0DexFljgd9Nl2fzZud14k2K+pXN62DI8EVK3RSOsUYrf1yqWIEbaq9Lebfk36urUStyQz8ZmcCFc2ANl1NwsKGHzG2Mx7zQeTNyzzBxqGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769933416; c=relaxed/simple;
	bh=QVUPPyi0Q6yHUSxcWcuz+4VlCKMlW0eUTqvgjfZT2/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR6vUxjkx0IqqaP6YBR2zt0+HlYpE5RSMG0OXfkgHZ3r+j/42Y/z75nvX77n+g4Hp8sef9Z/RDs9ozwUMRqE834aKxsePJC+IR9fRRwopZrmPiwz0Wa+Jk5h2+/6X0XnADpHhT1UM17xyVIv0spyL+AjzaIbtBALyT1Dq0EV8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p7ybh4nx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p7ybh4nx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54835C4CEF7;
	Sun,  1 Feb 2026 08:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769933415;
	bh=QVUPPyi0Q6yHUSxcWcuz+4VlCKMlW0eUTqvgjfZT2/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7ybh4nxrKehy/ltSYR/jjeipLwlSukaJjbuIpurob61pkSu6IrROghdgstHDGWJi
	 e3y+/D/mJTL8145ZDcZngTJMcfYK1ux9wuJDInvQnjAwm2aN23OcujAmQSeeR5Eiaj
	 eOTo02Gf5mA2mubqXQ18cTty2yPV8/d7uXcq/B3I=
Date: Sun, 1 Feb 2026 09:10:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: hansg@kernel.org, mchehab@kernel.org, sakari.ailus@linux.intel.com,
	andy@kernel.org, hverkuil@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] media: atomisp: Fix memory leak in
 atomisp_fixed_pattern_table()
Message-ID: <2026020156-carry-progeny-168c@gregkh>
References: <20260201072107.1797351-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201072107.1797351-1-zilin@seu.edu.cn>

On Sun, Feb 01, 2026 at 07:21:07AM +0000, Zilin Guan wrote:
> atomisp_v4l2_framebuffer_to_css_frame() allocates memory for
> raw_black_frame, which must be released via ia_css_frame_free().
> However, if sh_css_set_black_frame() fails, the function returns
> immediately without performing this cleanup, leading to a memory leak.
> 
> Fix this by assigning the error code to ret and allowing the code to
> fall through to the ia_css_frame_free() call.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.

Please properly document this as per the rules we have for using tools
like this.

thanks,

greg k-h
