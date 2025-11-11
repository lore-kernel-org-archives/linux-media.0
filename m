Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FF275AF5
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860063; cv=none; b=QWTcwTIWdJ3w9D2upPBNsgYEsFp+YABVblJx0wZV6HVHCAfgKklpxfdzTkPWwX3DDRynXz/wbBiwQsuT4gCIeYB+jrfGmbxW3IyRgPYDrG8/ieYWfkdqJaSlf0gLDnbGvRzvNOgZF8Afr26SGYSKWc4GAFZemptnCHGAtiTA5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860063; c=relaxed/simple;
	bh=AZBjE5xaurcKtZzY2oni9P2PkWeQW1P1L55/WtEuoMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpfPEyJry4ZPEMZ1+oxoF3DsG1MmHGdUimTB+WgrNMyj5fQsbtrSfa5La/puglraK8JGa+uT4y58VaQctWNdgyggvb/qB7e7YhotsSlKhdq69u1IaFXC06ZCFTDgftOpv/z7oKxQq+vMgSfJP29q3W0DpH3/38sw/AXmYKA2I7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRsCwojE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRsCwojE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762860062; x=1794396062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AZBjE5xaurcKtZzY2oni9P2PkWeQW1P1L55/WtEuoMM=;
  b=IRsCwojEs6iumcMewIVRHdN4dV52KDYm/+PhIU+KjdjItQ1+Stzv//2n
   fv7zcADE+OglL5R7Xax0lRKbzj8p0hPAWYWzOltwEiG8cHLGpvRAqk4T9
   eEFDjZ/Tt8EF4JzrHO3Rsu/5toLm3J40Srs3yHTtEtt4Wvs2awaFbooVh
   h3e5iTpyRIYwOAOICQpJ5Jn6P9ghnb966fpHoLoWokroAcF0Eczgchrmq
   qpKiq9Y3kMVrPQfsiTzAsR01o2c34poRc0vcG0SBSbeEjAO076R+WzpW2
   Lr2GaNO04niTSWLbMpPkMfcY1TjYek5SUF37QnlN6PJgqQBH+COuXCd4Y
   Q==;
X-CSE-ConnectionGUID: i3cxaZGTTKC3Av/woW5Oow==
X-CSE-MsgGUID: /jhFfUPxQoGD3YK5RFIlpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75220587"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="75220587"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:21:01 -0800
X-CSE-ConnectionGUID: OFBJUn8xTCKGGuf0hI2Ekw==
X-CSE-MsgGUID: ikp1niu6R4SUu2zn3sdnzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193196260"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.96])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:21:00 -0800
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 70FCC11F983;
	Tue, 11 Nov 2025 13:20:57 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vImQj-00000000Ot1-1U81;
	Tue, 11 Nov 2025 13:20:57 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: hans@jjverkuil.nl,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH 1/1] media: v4l2-ctrls: Set error v4l2_ctrl_new_fwnode_properties consistently
Date: Tue, 11 Nov 2025 13:20:57 +0200
Message-ID: <20251111112057.95655-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vast majority of the callers of v4l2_ctrl_new_fwnode_properties() do
check the returned error code but the function does not set the control
handler's error on failure. This will make error handling more complicated
and prone for bugs.

Always assign the control handler's error field on error in
v4l2_ctrl_new_fwnode_properties().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 3 ++-
 include/media/v4l2-ctrls.h                | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 209bc05883bb..1d4b5859f0e2 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -2780,7 +2780,8 @@ int v4l2_ctrl_new_fwnode_properties(struct v4l2_ctrl_handler *hdl,
 			orientation_ctrl = V4L2_CAMERA_ORIENTATION_EXTERNAL;
 			break;
 		default:
-			return -EINVAL;
+			hdl->error = -EINVAL;
+			return hdl->error;
 		}
 		if (!v4l2_ctrl_new_std_menu(hdl, ctrl_ops,
 					    V4L2_CID_CAMERA_ORIENTATION,
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index 31fc1bee3797..327976b14d50 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -1581,6 +1581,9 @@ int v4l2_ctrl_subdev_log_status(struct v4l2_subdev *sd);
  * not overwritten. Callers should register the controls they want to handle
  * themselves before calling this function.
  *
+ * This function will set the control handler's error field on failure, just as
+ * other functions adding controls to the handler.
+ *
  * Return: 0 on success, a negative error code on failure.
  */
 int v4l2_ctrl_new_fwnode_properties(struct v4l2_ctrl_handler *hdl,
-- 
2.47.3

