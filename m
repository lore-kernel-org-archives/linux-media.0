Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803D2B9A4
	for <linux-media@vger.kernel.org>; Wed, 11 Feb 2026 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807357; cv=none; b=dkBzTHqJ7bWaF0iahobNgMa4Eu7JyEfGk9kejwQRivWRHn7N/KRCfhjNSNIzQozF/0wmmcBkDI+pZLSpwLXgqf2u4eP5iaVko4+vuL+hvUKilcY+fmXBMTAA3388pmAVQ+/QuQz1wcIzN3nhAzVw9dIU6ocdQKTgq1nC6eH0M70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807357; c=relaxed/simple;
	bh=o5PyVut9mFnogPfJTpx6UNaVmRTHd4I/GHi44O5qJLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssZr6wnHI9Z3U1NAKeyfkjX29jTwfreWugB/+ygQPmWwYQCHbC9Vz+FutA7Obf1WnrXnEMBr/LP83Zt0vJHi4JcMn2enVxkqEnfl5WLY7UmSvxqLJFMENnuTivMdjvWHqLKdBRlHhn/mmmH+w/aEMwPzpe0Xz4IFvpPi4/TtN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0PjoNFm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0PjoNFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF828C2BC86;
	Wed, 11 Feb 2026 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770807356;
	bh=o5PyVut9mFnogPfJTpx6UNaVmRTHd4I/GHi44O5qJLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n0PjoNFmB4qpd+hxQODctVatVU1wSV4GlVXt8uvXxgTJIRnuii6FiuwbKtnF/Ybzj
	 wYvJ+u8wsCm/Ubs7tPcXdpTTe4rQv2J9p5BLTglnhrn2e09MpWXMgdCTnU2MKqsh2I
	 tyK0qTyFbzQAObH2zTmbODt0Bm4am7vEqxYMcq63b/mhCpHnTSAKWkVoLd5bnLdnk4
	 eprLnp+x9+gLU1xq0ofOvo4DJbfYOn8ZEuQTIs25nTsz0RwuUd2mHK+8qDA79I2OKO
	 caS1CjV6dd17LkdSNdeuc2G3JpOaItG1tv6qJ90C6cBIgX3iWluNEFvldFoRR8kBXH
	 Xw+uuWhED41rg==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vq7sw-00000002iv4-1xnn;
	Wed, 11 Feb 2026 11:55:54 +0100
Date: Wed, 11 Feb 2026 11:55:52 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Sean Young <sean@mess.org>, Nicolas
 Dufresne <nicolas.dufresne@collabora.com>, Bryan O'Donoghue
 <bryan.odonoghue@linaro.org>, Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCHv9 0/3] docs: media: multicommitters model documentation
Message-ID: <20260211115552.4241695f@localhost>
In-Reply-To: <cover.1770800320.git.hverkuil+cisco@kernel.org>
References: <cover.1770800320.git.hverkuil+cisco@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 09:58:37 +0100
Hans Verkuil <hverkuil+cisco@kernel.org> wrote:

> The main changes since v8 are:
> 
> - Typo/grammar fixes from Mauro
> - Added additional maintainer areas for Laurent and Sakari (patch 2/3)
> - Additional links to git development trees
> 
> Patch 1/3 updates maintainer-entry-profile.rst: it introduces the
> three Media maintainer levels (Media Driver Maintainer, Media Core Maintainer
> and Media Subsystem Maintainer) and what the responsibilities are.
> 
> Patch 2/3 adds back and updates the list of Media Maintainers that
> disappeared in patch 1/3. Please verify this whether the email
> addresses are the correct ones, and verify that the areas of responsibility
> are correct and that nothing is missing.
> 
> Patch 3/3 adds media-committers.rst: that focusses on the additional
> commit rights that can be granted to a Media Maintainer.
> 
> I have uploaded the documentation with these patches here:
> 
> https://hverkuil.home.xs4all.nl/spec/driver-api/maintainer-entry-profile.html
> https://hverkuil.home.xs4all.nl/spec/driver-api/media-committers.html

Heh, every time I read I find minor issues, but at this point, I guess
this version does the job. So, let's stick with it.


> 
> Regards,
> 
> 	Hans
> 
> Hans Verkuil (1):
>   docs: media: document Media Maintainers
> 
> Mauro Carvalho Chehab (2):
>   docs: media: update maintainer-entry-profile for multi-committers
>   docs: media: document media multi-committers rules and process
> 
>  Documentation/driver-api/media/index.rst      |   1 +
>  .../media/maintainer-entry-profile.rst        | 461 +++++++++++++++---
>  .../driver-api/media/media-committers.rst     | 201 ++++++++
>  3 files changed, 601 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/driver-api/media/media-committers.rst
> 


-- 
Thanks,
Mauro
