Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CC287276;
	Sun,  1 Feb 2026 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769977299; cv=none; b=Ol34VNkQET3Gccq1FG3HC59+LpARAXyz++YYNi5ZSbZ+BIhzpy239qXufWP3+RE6kvAJ+gqv/+cCFMs+hVVIuaKUj4q/p/3TB5pmzViBGnttBeB4+b/652zLUzt/tvTK+V5sbDi1kf/1BbmUmzheZO1UKsdWQ/z6awsIFZUhsjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769977299; c=relaxed/simple;
	bh=CkH9yVB84s1QFeZx86mJT6lmIvRcBRsoPIFbntUlbkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/e3fwYMVDACHWunCexJbNqiMC5zcEpZS/B1sD/ea+0A1tObcpn2irQ88bsZUM6VBFbtS+D06Rn13cE3LhauPbMR130HebMv38i5WMyrkY84yHVmtpH6NzEZfEmDcLBniDDYFuBD9AXMYOpTJm6K4OLT9EUqm3LvC99PqL2iFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIXu82bh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIXu82bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6645AC4CEF7;
	Sun,  1 Feb 2026 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769977299;
	bh=CkH9yVB84s1QFeZx86mJT6lmIvRcBRsoPIFbntUlbkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gIXu82bhYEl2Vmid6X5BMAAUH+UM6ceNzrS7B77vJWnWtMPfjZHg32tTiYsXsE6cH
	 Mz4j676iZQLZZEMyTtggBc2bl0YNl+QyW7MJjjfRPl764MlUZGZG+PjtBIoiQjW0AY
	 hhKvm0UapywEx06kk1nskca5gZqHxnAI5eYtS3yUUrDSyT+2qFEMcdVx4ZcuDjCF02
	 QPwj9aas1YLVmNzBALDsy9E1digSqGtPXa8dhrSQOODaoqkioMJ7CcypbLILAlsiHF
	 YZ4722hbHAhjjh+CQESvSOV96qkLVNL0p7vp2WovTE2H7hzlxj0bC2aE6BW2JVQ9YP
	 V/UbDkOIvfgrQ==
Date: Sun, 1 Feb 2026 21:21:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, linux-media@vger.kernel.org,
 jani.nikula@linux.intel.com, anisse@astier.eu, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jacopo Mondi
 <jacopo.mondi@ideasonboard.com>, Ricardo Ribalda <ribalda@chromium.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: Virtual camera driver
Message-ID: <20260201212133.1849a49e@foz.lan>
In-Reply-To: <12828248.O9o76ZdvQC@natalenko.name>
References: <20260201133342.335680-1-jarkko@kernel.org>
	<aX-joEDl_BJai8wY@kernel.org>
	<20260201200649.GW3374091@killaraus>
	<12828248.O9o76ZdvQC@natalenko.name>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 01 Feb 2026 21:14:54 +0100
Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> Hello.
>=20
> On ned=C4=9Ble 1. =C3=BAnora 2026 21:06:49, st=C5=99edoevropsk=C3=BD stan=
dardn=C3=AD =C4=8Das Laurent Pinchart wrote:
> > > There is a notable user base for v4l2-loopback. It is the defacto cho=
ice
> > > for streaming phone cams. =20
> >=20
> > This will then likely face the same hurdles as v4l2-loopback, the main
> > one being that camera support should be upstreamed with proper drivers
> > instead of a closed-source userspace daemon.
> >=20
> > For phone cameras, the way forward upstream is libcamera. Until kernel
> > drivers for ISPs are available, the soft ISP is a stop-gap solution. It
> > recently gained GPU acceleration support (with work to improve image
> > quality with additional algorithms ongoing). =20
>=20
> My use-case for v4l2loopback is to stream a webcam from one machine to an=
other (with the help of ffmpeg). Is this covered by something other than v4=
l2loopback now?

Using a kernel driver for something like that is a bad idea and may end
causing dead lock problems. You may also have performance issues and
high network traffic. The best solution for it is to use a proper
userspace tool, like obs:

	https://obsproject.com/kb/linux-installation

Thanks,
Mauro
