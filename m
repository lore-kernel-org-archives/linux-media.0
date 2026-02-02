Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BE146D5A;
	Mon,  2 Feb 2026 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769994140; cv=none; b=EmG1wiT9zd4hi/ICp8oDo37cwCWmkeIVICfOBN5bwJDc8VNoh2lKk5kH4sTWDWBnyK+A7e9acpnLBsTmwEjFg3EQXbSJEtG8k30MHT38tghxTxibTccE8kEHR55uzQlnmzbGm7Ht635q5NRRW4ItWrCW9SLk8DM/V7ZpSMUeFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769994140; c=relaxed/simple;
	bh=M1pw23M4kjVLO+oniBGIm7hzh++sPyQOg2iVfu8DEts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+SYrcjujFHOpsZVZdddmp6Bi3sKrTgyG0ExDUdR0QYyEJiIs2PU3QQEZc2vDVsoAzXpTIxbh+myg7vzBddxnnddDWvzHEICqWSKgZYUcGNghbxgXkR5UIXO/ILYghnQpZZ5qs0YNpSXhW3PXGyAUtdExvhmTcyKiEaarU2ozMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJKlFDba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJKlFDba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DB5C4CEF7;
	Mon,  2 Feb 2026 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769994140;
	bh=M1pw23M4kjVLO+oniBGIm7hzh++sPyQOg2iVfu8DEts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BJKlFDbafTZ4mFyn0zNjqjorDU+cj1gdDHSLhn5wL+nfgIL8UFO7xLd0KKerSbpH8
	 eDS3U6V7tyWTc78OQSO75+rLSimymgPyAVEn9/v090aV0UduIpPMErQIRRQcaaN1RM
	 MrbhsWjmGZFBeKTRroVWSGMtqgrb6KJy65PZtWMRXhD8GjrROqNUUyTmeANzWhtr1x
	 XT+iwzKmjYbSxNxJcSBiFCdBaIHXRiCmgJel972ISGguwwIkY06xiO/tWc4Gk682tU
	 z+P0n0i4eYEdR/nxChffpR92bkWEOFgQpbPRbcUP5kuDoVe/aQqgAqywJZDzFLqQ5U
	 io42544VL3V7w==
Date: Mon, 2 Feb 2026 02:02:14 +0100
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
Message-ID: <20260202020214.2243acec@foz.lan>
In-Reply-To: <13939245.uLZWGnKmhe@natalenko.name>
References: <20260201133342.335680-1-jarkko@kernel.org>
	<5073898.31r3eYUQgx@natalenko.name>
	<20260202001704.2419778a@foz.lan>
	<13939245.uLZWGnKmhe@natalenko.name>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 02 Feb 2026 00:25:37 +0100
Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> Date: Mon, 02 Feb 2026 00:25:37 +0100
> From: Oleksandr Natalenko <oleksandr@natalenko.name>
> To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jarkko Sakkinen=
 <jarkko@kernel.org>, linux-media@vger.kernel.org, jani.nikula@linux.intel.=
com, anisse@astier.eu, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Ver=
kuil <hverkuil@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Ja=
copo Mondi <jacopo.mondi@ideasonboard.com>, Ricardo Ribalda <ribalda@chromi=
um.org>, open list <linux-kernel@vger.kernel.org>
> Message-ID: <13939245.uLZWGnKmhe@natalenko.name>
>=20
> On pond=C4=9Bl=C3=AD 2. =C3=BAnora 2026 0:17:20, st=C5=99edoevropsk=C3=BD=
 standardn=C3=AD =C4=8Das Mauro Carvalho Chehab wrote:
> > No. At the machine with the camera, obs can read from a V4L2 input,
> > generate a mpeg TS stream, and listen to a UDP port (for instance).=20
> >=20
> > At the remote machine, you can just pass the URL to ffmpeg. =20
>=20
> I can't, I have to feed the stream into Firefox somehow for it to see the=
 stream as a virtual webcam.

Motioneye could be used on such scenario. It has a proper web
interface, allows multiple users to watch, has login control accepts
multiple cameras.

Thanks,
Mauro
