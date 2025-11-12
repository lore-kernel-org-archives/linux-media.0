Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06980288537
	for <linux-media@vger.kernel.org>; Wed, 12 Nov 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941820; cv=none; b=fctQtYWqs4cH9zZfOyBaMfUqLz/7wwNv34EKvB5SmpnTzFNPtoos7QS03QTtCAmSKHpH7Cak8pSVdHrJiq7/sf9vSsjLuhja437Nbvsbfs8gqbFZ+ouuyCZpOEgGd590Z703Phbg3xCVnaR7iZvVgxL//nunnJECie3KiqYN4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941820; c=relaxed/simple;
	bh=kqvWZyDMfPMWKmWrcbacIygTAJgFRaqXqBdfcngX7Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9ca/J0wuug+mLvjmOlPe0UwlCfoWW7gSob3ziAz6xgtRLURjGLDpo7GWKo6wlyjXzBqQqAktq92rmHwsslUx62oeUabFo4xPLI+UPo59lVVHuMPsZwPbN4syTgfCM5AfqSyXSTUCfaOxtjY4ybWWW64SEBulZnoeUdKoFruEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0IyYow9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0IyYow9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762941819; x=1794477819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kqvWZyDMfPMWKmWrcbacIygTAJgFRaqXqBdfcngX7Cs=;
  b=Z0IyYow9RiJOPjSjB6T6nmVoTE301t0UpHOMD8CSt80axqNa20vVenBD
   rxkyXvD1F+5iQIIAM2AhhwOak1W3WykciWrbuLmSQi0/PPRCuk/Tis4K7
   hp30nrkM3TvUKPfcpN2zby71n9J+0jTvvZC9GkStoYc2d04uH1usUU97b
   B5Xu2OhHcHmiR/3/19YZptkA/UlnYP2nNecpuaVevIf1/+s4/8YOJB9uY
   9pR2A5bgp5+iV2NnGwLtK5ZdjzSU1Ei+Ldph4ZRBu0Ph/MWHjeH5plC+S
   77PKlbzUQ9xLvEuBiQF+96NE/TgU/xrHV3fBLUNoenLir32srr4dzhCBF
   Q==;
X-CSE-ConnectionGUID: AeEpfld4SMC0oZOgqn8UrQ==
X-CSE-MsgGUID: CqELQuYhTGu/1eGCvxRC6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="75616167"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="75616167"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 02:03:38 -0800
X-CSE-ConnectionGUID: 1V0gZ0l5TEGOPbuASMXObA==
X-CSE-MsgGUID: rDYsMfqnTlKcFd6MD+uxIg==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.214])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 02:03:37 -0800
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8DCAD120852;
	Wed, 12 Nov 2025 12:03:31 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vJ7hN-00000000PJM-0m8u;
	Wed, 12 Nov 2025 12:03:33 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com,
	jacopo.mondi@ideasonboard.com,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Michael Riesch <michael.riesch@collabora.com>
Subject: [PATCH 1/1] media: v4l2-fwnode: Allow passing NULL fwnode to endpoint parsers
Date: Wed, 12 Nov 2025 12:03:33 +0200
Message-ID: <20251112100333.97288-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4l2_fwnode_endpoint_parse() and v4l2_fwnode_endpoint_alloc_parse() take
a fwnode as the first argument and leave it up to the caller to check a
valid fwnode has been obtained through various means. Instead, add a check
here so the callers won't need to do that anymore.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 3 +++
 include/media/v4l2-fwnode.h           | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index cb153ce42c45..22ec702a4567 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -465,6 +465,9 @@ static int __v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwnode,
 	enum v4l2_mbus_type mbus_type;
 	int rval;
 
+	if (!fwnode)
+		return -EINVAL;
+
 	pr_debug("===== begin parsing endpoint %pfw\n", fwnode);
 
 	fwnode_property_read_u32(fwnode, "bus-type", &bus_type);
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index f7c57c776589..299b60ce960b 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -182,7 +182,7 @@ enum v4l2_fwnode_bus_type {
 
 /**
  * v4l2_fwnode_endpoint_parse() - parse all fwnode node properties
- * @fwnode: pointer to the endpoint's fwnode handle
+ * @fwnode: pointer to the endpoint's fwnode handle (may be NULL)
  * @vep: pointer to the V4L2 fwnode data structure
  *
  * This function parses the V4L2 fwnode endpoint specific parameters from the
@@ -236,7 +236,7 @@ void v4l2_fwnode_endpoint_free(struct v4l2_fwnode_endpoint *vep);
 
 /**
  * v4l2_fwnode_endpoint_alloc_parse() - parse all fwnode node properties
- * @fwnode: pointer to the endpoint's fwnode handle
+ * @fwnode: pointer to the endpoint's fwnode handle (may be NULL)
  * @vep: pointer to the V4L2 fwnode data structure
  *
  * This function parses the V4L2 fwnode endpoint specific parameters from the
-- 
2.47.3

