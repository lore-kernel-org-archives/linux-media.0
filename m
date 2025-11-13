Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986329BDB0
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028563; cv=none; b=qlpAZwuaaomJh9B76Uz2CZm3P+iRHTCAlzanc3zzbO8l09oxS9k5ha1fV20OioT7a+d3iLtl520SSIICbQ/13y/jawHddTJ1RnWxLEHDdqghm31U6N9Dr4KMnfTANIcoyx4SafVa3PMtzbpbkQkiGJeFzrIN+EHJS/dhspwhiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028563; c=relaxed/simple;
	bh=mQqOJjtYnIzoh/JmziHTm3Ymg3vYw09XLeEp7zlxn3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=chJW+A8olsGSHOe5zIjJ3br9AggjFtoCfMSDRdOffzYuVGFaSOiOPZxGWNog9lFNpb1+X02/5YEVCIXOS+0b987msZTCF6duFQtGuRsWBjQoLkxr6XKRziXwu761B1vd5Klp9/6w1TcW4IknSAl1u4yxlMQuQhlF1Sus46w+TKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GmyTPyqt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GmyTPyqt"
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A77E15B2;
	Thu, 13 Nov 2025 11:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1763028438;
	bh=mQqOJjtYnIzoh/JmziHTm3Ymg3vYw09XLeEp7zlxn3w=;
	h=Date:From:To:Cc:Subject:From;
	b=GmyTPyqtVcW3csOll18HtDdBChVYkzNJnQHS9nEZV9x+VscQw9u8uhl3LVnyrtvBL
	 S1cSVSi5tRWF9fHSGNaRsMaCSBU7RybxNZJ8mnzBUa6vQ/CehCFa9cWMSQ1GX/WOSS
	 /BRNQO/PdD3So6+kuFO9OaPlIPTWnxawrtQ32lx0=
