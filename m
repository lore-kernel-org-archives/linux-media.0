Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F721A02
	for <linux-media@vger.kernel.org>; Mon, 13 Nov 2023 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXfPgMim"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7046419F
	for <linux-media@vger.kernel.org>; Mon, 13 Nov 2023 08:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699891567; x=1731427567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/eAJBJnLXU6l1z+pvyeZODlzrPftbcCwQ6BKWOK56GA=;
  b=eXfPgMimipaMHg8+o5WeSE8U0Au9Vpnx4xUed5WFwv0v4J8xKcFHRsGJ
   MXE89Wilj8UXmEO6at9ZZTadeGR+BXvG3OiztVf//101beLyjYU7IqxzR
   sJnAnNvYydrUCSu2q2TAI9OsooigonQXKoYN9dp33TWizhoyBH20bNEgI
   YLHLFswSPe8Xd+61FmXwBFJECCAaXNJXKq6dXqYSVspPW4Z3lU4r0qe2q
   0USrlcllyjC6R++qA82CRxZ6q3VV9SNSzi1WDsJ+5W5p9cYMcEVZWsQOh
   Cic92mbFlRxoRXbOpQh6wdlmeMno8xZJmnW5eSNsrYwSiGlW32jPmRH2h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3542959"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="3542959"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:06:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="887956363"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="887956363"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:06:04 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id BD1FC120BA7;
	Mon, 13 Nov 2023 18:06:01 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com,
	hdegoede@redhat.com
Subject: [PATCH v3 0/6] Use V4L2 CCI in CCS driver
Date: Mon, 13 Nov 2023 18:05:55 +0200
Message-Id: <20231113160601.1427972-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This set adds a few features to the V4L2 CCI library and makes the CCS
driver use V4L2 CCI.

The additional features are about storing driver specific information in
the CCI registers (besides register address) and obtaining register width
using a convenient V4L2 CCI macro.

since v2:

- Rename CCS static data read-only register access function.

- Fix ccs-regs.h generation to include all changes in the 4th patch (some
  had slipped into the 5th).

since v1:

- Fix two SMIAPP register definitions using misspelled CCI macro names.

- Add macros using FIELD_GET() to obtain CCI register address and width,
  use the macros in V4L2 CCI.

- Use _SHIFT and _MASK for private register range.

- Check CCS driver's private flags only cover driver-private bits of the
  CCI register definition, using  BUILD_BUG_ON().

- Fix CCS CCI register macro generation (register address vs. flag vs.
  array indices).

- Use a nicer way to check for the guardian value in the limit array, i.e.
  don't pass the value unconditionally to CCI_REG_WIDTH_BYTES().

- Include linux/bits.h and media/v4l2-cci.h in smiapp-reg-defs.h.

- Improve commit message of the  CCS static data register access function
  rename patch.

Sakari Ailus (6):
  media: v4l: cci: Include linux/bits.h
  media: v4l: cci: Add driver-private bit definitions
  media: v4l: cci: Add macros to obtain register width and address
  media: ccs: Generate V4L2 CCI compliant register definitions
  media: ccs: Better separate CCS static data access
  media: ccs: Use V4L2 CCI for accessing sensor registers

 .../driver-api/media/drivers/ccs/mk-ccs-regs  | 104 +-
 drivers/media/i2c/ccs/ccs-core.c              |  84 +-
 drivers/media/i2c/ccs/ccs-reg-access.c        | 213 +---
 drivers/media/i2c/ccs/ccs-regs.h              | 906 ++++++++---------
 drivers/media/i2c/ccs/ccs.h                   |   2 +
 drivers/media/i2c/ccs/smiapp-reg-defs.h       | 951 +++++++++---------
 drivers/media/v4l2-core/v4l2-cci.c            |   8 +-
 include/media/v4l2-cci.h                      |  11 +
 8 files changed, 1100 insertions(+), 1179 deletions(-)


base-commit: 62bdf633090d684c3ac6d3b46e926c0ac8cef466
-- 
2.39.2

