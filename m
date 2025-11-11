Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2336C585;
	Tue, 11 Nov 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877796; cv=none; b=XdFJ1tmJAMsUOowElZUmGmaRIQn5TsRQyYSEOG2Zo3KuNS88qJ9RLUv3c9DgOVmHoT6BVGuEqg8KQf57OuZOlIcA1UMp2Q7iGCR3HDpt4lMPGP1SSEL0hP6oIqJZFd6jwMzvn8x+EdX+PIH7pMWdnmfXTpbOZorDy+R53dgyv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877796; c=relaxed/simple;
	bh=0fOtyE81CndQhZvAF0A7rbLKCwor8F9FxcH5ApSWQiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GI9MSoqOlc+1rF8/G0XrBwybcBQg+K7ZXaS+5LFWVyBOCTgKIW6MaRJ2aC1I1/1dwB4xlfQqZKTl3jsrOmPyeLnF/b8jwp2RLQb0vb2ez3PXOBK7NAR0Fz30quLtaHxe5RIVo7+C+vRQ20ssIbGuty2mKKxxkuOz6rwLIo57TVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RE2AmY1V; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RE2AmY1V"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7BDD92147;
	Tue, 11 Nov 2025 17:14:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762877657;
	bh=0fOtyE81CndQhZvAF0A7rbLKCwor8F9FxcH5ApSWQiY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RE2AmY1VOGf+KrDePHnW2f522g7ylfWKAptiVpgo37kNe13Na37jKAmj1h9tkvrhQ
	 m/yAnPhMsHAXM5rP3ZQPow5vkb3NSPRKz6Yw22E6MYRA1VA+ZeQiP/bbmuaOZfaeSh
	 NblPbis3mj1inRlswEzCIS5f520ysPEG+lXakFRI=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Tue, 11 Nov 2025 16:15:55 +0000
Subject: [PATCH v13 11/15] Documentation: mali-c55: Add Statistics
 documentation
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-c55-v13-11-3dc581355e3a@ideasonboard.com>
References: <20251111-c55-v13-0-3dc581355e3a@ideasonboard.com>
In-Reply-To: <20251111-c55-v13-0-3dc581355e3a@ideasonboard.com>
To: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Cc: Anthony.McGivern@arm.com, jacopo.mondi@ideasonboard.com, 
 nayden.kanchev@arm.com, robh+dt@kernel.org, mchehab@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 jerome.forissier@linaro.org, kieran.bingham@ideasonboard.com, 
 laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8083;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=0fOtyE81CndQhZvAF0A7rbLKCwor8F9FxcH5ApSWQiY=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBpE2FERrzkWaCBJ0U5DVr/YiTtf+2y+ddtxBy0n
 K7ulfRtjLaJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCaRNhRAAKCRDISVd6bEV1
 MrjeD/4zSuetrQAnUbiYBQlXW80AvDQMigW0HFAJvAPzne/L3UMTEbBxHtfEeRSUWT/zeimlgn1
 aBgMk3CjHktiDTNpWw1wuC4f4w4TdAgjLtQCAbaLLqVy+epQHnbmFmPTGCMznUMIVRGkgfYZzsi
 X2LrIqyNflOUejIWB8d7+75AGZ0iEs0Ii5jCC9Ao+Kkix2XM8cB0AL+WLKONV67kW6VC3+kUXSV
 VpUBC2dIBNxQ2Pm1RD/d93YnGLZsnC5KUMsZBhgfJ0A9+Km4VMg6t8QsjRE04Xp4zpwoH90VIBO
 Ya6+DlYJiNF59dq8tenLIFkGHYXd5bRxX6dhLFz2Nxj5d2EcupU8eBTTLnRLmwJKmXzlGdl9dzB
 8VQPVC7clSU9WFObAFqIWPXkPH3oWhXHJaNiSfvm0EciFkcZk8THIJq4B+qSHjeRS9E2kqnE3b5
 jT6f/31Iw2olBYERysTPAMzMGY0X/AnVynTF1gMloWDE1JvuGBs0Bqpsapqc/1EDx/QdKW7kjZF
 3hVaFbPKotfos4qwG8paPiMNet13iSOVmOw3sdZvqcHxT6KThze/1aZVNXn/3Ol4S32iESSqy7n
 s389wj/s5SdG5iQKGhR9TcXpQTWnmLWwLc/BtdMPkVvXtPNTNVWtg61YlWsijuW1KDzDghlo+KF
 qLOs9Fui3VfDHmw==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