Date: Thu, 13 Nov 2025 11:09:15 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: hans@jjverkuil.nl
Subject: [GIT PULL FOR v6.19] Mali C55, v4l2-isp, Renesas IVC
Message-ID: <mm3jbjexeqvgnolgdvkb6d3e5zt7b7ppttozjwey67ptta7k2h@fvon4edqkp2j>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit 29ae148fa88934bfd81af2a616816f9e22559b7c:

  Merge tag 'v6.18-rc5' into media-next (2025-11-11 12:44:28 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/linux-media/users/jmondi.git tags/mali-c55-for-v6.19

for you to fetch changes up to 64f5ff385db848a06c8d0dd46eb7fdc19218e39f:

  MAINTAINERS: Add entry for rzv2h-ivc driver (2025-11-13 09:56:02 +0100)

----------------------------------------------------------------
v4l2-isp, Mali C55, Renesas IVC for v6.19

- v4l2-isp helpers and uAPI
- Mali C55 ISP driver (which use v4l2-isp)
- Renesas IVC driver

This PR introduces support for the Mali C55 ISP driver, which is used on
Renesas RZ/V2H in combination with the IVC that performs memory access
on behalf of the ISP.

The Mali C55 driver uses the generic V4L2 ISP parameters format and helpers,
which are part of this pull request as well.

CI pipeline at:
https://gitlab.freedesktop.org/linux-media/users/jmondi/-/pipelines/1546316

Some checkpatch issues, but we can only trade alignment issues for long lines
issues.
----------------------------------------------------------------
Daniel Scally (17):
      media: uapi: Add MEDIA_BUS_FMT_RGB202020_1X60 format code
      media: uapi: Add 20-bit bayer formats
      dt-bindings: media: Add bindings for ARM mali-c55
      media: uapi: Add controls for Mali-C55 ISP
      media: mali-c55: Add Mali-C55 ISP driver
      media: Documentation: Add Mali-C55 ISP Documentation
      MAINTAINERS: Add entry for mali-c55 driver
      media: Add MALI_C55_3A_STATS meta format
      media: uapi: Add 3a stats buffer for mali-c55
      media: platform: Add mali-c55 3a stats devnode
      Documentation: mali-c55: Add Statistics documentation
      media: uapi: Add parameters structs to mali-c55-config.h
      media: platform: Add mali-c55 parameters video node
      Documentation: mali-c55: Document the mali-c55 parameter setting
      dt-bindings: media: Add bindings for the RZ/V2H(P) IVC block
      media: platform: Add Renesas Input Video Control block driver
      MAINTAINERS: Add entry for rzv2h-ivc driver

Jacopo Mondi (9):
      media: uapi: Introduce V4L2 generic ISP types
      media: uapi: Convert RkISP1 to V4L2 extensible params
      media: uapi: Convert Amlogic C3 to V4L2 extensible params
      media: Documentation: uapi: Add V4L2 ISP documentation
      media: v4l2-core: Introduce v4l2-isp.c
      media: rkisp1: Use v4l2-isp for validation
      media: amlogic-c3: Use v4l2-isp for validation
      media: Documentation: kapi: Add v4l2 generic ISP support
      media: mali-c55: Add image formats for Mali-C55 parameters buffer

 Documentation/admin-guide/media/mali-c55-graph.dot |   19 +
 Documentation/admin-guide/media/mali-c55.rst       |  413 +++++++
 Documentation/admin-guide/media/v4l-drivers.rst    |    1 +
 .../devicetree/bindings/media/arm,mali-c55.yaml    |   86 ++
 .../bindings/media/renesas,r9a09g057-ivc.yaml      |  103 ++
 Documentation/driver-api/media/v4l2-core.rst       |    1 +
 Documentation/driver-api/media/v4l2-isp.rst        |   49 +
 .../userspace-api/media/drivers/index.rst          |    1 +
 .../userspace-api/media/drivers/mali-c55.rst       |   55 +
 .../userspace-api/media/v4l/meta-formats.rst       |    2 +
 .../media/v4l/metafmt-arm-mali-c55.rst             |   84 ++
 .../userspace-api/media/v4l/subdev-formats.rst     |  420 ++++++-
 Documentation/userspace-api/media/v4l/v4l2-isp.rst |   67 ++
 MAINTAINERS                                        |   31 +
 drivers/media/platform/Kconfig                     |    1 +
 drivers/media/platform/Makefile                    |    1 +
 drivers/media/platform/amlogic/c3/isp/Kconfig      |    1 +
 .../media/platform/amlogic/c3/isp/c3-isp-params.c  |  165 +--
 drivers/media/platform/arm/Kconfig                 |    5 +
 drivers/media/platform/arm/Makefile                |    2 +
 drivers/media/platform/arm/mali-c55/Kconfig        |   18 +
 drivers/media/platform/arm/mali-c55/Makefile       |   11 +
 .../media/platform/arm/mali-c55/mali-c55-capture.c |  961 ++++++++++++++++
 .../media/platform/arm/mali-c55/mali-c55-common.h  |  310 ++++++
 .../media/platform/arm/mali-c55/mali-c55-core.c    |  917 ++++++++++++++++
 drivers/media/platform/arm/mali-c55/mali-c55-isp.c |  665 +++++++++++
 .../media/platform/arm/mali-c55/mali-c55-params.c  |  817 ++++++++++++++
 .../platform/arm/mali-c55/mali-c55-registers.h     |  449 ++++++++
 .../media/platform/arm/mali-c55/mali-c55-resizer.c | 1156 ++++++++++++++++++++
 .../media/platform/arm/mali-c55/mali-c55-stats.c   |  325 ++++++
 drivers/media/platform/arm/mali-c55/mali-c55-tpg.c |  437 ++++++++
 drivers/media/platform/renesas/Kconfig             |    1 +
 drivers/media/platform/renesas/Makefile            |    1 +
 drivers/media/platform/renesas/rzv2h-ivc/Kconfig   |   18 +
 drivers/media/platform/renesas/rzv2h-ivc/Makefile  |    5 +
 .../platform/renesas/rzv2h-ivc/rzv2h-ivc-dev.c     |  251 +++++
 .../platform/renesas/rzv2h-ivc/rzv2h-ivc-subdev.c  |  376 +++++++
 .../platform/renesas/rzv2h-ivc/rzv2h-ivc-video.c   |  533 +++++++++
 .../media/platform/renesas/rzv2h-ivc/rzv2h-ivc.h   |  130 +++
 drivers/media/platform/rockchip/rkisp1/Kconfig     |    1 +
 .../media/platform/rockchip/rkisp1/rkisp1-params.c |  150 +--
 drivers/media/v4l2-core/Kconfig                    |    4 +
 drivers/media/v4l2-core/Makefile                   |    1 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |    2 +
 drivers/media/v4l2-core/v4l2-isp.c                 |  132 +++
 include/media/v4l2-isp.h                           |   91 ++
 include/uapi/linux/media-bus-format.h              |    9 +-
 include/uapi/linux/media/amlogic/c3-isp-config.h   |   92 +-
 include/uapi/linux/media/arm/mali-c55-config.h     |  794 ++++++++++++++
 include/uapi/linux/media/v4l2-isp.h                |  102 ++
 include/uapi/linux/rkisp1-config.h                 |  107 +-
 include/uapi/linux/v4l2-controls.h                 |    6 +
 include/uapi/linux/videodev2.h                     |    4 +
 53 files changed, 9999 insertions(+), 384 deletions(-)
 create mode 100644 Documentation/admin-guide/media/mali-c55-graph.dot
 create mode 100644 Documentation/admin-guide/media/mali-c55.rst
 create mode 100644 Documentation/devicetree/bindings/media/arm,mali-c55.yaml
 create mode 100644 Documentation/devicetree/bindings/media/renesas,r9a09g057-ivc.yaml
 create mode 100644 Documentation/driver-api/media/v4l2-isp.rst
 create mode 100644 Documentation/userspace-api/media/drivers/mali-c55.rst
 create mode 100644 Documentation/userspace-api/media/v4l/metafmt-arm-mali-c55.rst
 create mode 100644 Documentation/userspace-api/media/v4l/v4l2-isp.rst
 create mode 100644 drivers/media/platform/arm/Kconfig
 create mode 100644 drivers/media/platform/arm/Makefile
 create mode 100644 drivers/media/platform/arm/mali-c55/Kconfig
 create mode 100644 drivers/media/platform/arm/mali-c55/Makefile
 create mode 100644 drivers/media/platform/arm/mali-c55/mali-c55-capture.c
 create mode 100644 drivers/media/platform/arm/mali-c55/mali-c55-common.h
 create mode 100644 drivers/media/platform/arm/mali-c55/mali-c55-core.c
 create mode 100644 drivers/media/platform/arm/mali-c55/mali-c55-isp.c
 create mode 100644 drivers/media/platform/arm/mali-c55/mali-c55-params.c
 create mode 100644 drivers/media/platform/arm/mali-c55/mali-c55-registers.h
 create mode 100644 drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
 create mode 100644 drivers/media/platform/arm/mali-c55/mali-c55-stats.c
 create mode 100644 drivers/media/platform/arm/mali-c55/mali-c55-tpg.c
 create mode 100644 drivers/media/platform/renesas/rzv2h-ivc/Kconfig
 create mode 100644 drivers/media/platform/renesas/rzv2h-ivc/Makefile
 create mode 100644 drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc-dev.c
 create mode 100644 drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc-subdev.c
 create mode 100644 drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc-video.c
 create mode 100644 drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc.h
 create mode 100644 drivers/media/v4l2-core/v4l2-isp.c
 create mode 100644 include/media/v4l2-isp.h
 create mode 100644 include/uapi/linux/media/arm/mali-c55-config.h
 create mode 100644 include/uapi/linux/media/v4l2-isp.h
