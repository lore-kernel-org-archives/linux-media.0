Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="burPYd1v"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37C27DD
	for <linux-media@vger.kernel.org>; Wed, 22 Nov 2023 01:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700644893; x=1732180893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M2C/+AYqsQUaWLb+9P2yh++ErpEU/16J0gJVunrfqXk=;
  b=burPYd1vskIfhdVeNOEkVTnEKzSKlIogtfgAkmFcARM4pzTfQfU/h+Dt
   dDaYd9SsZQ1V6yFRyxybaW0K5szQ7Pw+WttuHHn9is6+xm0WcXec/95Uc
   2V2pZq6l1AruUoZsXjXHuGlf5iRqoR7F7m/x2dZmw/AxrxrShjsMc8nyz
   CO126W2qMc7lwBgR9jdDVInKUhpix7zEJZRnlfkbaoHfnzFp1UdGpTdkp
   gQLZyECZKsGsP8/c8/QIyqIH9w5TyUnnWJimJS+KoiKIFZEzUA18ZhoOn
   uPTDdgzLpBJLIjzxX0DWen0kP2RbfPwO+7NCZ1ImOTV7AuVr+Mp4Yw3ju
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372193653"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="372193653"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 01:21:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910729313"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="910729313"
Received: from icg-kernel3.bj.intel.com ([172.16.126.107])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2023 01:21:31 -0800
From: bingbu.cao@intel.com
To: linux-media@vger.kernel.org,
	sakari.ailus@linux.intel.com
Cc: hdegoede@redhat.com,
	bingbu.cao@intel.com,
	bingbu.cao@linux.intel.com
Subject: [PATCH v3 0/4] Enable sensor's runtime PM before registering async sub-dev
Date: Wed, 22 Nov 2023 17:30:39 +0800
Message-ID: <20231122093043.233148-1-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bingbu Cao <bingbu.cao@intel.com>

Following Sakari's patch:
<URL:https://lore.kernel.org/linux-media/20231102090752.1418132-1-sakari.ailus@linux.intel.com/>

The sensor device maybe accessible right after its async sub-device is
registered, so runtime PM should be ready before its async sub-device
is registered.

---
v2->v3: fix ov01a10 driver to set the runtime pm status to be active
	also add pm_runtime_set_suspended() into .remove
v1->v2: move pm_runtime_idle() together with pm_runtime_enable()
---

Bingbu Cao (4):
  media: imx355: Enable runtime PM before registering async sub-device
  media: ov01a10: Enable runtime PM before registering async sub-device
  media: ov13b10: Enable runtime PM before registering async sub-device
  media: ov9734: Enable runtime PM before registering async sub-device

 drivers/media/i2c/imx355.c  | 12 +++++++-----
 drivers/media/i2c/ov01a10.c | 18 ++++++++++++++----
 drivers/media/i2c/ov13b10.c | 14 +++++++++-----
 drivers/media/i2c/ov9734.c  | 19 +++++++++++--------
 4 files changed, 41 insertions(+), 22 deletions(-)

-- 
2.42.0

