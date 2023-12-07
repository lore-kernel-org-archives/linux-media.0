Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ehkEu1zU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FCE10DA
	for <linux-media@vger.kernel.org>; Thu,  7 Dec 2023 04:45:51 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 41993669;
	Thu,  7 Dec 2023 13:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1701953109;
	bh=qulTg7ocO0xRL7HNMlJgNaAgSElZzMAjP+e3qJ+o8L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehkEu1zUEu6CaWTWP6o8qgCgh6yyTLuEHiN4S3KYklQ1aW67mSteGlnqf0GokshsC
	 q/nnCwyVanibhICMISAacl2i4wKyfNxAKwEsX9aqd4490wPyuKk32jc+A6gMZdFLhr
	 UMunivC2sQxwb0gXITp7qRPQKMVwytLZPOZ4jQKg=
Date: Thu, 7 Dec 2023 14:45:56 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	hverkuil@xs4all.nl
Subject: Re: [PATCH 5/6] media: tw9910: Don't set format in sub-device state
Message-ID: <20231207124556.GG9675@pendragon.ideasonboard.com>
References: <20231207120912.270716-1-sakari.ailus@linux.intel.com>
 <20231207120912.270716-6-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207120912.270716-6-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Thu, Dec 07, 2023 at 02:09:11PM +0200, Sakari Ailus wrote:
> For the purpose of setting old non-pad based sub-device try format as a
> basis for VIDIOC_TRY_FMT implementation, there is no need to set the
> format in the sub-device state. Drop the assignment to the state, which
> would result in a NULL pointer dereference.
> 
> Fixes: fd17e3a9a788 ("media: i2c: Use accessors for pad config 'try_*' fields")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/media/i2c/tw9910.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/tw9910.c b/drivers/media/i2c/tw9910.c
> index 7c331a7f12d4..905af98c7d53 100644
> --- a/drivers/media/i2c/tw9910.c
> +++ b/drivers/media/i2c/tw9910.c
> @@ -829,8 +829,6 @@ static int tw9910_set_fmt(struct v4l2_subdev *sd,
>  	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE)
>  		return tw9910_s_fmt(sd, mf);
>  
> -	*v4l2_subdev_state_get_format(sd_state, 0) = *mf;
> -
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
