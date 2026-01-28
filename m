Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC030C63A;
	Wed, 28 Jan 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616657; cv=none; b=czRJO6aaovS/RkcEiRSnlS95k3dYTX0zUOt7qHijZlXur0KfJkvWt4SibIpqymne1X10taAnsJnhfEof9Xg2crUKa/Vg43CvVoKlwlHxyV9WBA9EDX+X5qIBmKAouNBVl/ACXoGGQKh2Jc0joDclNiud9FYIHpXSeEi3J9f8hI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616657; c=relaxed/simple;
	bh=45zUWB0jKIz5xo58Qn3659W4XRcukZY3ayN+X4OqnP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmV2ijeFgwxd5UyI60CLKHdFE1aNbF3EmiWAOpMPpviUhXR7/mjX3L6c+8XNtrMbBX0GF0mN7IhfB4fi6e/5bVT17rf1a0b8V35tP2m5ZxIXPJHbr4fquMuHIlfdH1wYzfZ7SsCCHdha3/OYd8PMEceCHZsW7iVqOft/fqbcSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gVOaid00; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVOaid00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C75C4AF0C;
	Wed, 28 Jan 2026 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616656;
	bh=45zUWB0jKIz5xo58Qn3659W4XRcukZY3ayN+X4OqnP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVOaid00IWVg9HHqndJFQ8irqmxJXH6DTJ4gz1YO2cXpKh7w9t1gpN5ZJLlIAMH+g
	 ssbws83FzOXPbJA6weIlbFMfPOw3oiuKQLarU7kkilAn8K+ov8y4stoBd/zzW3YEUa
	 Vk0us0i6CFv3CQiIHXWziqsmdJFHU6gbnZ97dN24=
Date: Wed, 28 Jan 2026 17:10:53 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Timoth=E9e?= Kremer <timothee.kremer@epitech.eu>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: [PATCH] staging: media: av7110: refactor sleep timers
Message-ID: <2026012834-pulp-reuse-4e03@gregkh>
References: <GV2PR02MB11640C6AA4BEEE7A1B584411C8991A@GV2PR02MB11640.eurprd02.prod.outlook.com>
 <2026012844-abruptly-fraying-28a3@gregkh>
 <GV2PR02MB11640D51CC0CEA2978D83E1638991A@GV2PR02MB11640.eurprd02.prod.outlook.com>
 <GV2PR02MB116404A030FFE770E324158D68991A@GV2PR02MB11640.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GV2PR02MB116404A030FFE770E324158D68991A@GV2PR02MB11640.eurprd02.prod.outlook.com>

On Wed, Jan 28, 2026 at 03:08:49PM +0000, Timothée Kremer wrote:
> >From 5169a8c4cf139011f2a4928ae2205d9f9e055675 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Timoth=C3=A9e=20KREMER?= <timothee.kremer@epitech.eu>
> Date: Wed, 28 Jan 2026 15:57:34 +0100
> Subject: [PATCH] staging: media: av7110: remove dead code
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

Something went really wrong here, sorry.

Can you use git send-email to send your patches out?

thanks,

greg k-h