Add documentation explaining the ability to capture statistics from
the mali-c55 driver's new V4L2 device, as well as the various tap
points from which those statistics can be drawn in the ISP's
processing flow. Additionally add a page detailing the new V4L2
meta format for the mali-c55 statistics.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Nayden Kanchev  <nayden.kanchev@arm.com>
Co-developed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
Changes in v12:

        - Fix reference

Changes in v11:

        - None

Changes in v10:

	- None

Changes in v9:

	- None

Changes in v8:

	- None

Changes in v7:

	- None

Changes in v6:

	- None

Changes in v5:

	- New patch
---
 Documentation/admin-guide/media/mali-c55.rst       | 60 +++++++++++++++++++++-
 .../userspace-api/media/v4l/meta-formats.rst       |  1 +
 .../media/v4l/metafmt-arm-mali-c55.rst             | 29 +++++++++++
 MAINTAINERS                                        |  1 +
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/media/mali-c55.rst b/Documentation/admin-guide/media/mali-c55.rst
index 72cdded507b3a7918e28d9bd9a1c6f72ddf9e664..03723e0e8e43f17a04ede0032b2ddbfdb859d1e3 100644
--- a/Documentation/admin-guide/media/mali-c55.rst
+++ b/Documentation/admin-guide/media/mali-c55.rst
@@ -67,10 +67,11 @@ The driver has 4 V4L2 subdevices:
 - `mali_c55 resizer fr`: The Full-Resolution pipe resizer
 - `mali_c55 resizer ds`: The Downscale pipe resizer
 
-The driver has 2 V4L2 video devices:
+The driver has 3 V4L2 video devices:
 
 - `mali-c55 fr`: The full-resolution pipe's capture device
 - `mali-c55 ds`: The downscale pipe's capture device
+- `mali-c55 3a stats`: The 3A statistics capture device
 
 Frame sequences are synchronised across to two capture devices, meaning if one
 pipe is started later than the other the sequence numbers returned in its
@@ -333,6 +334,63 @@ configured, followed by formats in the appropriate places:
     # Set format on the video device and stream
     yavta -f RGB565 -s 1920x1080 -c10 /dev/video0
 
+.. _mali-c55-3a-stats:
+
+Capturing ISP Statistics
+========================
+
+The ISP is capable of producing statistics for consumption by image processing
+algorithms running in userspace. These statistics can be captured by queueing
+buffers to the `mali-c55 3a stats` V4L2 Device whilst the ISP is streaming. Only
+the :ref:`V4L2_META_FMT_MALI_C55_STATS <v4l2-meta-fmt-mali-c55-stats>`
+format is supported, so no format-setting need be done:
+
+.. code-block:: none
+
+    # We assume the media graph has been configured to support RGB565 capture
+    # from the mali-c55 fr V4L2 Device, which is at /dev/video0. The statistics
+    # V4L2 device is at /dev/video3
+
+    yavta -f RGB565 -s 1920x1080 -c32 /dev/video0 && \
+    yavta -c10 -F /dev/video3
+
+The layout of the buffer is described by :c:type:`mali_c55_stats_buffer`,
+but broadly statistics are generated to support three image processing
+algorithms; AEXP (Auto-Exposure), AWB (Auto-White Balance) and AF (Auto-Focus).
+These stats can be drawn from various places in the Mali C55 ISP pipeline, known
+as "tap points". This high-level block diagram is intended to explain where in
+the processing flow the statistics can be drawn from::
+
+                  +--> AEXP-2            +----> AEXP-1          +--> AF-0
+                  |                      +----> AF-1            |
+                  |                      |                      |
+      +---------+ |   +--------------+   |   +--------------+   |
+      |  Input  +-+-->+ Digital Gain +---+-->+ Black Level  +---+---+
+      +---------+     +--------------+       +--------------+       |
+  +-----------------------------------------------------------------+
+  |
+  |   +--------------+ +---------+       +----------------+
+  +-->| Sinter Noise +-+  White  +--+--->|  Lens Shading  +--+---------------+
+      |   Reduction  | | Balance |  |    |                |  |               |
+      +--------------+ +---------+  |    +----------------+  |               |
+                                    +---> AEXP-0 (A)         +--> AEXP-0 (B) |
+  +--------------------------------------------------------------------------+
+  |
+  |   +----------------+      +--------------+  +----------------+
+  +-->|  Tone mapping  +-+--->| Demosaicing  +->+ Purple Fringe  +-+-----------+
+      |                | |    +--------------+  |   Correction   | |           |
+      +----------------+ +-> AEXP-IRIDIX        +----------------+ +---> AWB-0 |
+  +----------------------------------------------------------------------------+
+  |                    +-------------+        +-------------+
+  +------------------->|   Colour    +---+--->|    Output   |
+                       | Correction  |   |    |  Pipelines  |
+                       +-------------+   |    +-------------+
+                                         +-->  AWB-1
+
+At present all statistics are drawn from the 0th tap point for each algorithm;
+I.E. AEXP statistics from AEXP-0 (A), AWB statistics from AWB-0 and AF
+statistics from AF-0. In the future this will be configurable.
+
 References
 ==========
 .. [1] https://git.linuxtv.org/v4l-utils.git/
diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index 7b758ea9eb4ac3c4b354bf8e2f319985ed9e2b37..3e0cab153f0ac5e6d76696c5b78eebb0db43b354 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -13,6 +13,7 @@ These formats are used for the :ref:`metadata` interface only.
 .. toctree::
     :maxdepth: 1
 
+    metafmt-arm-mali-c55
     metafmt-c3-isp
     metafmt-d4xx
     metafmt-generic
diff --git a/Documentation/userspace-api/media/v4l/metafmt-arm-mali-c55.rst b/Documentation/userspace-api/media/v4l/metafmt-arm-mali-c55.rst
new file mode 100644
index 0000000000000000000000000000000000000000..0bda9740a6be20df541ac7cf78e45e510f79ad19
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/metafmt-arm-mali-c55.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _v4l2-meta-fmt-mali-c55-stats:
+
+*************************************
+V4L2_META_FMT_MALI_C55_STATS ('C55S')
+*************************************
+
+3A Statistics
+=============
+
+The ISP device collects different statistics over an input bayer frame. Those
+statistics can be obtained by userspace from the
+:ref:`mali-c55 3a stats <mali-c55-3a-stats>` metadata capture video node, using
+the :c:type:`v4l2_meta_format` interface. The buffer contains a single instance
+of the C structure :c:type:`mali_c55_stats_buffer` defined in
+``mali-c55-config.h``, so the structure can be obtained from the buffer by:
+
+.. code-block:: C
+
+	struct mali_c55_stats_buffer *stats =
+		(struct mali_c55_stats_buffer *)buf;
+
+For details of the statistics see :c:type:`mali_c55_stats_buffer`.
+
+Arm Mali-C55 uAPI data types
+============================
+
+.. kernel-doc:: include/uapi/linux/media/arm/mali-c55-config.h
diff --git a/MAINTAINERS b/MAINTAINERS
index e7b1b3458854a764ef94bed30ed518256ac2bca6..f7bc74181fa4d2f8bfa9022ea85f94fbb01ff62d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2115,6 +2115,7 @@ F:	Documentation/admin-guide/media/mali-c55-graph.dot
 F:	Documentation/admin-guide/media/mali-c55.rst
 F:	Documentation/devicetree/bindings/media/arm,mali-c55.yaml
 F:	Documentation/userspace-api/media/drivers/mali-c55.rst
+F:	Documentation/userspace-api/media/v4l/metafmt-arm-mali-c55.rst
 F:	drivers/media/platform/arm/mali-c55/
 F:	include/uapi/linux/media/arm/mali-c55-config.h
 

-- 
2.43.0

