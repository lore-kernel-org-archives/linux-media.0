Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF629156F9;
	Wed, 22 Nov 2023 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2YTstX2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7CFC433C7;
	Wed, 22 Nov 2023 12:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700655784;
	bh=DFhsCyEH5nky3Jc1oIQ8dW/1lPBVcizFpK8ZXl27xXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2YTstX2MYQv0mw9KfEDkiXLQ6NHWhsucvPF4FUR4ltAkcqYMd19EFBp2ruC4yMR01
	 tw5Vd9qVwhjn7oKsdbtg4vwFNYUMFunO+RGYk+VLhIi522hKYQ+mOJcb6LKMo40T7w
	 B3u9LsEw01kru4z1ieQyCHG1YLWWwDV4vBpXBuUI=
Date: Wed, 22 Nov 2023 12:23:00 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	"Ricardo B . Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH V2 0/3] staging: vchiq_arm: move state dump to debugfs
Message-ID: <2023112238-acting-removing-50bd@gregkh>
References: <20231029124837.119832-1-wahrenst@gmx.net>
 <8351ddaf-c63e-4527-809f-d002bd79ad14@gmx.net>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8351ddaf-c63e-4527-809f-d002bd79ad14@gmx.net>

On Wed, Nov 22, 2023 at 01:17:07PM +0100, Stefan Wahren wrote:
> Hi Greg,
> 
> Am 29.10.23 um 13:48 schrieb Stefan Wahren:
> > Hello,
> > 
> > since recent discussion raised the question about the future of debugfs
> > for vchiq [1], i want to submit this cleanup patch series as part of the
> > discussion and a small Halloween present ;-)
> > 
> > Best regards
> > 
> > Changes in V2:
> > - rebase on top of current staging-next
> > - address suggestion from Laurent Pinchart in patch 1
> > - fix checkpatch issue (too long line) in patch 2
> > 
> > [1] - https://lore.kernel.org/lkml/7ea529c2-3da6-47df-9b09-28d4ab36c4ef@kadam.mountain/T/
> > 
> > Stefan Wahren (3):
> >    staging: vchiq_core: Make vchiq_dump_service_state static
> >    staging: vchiq_core: Shorten bulk TX/RX pending dump
> >    staging: vchiq_arm: move state dump to debugfs
> 
> should i resend incl. the received Reviewed-by tags?

No, just wait for me to catch up with staging patches.  Should be a week
or so...

tjhanks,

greg k-h
