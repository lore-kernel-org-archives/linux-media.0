Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578C33C1BD
	for <linux-media@vger.kernel.org>; Tue, 10 Feb 2026 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770712932; cv=none; b=i9ALphwFo+coglUbYmHL1h0QoWBbZWGPUbaCteyCuONmdZcrnBD1s3EGpo/WK4ajFTegbffWN1wSXGTUOIR6VtxIj/8r2C9wbZ3TZSrbZJIBjYFxY62q0W7V66oceO0TgzPhAIdaVh4jBcjVnxH5eWojqx1Y575rBuNXovXw4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770712932; c=relaxed/simple;
	bh=ua9qxAs5mKd+cri7PB0Y1yEr0ip2j10gyjtq7H5kt0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JR1VhdhbfZzFaxEK8U1OC5vdvV+fz9/XnPgEMo2ZqAnH8Yvm/7jVFIr0sU2JrQSde6fm2eTSge1gaacgT/ng0GNCbJW6qUgohLKnRa0MHzBCP+1NBh7w18WEIKG97gYTCeYDjSGCJIiUD2OH1cxbX65D7QEovjoKbqpavUh9x78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zja2U6F6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zja2U6F6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770712932; x=1802248932;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ua9qxAs5mKd+cri7PB0Y1yEr0ip2j10gyjtq7H5kt0Q=;
  b=Zja2U6F602G/htfeYAl5dmXkZkvSV4bkwJfcn8gGNMmcrl4YkTf46EQs
   bD4ZuWUUlHgaysgCsPtIz+KCXimrbOCQVmcjGcxqQV6POxcPmtxc3p/Rl
   xrTJQOPuFIhKfBgNJMnrRTB690vTBN4kA9N7nVOr8BGBGhoTAwrEqwamk
   6mfVoF1JpGsn5Lz9jaNB/v+0xNXwQ7oONRsVGRMJF0uolI5O0/d7Zgz4q
   Z85PgI7PlWtaxvt4ILMP1Me2HI3mk00OQD65nKm/hhH/oOhbQhSKtSKBu
   g5dQf0QJfknlMSqNywPQKhE/V+2J+UmuvgIoG93g4+F3vqjg5r3vRGWHk
   w==;
X-CSE-ConnectionGUID: A9v49OvATF+zzhvRV3ET7w==
X-CSE-MsgGUID: QOWqBlO3TeGa3So8mf2Omg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75461397"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75461397"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 00:42:11 -0800
X-CSE-ConnectionGUID: Hwa5mLOERFWtCmfXRc4lmQ==
X-CSE-MsgGUID: mcfuFil/SqK7N4yFBNYoMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="249494728"
Received: from ettammin-desk.ger.corp.intel.com (HELO alaakso-DESK.intel.com) ([10.245.246.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 00:42:08 -0800
From: Antti Laakso <antti.laakso@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: hverkuil+cisco@kernel.org,
	sakari.ailus@linux.intel.com,
	johannes.goede@oss.qualcomm.com,
	dongcheng.yan@intel.com,
	sre@kernel.org,
	hao.yao@intel.com,
	dan.scally@ideasonboard.com,
	miguel.vadillo@intel.com,
	ribalda@chromium.org,
	jason.z.chen@intel.com
Subject: [PATCH] media: ipu-bridge: Add DMI quirk for CVS-sensor dependency
Date: Tue, 10 Feb 2026 10:41:52 +0200
Message-ID: <20260210084152.332001-1-antti.laakso@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A supplier-consumer dependency should exist between the CVS and sensor.
However, this dependency is missing on Dell Pro Max 16 Premium laptop.

To initialize these devices correctly for this laptop, add DMI match
table to ignore broken dependency.

Signed-off-by: Antti Laakso <antti.laakso@linux.intel.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index b2b710094914..8dee6dfb51b3 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -121,6 +121,18 @@ static const struct dmi_system_id upside_down_sensor_dmi_ids[] = {
 	{} /* Terminating entry */
 };
 
+/* DMI matches for systems where sensor-CVS dependency is missing. */
+static const struct dmi_system_id missing_dependency_dmi_ids[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Dell Pro Max 16 Premium MA16250"),
+		},
+		.driver_data = "OVTI08F4",
+	},
+	{} /* Terminating entry */
+};
+
 static const struct ipu_property_names prop_names = {
 	.clock_frequency = "clock-frequency",
 	.rotation = "rotation",
@@ -163,13 +175,22 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 		struct acpi_device *consumer, *ivsc_adev;
 
 		acpi_handle handle = acpi_device_handle(ACPI_PTR(adev));
-		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
+		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1) {
+			const struct dmi_system_id *dmi_id;
+
+			dmi_id = dmi_first_match(missing_dependency_dmi_ids);
+			if (dmi_id &&
+			    acpi_dev_hid_match(adev, dmi_id->driver_data))
+				return ivsc_adev;
+
 			/* camera sensor depends on IVSC in DSDT if exist */
-			for_each_acpi_consumer_dev(ivsc_adev, consumer)
+			for_each_acpi_consumer_dev(ivsc_adev, consumer) {
 				if (ACPI_PTR(consumer->handle) == handle) {
 					acpi_dev_put(consumer);
 					return ivsc_adev;
 				}
+			}
+		}
 	}
 
 	return NULL;
-- 
2.52.0

