Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6A27EFFA
	for <linux-media@vger.kernel.org>; Wed, 11 Feb 2026 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800977; cv=none; b=aUiGmN+GqlxyMf5WEbEjc494yASz3osJ+npufVVR6yncq2LoHYkGPrmWdJUaMaML0GfUO/7bzJ5LKOXWQnmNQnFYco+5Mc1RIYY9Tx2kR++00e6LuwcvkSFcWwq+ZN3cUYkBnwshZvlNCgZkTcuTuWWt5sfCtpg4GJqJiCfymoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800977; c=relaxed/simple;
	bh=ieZdqCrbgXt8Q0D0lLKrHvXYJK6iDWCK0+sWmU0Ehpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0CH8B/eYnssJdKe/pqGJftYeOcHYvvqjLX8xrB0pQlKDEgLd30i2J93ujifsb7zr95HcOIDZRC1iMARRZy8LV04jnOCK6B5mUEeDCJJLLrzdBhqf/GEu4jSbts+g9i5bB+TRc1+7DvfTULQWj+ngH9YXhN5EtlzZlfnnen3d7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIlmv1bO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIlmv1bO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770800976; x=1802336976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ieZdqCrbgXt8Q0D0lLKrHvXYJK6iDWCK0+sWmU0Ehpg=;
  b=KIlmv1bOjQn6hDlEbES6CCIXSXGpjqUb5ZG6kbl5jCKKX+aOLI9iyw/9
   nRuVTBmNk2cLfOjK/1+M2p5gkm0IAIwLRoj79D1TJGGVlxBWYw2YyBcjW
   rBbI+x/hV0AygAYfYLbogkcmRdluE7CTc3k6T9nL70fPYmI5YQ3tQwejK
   1EsPZsdxymo/oDN1jeB6emNOd/YM14Of9qPSIlTv+yArlWJss4II6bVGR
   IEH6c5L8k4ZcgMMhbfNoyfLtwBqy6ZyyKqkvYvSMrGTFL4mLtyPXDfDIO
   uMcjORCeRi3BKrZkvtGPAgQIb1ZaLcjfd0VEliA5XewJtgqX7f/3c5u8l
   g==;
X-CSE-ConnectionGUID: KDUMx9qhQwCk4rItG2BPFQ==
X-CSE-MsgGUID: IhXwbgqLRgGa9Q+sL/M8yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72019048"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72019048"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 01:09:33 -0800
X-CSE-ConnectionGUID: zM+ZwkDlQ/CnCGCyvl+xZQ==
X-CSE-MsgGUID: ag9zpxeGT/qIfUjeDvZ6pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212222860"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.208])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 01:09:24 -0800
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id D4DFE121DA3;
	Wed, 11 Feb 2026 11:09:31 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vq6Do-00000007laa-2zFR;
	Wed, 11 Feb 2026 11:09:20 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: hans@jjverkuil.nl,
	laurent.pinchart@ideasonboard.com,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Kate Hsuan <hpa@redhat.com>,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Julien Massot <julien.massot@collabora.com>,
	Naushir Patuck <naush@raspberrypi.com>,
	"Yan, Dongcheng" <dongcheng.yan@intel.com>,
	"Cao, Bingbu" <bingbu.cao@intel.com>,
	"Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Mirela Rabulea <mirela.rabulea@nxp.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Ricardo Ribalda Delgado <ribalda@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	David Plowman <david.plowman@raspberrypi.com>,
	"Yu, Ong Hock" <ong.hock.yu@intel.com>,
	"Ng, Khai Wen" <khai.wen.ng@intel.com>
Subject: [PATCH v2 13/14] media: v4l2-subdev: Perform client info changes to i2c drivers
Date: Wed, 11 Feb 2026 11:09:19 +0200
Message-ID: <20260211090920.1851141-14-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211090920.1851141-1-sakari.ailus@linux.intel.com>
References: <20260211090920.1851141-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perform client info argument related changes to two i2c drivers (s5k5baf
and tc358743). These changes are not done by Coccinelle scripts in the
following patch and will be squashed to the previous patch eventually.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/s5k5baf.c                     | 1 +
 drivers/media/i2c/tc358743.c                    | 2 +-
 drivers/media/pci/intel/ipu6/ipu6-isys-subdev.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/s5k5baf.c b/drivers/media/i2c/s5k5baf.c
index d1d00eca8708..a580b7e63302 100644
--- a/drivers/media/i2c/s5k5baf.c
+++ b/drivers/media/i2c/s5k5baf.c
@@ -1463,6 +1463,7 @@ static bool s5k5baf_cmp_rect(const struct v4l2_rect *r1,
 }
 
 static int s5k5baf_set_selection(struct v4l2_subdev *sd,
+				 const struct v4l2_subdev_client_info *ci,
 				 struct v4l2_subdev_state *sd_state,
 				 struct v4l2_subdev_selection *sel)
 {
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index a0ca19359c43..59f509aa1939 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -1822,7 +1822,7 @@ static int tc358743_set_fmt(struct v4l2_subdev *sd,
 	struct tc358743_state *state = to_state(sd);
 
 	u32 code = format->format.code; /* is overwritten by get_fmt */
-	int ret = tc358743_get_fmt(sd, sd_state, format);
+	int ret = tc358743_get_fmt(sd, ci, sd_state, format);
 
 	if (code == MEDIA_BUS_FMT_RGB888_1X24 ||
 	    code == MEDIA_BUS_FMT_UYVY8_1X16)
diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.h b/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.h
index 35069099c364..d4f76d513dc6 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.h
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-subdev.h
@@ -31,6 +31,7 @@ bool ipu6_isys_is_bayer_format(u32 code);
 u32 ipu6_isys_convert_bayer_order(u32 code, int x, int y);
 
 int ipu6_isys_subdev_set_fmt(struct v4l2_subdev *sd,
+			     const struct v4l2_subdev_client_info *ci,
 			     struct v4l2_subdev_state *state,
 			     struct v4l2_subdev_format *fmt);
 int ipu6_isys_subdev_enum_mbus_code(struct v4l2_subdev *sd,
-- 
2.47.3

