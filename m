Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0319481DD;
	Sun,  1 Feb 2026 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769987830; cv=none; b=iX0ij2r+F8Bvi+9qwsnCvRgi+r5JGTWaZalavYCK7/LZ1/ybCF52TaoCZWPHRcS4BQn2Th9v1UlPeM6UIdAtyUxEfj4aLqRfqwgO2jT2XLvSi4BRtxPu+TTXfMyiDzqfat+1g9LLbvGsUmJ6zuPmdWJiCiG53J4PGV2T6HBwH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769987830; c=relaxed/simple;
	bh=RdOT8+Y+yiwtt66D2dg3A7FAu7IL2cpBnVTher2Wu1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5UCmtGY/5gEdtS6MC1rk7DdEvetLqPDPNyKCvoa7p722ogxMpr1ctue9HsVIT/3uv202jDqOGKfLy/oXBD+RuWLNcgv28lAgv2KqAS0Srt6OkjOOqAB+ECLHDKr4zXs+ByuVdhkzAbx3qyO9+B3VoDVqO/Nqn6Q5CZgZTnZq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUtyyCqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUtyyCqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD847C4CEF7;
	Sun,  1 Feb 2026 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769987830;
	bh=RdOT8+Y+yiwtt66D2dg3A7FAu7IL2cpBnVTher2Wu1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUtyyCqCXhdc9ubZtXMYY017HNTDCvJ/q12oadvWcwK2COYclzciPAIGKXssFk6uL
	 KT1/XTR21vc35ckYgVOVMspNzSFyqDYZSnzcvekmIPzFtVPkZiI0B583+SXDLdQDg8
	 9xxlD2YUCoqYeIJfFkDlXVTluvH0E6OApjNPoD6o8uq884z0fntt+vsZjBLnpquTnd
	 J+fgLaXfisGZVPTJyRhBHiMR6zCao7zrcJHgNNyNdwQrkH0AZSEJbAzmVJ3koOLxcK
	 IBuJxPa9g5mAyOikH/IaWNyiBaOaChKJB3vQhzajl0U5j31/+ZyyzeSmJV8CXrgYQL
	 O13ULAmjhg+Rw==
Date: Mon, 2 Feb 2026 00:17:04 +0100
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
Message-ID: <20260202001704.2419778a@foz.lan>
In-Reply-To: <5073898.31r3eYUQgx@natalenko.name>
References: <20260201133342.335680-1-jarkko@kernel.org>
	<12828248.O9o76ZdvQC@natalenko.name>
	<20260201212133.1849a49e@foz.lan>
	<5073898.31r3eYUQgx@natalenko.name>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 01 Feb 2026 21:26:24 +0100
Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> On ned=C4=9Ble 1. =C3=BAnora 2026 21:21:33, st=C5=99edoevropsk=C3=BD stan=
dardn=C3=AD =C4=8Das Mauro Carvalho Chehab wrote:
> > > My use-case for v4l2loopback is to stream a webcam from one machine t=
o another (with the help of ffmpeg). Is this covered by something other tha=
n v4l2loopback now? =20
> >=20
> > Using a kernel driver for something like that is a bad idea and may end
> > causing dead lock problems. You may also have performance issues and
> > high network traffic. The best solution for it is to use a proper
> > userspace tool, like obs:
> >=20
> > 	https://obsproject.com/kb/linux-installation =20
>=20
> Ignoring the fact I've never had any performance issues, and I don't care=
 much about how big the traffic is in my isolated VLAN dedicated to this sp=
ecific task, the OBS solution still uses v4l2loopback under the hood. Could=
 you please tell me what do I miss in this regard?

No. At the machine with the camera, obs can read from a V4L input,
generate a mpeg TS stream, and listen to a UDP port (for instance).=20

At the remote machine, you can just pass the URL to ffmpeg.

No need to use OOT kernel drivers.=20

Btw, there are other solutions that work the same way, like
motioneye.

Thanks,
Mauro
