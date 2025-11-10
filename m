Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F1191
	for <linux-media@vger.kernel.org>; Mon, 10 Nov 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775200; cv=none; b=jLpIjEUATppglsOSEkxDVB6SS1SGDnlmPPm/KMF/uo1e1mVUDqqcmjc1K3p/W8Z5prA1jutPsX5htpIx7n2oD9Xbwg8I4J4Baq63N9oeKMCzS5iRQOdobtQ7utZGpTfIG2+0yUyJO72NnsjK8BsbJz5KTE1bqo+0oehTUGbuFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775200; c=relaxed/simple;
	bh=si5lW1ydzquhPG/yrtEo8G93FCB3p2Wrmwm9W6QchvE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EFKnqGMZJsWU//Cvw04U1/U5l7zqRSfCEZi6ciZ8cGtAbL3+xpxn6TcQqSGAES4cUXVswxQ/nxbvK6CCEb59GDATVqWTsDdrB4/0tQanG/ggkd5CYz3rjahBg2PnhJ42qtdOFyOmcT78rt6GfLdLP6UX5WfZS6D+wlDhDXeSayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbwx95A3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbwx95A3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57A7C4CEFB;
	Mon, 10 Nov 2025 11:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775200;
	bh=si5lW1ydzquhPG/yrtEo8G93FCB3p2Wrmwm9W6QchvE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=tbwx95A3d3o4lhyzn1sERSENKOGnpKZhEPUfyx2/m6vl6GHUP3SEzvMScGahy8+3D
	 +6dzAImZnLTRNUEbWvwsnCOvQ+3tyl0ElyjaP/0Q9pIIV8FetHWttKZent8CqJZ5LA
	 Qda4arIA+5cJ66J/rbHL6+ct7S6G4qfytstgR1qZNg3IO+Ex+LhOstQ5qZj0qSdBgj
	 5bvZITwnZbwd0oE/WjNoFFJnTvQqkqj42BVWTBwhqHVfY36tSixV2tocNVWZCVswVo
	 XsEQjGrLLBKlCGe+Xv/jp5brlnhlEH6sUZjUaCrbauPdCN91GrpF1vYtwneS/n7WfZ
	 mQzBcjQBIOHtw==
Message-ID: <09cefa2c-18ea-4051-8337-65bfd8472e43@kernel.org>
Date: Mon, 10 Nov 2025 12:46:38 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [v4l-utils] [PATCH] v4l2-ctl: Take stream skip into account to
 setup out buffers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-media@vger.kernel.org
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>
References: <20251022155031.2978-1-laurent.pinchart@ideasonboard.com>
Content-Language: en-US, nl
In-Reply-To: <20251022155031.2978-1-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Laurent,

On 22/10/2025 17:50, Laurent Pinchart wrote:
> When setting up out buffers in do_setup_out_buffers(), the function
> stops after stream_count buffers and returns QUEUE_STOPPED. This doesn't
> take the stream_skip counter into account, resulting in the queue being
> stopped too early. Fix it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> I've tested this patch with a JPEG encoder, invoking v4l2-ctl with
> 
> v4l2-ctl -d $dev \
>         --set-fmt-video-out width=${width},height=${height},pixelformat='Y12 ' \
>         --set-fmt-video width=${width},height=${height},pixelformat=JPEG \
>         --stream-out-mmap \
>         --stream-mmap=3 \
>         --stream-from ${infile} \
>         --stream-to ${outfile} \
>         --stream-skip=50 \
>         --stream-count=1 \
>         --stream-loop \
>         --verbose
> 
> Without the patch streaming stops after 1 frame, with it it stops after
> 51 frames.

This review is really for both this patch and the "v4l2-ctl: Don't ignore skip when writing
capture buffers" patch since they are related.

--stream-skip was originally implemented for capture devices, and there it is easy to
understand what it does.

It was later used as well for output devices and m2m devices, but never documented what
it should do (as you noticed).

I think this needs to be properly defined.

For output devices I would expect that --stream-skip skips the first N buffers that are
received (typically from an input file), so they are never queued to the hardware. It's
really the only thing that makes sense.

do_setup_out_buffers() clearly doesn't do that, it queues them anyway. I doubt if this
was ever tested.

I think this proposed definition also works fine for m2m devices.

The ignore_count_skip boolean is a bad name, perhaps that should be inverted and
call it use_stream_skip instead.

If you explicitly want to queue the buffers to the m2m device, but skip the first
N captured (i.e. processed) buffers, then that would require a new option, I think.
But I'm not sure if that's very useful, unless the first N buffers processed by an
m2m device are garbage for some reason, but that's really bad hardware.

If this is actually what you want, then I need to have a bit more info first and
a discussion.

Regards,

	Hans

> 
> ---
>  utils/v4l2-ctl/v4l2-ctl-streaming.cpp | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
> index ec85e41e9e12..5192f1e168b9 100644
> --- a/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
> +++ b/utils/v4l2-ctl/v4l2-ctl-streaming.cpp
> @@ -1374,9 +1374,14 @@ static int do_setup_out_buffers(cv4l_fd &fd, cv4l_queue &q, FILE *fin, bool qbuf
>  			if (!verbose)
>  				stderr_info(">");
>  			fflush(stderr);
> -			if (!ignore_count_skip && stream_count)
> -				if (!--stream_count)
> -					return QUEUE_STOPPED;
> +			if (!ignore_count_skip) {
> +				if (stream_skip) {
> +					--stream_skip;
> +				} else if (stream_count) {
> +					if (!--stream_count)
> +						return QUEUE_STOPPED;
> +				}
> +			}
>  		}
>  		if (fmt.g_pixelformat() == V4L2_PIX_FMT_FWHT_STATELESS) {
>  			set_fwht_req_by_idx(i, &last_fwht_hdr,
> 
> base-commit: 910ce5d9ec8377811faaad7da456d25370c9188b

