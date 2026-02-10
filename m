Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D09341AD7
	for <linux-media@vger.kernel.org>; Tue, 10 Feb 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716758; cv=none; b=At55F6YTdaROvdJ7sjOWTTUKPXzWPvgRErZ7b7yKJRBSAKnZ2jv6wk2Ga5S7ODz4RwmdT08szPKvXPcxhX1Lep7f/Y/KZeCbtc1JCYjq3SarovGdlNZdLxdL4lQGpMEnNcyXGP0O0EpWv5do7XbD9suw3MWLAJ7zL0Oll9q9ICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716758; c=relaxed/simple;
	bh=vw1hcno46UnFu2L+rXnuHDJRMyJKSH1S/8dj9F9hQqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCUAtFhav1HRq30bmyEv/pPJ9FV/4ZdEWmqUrrhfbzPLOt3OOIAOhZB3OOKx17RBj5P7QJ0MneaM0rAkD+l2TJ0mPU96aL+nnhbRYU0xhPPPvTaeyKPNCZd/IMzUbD2viEbjFyuqzwF1Yfrx1sE53FMCtx4cf6RgMH1x9iiOrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cohunt.app; spf=fail smtp.mailfrom=cohunt.app; dkim=pass (2048-bit key) header.d=cohunt.app header.i=@cohunt.app header.b=sr2EpDHv; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cohunt.app
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cohunt.app
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cohunt.app header.i=@cohunt.app header.b="sr2EpDHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cohunt.app;
	s=protonmail2; t=1770716752; x=1770975952;
	bh=fvcWjFEo1YRlAQr9yZYhEuASxAZU88nJop4nZrb/pbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sr2EpDHvYQrc/8sG2HQo07BKq2wgC2hSVWw26ssWVJlwZ2EnnblnOCjEKBhl9nweO
	 QfXC6VCvqqShmX75Zn1qNRH5LJCyzKn1H00Ev5erKTlV6p0/13b/Mbpfh59M5ZCQWT
	 bQueC53na1Lay/LDjmh5RrOPsentj9YAu4Os50ZesjUIXq2n64j6i9V4W1N2Xx71cU
	 mNX6jJuwzKLvcNtFcjztW2HAykcDYdjCWnba5bPWeBrGRrw/EPa9cLarWXv4RwcBN9
	 ltmFSxZdAlqXhkxlzndh+YnjY4vq1AuikCbABmknPv+n1LYtUX8fFZiavOCh7PbCxo
	 YZt3kmpkr9Kag==
X-Pm-Submission-Id: 4f9Gs857r4z1DDp2
From: Leif Skunberg <diamondback@cohunt.app>
To: sakari.ailus@linux.intel.com,
	bingbu.cao@intel.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leif Skunberg <diamondback@cohunt.app>
Subject: [PATCH v2] media: ipu-bridge: Add OV5675 sensor config
Date: Tue, 10 Feb 2026 10:45:45 +0100
Message-ID: <20260210094545.37918-1-diamondback@cohunt.app>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210085558.34140-1-diamondback@cohunt.app>
References: <20260210085558.34140-1-diamondback@cohunt.app>
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
index 4e579352a..170cea847 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -88,6 +88,8 @@ static const struct ipu_sensor_config ipu_supported_sensors[] = {
 	IPU_SENSOR_CONFIG("OVTIDB10", 1, 560000000),
 	/* Omnivision OV2680 */
 	IPU_SENSOR_CONFIG("OVTI2680", 1, 331200000),
+	/* Omnivision OV5675 */
+	IPU_SENSOR_CONFIG("OVTI5675", 1, 450000000),
 	/* Omnivision OV8856 */
 	IPU_SENSOR_CONFIG("OVTI8856", 3, 180000000, 360000000, 720000000),
 	/* Toshiba T4KA3 */
-- 
2.53.0

