Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F6244664
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025040; cv=pass; b=VGvxRtALlzW1utQvFz7lb22gET/AliQRHpCFj6KOgOzbP4WdLo8hdIuoYeK3ynVE+0A5BrKfOjzZPYoJomm5gqX4wO3qvrN6A3GuyuQGHdW9j/G/h0NzmAwmT0iGCxnFQqYDxUnjpey7+Cdkovx2U074WJOfdBczdQwL1ut1anA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025040; c=relaxed/simple;
	bh=7RRUncs6hyLJQQD1HbCkiQu5UkVkLX1T6GNoWyLCSi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pSuYwEVVivKLAz6FeHCHw2F6DWoufcOtUAlK+Gslyxm0VH/mzNLbaGrqdI49B/lAEzbZou53QGTAcU4lVmB6L2OcDmJLelTbXz79uLIj6c5sQLLA9V1sX2jHqW46cIY9o2xbqGNi9blIzD+3/VOIb8o5PWFx7iaw5s0nvTXLv0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qNajYpA2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qNajYpA2"
Received: from hillosipuli.retiisi.eu (91-158-51-183.elisa-laajakaista.fi [91.158.51.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d6Z7B0CrXz49Pxv;
	Thu, 13 Nov 2025 11:03:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1763024599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rju+1j4jb2xgeikdI4gvvlHUq6DcU9RCwB96TzY3Nfo=;
	b=qNajYpA2GHWWZ12IiQQ9Vt89BF0DhwosGyphk5LGsfzgeGSxrH8mulujTG6A+Eq+wIoLkM
	x53j6HStJmL3HLl+vbOJkKVZrAMdfsVrQyIj2w6+6YymwMllfOj8RW24kGhqPOshQ/8YM/
	9kyKsIXMyWOAWVKKzqYq06kKbDJ2Lsh1B9augfq0HkI5EjZ/tniCSyTobzERJj/xOD0cw5
	jBv/c4eP6VZC0h6FIDI82933wLtLpdVHaXbN9nYask06fa2i7RSwnxVpzA5+WuW4BJjYHW
	rnJbE7tPQRWpmHrS2ZqowI1Tx6kC8XPaLNQ6OxA2uMww6wdDWfETgH0yKD89JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1763024599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rju+1j4jb2xgeikdI4gvvlHUq6DcU9RCwB96TzY3Nfo=;
	b=A/QtWarQDAGqKGpn571rptE7GMNgnEuJZaT7gLYMNlzljTghoDDC7TXniA1oBRTEZwi/j+
	q8+BiJ6VEwtB3oQ83qarnleekdRKj0Qs5NjYXfHP7mojmoUbwBAfiCg3J9b27WXyEjD8LZ
	C+tOWCEbUG3BJZ13tOk6Sqa/RGw2zDQCfP90LaFIFt/rtPi5QYffA01dG7cCyz60yjRT9u
	TqlEqnCbMpC2q4Q6p2vdFwSL8/nZzVjjq3I3GIcUP9q859jyWt1daQTzamCJBVlISr9rLS
	gDXv/KfcMK73QBoJNPlUqtl6WZLunNVn3t4IiMdzzs+FsSATiNtbBtavLBtCiA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1763024599;
	b=RzwPgogh20Oxl4cucIoX26iHu9AsCV381eRL/OVw3KPMmnZ9Gkorb8sw7p2hz9UcLfCocf
	+TkOM94jeRMQlKJeHni1YbqKMXcXaalHD6I4TYz8V4zJhyRqLn/cnwqlszBqkqNGtbIUzI
	QiECel/LMxmGKQDr5hFJm0LH9SkLBDLUu9syBuZO3avUeIM1EZ883NT3JeT9rvp2j59oAo
	WA/bgGB5UDSmwGI6aZMhjsXucoIR4FsPUBCFAIjlOnxUMLFR5PB4Y/2imPDMQxF7KBdfjK
	tJba3kUaxdSOwClSwOwsuR18ooALK+m1k1/NwCfaEq56UxqbdvdXMpOiNW559Q==
Received: from valkosipuli.retiisi.eu (valkosipuli.local [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 7D706634C50;
	Thu, 13 Nov 2025 11:03:17 +0200 (EET)
Date: Thu, 13 Nov 2025 11:03:17 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: linux-media@vger.kernel.org
Cc: hans@jjverkuil.nl
Subject: [GIT PULL FOR v6.19] Fixes and cleanups
Message-ID: <aRWe1S2iHSoN7TDj@valkosipuli.retiisi.eu>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans, Mauro,

The following changes since commit 29ae148fa88934bfd81af2a616816f9e22559b7c:

  Merge tag 'v6.18-rc5' into media-next (2025-11-11 12:44:28 +0100)

are available in the Git repository at:

  git://linuxtv.org/sailus/media_tree.git tags/for-6.19-3-signed

for you to fetch changes up to bd15c0456d3eb5e51f177899552ab805a3d247f6:

  MAINTAINERS: adjust file entry in TDA1997x MEDIA DRIVER (2025-11-12 12:00:58 +0200)

----------------------------------------------------------------
V4L2 cleanups and fixes for 6.19
- Sensor driver cleanups and improvements (imx335, imx219 and imx214)
- MAINTAINERS file name fix for TDA1997x
- Dynamic CSI-2 lane number configuration in v4l2-common, imx-mipi-csis
- Monochrome format support in ipu6
- IMX461 and OV05C10 added to IPU bridge (no drivers yet though)
- DT bindings fix for fsl,imx6q-vdoa

----------------------------------------------------------------
Frank Li (1):
      dt-bindings: media: fsl,imx6q-vdoa: remove redundant ""

Hans de Goede (1):
      media: ipu6: isys: Add support for monochrome media bus formats

Hao Yao (1):
      media: ipu-bridge: Add OV05C10 to the list of supported sensors

Isaac Scott (4):
      media: v4l: Add helper to get number of active lanes via a pad
      media: imx-mipi-csis: Move redundant debug print in probe
      media: imx-mipi-csis: Add num_data_lanes to mipi_csis_device
      media: imx-mipi-csis: Support active data lanes differing from maximum

Jai Luthra (6):
      media: imx335: Update the native pixel array width
      media: imx335: Update HBLANK range on mode change
      media: imx335: Handle runtime PM in leaf functions
      media: imx355: Use subdev active state
      media: imx335: Support 2x2 binning
      media: imx335: Switch to {enable,disable}_streams

Jimmy Su (1):
      media: ipu-bridge: Add IMX471 to the list of supported sensors

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in TDA1997x MEDIA DRIVER

Ricardo Ribalda (1):
      media: i2c: imx214: Rearrange control initialization

Tarang Raval (2):
      media: i2c: imx219: Propagate errors from control range updates
      media: i2c: imx219: Replace exposure magic value with named constant

Umang Jain (2):
      media: imx335: Rectify name of mode struct
      media: imx335: Support vertical flip

 .../devicetree/bindings/media/fsl,imx6q-vdoa.yaml  |   2 +-
 MAINTAINERS                                        |   2 +-
 drivers/media/i2c/imx214.c                         |  15 +-
 drivers/media/i2c/imx219.c                         |  74 +--
 drivers/media/i2c/imx335.c                         | 509 ++++++++++++++-------
 drivers/media/pci/intel/ipu-bridge.c               |   4 +
 drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c      |   4 +
 drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c    |  34 +-
 drivers/media/pci/intel/ipu6/ipu6-isys-video.c     |  14 +
 drivers/media/platform/nxp/imx-mipi-csis.c         |  21 +-
 drivers/media/v4l2-core/v4l2-common.c              |  29 ++
 include/media/v4l2-common.h                        |  20 +
 12 files changed, 505 insertions(+), 223 deletions(-)

Please pull.

-- 
Kind regrds,

Sakari Ailus
