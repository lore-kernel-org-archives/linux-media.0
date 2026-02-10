Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AF3375AA;
	Tue, 10 Feb 2026 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713770; cv=none; b=GcSMgiRnLEOn9hZgl3S+nbwsUtDs91FZ8RYFEqu7gZkouz0Dl2TLgYHCpx8m9KkJIde9dUBsv2jULR0Wlvt8KiWHjDo4qd+uCZ4n6eeLGyTrHGhvAYZTRNXep5ae8Auv4ekYhBfk5aveIOQhV9FsOhmb0M1emWfCIZqdyAq1zPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713770; c=relaxed/simple;
	bh=s/2vlVFUHhP9X9nzhy8iQquDfa7Nl8RYY9trdnKUaNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIZSJpJ6X8t9mXzE6Fkv5TN/uOqMOnKg2cmBcTpc0frAeNwpYdv8HL/kdeYJgerLoray06Wu5qNYmCoQmshAQckBeOHm9+dkPKk7bOgnPFyiTPxDOy+d9OLF/twiUP+s6hj1l3Asut0ZadRxWKs2xE5ngXmrxNffkDxvhiI1Fho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cohunt.app; spf=fail smtp.mailfrom=cohunt.app; dkim=pass (2048-bit key) header.d=cohunt.app header.i=@cohunt.app header.b=L9i7NRO9; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cohunt.app
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cohunt.app
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cohunt.app header.i=@cohunt.app header.b="L9i7NRO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cohunt.app;
	s=protonmail2; t=1770713763; x=1770972963;
	bh=jzs7HdJFfzhuKcRuXQwM6EopM9IhF3SuN6z8aM8bWUM=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=L9i7NRO9Q906BKxy2R+b2K80pY52mJjYl/IV3gQc/EFLGdfyHHmh+kqj0V3gnk6Hx
	 rrj6FabkBqAWr9oaXGhEEUUOaLKY568p1aVaV8gUZ8U0BVL4iDSBfXBR+3cI3Zk5q+
	 +YfOEpAuyB2Cetb1R8Tn31k/Yg6nB07AINMNRJtZdxn6l/xINHl0dHhxAcTgY+kwrO
	 F+O4z0I9996/lEJ+Xzxw37HJHJTp89XyiK3T3ciaqOYtKlk07QU1z9DQQsWLA8oVkc
	 s0C7mza1VsdWzhA19TYdOrASilAC0tpkgXGoG24sMBMqrRZDDCG3n7FwCa61voJWiE
	 mJSrxzbXvi3ZQ==
X-Pm-Submission-Id: 4f9Flj6qV3z1DFFV
From: Leif Skunberg <diamondback@cohunt.app>
To: sakari.ailus@linux.intel.com,
	bingbu.cao@intel.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leif Skunberg <diamondback@cohunt.app>
Subject: [PATCH 1/2] media: ipu-bridge: Add OV5675 sensor config
Date: Tue, 10 Feb 2026 09:55:58 +0100
Message-ID: <20260210085558.34140-1-diamondback@cohunt.app>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Omnivision OV5675 (ACPI HID OVTI5675) to the
ipu_supported_sensors[] table with a link frequency of 450 MHz.

This sensor is found in the Lenovo ThinkPad X1 Fold 16 Gen 1 behind
an Intel Vision Sensing Controller (IVSC). Without this entry the IPU
bridge does not create the software-node fwnode graph for the sensor,
preventing the camera from being enumerated.

Signed-off-by: Leif Skunberg <diamondback@cohunt.app>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 4e579352a..aaad759dd 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -79,6 +79,8 @@ static const struct ipu_sensor_config ipu_supported_sensors[] = {
 	IPU_SENSOR_CONFIG("OVTI02C1", 1, 400000000),
 	/* Omnivision OV02E10 */
 	IPU_SENSOR_CONFIG("OVTI02E1", 1, 360000000),
+	/* Omnivision OV5675 */
+	IPU_SENSOR_CONFIG("OVTI5675", 1, 450000000),
 	/* Omnivision OV08A10 */
 	IPU_SENSOR_CONFIG("OVTI08A1", 1, 500000000),
 	/* Omnivision OV08x40 */
-- 
2.53.0

