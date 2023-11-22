Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="DA+dU0F/"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028851706
	for <linux-media@vger.kernel.org>; Wed, 22 Nov 2023 04:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1700655596; bh=C5uEHWw0ck0yC6ePUY2cLaXlArnY9vjuPeY5+3yy3Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DA+dU0F/SErJhIw9vAicDxhQJtSc+H+pGD4Jm+kiIpjhnmszG/OjHQsIk9LGI4KXO
	 HkVdOHLFVUV3/zTstgPZmoM+eSzQaZsovXWhkcqtK19jiN6dizKt2e0ZBxlJz6bb8G
	 a6YIpEIUe5dHw3STzjdBvUBVVqoOC3hlKueY7EGyDy6MSFp5//W1+CdxBfnDLrEZcU
	 DpRTKqT2ILmI6wznbIZaFoqngMb1ia75RIfpYF94dXhhMBnpVTPSGHsDTpI0MJVpDx
	 inO+veeEuMvbzQ+Bdj1u6EaFvGcm5+uEUCKcUomdN7bs9/eIomf+TB2OWScSM/iDaM
	 Pdqflo+rDpdAQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 68D301000CD; Wed, 22 Nov 2023 12:19:56 +0000 (GMT)
Date: Wed, 22 Nov 2023 12:19:56 +0000
From: Sean Young <sean@mess.org>
To: Gregor Jasny <gjasny@googlemail.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: New v4l-utils release?
Message-ID: <ZV3x7EBufjZd6Pkg@gofer.mess.org>
References: <12b6687c-2517-4844-abd4-1e64f83c27b6@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b6687c-2517-4844-abd4-1e64f83c27b6@googlemail.com>

On Wed, Nov 22, 2023 at 01:03:34PM +0100, Gregor Jasny wrote:
> Hello,
> 
> do you have any objections or blockers for a new v4l-utils release on the
> upcoming weekend?

Nothing from me - however there are a bunch of IR fixes that would be
nice to get released, so I'm all for a release. Thanks!


Sean
