Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676329B777
	for <linux-media@vger.kernel.org>; Mon,  2 Feb 2026 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019774; cv=none; b=e08WObYN4wubId+HPaYHORBWgFjUuYx0f817jLMAdQ1ShaQ9eV5XvY08WPi3sXvoF76nnfj8T0T4xWPaTR+uCxaPWD+ECwGgwpCOmSYkqeU+unqvT83uXtziWWa9aV8FhfjQZZy4uDTekK6YbTLitlkc/sBeZxd80dbBVKK3uio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019774; c=relaxed/simple;
	bh=rqi7TYwfSOeWsom8gxMFfQJVVUmwrAxAm8yoKw+5saE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JtI63LXTd1fzD08incPTmYl6kBFntqI7fm1IYWNBCaENvi7ro3PtHeHKWDr+xUTB70w588uSyyixXR5BVkB9bmQbQXJbCiPv+KNHmDilF1vhQXM+GjUiENJ0IMaMD4aMzdeqwwDaiejmmw/KFqKaijJ5GqrLDHVsedRwkyczydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2zWbMG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2zWbMG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A54C116C6;
	Mon,  2 Feb 2026 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770019774;
	bh=rqi7TYwfSOeWsom8gxMFfQJVVUmwrAxAm8yoKw+5saE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=H2zWbMG/EjjUSjCk+ZmbyCGUKGxioVG9liUsIGI8SL8zthcs7ioyZHKx+bQJ7nj3t
	 reg/Jjy6gBlG6KrpnCHSGFjGwYh0nt4rRCAaSbMOxV35Gd1Si92dFDEQFDUEpm57FZ
	 auMho6ySP5361f+B517jankG0+vdKfNGiUjAxmd8iGbxlI1DK/i81rvF+7BRWya3+E
	 7NXFl1E4lqenOzUnbBvc+3+UuAZ8Dps5Dt80m8h/O8dtwTmUTJEFEn7MXvEZ/7dlnC
	 DmkTE7g1d8+6At8Qk84QSMAw+53+2XStya3vVtzuWRV9xG8v8dXY5nNp+wr0254wIm
	 7UEy1ilwZxNXA==
Message-ID: <12d85442-a9ed-422d-bc39-63c6c03950b7@kernel.org>
Date: Mon, 2 Feb 2026 09:09:31 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 0/2] edid-decode: ARVR parsers and DisplayID sanity checks
To: HAYOU YASSINE <yassine.hayou@gmail.com>
Cc: linux-media@vger.kernel.org
References: <CANAm-cducmYzMhLRz0Yf8CcC8i0yUjscZ6VgXycxJdU-e-JX4w@mail.gmail.com>
 <27bad1ad-ec8e-4574-aafe-5fa9d3e8d057@kernel.org>
 <CANAm-cd_9inwt_3jsaXQomFsai5dDnuK8cAGYO4pfMQ7iQ1NxA@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CANAm-cd_9inwt_3jsaXQomFsai5dDnuK8cAGYO4pfMQ7iQ1NxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yassine,

On 01/02/2026 19:46, HAYOU YASSINE wrote:
> Hi Hans,
> 
> Thank you for the review.
> 
> Per your request, I have created and attached a sample EDID file that contains the AR/VR data blocks. It includes both the AR/VR HMD (0x2c) and AR/VR Layer (0x2d) tags, which should allow you to
> verify the output of the first patch.

Just to confirm: this is not a real EDID (i.e. one used in an actual product), but
instead it is created to test these specific data blocks?

So this would go to the test directory, not the data directory.

Regards,

	Hans

> 
> Feel free to add this file to the data directory for future reference.
> 
> Regards,
> 
> Yassine
> 
> 
> Le ven. 30 janv. 2026 à 15:11, Hans Verkuil <hverkuil+cisco@kernel.org <mailto:hverkuil%2Bcisco@kernel.org>> a écrit :
> 
>     Hi Yassine,
> 
>     On 23/01/2026 16:26, HAYOU YASSINE wrote:
>     > Hi,
>     >
>     > This patch series includes two improvements to edid-decode:
>     >
>     > Patch 1/2: Implements full parsing for DisplayID 2.1 AR/VR data blocks
>     > - Tag 0x2c (ARVR_HMD): 79-byte block with optics, lens adjustment,
>     >   field of view, center of projection, and streams per layer fields
>     > - Tag 0x2d (ARVR_Layer): 20-byte block with HMD identification,
>     >   layer configuration, lens distortion, and scaling support
>     > - Includes comprehensive sanity checks for both blocks
>     >
>     > Patch 2/2: Adds validation checks for DisplayID data blocks
>     > - Tag 0x20 (Product ID): Validates payload length, week range, and model year
>     > - Tag 0x21 (Display Parameters v2): Validates pixel format, chromaticity
>     >   coordinates, luminance information, and gamma EOTF range
>     > - Tag 0x22 (Type VII Timing): Validates pixel clock max, image dimensions max,
>     >   and negative blanking periods
>     > - Tag 0x24 (Type IX Timing): Validates image dimensions max and refresh rate max
>     > - Tag 0x25 (Dynamic Video Timing Range Limits): Validates pixel clock and
>     >   refresh rate ranges with revision-specific limits
>     >
>     > These patches improve edid-decode's ability to parse and validate DisplayID
>     > data according to the VESA DisplayID Standard Version 2.1a, helping identify
>     > corrupted or invalid EDID data early and providing better error reporting
>     > for debugging display issues.
>     >
>     > Please review.
> 
>     I've been going over these patches, and they look good to me. Nice to see
>     this implemented.
> 
>     Do you have an EDID that has the ARVR data blocks? If you do, then that
>     might be a good one to add to the data directory with example EDIDs.
> 
>     If possible, I'd like to check the output with such an EDID first before I commit
>     the first patch.
> 
>     Regards,
> 
>             Hans
> 
>     >
>     > Thanks,
>     > Yassine
> 

