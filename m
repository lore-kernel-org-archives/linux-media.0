Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JOeTHv1J"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EECB127
	for <linux-media@vger.kernel.org>; Sat, 25 Nov 2023 16:08:00 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AB94629B;
	Sun, 26 Nov 2023 01:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1700957242;
	bh=JenfwD0fBhMo2vtVd1lmNnf+2seuFNZjBor3XQkfZQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOeTHv1Jnl+awrsk6EF2J2/PlrTt41JEyWc7pk1/HrxqMcj268LSh92CX6lGMcrqB
	 mdv8aOf7H+90MAxZmjNk9FjTnTS99+mUQdcX9m/Ts/tZTLLlQrTUxuXUTGc7r95cBO
	 t0Th3vpN4XD0FlnDmB0o6CU94ysxQUz2ftP9zuwY=
Date: Sun, 26 Nov 2023 02:08:02 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [RFC PATCH v1 2/4] media: v4l2-subdev: Add which field to struct
 v4l2_subdev_frame_interval
Message-ID: <20231126000802.GA20658@pendragon.ideasonboard.com>
References: <20231024005130.28026-1-laurent.pinchart@ideasonboard.com>
 <20231024005130.28026-3-laurent.pinchart@ideasonboard.com>
 <e71ab7fb-eaac-45de-b31c-27d9ba5f5744@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e71ab7fb-eaac-45de-b31c-27d9ba5f5744@ideasonboard.com>

On Tue, Oct 24, 2023 at 10:11:39AM +0300, Tomi Valkeinen wrote:
> On 24/10/2023 03:51, Laurent Pinchart wrote:
> > Due to a historical mishap, the v4l2_subdev_frame_interval structure
> > is the only part of the V4L2 subdev userspace API that doesn't contain a
> > 'which' field. This prevents trying frame intervals using the subdev
> > 'TRY' state mechanism.
> > 
> > Add a 'which' field is simple as the structure has 8 reserved fields.
> 
> "Adding"
> 
> > This would however break userspace as the field is currently set to 0,
> > corresponding to V4L2_SUBDEV_FORMAT_TRY, while the corresponding ioctls
> > currently operate on the 'ACTIVE' state. We thus need to add a new
> 
> That's not the only problem. It wouldn't work even if 0 would be 
> 'ACTIVE'. The userspace is required to clear the reserved fields, but 
> the newly added 'which' field is no longer a reserved field, and thus 
> the userspace might not clear it, leading to it being uninitialized. But 
> this is solved with the V4L2_SUBDEV_CLIENT_CAP_WHICH_INTERVAL.

Yes, I didn't claim it would be the only problem :-)

> > subdev client cap, V4L2_SUBDEV_CLIENT_CAP_WHICH_INTERVAL, to indicate
> > that userspace is aware of this new field.
> > 
> > All drivers that implement the subdev .g_frame_interval() and
> > .s_frame_interval() operations are updated to return -EINVAL when
> 
> .get_frame_interval() and .set_frame_interval() now =).

Will be fixed in v2.

-- 
Regards,

Laurent Pinchart
