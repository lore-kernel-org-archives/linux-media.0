Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B33590C3;
	Mon,  2 Feb 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032474; cv=none; b=FGAQztwb7nNcL5lh5b+vx7BINqSW6dBEvoe65CaMflquwknff48HD1QDlw6mMxvsH1WGLzqMix2ZJe1P+7pl6U2LW37fIvrpN/T1ub8cJwCUG6Orh/8UJuEwCv46tZGOMEMalkVToMauwDYc57lSdqR0oUtnktARZggX6YVpKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032474; c=relaxed/simple;
	bh=MrjzcWn00//g9RHO/pScfMTyKrxPM72MZTQiOj3fNX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1q4eKZFApTghTeORXHXwswMUxvocFd4g358r0AI4xLX413ax7+wJ/uoExZUodxtF1HyHlabIhUBoA93XtO7pm8HTjRsRcWhZFxEp1rIP/HtNhXbkoxBPACyk9ACIPbC3gr8omVltTWZOl2litfrVAvNVIejlKuQMWQdaP4E4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R88vGR1S; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R88vGR1S"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4435A492;
	Mon,  2 Feb 2026 12:40:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770032431;
	bh=MrjzcWn00//g9RHO/pScfMTyKrxPM72MZTQiOj3fNX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R88vGR1S8VGe86LRQlRg/kszqE/KM0B/ZuCydAEtCT5Jv3b9YK6Y3CYohPjwARMzZ
	 zpxcM73zFBcJX05RPHQpRI1Gbwd6F8cMxA430Xjc0UblRwABEYUPMs/YbGgUVfjs+2
	 ynfy7ePmTGT1MW/DK1uYH+Zt8nVuWyds8SaA/rhY=
Date: Mon, 2 Feb 2026 13:41:10 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>, linux-media@vger.kernel.org,
	jani.nikula@linux.intel.com, anisse@astier.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: Virtual camera driver
Message-ID: <20260202114110.GD3374091@killaraus>
References: <20260201133342.335680-1-jarkko@kernel.org>
 <13939245.uLZWGnKmhe@natalenko.name>
 <20260202020214.2243acec@foz.lan>
 <3399673.44csPzL39Z@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3399673.44csPzL39Z@natalenko.name>

On Mon, Feb 02, 2026 at 08:16:36AM +0100, Oleksandr Natalenko wrote:
> On pondělí 2. února 2026 2:02:14, středoevropský standardní čas Mauro Carvalho Chehab wrote:
> > > On pondělí 2. února 2026 0:17:20, středoevropský standardní čas Mauro Carvalho Chehab wrote:
> > > > No. At the machine with the camera, obs can read from a V4L2 input,
> > > > generate a mpeg TS stream, and listen to a UDP port (for instance). 
> > > > 
> > > > At the remote machine, you can just pass the URL to ffmpeg.  
> > > 
> > > I can't, I have to feed the stream into Firefox somehow for it to
> > > see the stream as a virtual webcam.
> > 
> > Motioneye could be used on such scenario. It has a proper web
> > interface, allows multiple users to watch, has login control accepts
> > multiple cameras.
> 
> I still don't get it how this will help with using a webcam from one
> machine in google meet on another machine, sorry.

I don't get it either :-)

Please see my reply to Gergo in this mail thread for an example of how
to create a virtual video source for PipeWire using GStreamer.

-- 
Regards,

Laurent Pinchart
