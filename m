Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83EB3542F1
	for <linux-media@vger.kernel.org>; Wed, 11 Feb 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800964; cv=none; b=FMDqQFn20fBCXdCspsZDmojZzJ3XK3SMiZBydyL1/ONms36e7bEKlNyICSQbx1xu7EnEjrUAlEdjertJp4srBhsHsktPcGyHQG3xGcsNws35P9bzmGiXDxVhdMEKelErupr3I0nam7jX9i0RdNI9nwuOsTLiaFj3EYZEdHlNA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800964; c=relaxed/simple;
	bh=o5cCOFuvTO15y/C13IyG4UU4VQKNcku4BAmJLHOBeC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmNVOcImRiGcIFwrgkciSmsGtR/IqKimjp+6/PLjtZjfp30yXthf+TPLDzJjEAmb1AVKlUUNstWUFl6jS7Fmkjvj4nMKiZPuveVBnnYJrV8/3WWEaeXTWvcbUTFZgiXRMZGnU4vYR5AaUql43Rq3lJjlWb4U3JaihWTyzzNb5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akJSxrSG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akJSxrSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770800963; x=1802336963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o5cCOFuvTO15y/C13IyG4UU4VQKNcku4BAmJLHOBeC8=;
  b=akJSxrSGVJ9s40wmvBE1il45rt0N+w0uuzzFft4IOBH2qQXEJgaeGJ9m
   n248AGXd2vLfE49g554ADK+YIbr95KbHXH40PPJPrJc//4XHqz2XRj+pj
   mIswGSdTPl8OcB3v7eUSac8dPGn54F5sOCyHC38VIicwNuSmLa0hU4Xch
   kjDdJMaKs/NCs/AqMiqW1Of60xC1i/idV+oWLZdT7yMORW8Ex5prWSCOG
   lwiL83k7qV+iblGuOUcWwiRrF+edi4HHLrMnZl65bifmDQoILuvHH1rIP
   TAtqtF5eNJ1epKNdok09NlI377YYiOV0KejJ71CHU5BojPWwZesvzBURp
   Q==;
X-CSE-ConnectionGUID: Y96Y/7zQRBOb6FVVrzE3ug==
X-CSE-MsgGUID: iIJsgnWDTbO8TjesUuilXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72018924"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72018924"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 01:09:21 -0800
X-CSE-ConnectionGUID: QwyUeSGsRgq6RZDbEfNYaA==
X-CSE-MsgGUID: hBbS+rFVSqK+onuOuYH5kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212222787"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.208])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 01:09:15 -0800
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id AF298121D46;
	Wed, 11 Feb 2026 11:09:31 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vq6Do-00000007la0-2NE2;
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
Subject: [PATCH v2 04/14] media: Documentation: Improve pixel rate calculation documentation
Date: Wed, 11 Feb 2026 11:09:10 +0200
Message-ID: <20260211090920.1851141-5-sakari.ailus@linux.intel.com>
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

Improve documentation on calculating the pixel rate, by adding references
to relevant functions and mentioning V4L2 fwnode endpoint instead of OF
endpoint.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/driver-api/media/tx-rx.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/tx-rx.rst b/Documentation/driver-api/media/tx-rx.rst
index 7df2407817b3..9b231fa0216a 100644
--- a/Documentation/driver-api/media/tx-rx.rst
+++ b/Documentation/driver-api/media/tx-rx.rst
@@ -104,7 +104,11 @@ where
    * - k
      - 16 for D-PHY and 7 for C-PHY.
 
-Information on whether D-PHY or C-PHY is used, and the value of ``nr_of_lanes``, can be obtained from the OF endpoint configuration.
+Information on whether D-PHY or C-PHY is used as well as the value of
+``nr_of_lanes`` can be obtained from the V4L2 endpoint configuration; see
+:c:func:`v4l2_fwnode_endpoint_alloc_parse()`,
+:c:func:`v4l2_fwnode_endpoint_parse()` and
+:c:func:`v4l2_get_active_data_lanes()`.
 
 .. note::
 
-- 
2.47.3

