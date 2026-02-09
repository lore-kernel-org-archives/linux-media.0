Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF32147F9;
	Mon,  9 Feb 2026 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619636; cv=none; b=Hkgu/V7oX7RfqtBe1+fdXqixoJ9RqGF1E+7qy1B019L9fp013rY3OovjKyzXop9g6WUsnaV5iTAapKp3278sbWKnwECTY7qKXk6l/6ZjIXlsX0fePf74ps79elK8TcetjjlHbzO1Sr1Fjr0Qr2SwZzyrk37O7atITiNSz+G+Iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619636; c=relaxed/simple;
	bh=X0VFv0OyK5yF8Is/7vnwYVotikgIyEARoujHW3OY+LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANISSfc0WUkZd9Pl7/SpuzmUxZED51X6po7NhHbZdiD1QyLh/WVWJ9bnIPjqw5B2jEnQFsITvuFSoAdA5eKWLVqDjq0aLkQYtGxLyRMIyixSWJNRZBhtQvEm2JD8y7UmtwFgD+MFDOjcDiLfDFlMGgbXF6+xeTRHddAGmyVNZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Rqe+jsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Rqe+jsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B16C116C6;
	Mon,  9 Feb 2026 06:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770619636;
	bh=X0VFv0OyK5yF8Is/7vnwYVotikgIyEARoujHW3OY+LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Rqe+jsCL/5ETlAKHFF726Gh66BwZsb70adkmlvsZZaI53SP0l98ZPm6NDj0zuNd1
	 7awlyu8stOuamFJ7WtoANAl23i4TIZCo0YhToxNP6hgXvGu8Uh+qJGzHz4kiHvOcdI
	 4s83WCgWfH8AwpdwGlV2X8Ier8/S26HD9eRTqXwI=
Date: Mon, 9 Feb 2026 07:47:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Taekyung Oh <ohxorud@ohxorud.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: media: atomisp: fix block comment style in
 ov2722.h
Message-ID: <2026020950-pacific-concur-9b99@gregkh>
References: <20260209045514.40352-1-ohxorud@ohxorud.com>
 <20260209045514.40352-2-ohxorud@ohxorud.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209045514.40352-2-ohxorud@ohxorud.com>

On Mon, Feb 09, 2026 at 04:55:53AM +0000, Taekyung Oh wrote:
> Fix coding style warnings reported by checkpatch.pl.
> Move the comments above the corresponding code lines.
> 
> Signed-off-by: Taekyung Oh <ohxorud@ohxorud.com>
> ---
>  drivers/staging/media/atomisp/i2c/ov2722.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/i2c/ov2722.h b/drivers/staging/media/atomisp/i2c/ov2722.h
> index 00317d105..c69f0086c 100644
> --- a/drivers/staging/media/atomisp/i2c/ov2722.h
> +++ b/drivers/staging/media/atomisp/i2c/ov2722.h
> @@ -566,8 +566,8 @@ static const struct ov2722_reg ov2722_VGA_30fps[] = {
>  #endif
>  
>  static const struct ov2722_reg ov2722_1632_1092_30fps[] = {
> -	{OV2722_8BIT, 0x3021, 0x03}, /* For stand wait for
> -				a whole frame complete.(vblank) */
> +    /* For stand wait for a whole frame complete.(vblank) */
> +	{OV2722_8BIT, 0x3021, 0x03},

You now added a different coding style warning :(

