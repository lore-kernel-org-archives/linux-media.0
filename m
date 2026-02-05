Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A443C05E
	for <linux-media@vger.kernel.org>; Thu,  5 Feb 2026 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310762; cv=none; b=u9+NxKwohdoN4VI+iqjgl0XwtEgDhYKvu52DWnSlDuJZFH5Ty4ttL120zlTHhFpFbZVqjbvGSQ21YpEiH/aAl4sVpwVsasH3FJQkZoRueP28FyguDeYWGVnfdzXwaLt9ohLfrPDkt/WL5BCxKDx8vlu8bsTbEiZQU0Uo/oZqVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310762; c=relaxed/simple;
	bh=pBCmSCbX1dLAqczsNgFh/4/XcJp3lXEVtRZkjXbqSKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKCxV7wStJ/3+kIKCd3MzNs0AvnbHHlEYF83Br/0nD8uHTDtdmx6QCShZKKHjZdfA3zuSDMeKE8MXAxlEv31Dh0CtSQdWCtCQTTTiLXlV8/n8s3vOHOx4J0yNeK9CdAloDicsICMWf4eLxGMNl/+rHhlqFG2ZFkOgl4l9eIkk+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=f01Tigv0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="f01Tigv0"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id C5EEF227;
	Thu,  5 Feb 2026 17:58:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770310711;
	bh=pBCmSCbX1dLAqczsNgFh/4/XcJp3lXEVtRZkjXbqSKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f01Tigv0GQBzFcm4pqmyluqynlfnkp3fBThTOaEXtdus+eoQKtj14kyEysjyLNY8h
	 NNaO6VeP7m9Zps5mDnqVaxIDjwcFzfHPuaxCFYox614ngKi/2HqTyrriyp2EWBTBfD
	 RpjMfBC4KYRUZUGB4ZWtSiEmZXjHQilsjQvvlJrw=
Date: Thu, 5 Feb 2026 18:59:12 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sean Young <sean@mess.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCHv7 2/3] docs: media: document Media Maintainers
Message-ID: <20260205165912.GO156228@killaraus>
References: <cover.1769511207.git.hverkuil+cisco@kernel.org>
 <74976e732f6be2964e0371c73407c9dccf755424.1769511207.git.hverkuil+cisco@kernel.org>
 <444435bf1e67841c49b22cb9b4a41c8c17c710e4.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <444435bf1e67841c49b22cb9b4a41c8c17c710e4.camel@collabora.com>

On Thu, Feb 05, 2026 at 09:24:26AM -0500, Nicolas Dufresne wrote:
> Le mardi 27 janvier 2026 à 11:53 +0100, Hans Verkuil a écrit :
> > Document who the Media Maintainers are and what their
> > responsibilities are.
> > 
> > Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
> > ---
> >  .../media/maintainer-entry-profile.rst        | 47 +++++++++++++++++--
> >  1 file changed, 44 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/driver-api/media/maintainer-entry-profile.rst b/Documentation/driver-api/media/maintainer-entry-profile.rst
> > index be4728b97759..4f73ee073860 100644
> > --- a/Documentation/driver-api/media/maintainer-entry-profile.rst
> > +++ b/Documentation/driver-api/media/maintainer-entry-profile.rst
> > @@ -346,13 +346,54 @@ With the pull request workflow, pull requests shall use PGP-signed tags.
> >  For more details about PGP signing, please read
> >  Documentation/process/maintainer-pgp-guide.rst.
> >  
> > -Subsystem Media Maintainers
> > ----------------------------
> > +List of Media Maintainers
> > +-------------------------
> >  
> > -The subsystem maintainers are:
> > +The Media Maintainers listed here all have patchwork access and can
> > +make Pull Requests or have commit rights.
> > +
> > +The Media Subsystem Maintainers are:
> >    - Mauro Carvalho Chehab <mchehab@kernel.org>
> >    - Hans Verkuil <hverkuil@kernel.org>
> >  
> > +The Media Core Maintainers are:
> > +  - Sakari Ailus <sakari.ailus@linux.intel.com>
> > +
> > +    - ISP
> > +    - sensor drivers
> > +    - v4l2-async and v4l2-fwnode core frameworks
> > +    - v4l2-flash-led-class core framework
> > +
> > +  - Mauro Carvalho Chehab <mchehab@kernel.org>
> > +
> > +    - DVB
> > +
> > +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +
> > +    - Media controller drivers
> > +    - Core media controller framework

You could list me for ISPs as well, Sakari and I handle the together.

I'm not alone there of course, it's a team effort and Dan and Jacopo are
also active in developing and reviewing multiple ISP drivers. Not that
we necessarily want to list them in this document (and I don't know if
they would be interested), but I want publicly credit them in this mail
for the work they do.

> > +
> > +  - Hans Verkuil <hverkuil@kernel.org>
> > +
> > +    - V4L2 drivers
> > +    - V4L2 and videobuf2 core frameworks
> > +    - HDMI CEC drivers
> > +    - HDMI CEC core framework
> > +
> > +  - Sean Young <sean@mess.org>
> > +
> > +    - Remote Controller (infrared) drivers
> > +    - Remote Controller (infrared) core framework
> > +
> > +The Media Driver Maintainers responsible for specific areas are:
> > +  - Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > +
> > +    - Codec drivers
> 
> I also took care of M2M color converters lately, while trying to delegate when
> it makes sense (such as DWL100 delegated to Laurent). So we may (or may not)
> add:
> 
>        - M2M driver not otherwise delegated
> 
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> 
> > +
> > +  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > +
> > +    - Qualcomm drivers
> > +
> >  Submit Checklist Addendum
> >  -------------------------
> >  

-- 
Regards,

Laurent Pinchart
