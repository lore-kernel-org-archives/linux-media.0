Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425501428D;
	Thu,  7 Dec 2023 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hri+49dv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F73C433C9;
	Thu,  7 Dec 2023 06:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701931956;
	bh=lPKwF3kdsIYd1OD7+HVH5a6Y8sFi9im8Lkn4cxRrJdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hri+49dv5qf8qMtGvCIX9NcHBndIBYnZTtrH4TYEmSEF1NYiHP2AUWVZ3gZ/SRsmV
	 SXTLOywSocUr+gb5xP+4Fxple9klI1Im1gaVzZGD+Et8KEXEti9yFq+p8vugpHSjZy
	 byWo0wzOLXMoz8Wuyyh/MXRdP6zVWu0L1wFkgMqc=
Date: Thu, 7 Dec 2023 11:39:07 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dan Carpenter <error27@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	"Ricardo B . Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH v3 1/4] staging: vc04_services: Drop vchiq_log_error() in
 favour of dev_err
Message-ID: <2023120750-engorge-wham-83a0@gregkh>
References: <20231205084157.73819-1-umang.jain@ideasonboard.com>
 <20231205084157.73819-2-umang.jain@ideasonboard.com>
 <d6bf7115-dd15-43a0-b45a-41fc778ff160@gmx.net>
 <6a8566c0-bd26-4ec1-9f7d-d58bbed8411c@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a8566c0-bd26-4ec1-9f7d-d58bbed8411c@ideasonboard.com>

On Wed, Dec 06, 2023 at 10:57:59AM +0530, Umang Jain wrote:
> Hi Stefan
> 
> On 12/6/23 1:02 AM, Stefan Wahren wrote:
> > Hi Umang,
> > 
> > Am 05.12.23 um 09:41 schrieb Umang Jain:
> > > Drop vchiq_log_error() macro which wraps dev_dbg(). Introduce the usage
> > > of dev_err() directly.
> > sorry, i missed to review the last change. So the change won't be that
> > trivial.
> 
> All the changes you said are valid and I have taken a note of it.
> 
> However, I think it would best that if we can address them in a separate
> series on top of this (and I will do it). It would seem to be streamlined on
> top of this.

Agreed, I'll merge this now so you can make forward progress here,
thanks!

greg k-h
