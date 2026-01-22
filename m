Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E27081E;
	Thu, 22 Jan 2026 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091345; cv=none; b=MAFB4sCRW9dvNUXNcsPivZ2Cw33pS3keUit+5ZUV1T7LmnGZvQqtT9a9HB8Ot+fqgpdMxhhNyUxyhfd/MXm5BaldvsAvxDnL3rzexHWzsfBKDpLOeJsUpa+8J3gT6w96dXV349ttZ9k+AfgoKNUwP7015WnFMnj79fTcpSxznWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091345; c=relaxed/simple;
	bh=4fAqzaRKpE2DY0ZYu8wwE1L8t5B65MVAu7uENVqu/HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPx4xMfq9VNAo/fAE+f49PbQbV5njfufC6puSjK0NJAjxHIUgZBbOoekEuCkSVZ0SHF4IuHt0Buphp2OadkkimjSaqY42yE4KqIe5cHdLhTE+piC6Wt77KDCYElaKXchGE1zSFzWcRysqa0jd6wDCT4mUadolUuKa1gGlRwPCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=v2fAJcC/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="v2fAJcC/"
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A854A06;
	Thu, 22 Jan 2026 15:15:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769091308;
	bh=4fAqzaRKpE2DY0ZYu8wwE1L8t5B65MVAu7uENVqu/HU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v2fAJcC/6ixw4Sd2kTTMtVvN9mx3ZPZR7iSkS8+PySlHBGMMMD5Hb2qSPAwC03Mn1
	 xAbDUWCI1jAy6+6+znwlt4zPWpLfsbeWrT0VQkGAP/cigTt/C+DQctWZVT7efkzCcv
	 h2oudF2mK0i9ixbwS88TeKsSMG1xJdUwCmRw+MBg=
Message-ID: <21e5fbbf-5035-4d4b-9cec-87117b45f95b@ideasonboard.com>
Date: Thu, 22 Jan 2026 16:15:37 +0200
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] media: subdev: Add
 v4l2_subdev_get_frame_desc_passthrough and use it
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324-frame-desc-passthrough-v4-0-dbe2412297cc@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20250324-frame-desc-passthrough-v4-0-dbe2412297cc@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 24/03/2025 10:04, Tomi Valkeinen wrote:
> When writing the exact same code the third time for Renesas, I thought
> we probably need a helper.
> 
>  Tomi

It's been a while, but the need for this series hasn't gone anywhere. I
will need to send a rebased version and re-test, but any comments before
I do that?

 Tomi

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> ---
> Changes in v4:
> - Update the helper name in commit descriptions too
> - Link to v3: https://lore.kernel.org/r/20250324-frame-desc-passthrough-v3-0-993839a1f9b3@ideasonboard.com
> 
> Changes in v3:
> - Rename the helper to v4l2_subdev_get_frame_desc_passthrough()
> - Check for fd->entry[] array overflow
> - Add error prints (with dev_dbg)
> - Link to v2: https://lore.kernel.org/r/20250219-frame-desc-passthrough-v2-0-5135d57ecd6a@ideasonboard.com
> 
> Changes in v2:
> - Fix "uninitialized symbol 'ret'"
> - Reorder local variables
> - Link to v1: https://lore.kernel.org/r/20250218-frame-desc-passthrough-v1-0-a32458f53714@ideasonboard.com
> 
> ---
> Tomi Valkeinen (3):
>       media: subdev: Add v4l2_subdev_get_frame_desc_passthrough helper
>       media: i2c: ds90ub953: Use v4l2_subdev_get_frame_desc_passthrough
>       media: i2c: ds90ub913: Use v4l2_subdev_get_frame_desc_passthrough
> 
>  drivers/media/i2c/ds90ub913.c         |  59 +-----------------
>  drivers/media/i2c/ds90ub953.c         |  61 +-----------------
>  drivers/media/v4l2-core/v4l2-subdev.c | 113 ++++++++++++++++++++++++++++++++++
>  include/media/v4l2-subdev.h           |  22 +++++++
>  4 files changed, 137 insertions(+), 118 deletions(-)
> ---
> base-commit: f2151613e040973c868d28c8b00885dfab69eb75
> change-id: 20250218-frame-desc-passthrough-66805e413974
> 
> Best regards,

