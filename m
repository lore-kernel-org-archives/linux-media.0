Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9AA163
	for <linux-media@vger.kernel.org>; Sun,  8 Feb 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770559625; cv=none; b=dRgT37RxQOwUeZ0QJBoW8GKzrUk9muucCKwtvZTLsaGvlyJFE+0cqFGF2jI0DN5snAwpdPsV3RzQwJWywyflTGWLoN13qGJ81HaL3oMPkaRgG1yfSYOnusrZtZ9OMxqVeNIuAiRHzype/70b8Ky4IStJ0ulQ5hh+BvShcRW5hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770559625; c=relaxed/simple;
	bh=cvJwMVvLHyJL1du1FlRII9MmG1AyOuvljdbHs6UbRCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPFYAQ29DzTspUGtren9GFpimM64cL9BNybMClLAf9tUtzxJ7sVQW03AHPdPWahSFySYMc3Pn8wbTcRfVyi6L2Uptvj/t5vc9BiDRmLUIcB7ocCkcLg7YT9k7T9gyCNEuUKugE+H75ggkWFjUSO4eB50zxvCJ4+u+tXgyS932rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eU3mwjZy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eU3mwjZy"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id ED783C6C;
	Sun,  8 Feb 2026 15:06:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770559579;
	bh=cvJwMVvLHyJL1du1FlRII9MmG1AyOuvljdbHs6UbRCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eU3mwjZyNMGjVu7XRSiadx5EBxol7YZtSNWZKbbv4rDeRIAZ0pnBuc0Wk/sEQ3TC+
	 ZsMhrRQtQt5kWxTh3fi3BB977flXI8+VBp6DJs6/xyHpPzzTnZY2+0toF92/acUUWr
	 LEWzm/6QD9sPd86tahkwJhcH9WO8q1ImhzcqVhUM=
Date: Sun, 8 Feb 2026 16:07:02 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: arash golgol <arash.golgol@gmail.com>
Cc: linux-media@vger.kernel.org, paulk@sys-base.io, mchehab@kernel.org,
	wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] media: sun6i-mipi-csi2: Use V4L2 subdev active state
Message-ID: <20260208140702.GQ1376807@killaraus.ideasonboard.com>
References: <20260206123455.46476-1-arash.golgol@gmail.com>
 <20260207214932.GO1376807@killaraus.ideasonboard.com>
 <CAMxPZkid_QP2Q0wk9wBJi3RnfzbZ38CRso+BkT+srQTYwEmfOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxPZkid_QP2Q0wk9wBJi3RnfzbZ38CRso+BkT+srQTYwEmfOw@mail.gmail.com>

On Sun, Feb 08, 2026 at 02:23:39PM +0330, arash golgol wrote:
> Hi Laurent,
> 
> Thank you for the careful review and the detailed comments.
> 
> On Sun, Feb 8, 2026 at 1:19 AM Laurent Pinchart wrote:
> > On Fri, Feb 06, 2026 at 04:04:55PM +0330, Arash Golgol wrote:
> ...
> >
> > You can drop the else and write
> >
> >         ret = v4l2_subdev_call(source_subdev, video, s_stream, 1);
> >         if (ret && ret != -ENOIOCTLCMD)
> >                 goto disable;
> >
> >         ret = 0;
> >         goto unlock;
> >
> 
> Sure, I'll do this in v2.
> 
> >
> > Error paths below should call v4l2_subdev_cleanup(), which should be ...
> > ... introduced here:
> >
> > error_v4l2_subdev_cleanup:
> >         v4l2_subdev_cleanup(subdev);
> 
> Yes, you're right about error handling.
> I was checking the code for the proper place to jump to the
> error_v4l2_subdev_cleanup label.
> Consider this section of code, trying to set up the bridge upstream
> source (in middle of
>  sun6i_mipi_csi2_bridge_setup()).
> 
>         ret = sun6i_mipi_csi2_bridge_source_setup(csi2_dev);
>         if (ret && ret != -ENODEV)
>                  goto error_v4l2_notifier_cleanup;
> 
>         (rest of the code)
> 
>         error_v4l2_notifier_cleanup:
>                 v4l2_async_nf_cleanup(notifier);
> 
> I was wondering whether jumping to error_v4l2_notifier_cleanup on failure of
> sun6i_mipi_csi2_bridge_source_setup() is meaningful, as in that case no
> async connection has been added to the notifier yet.

It doesn't seem needed indeed, but it also doesn't hurt.

> So I guess failure of sun6i_mipi_csi2_bridge_source_setup() could be a
> proper place to jump to
> error_v4l2_subdev_cleanup label. In this model, failure to set up the
> upstream source means
> the bridge cannot function at all, so I unwind back to subdev_cleanup().
> 
> Something like this:
> 
>         ret = v4l2_subdev_init_finalize(subdev);
>         if (ret < 0)
>                 goto error_media_entity_cleanup;
> 
>         /* V4L2 Async */
> 
>         v4l2_async_subdev_nf_init(notifier, subdev);
>         notifier->ops = &sun6i_mipi_csi2_notifier_ops;
> 
>         ret = sun6i_mipi_csi2_bridge_source_setup(csi2_dev);
>         if (ret && ret != -ENODEV)
>                 goto error_v4l2_subdev_cleanup;
> 
>        (rest of the code ... )
> 
>         error_v4l2_subdev_cleanup:
>                 v4l2_subdev_cleanup(subdev);
> 
>         error_media_entity_cleanup:
>                 media_entity_cleanup(&subdev->entity);
> 
> Is my understanding correct?
> If yes, should I add this change to v2 too?

That looks good to me.

> > Those are only small issues, overall the patch is very nice. Thank you
> > for taking the extra step to convert the driver to the V4L2 subdev
> > active state. I expect we'll merge the next version once the comments
> > are addressed.
> 
> Thank you for your kind words.
> I've prepared v2 and addressed your comments, but I wanted to clarify
> the correct error handling approach here before sending it.

-- 
Regards,

Laurent Pinchart
