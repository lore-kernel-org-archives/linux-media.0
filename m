Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F22951002;
	Thu, 30 Nov 2023 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="j9fUKgwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92729C433C7;
	Thu, 30 Nov 2023 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701361822;
	bh=ZC5pdnxtaALPr6AWPyuqbZFGRFQlJPG/PBmeu7mFd8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j9fUKgwHvAvpJw63f0OOVvKu178+7dLQWz79YoLP6ltAqLBv/iEYG68qz3K87fUug
	 4pc6HKgv7hslYeC/wBGkZYsK0oRaz8DX6zzgnOcE3uxvBr9HnlieG/rCIEAESTCAJw
	 mwQe49iP1ijKKhRO0BVXrlDfZz5dBzPSbqVJKD2Y=
Date: Thu, 30 Nov 2023 08:30:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Antti Palosaari <crope@iki.fi>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Media Subsystem
 <linux-media@vger.kernel.org>, Linux Memory Management List
 <linux-mm@kvack.org>, Linux Kernel Janitors
 <kernel-janitors@vger.kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Drop Antti Palosaari
Message-Id: <20231130083021.a99013c58318ebe66b408f2d@linux-foundation.org>
In-Reply-To: <9da4252b-269b-c25b-c485-afdcd8207268@iki.fi>
References: <20231130083848.5396-1-bagasdotme@gmail.com>
	<9da4252b-269b-c25b-c485-afdcd8207268@iki.fi>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 10:43:16 +0200 Antti Palosaari <crope@iki.fi> wrote:

> Hello,
> 
> On 11/30/23 10:38, Bagas Sanjaya wrote:
> > He is currently inactive (last message from him is two years ago [1]).
> > His media tree [2] is also dormant (latest activity is 6 years ago),
> > yet his site is still online [3].
> > 
> > Drop him from MAINTAINERS and add CREDITS entry for him. We thank him
> > for maintaining various DVB drivers.
> > 
> > [1]: https://lore.kernel.org/all/660772b3-0597-02db-ed94-c6a9be04e8e8@iki.fi/
> > [2]: https://git.linuxtv.org/anttip/media_tree.git/
> > [3]: https://palosaari.fi/linux/
> > 
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> > Essentially no change from RFC [1]. However, since there is no response on
> > RFC (including from Antti), let's drop him so that Cc: lists can be
> > a bit shorter.
> 
> Acked-by: Antti Palosaari <crope@iki.fi>

A shame, but thank you for all your work!
