Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eRIyaeJc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD818B
	for <linux-media@vger.kernel.org>; Thu, 23 Nov 2023 05:49:36 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AB9C0E52;
	Thu, 23 Nov 2023 14:49:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700747342;
	bh=6di/q2LeJDdBkTyqVzwKVLsTfrj/8IGXR6rMoM2i4Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRIyaeJcaUfBr2+0Bg1kip7vQ7FCGEZhZmYpcgwhHHLeBrueGkm4oKvbOlA7rPcE7
	 3E04Z24D1la1+ssHKfRrxihEI9dJXO7eSoseeeyjDB90RlzbM1gZN+y4Hvxs5tGOk6
	 kzTYT7eOWml3lOx0YYbCGyerfy9z+YCKxhrmNlDI=
Date: Thu, 23 Nov 2023 15:49:41 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Umang Jain <umang.jain@ideasonboard.com>, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dan Carpenter <error27@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 6/9] staging: vc04_services: Drop vchiq_log_error() in
 favour of dev_dbg
Message-ID: <20231123134941.GD16377@pendragon.ideasonboard.com>
References: <20231107095156.365492-1-umang.jain@ideasonboard.com>
 <20231107095156.365492-7-umang.jain@ideasonboard.com>
 <2023112322-wife-aspect-135b@gregkh>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023112322-wife-aspect-135b@gregkh>

On Thu, Nov 23, 2023 at 01:02:45PM +0000, Greg Kroah-Hartman wrote:
> On Tue, Nov 07, 2023 at 04:51:53AM -0500, Umang Jain wrote:
> > Drop vchiq_log_error() macro which wraps dev_dbg(). Introduce the usage
> > of dev_dbg() directly.
> > 
> > Add a new enum vchiq_log_type and log_type() helper to faciliate the
> > type of logging in dev_dbg(). This will help to determine the type of
> > logging("error", "warning", "debug", "trace") to dynamic debug.
> > 
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > ---
> >  .../interface/vchiq_arm/vchiq_arm.c           |  54 ++++----
> >  .../interface/vchiq_arm/vchiq_connected.c     |   6 +-
> >  .../interface/vchiq_arm/vchiq_core.c          | 126 ++++++++++--------
> >  .../interface/vchiq_arm/vchiq_core.h          |  23 +++-
> >  .../interface/vchiq_arm/vchiq_dev.c           |  47 ++++---
> >  5 files changed, 143 insertions(+), 113 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > index 9fb3e240d9de..2cb2a6503058 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > @@ -696,8 +696,8 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
> >  
> >  	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
> >  	if (!instance) {
> > -		vchiq_log_error(state->dev, VCHIQ_CORE,
> > -				"%s: error allocating vchiq instance\n", __func__);
> > +		dev_dbg(state->dev, "%s: %s: %s: error allocating vchiq instance\n",
> > +			log_cat(VCHIQ_CORE), log_type(ERROR), __func__);
> 
> All dev_dbg() calls have __func__ in them automatically, you never need
> to duplicate it again as that's redundant :(

Oh ? I didn't know that, and can't find it in the code. I may be missing
something though. Are you referring to the +f flag for dynamic debug
entries ? It won't work if dynamic debug isn't enabled though, but maybe
we don't care about that ?

-- 
Regards,

Laurent Pinchart
