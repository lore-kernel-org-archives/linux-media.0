Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDFB32AAA1
	for <linux-media@vger.kernel.org>; Thu, 22 Jan 2026 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052305; cv=none; b=nXAHjd46TdDCPeKjK0SaoQSo+TT+mQGtfdIW0g1y4bzybBWbAOTuUnSGggKzL0WaAsuEYEWL98ww2LGVKRAszj+zqMoYiyc5fLlWTWBYF3duHGmOvPIDE2CwcQLI0Hr3Lvm2PCbvyNSyOjxj7EZWJ89KakIsEEqyao3MQJr1ECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052305; c=relaxed/simple;
	bh=2KxPpmLUSEvAz1IAa0NXPHc13znn8+LLv97mEoYxw5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iId9T8LgjDo6b2alF4Xcs8Ir0QxQpy12YbZoIvC15tgCNMnzoZXycdw7hmTH4SjIbchypq7+rOI6TdYRd4Lfhz3bBaXOEcn4yDN62jAVciV5vK5yz4itViBpbOSVGxvBehoRVFQVfRl5dxiUTnEeabSReLpZ514DXP2YMyiWZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LXvhqBAX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LXvhqBAX"
Received: from pendragon.ideasonboard.com (2001-14ba-703d-e500--ff4.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::ff4])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 8516E2DD;
	Thu, 22 Jan 2026 04:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1769052268;
	bh=2KxPpmLUSEvAz1IAa0NXPHc13znn8+LLv97mEoYxw5g=;
	h=Date:From:To:Cc:Subject:From;
	b=LXvhqBAXv/b0HLxpAmO0M6PqZOnJ3eHUhRfH0yWD43wLFZ0yhoawThrX8Cy/YaNpc
	 SiLKZhva4+jAps4Ib2kKUij5ybX4bntM8Biq4ILaJboeWyGHOrd+q1RCj8sXVcTjHT
	 MTw/xa4mJdlgU0WZ7OcpjTD4iDyOIU3aMP6NETHE=
Date: Thu, 22 Jan 2026 05:24:59 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Hans Verkuil <hans@jjverkuil.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hansg@kernel.org>
Subject: [GIT PULL FOR v6.20] uvcvideo driver fixes
Message-ID: <20260122032459.GA215800@killaraus>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Hans, Mauro,

Sorry for the late pull request, this should be my last one for v6.20.

The following changes since commit e3b5b77e36894b4d61374ecb916355809c6e4aa4:

  media: rkvdec: Add HEVC support for the VDPU383 variant (2026-01-21 14:43:10 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/linux-media/users/uvc.git tags/next-media-uvc-20260121

for you to fetch changes up to 81611a213bdf88d654835acf42d6c541ac35a8f2:

  media: uvcvideo: Pass allocation size directly to uvc_alloc_urb_buffer (2026-01-22 04:08:38 +0200)

----------------------------------------------------------------
uvcvideo driver fixes:

- Fix support for devices with unit and terminal ID collisions
- Return queued buffers on stream start failure
- Fix URB allocation for small buffers

----------------------------------------------------------------
Michal Pecio (1):
      media: uvcvideo: Return queued buffers on start_streaming() failure

Ricardo Ribalda (3):
      media: uvcvideo: Create an ID namespace for streaming output terminals
      media: uvcvideo: Fix allocation for small frame sizes
      media: uvcvideo: Pass allocation size directly to uvc_alloc_urb_buffer

 drivers/media/usb/uvc/uvc_driver.c | 54 +++++++++++++++++++++++---------------
 drivers/media/usb/uvc/uvc_queue.c  | 12 +++++----
 drivers/media/usb/uvc/uvc_video.c  | 15 ++++++-----
 drivers/media/usb/uvc/uvcvideo.h   |  3 ++-
 4 files changed, 51 insertions(+), 33 deletions(-)

-- 
Regards,

Laurent Pinchart
