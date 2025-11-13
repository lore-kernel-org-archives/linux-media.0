Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD0286A4
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024633; cv=pass; b=Dlb+POv459f5vw+kt+9AQ+GnVt46leB/eNjsKSkqKGCTM6UDeKb8AGjp3p17CZmWfUAva6clWkSsfwZRIR6WvzOUH1k7YXqDMsxB0dhjL1X6zG9KZc54lPF7e3qTOAxyHoc1EpRdNhV2aZanNQHPaUyRlt37OlZdRcSwGCKlVfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024633; c=relaxed/simple;
	bh=h/xtmFlubgwi8ArPEAKleQnvquoE35plCcKkCPUaFxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r7ulMtfAiZJFrIySGthuWYEahcqO7wMRwpeVoyUyQrPCMh4166ElAW/lZjdLvaRuDy6rjakMcPYICyBuT7Viaeg9S7c/88G5N89+H7A7jWx/bBGNgTHLDLi6SnDhUnRffcbD1xKp7L6BbSrpg8hKAJPQNclimv7BH2PJTszd9sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=y+4JYiU6; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="y+4JYiU6"
Received: from hillosipuli.retiisi.eu (91-158-51-183.elisa-laajakaista.fi [91.158.51.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d6Z7k16TvzyS6;
	Thu, 13 Nov 2025 11:03:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763024626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QazRgwZqNpdltoJSqekzJUAMRMmrEG2OvFmIb209ED4=;
	b=y+4JYiU6JEVbNZmP6pNbjsNf4heoJ/VycL/IjeAD6GxnPei0MrZJ8CvdYsX0ekORIaKZNT
	tNI9E3Ka2hnLeMOXVjpXjEcNsK0fPIAyUlcRRlqmD+gl2jrWFxFNqsU6F+ry6coNYZsX93
	PRmNLoTTfN0IqhtriQHDTgpfpj51c6o=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763024626;
	b=X61bMdbQqULksko78QF7tQzCOU3EpUT1WP1hD4eiC2KjO9650Y44KVzjthe25jQRyxyRUe
	DLEInAfeKlbif4EXqxN/mk0KvKQDZM5ORrfCFK1UfL2SoeAUwhLitIjmrnft5CQKoYriSe
	cQqTvnYOnOT8BS7m92H6rFuIvbJewY4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763024626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QazRgwZqNpdltoJSqekzJUAMRMmrEG2OvFmIb209ED4=;
	b=tmC568T80a7l9ftRuL5Ae2ukNq5zemNx3G5vlK5GURXpbxSijTlGyZsgf17Bd67YIAJwSR
	hpDUFsDEcXYqouyzdR42Zwb25sK51UILcAeRlHw/sZ1TnAqPgW1wHupPxcE6p9ZssTMUN5
	EizlzAPO/dD58hsKdsvxUvqAu0RfwYc=
Received: from valkosipuli.retiisi.eu (valkosipuli.local [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id B9D32634C50;
	Thu, 13 Nov 2025 11:03:45 +0200 (EET)
Date: Thu, 13 Nov 2025 11:03:45 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: linux-media@vger.kernel.org
Cc: hans@jjverkuil.nl
Subject: [GIT PULL FOR v6.19] New drivers
Message-ID: <aRWe8WmlPLrYUq8S@valkosipuli.retiisi.eu>
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

  git://linuxtv.org/sailus/media_tree.git tags/for-6.19-2-signed

for you to fetch changes up to 00a56319c1d57b2bd7a62ee7c6727eb0ca697a64:

  media: i2c: add Samsung S5KJN1 image sensor device driver (2025-11-12 13:08:08 +0200)

----------------------------------------------------------------
New V4L2 drivers for v6.19:
- Sony IMX111
- Samsung S5KJN1

----------------------------------------------------------------
Svyatoslav Ryhel (2):
      dt-bindings: media: i2c: document Sony IMX111 CMOS sensor
      media: i2c: add Sony IMX111 CMOS camera sensor driver

Vladimir Zapolskiy (2):
      dt-bindings: media: i2c: Add Samsung S5KJN1 image sensor
      media: i2c: add Samsung S5KJN1 image sensor device driver

 .../bindings/media/i2c/samsung,s5kjn1.yaml         |  103 ++
 .../devicetree/bindings/media/i2c/sony,imx111.yaml |  105 ++
 MAINTAINERS                                        |    8 +
 drivers/media/i2c/Kconfig                          |   20 +
 drivers/media/i2c/Makefile                         |    2 +
 drivers/media/i2c/imx111.c                         | 1610 ++++++++++++++++++++
 drivers/media/i2c/s5kjn1.c                         | 1407 +++++++++++++++++
 7 files changed, 3255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/samsung,s5kjn1.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
 create mode 100644 drivers/media/i2c/imx111.c
 create mode 100644 drivers/media/i2c/s5kjn1.c

Please pull.

-- 
Kind regards,

Sakari Ailus
