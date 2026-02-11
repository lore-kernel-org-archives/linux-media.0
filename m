Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13F70808
	for <linux-media@vger.kernel.org>; Wed, 11 Feb 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800963; cv=none; b=rGeDrTYQRuWHBJKZXrG/7cYvmMZ+tU5p25mSNyt2JxsMaPgiIG3lH9pUt3bAYuqlJPWRwsQnl6kf6V3nOeskbsN2Brcgs1M2eSs71lHn3tzDQ1ZzyIuYaNvrdGAivF+fXy8OSbhscCPTDz2uQ2pi1a3nLYZuJIYlsMMkhj9Kwwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800963; c=relaxed/simple;
	bh=p+7wLYZRqYGLrHjH4Iw1UW1GedO2euHRAeT7VfN6uxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsHaXZNiksuO3UxCBYxJvR3IJK9pHRfy0Cnnv5YJObh3DCIHYIUChOAtP6KH2xqtOFGnClFmduh9mkkVOHLWZQDCIpn6M6lfcJN53eq29o2kQH9w77t4R0r/utRdvt8G+f1eizpCiTwa7+2l7Z/JGQdgm7Mh7WZcA8oTgbIBdIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IktnGgkS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IktnGgkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770800962; x=1802336962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+7wLYZRqYGLrHjH4Iw1UW1GedO2euHRAeT7VfN6uxA=;
  b=IktnGgkSHWx4r8UnJGglnZNLOZ6VHgW+UKqwNZ1vZko6eAjXNpRYTEJZ
   j1iUdo4xhlpAczdc8YbE5qz8cjlfyrs1LzUDqRcsm+8IatmfySNx8pRzG
   vsUPvconZs3uTOFuTuviN46ctrh2ixOESVYkNc7zqkTuDBa4tKRdfpbKH
   D2a5/YpLO6rw5mquw0FWTRTPlL/o2UcYALZfejiG7Hb+DNdJArpJDRL7k
   1LWo+sCxaCCdRAIIIxVYBs9GmRkSYTzTjoCkYDom8Up4a83LheljJwlM1
   ErPpv5rUH9L0lCVJQ38T/ENaQxZfI+TMa+9wCsAPSI8f2h2qPx5Q7JRZD
   g==;
X-CSE-ConnectionGUID: jlGhLmm6S0yQTJds82R1nw==
X-CSE-MsgGUID: 4xzG3o+hSS679xp7DsZ8qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72018900"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72018900"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 01:09:21 -0800
X-CSE-ConnectionGUID: M4T34fRSRVexM0gd/fcvCw==
X-CSE-MsgGUID: h+xHDfUHRiC/JsKjZheOtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212222784"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.208])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 01:09:15 -0800
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id A7DE0121D42;
	Wed, 11 Feb 2026 11:09:31 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vq6Do-00000007lZs-2BgK;
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
Subject: [PATCH v2 02/14] media: v4l2-subdev: Allow accessing routes with STREAMS client capability
Date: Wed, 11 Feb 2026 11:09:08 +0200
Message-ID: <20260211090920.1851141-3-sakari.ailus@linux.intel.com>
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

Disable access to routes when the STREAMS client capability bit isn't set.
Routes aren't relevant otherwise anyway.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 66842b975f91..b2105c34478e 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1008,6 +1008,9 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
 			return -ENOIOCTLCMD;
 
+		if (!client_supports_streams)
+			return -EINVAL;
+
 		memset(routing->reserved, 0, sizeof(routing->reserved));
 
 		krouting = &state->routing;
@@ -1035,6 +1038,9 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
 			return -ENOIOCTLCMD;
 
+		if (!client_supports_streams)
+			return -EINVAL;
+
 		if (routing->which != V4L2_SUBDEV_FORMAT_TRY && ro_subdev)
 			return -EPERM;
 
-- 
2.47.3

