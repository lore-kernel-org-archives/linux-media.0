Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q5kbixME"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122252703;
	Fri, 24 Nov 2023 11:06:32 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1BBEE1434;
	Fri, 24 Nov 2023 20:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700852757;
	bh=yBfr7fbPq7YEO13cj00kaacBd89zDINg5rGSJKgDp4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5kbixMEN9ox7v8gcUk184bNSZqOlXt/TuzXyE/wMKQdStmA6JEuUFW+7dnTKtixo
	 Zi+D9cQjZ4P/yk0XoXPzMUg2iY3yyEY5GqADP3by8nU3k/rHB5BRRW8FluKwoQcvOU
	 yzw9YkFjFje5zWXe4livKPzSYluM8NYC8LCmuCYI=
Date: Fri, 24 Nov 2023 21:06:36 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linuxfancy@googlegroups.com,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Steve Longerbeam <slongerbeam@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov5640: add missing v4l2_subdev_init_finalize
Message-ID: <20231124190636.GA15686@pendragon.ideasonboard.com>
References: <20231124184913.2574925-1-tomm.merciai@gmail.com>
 <ZWDzL+prP90gV6m2@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWDzL+prP90gV6m2@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>

On Fri, Nov 24, 2023 at 08:02:07PM +0100, Tommaso Merciai wrote:
> On Fri, Nov 24, 2023 at 07:49:13PM +0100, Tommaso Merciai wrote:
> > After the ov5640 configurations steps let's add v4l2_subdev_init_finalize
> > that finalizes the initialization of the subdevice.
> > 
> > References:
> >  - https://linuxtv.org/downloads/v4l-dvb-apis/driver-api/v4l2-subdev.html
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  drivers/media/i2c/ov5640.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > index 3f79a3b77044..338eea802ab8 100644
> > --- a/drivers/media/i2c/ov5640.c
> > +++ b/drivers/media/i2c/ov5640.c
> > @@ -3924,6 +3924,12 @@ static int ov5640_probe(struct i2c_client *client)
> >  	if (ret)
> >  		goto entity_cleanup;
> >  
> > +	ret = v4l2_subdev_init_finalize(&sensor->sd);
> > +	if (ret < 0) {
> > +		dev_err(dev, "subdev init error: %d\n", ret);
> > +		goto entity_cleanup;
> > +	}
> > +
> >  	ret = ov5640_sensor_resume(dev);
> >  	if (ret) {
> >  		dev_err(dev, "failed to power on\n");
> 
> Ignore this patch please. I forget the cleanup part.

And you also forgot the conversion to the V4L2 subdev active state API
:-) See commit e8a5b1df000e ("media: i2c: imx219: Use subdev active
state") for an example.

-- 
Regards,

Laurent Pinchart
