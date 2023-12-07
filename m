Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NJAXH28P"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB01199B
	for <linux-media@vger.kernel.org>; Thu,  7 Dec 2023 04:45:15 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BF367669;
	Thu,  7 Dec 2023 13:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1701953073;
	bh=fYDAoIWlivROkLsYiKqa55tGvTdbthskOvDDxSZ5ou8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJAXH28PqxXn/SWIEmjCj5owuFUBq8RAESrnZzwnvOqZnZArho+dME81u+6LLC/dC
	 /1zy4NXf8/jy36DNc2R07Zxk3XluTfCeetkpIe41sNiToadVCpx2oQHCPn2N5RF7p/
	 3sh+linwoSqWxb3LFs8CdEWWRbI6ml4Uxh5P2kzY=
Date: Thu, 7 Dec 2023 14:45:20 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	hverkuil@xs4all.nl
Subject: Re: [PATCH 3/6] media: mt9t112: Don't set format in sub-device state
Message-ID: <20231207124520.GE9675@pendragon.ideasonboard.com>
References: <20231207120912.270716-1-sakari.ailus@linux.intel.com>
 <20231207120912.270716-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207120912.270716-4-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Thu, Dec 07, 2023 at 02:09:09PM +0200, Sakari Ailus wrote:
> For the purpose of setting old non-pad based sub-device try format as a
> basis for VIDIOC_TRY_FMT implementation, there is no need to set the
> format in the sub-device state. Drop the assignment to the state, which
> would result in a NULL pointer dereference.
> 
> Fixes: fd17e3a9a788 ("media: i2c: Use accessors for pad config 'try_*' fields")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/media/i2c/mt9t112.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/mt9t112.c b/drivers/media/i2c/mt9t112.c
> index 2e2d9853c089..fb1588c57cc8 100644
> --- a/drivers/media/i2c/mt9t112.c
> +++ b/drivers/media/i2c/mt9t112.c
> @@ -982,7 +982,6 @@ static int mt9t112_set_fmt(struct v4l2_subdev *sd,
>  
>  	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE)
>  		return mt9t112_s_fmt(sd, mf);
> -	*v4l2_subdev_state_get_format(sd_state, 0) = *mf;
>  
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart
