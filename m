Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284A173
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819997; cv=none; b=Xpr0wqWfqpz1X+CEghjy9ZlLLL1RFK40k401pO9vK+37bBJYaT18r6Nyf+Jcq5+kwMReDhHVJXub9xaJyX+v4Lchg8CSKqhfK5i2h5L3maRSvTBNdgTTvZDnxmGjlP2Gr63la8KZU16t1z+hfofEaArY2mWEKg434lDLDYgweDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819997; c=relaxed/simple;
	bh=yYLYXQcl2ACik1idtfc4W+M0s3XvpPboOYSlSGbPW1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbtfWHJaY8MBLDDLi798hk60UbymDLfoh4MWD2Sp69IYzRdGMRAVuR/nTZSFx6A8vmMkpZi35yehaDWeK3WtDYRZY+fbht8FWIinJZeuUYotfQU6RgJvi0VdSMYjddDaMfJ5aly0lrhLV9kutZZtwErp6IFvT7AB5gGajzhSwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NiRJrHff; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NiRJrHff"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id EA296229;
	Tue, 11 Nov 2025 01:11:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762819875;
	bh=yYLYXQcl2ACik1idtfc4W+M0s3XvpPboOYSlSGbPW1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiRJrHff3IkR0WUA6mM45eVN6v+piN+LGCpeBmOF35HKIf3GUW9EzYroBH0v64h7/
	 fR6M7CzN8SyuXHWUMVuQHwnw2hwgc3Cv6VF6Fj97IYigmfsytYPQFe7womIqlbFeAH
	 nxqyFDkJPE/JoE0XJe5SmnIfI9OCYqBtJgRpncv4=
Date: Tue, 11 Nov 2025 02:13:08 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: [v4l-utils] [PATCH] v4l2-ctl: Take stream skip into account to
 setup out buffers
Message-ID: <20251111001308.GB30837@pendragon.ideasonboard.com>
References: <20251022155031.2978-1-laurent.pinchart@ideasonboard.com>
 <09cefa2c-18ea-4051-8337-65bfd8472e43@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09cefa2c-18ea-4051-8337-65bfd8472e43@kernel.org>

Hi Hans,

On Mon, Nov 10, 2025 at 12:46:38PM +0100, Hans Verkuil wrote:
> On 22/10/2025 17:50, Laurent Pinchart wrote:
> > When setting up out buffers in do_setup_out_buffers(), the function
> > stops after stream_count buffers and returns QUEUE_STOPPED. This doesn't
> > take the stream_skip counter into account, resulting in the queue being
> > stopped too early. Fix it.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > I've tested this patch with a JPEG encoder, invoking v4l2-ctl with
> > 
> > v4l2-ctl -d $dev \
> >         --set-fmt-video-out width=${width},height=${height},pixelformat='Y12 ' \
> >         --set-fmt-video width=${width},height=${height},pixelformat=JPEG \
> >         --stream-out-mmap \
> >         --stream-mmap=3 \
> >         --stream-from ${infile} \
> >         --stream-to ${outfile} \
> >         --stream-skip=50 \
> >         --stream-count=1 \
> >         --stream-loop \
> >         --verbose
> > 
> > Without the patch streaming stops after 1 frame, with it it stops after
> > 51 frames.
> 
> This review is really for both this patch and the "v4l2-ctl: Don't ignore skip when writing
> capture buffers" patch since they are related.
> 
> --stream-skip was originally implemented for capture devices, and there it is easy to
> understand what it does.
> 
> It was later used as well for output devices and m2m devices, but never documented what
> it should do (as you noticed).

Indeed :-)

> I think this needs to be properly defined.

I certainly agreee.

> For output devices I would expect that --stream-skip skips the first N buffers that are
> received (typically from an input file), so they are never queued to the hardware. It's
> really the only thing that makes sense.
> 
> do_setup_out_buffers() clearly doesn't do that, it queues them anyway. I doubt if this
> was ever tested.
> 
> I think this proposed definition also works fine for m2m devices.
> 
> The ignore_count_skip boolean is a bad name, perhaps that should be inverted and
> call it use_stream_skip instead.
> 
> If you explicitly want to queue the buffers to the m2m device, but skip the first
> N captured (i.e. processed) buffers, then that would require a new option, I think.
> But I'm not sure if that's very useful, unless the first N buffers processed by an
> m2m device are garbage for some reason, but that's really bad hardware.
> 
> If this is actually what you want, then I need to have a bit more info first and
> a discussion.

That's what I'm trying to achieve. I needed the ability to select the
number of frames on the capture side to write to files, as well as the
position of those frames within the capture stream. This is how
skip+count operate on a capture device, so I thought it would make sense
to do the same for M2M devices.

> > ---
> >  utils/v4l2-ctl/v4l2-ctl-streaming.cpp | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
> > index ec85e41e9e12..5192f1e168b9 100644
> > --- a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
> > +++ b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
> > @@ -1374,9 +1374,14 @@ static int do_setup_out_buffers(cv4l_fd &fd, cv4l_queue &q, FILE *fin, bool qbuf
> >  			if (!verbose)
> >  				stderr_info(">");
> >  			fflush(stderr);
> > -			if (!ignore_count_skip && stream_count)
> > -				if (!--stream_count)
> > -					return QUEUE_STOPPED;
> > +			if (!ignore_count_skip) {
> > +				if (stream_skip) {
> > +					--stream_skip;
> > +				} else if (stream_count) {
> > +					if (!--stream_count)
> > +						return QUEUE_STOPPED;
> > +				}
> > +			}
> >  		}
> >  		if (fmt.g_pixelformat() == V4L2_PIX_FMT_FWHT_STATELESS) {
> >  			set_fwht_req_by_idx(i, &last_fwht_hdr,
> > 
> > base-commit: 910ce5d9ec8377811faaad7da456d25370c9188b

-- 
Regards,

Laurent Pinchart
