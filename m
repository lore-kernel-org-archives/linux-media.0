Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88012EBBAF;
	Wed, 28 Jan 2026 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603473; cv=none; b=NswdgWz5zEtCThgvaAp7oMF2IpdTQoMIc2nVPmlt2I8UUQCxWEXAxXyJtFPcxU0KBBwdHZ1z5CabpHiJTTipFxPwEODe0Jjmr3k9gyeJ7tmoo++Dw4Wg/emKF6eVfMVuD+q6OFkN5ZaQSgg904yxxpgtGWSoidAQ9YxM4RYqel8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603473; c=relaxed/simple;
	bh=94gNhwdQQu1bxv86osHB3gfCAfAhJFsJDEjNcYNfGsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiBQKNdEGahiWAX714DUh07RkKw0i5uRlRkh1C+NGw83U1SOerjfH0NTBRcp15u8h3ULaxpRo+3uGXAxfJh26fxJMp9iS2LsBezxQEL+99R5ufe2mCtH+iGK963dSYbyMVVT1uFtrI15Idia8KMxrrTNmbNNIj+ACclXOqMJe5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cIGTMOnC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cIGTMOnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACB5C4CEF1;
	Wed, 28 Jan 2026 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769603472;
	bh=94gNhwdQQu1bxv86osHB3gfCAfAhJFsJDEjNcYNfGsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIGTMOnCg7gQUxO2DFeCu/065OHAlGSJDPA9EGRwcOKSxhs+Cfc93FDiu7qFzA6oq
	 ayXpEz7bJpsLuTqKBbb5TlOI899qCCRe6P5aPOYCpRrQDYUhFY8T05Gw4rxOy3Ekqv
	 9GMBhKnDQPmPup5tuqeAzZ8fY6BiE5BZ0u4qoGz4=
Date: Wed, 28 Jan 2026 13:31:09 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Timoth=E9e?= Kremer <timothee.kremer@epitech.eu>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: media: av7110: cleanup sleep   timers and dead
 code
Message-ID: <2026012844-abruptly-fraying-28a3@gregkh>
References: <GV2PR02MB11640C6AA4BEEE7A1B584411C8991A@GV2PR02MB11640.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GV2PR02MB11640C6AA4BEEE7A1B584411C8991A@GV2PR02MB11640.eurprd02.prod.outlook.com>

On Wed, Jan 28, 2026 at 11:06:32AM +0000, Timothée Kremer wrote:
> Refactor sleep timers to use usleep_range() for short delays (<20ms)
> while retaining msleep() for longer delays to maintain hardware stability.
> 
> Also remove dead code blocks wrapped in #if 0 to clean up the driver.

Please only do one logical thing per commit, this should be multiple
changes.  A huge hint, when you say "Also" that means it should be split
up.

thanks,

greg k-h
