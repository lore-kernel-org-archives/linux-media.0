Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0A21E08D
	for <linux-media@vger.kernel.org>; Tue, 10 Feb 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711518; cv=none; b=uo8InXhpYj6GH11ZKywHEaHHWaxfK8SbV+ZHdP4Z1xEX+yZsudYcNtSkfvsrOn+kdVILz6f5lwyPboaHVVMGxWcfzBTXP8cXb8muUWYjRooUqTcGE7+ICtJqGT3KOBk/NFGSsDa704Teuhg25lJ6FnPAXshzYk9GdJk0jacL+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711518; c=relaxed/simple;
	bh=s/2vlVFUHhP9X9nzhy8iQquDfa7Nl8RYY9trdnKUaNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8IjxiyUchJgA9yv7zOeBwGs1yf2w+ZrW4w+Ch+rG5Uq/5DytehDj2Z1Bf4IhVQwrVzRgUhcqV+lbJ/ERRAs5fX8XCYA477WVyurjVIAeWfDvk2P2pdqDACF01hlc7w0q46UREn2Mu1/HOWKVP7HFfgAJLDyiBKiDzM12hj64XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cohunt.app; spf=fail smtp.mailfrom=cohunt.app; dkim=pass (2048-bit key) header.d=cohunt.app header.i=@cohunt.app header.b=UE+7dYsV; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cohunt.app
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cohunt.app
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cohunt.app header.i=@cohunt.app header.b="UE+7dYsV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cohunt.app;
	s=protonmail2; t=1770711499; x=1770970699;
	bh=jzs7HdJFfzhuKcRuXQwM6EopM9IhF3SuN6z8aM8bWUM=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UE+7dYsVcGMM+N5WvINwTJcZCc/+Ye+DCIY6HJFbeCkufCIbGYi5K8Y1XGeZwkpXv
	 CIdbqJEd1KcMdQi+D3FhrpvDVrW8+zK0esX4EVjGrhilnqpEisO708mDITuB9xV4BG
	 F8UgWkj+9jSqZxEKiuQCt3XL7O4oQCqQiiZKER+NjHQibwxavIfqEuuJVma5phX26p
	 XzdPIhFrzqTOg5BvpLxSq+7bpUBJ9l7wyfPswr7qIp1PfJyAWOk3xOkr2zdw5FFcvW
	 mZgc60+HkUbIrupq/q9MhRDcpnM/rFjpzoERPyPTjkqe0FVndm12lNHlYWJHPPYVGQ
	 gT13nQp1dWTLA==
X-Pm-Submission-Id: 4f9Dw81Ch3z2Scn6
From: Leif Skunberg <diamondback@cohunt.app>
To: sakari.ailus@linux.intel.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leif Skunberg <diamondback@cohunt.app>
Subject: [PATCH 1/2] media: ipu-bridge: Add OV5675 sensor config
Date: Tue, 10 Feb 2026 09:18:13 +0100
Message-ID: <20260210081813.29559-1-diamondback@cohunt.app>
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

