Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B0770E0
	for <linux-media@vger.kernel.org>; Thu,  9 May 2024 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293296; cv=none; b=ddB2O30gKkQWTk0c+LeTfxfVYS+UYNsmIV5utmS4y3AZt4chuwbG3ga7oa1NrodU8rDHqeT7TC/kxY+j9e3v7Ycw/+iiSOf6VKd8+YbqTPVnBdTBhChytb92vvUz2uq0tCJUAoEWXjrWINSw4S/+dEjbxPudCMU3QjSXM9sCTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293296; c=relaxed/simple;
	bh=LMiFxSAY21n4KMposEB9MFwBCUYoYVGfvm0Wqq0fi2s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X3kGpV2SnlyUr2ifDSsuOauEUalxyZ4h8vkRjLmPxfQcbp3PRgRGdBHJd3Viedt6a+3JZOlHUznEwhngyVCM+rw/r1k1z2WdIovrD9aZKIwqU2spjE+eP/WQID/qq0ymBKUXDvyMasc/DTYJHc/6cRzCz/RBtIXaDxorRMUfIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uAXpYqkP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uAXpYqkP"
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1B095397;
	Fri, 10 May 2024 00:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715293289;
	bh=LMiFxSAY21n4KMposEB9MFwBCUYoYVGfvm0Wqq0fi2s=;
	h=Date:From:To:Subject:From;
	b=uAXpYqkPVsZB7lGU0SE1WzrXcdJuwU5R1W4xGPdWlB/0iFnRTqHorcBxUhM+zHFw2
	 iQx4zGHc6O1rEHJO4MLqErmKw1pnYvgs0tpEbdd63BxyDtIOWFznBk4Dj+qdZ1m7ts
	 oltw8y7HbKiT4Nf+jng37WsKOR9BTKFb94kvq8t8=
Date: Fri, 10 May 2024 01:21:23 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-media@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [GIT PULL FOR v6.10] bcm2835-unicam fixes
Message-ID: <20240509222123.GA21033@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Hans,

The following changes since commit 48259b90973718d2277db27b5e510f0fe957eaa0:

  media: media: intel/ipu6: Fix spelling mistake "remappinp" -> "remapping" (2024-05-08 19:23:30 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.git tags/media-fixes-unicam-20240510

for you to fetch changes up to 33108abc0e22f6f5d1209f4ba2b53cc94328f633:

  media: bcm2835-unicam: Fix driver path in MAINTAINERS (2024-05-10 01:08:12 +0300)

These commits fix various issues related to the bcm2835-unicam driver,
that has been merged in the stage tree and is scheduled for v6.10.

----------------------------------------------------------------
bcm2835-unicam fixes for v6.10

----------------------------------------------------------------
Dan Carpenter (1):
      media: bcm2835-unicam: Fix a NULL vs IS_ERR() check

Laurent Pinchart (1):
      media: bcm2835-unicam: Fix driver path in MAINTAINERS

Ricardo Ribalda (2):
      media: bcm2835-unicam: Do not replace IRQ retcode during probe
      media: bcm2835-unicam: Do not print error when irq not found

Uwe Kleine-König (1):
      media: bcm2835-unicam: Convert to platform remove callback returning void

 MAINTAINERS                                      |  2 +-
 drivers/media/platform/broadcom/bcm2835-unicam.c | 16 +++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)


-- 
Regards,

Laurent Pinchart
