Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713B2EE60B
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046570; cv=none; b=TFPoXWU8vqGnqJoSWhqsXInLk9qJpLMx5uL4uXwaPyZCPEDNyW2NDvA25TdF8iCES2bHi8BYl9R7IdqtNmvZonhhjtc0fj8ZxTRrNUx3eWx+O8pkdpQL9/RCm0HSYtAIr+tYANNK3asjYbgimcfQNLgOaz7rD1cdrIKJxD1PKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046570; c=relaxed/simple;
	bh=dyeQ9ubAUemlXdbieRkkQhYSxIxnu0R2SGJe4LyLlxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnxzbBQ2YKk5Dli+BdwE8imLDLbfHlOeK+nCtC5TvTBA7f8AMxrJkakXDGIxENZfr1MdZcnkd51uXfYTyJ9emhXJ4sQ1noNleSZIr049Oc+MZVRxcQFlF8Y/A30u3Y+hPtOy+Dg1ijkYNpF8KKMfkX3xefhODBcxojpg+zbJndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBm7Ms4h; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBm7Ms4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046568; x=1794582568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dyeQ9ubAUemlXdbieRkkQhYSxIxnu0R2SGJe4LyLlxM=;
  b=ZBm7Ms4hIYWd/+IE6L7JTmmA4/jn2wWRukJJ03woiXU7Mea71mMEavF6
   TVf/TFknr7Aa4jnMqpppePNeffZyNwpEDrDWT/35TIYnuHct/4uCkn+x3
   04ZL+FDk/ZQbplSKBh96Y8N2UYO+LPmeSLISDXNo1a8cEcaLKB3sfJa3A
   JlWoRxjJEWsWtLovokIcXoRbDkeAekS8U9499g11Fgwf90C0p0IlxVJTF
   E6BK4idNHwJJ0pvQoh/qEOSK4Hhnz978o6s+FUXQeCFQu/guUhP4Q+2/n
   LrEJZCW2gU1eIBMIxcP1PiL4UmwZOH9HoA807wBis5/haGF+jHNiI42hy
   Q==;
X-CSE-ConnectionGUID: CGcFNak5RXONtTdXGnwx+Q==
X-CSE-MsgGUID: 26m49N6xSQC2F90i3RwWuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65035930"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65035930"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:09:28 -0800
X-CSE-ConnectionGUID: eaIh+LESSTaj5XxCZxiJ6g==
X-CSE-MsgGUID: Mu+4dIRIRTC1b1lP+yWyIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="226839912"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.89])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:09:27 -0800
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 376B6121DDC;
	Thu, 13 Nov 2025 17:09:24 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vJYww-00000002keO-1UQZ;
	Thu, 13 Nov 2025 17:09:26 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com,
	jacopo.mondi@ideasonboard.com,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Michael Riesch <michael.riesch@collabora.com>
Subject: [PATCH v2 1/1] media: v4l2-fwnode: Allow passing NULL fwnode to endpoint parsers
Date: Thu, 13 Nov 2025 17:09:26 +0200
Message-ID: <20251113150926.655972-1-sakari.ailus@linux.intel.com>
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
since v1:

- Explicitly mention @fwnode == NULL case for -EINVAL

 drivers/media/v4l2-core/v4l2-fwnode.c | 3 +++
 include/media/v4l2-fwnode.h           | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

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
index f7c57c776589..cd82e70ccbaa 100644
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
@@ -218,7 +218,7 @@ enum v4l2_fwnode_bus_type {
  *
  * Return: %0 on success or a negative error code on failure:
  *	   %-ENOMEM on memory allocation failure
- *	   %-EINVAL on parsing failure
+ *	   %-EINVAL on parsing failure, including @fwnode == NULL
  *	   %-ENXIO on mismatching bus types
  */
 int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwnode,
@@ -236,7 +236,7 @@ void v4l2_fwnode_endpoint_free(struct v4l2_fwnode_endpoint *vep);
 
 /**
  * v4l2_fwnode_endpoint_alloc_parse() - parse all fwnode node properties
- * @fwnode: pointer to the endpoint's fwnode handle
+ * @fwnode: pointer to the endpoint's fwnode handle (may be NULL)
  * @vep: pointer to the V4L2 fwnode data structure
  *
  * This function parses the V4L2 fwnode endpoint specific parameters from the
@@ -276,7 +276,7 @@ void v4l2_fwnode_endpoint_free(struct v4l2_fwnode_endpoint *vep);
  *
  * Return: %0 on success or a negative error code on failure:
  *	   %-ENOMEM on memory allocation failure
- *	   %-EINVAL on parsing failure
+ *	   %-EINVAL on parsing failure, including @fwnode == NULL
  *	   %-ENXIO on mismatching bus types
  */
 int v4l2_fwnode_endpoint_alloc_parse(struct fwnode_handle *fwnode,
-- 
2.47.3

