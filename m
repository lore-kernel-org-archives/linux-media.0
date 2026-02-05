Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F393F0741
	for <linux-media@vger.kernel.org>; Thu,  5 Feb 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302228; cv=none; b=Z9kWJpdiPz9ih/dy8pHBEuT2qdWh0v1w/92blZ2ZDI8bPY5rEqUCqomjjYo4Rzn9qbLYT9tvGcywIohOEr3siqzS8UK8MyNL56zwTdOd8CEwpXn0ErcsFxC1j4sKFeArpcb4SUxrmL0M5PLR7ldXqAX+ZlLz+Avo1nZ7/vAk3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302228; c=relaxed/simple;
	bh=upEXc5z/7wZo+eLye5ZKfTyb8LiBUqeeAq3UNdGCAJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ml2Ny8iV9O0viDR+pILXBhzC3l+LyIcFs3lS8UYRks6WeZRS2FyqSuXe2Qt2+/dmw+onOLMwP/Mhe0olykPPtUyVB3mX7FbCtimCJxk/A2JvRGoE2Odal7w5+hsOGVOP15MvCDxEbRIhewXz1ksjZV5sGFTC6i/vluuiUVkWn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1VVtXft; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1VVtXft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7CBC19421;
	Thu,  5 Feb 2026 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770302228;
	bh=upEXc5z/7wZo+eLye5ZKfTyb8LiBUqeeAq3UNdGCAJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1VVtXft2r2RwmZVSDbtW78OHisCWJK33dk7JL3OBHDowFa2qu+ufbGNKmxpDVQFs
	 KvYeE/Aslel5HtmVUTvA7uNfrpPsDhdK9arTzrKrg48rJarPgBZ+5NE5ZtZfEOAl1/
	 orasGpaBB2OZaKRCj9zR+uhoA/sR2VNY41fC6nzlJSCDAQwsVkMzCDtpyAABVqcyUk
	 agoas01RnK+0bBQUCKWBr6N3hEXurmTCaKhTiZO4b4+Vsk+miZdOvPOMXvqnW4P0OL
	 +/gEQMBjLR148fNNP1bjIdK/Srd4nCAEhc98PVeK/L8lEbqNJmhsBcafaMTgHddh9Z
	 Fv0YXgdEveTqw==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sean Young <sean@mess.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv8 2/3] docs: media: document Media Maintainers
Date: Thu,  5 Feb 2026 15:32:53 +0100
Message-ID: <fba697cdae27aa065ded8686fa5c58710cbe7940.1770301974.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1770301974.git.hverkuil+cisco@kernel.org>
References: <cover.1770301974.git.hverkuil+cisco@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document who the Media Maintainers are and what their
responsibilities are.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/maintainer-entry-profile.rst        | 48 +++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/media/maintainer-entry-profile.rst b/Documentation/driver-api/media/maintainer-entry-profile.rst
index e64716060535..6513bd281354 100644
--- a/Documentation/driver-api/media/maintainer-entry-profile.rst
+++ b/Documentation/driver-api/media/maintainer-entry-profile.rst
@@ -350,13 +350,55 @@ With the pull request workflow, pull requests shall use PGP-signed tags.
 For more details about PGP signing, please read
 Documentation/process/maintainer-pgp-guide.rst.
 
-Subsystem Media Maintainers
----------------------------
+List of Media Maintainers
+-------------------------
 
-The subsystem maintainers are:
+The Media Maintainers listed here all have patchwork access and can
+make Pull Requests or have commit rights.
+
+The Media Subsystem Maintainers are:
   - Mauro Carvalho Chehab <mchehab@kernel.org>
   - Hans Verkuil <hverkuil@kernel.org>
 
+The Media Core Maintainers are:
+  - Sakari Ailus <sakari.ailus@linux.intel.com>
+
+    - ISP
+    - sensor drivers
+    - v4l2-async and v4l2-fwnode core frameworks
+    - v4l2-flash-led-class core framework
+
+  - Mauro Carvalho Chehab <mchehab@kernel.org>
+
+    - DVB
+
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+
+    - Media controller drivers
+    - Core media controller framework
+
+  - Hans Verkuil <hverkuil@kernel.org>
+
+    - V4L2 drivers
+    - V4L2 and videobuf2 core frameworks
+    - HDMI CEC drivers
+    - HDMI CEC core framework
+
+  - Sean Young <sean@mess.org>
+
+    - Remote Controller (infrared) drivers
+    - Remote Controller (infrared) core framework
+
+The Media Driver Maintainers responsible for specific areas are:
+  - Nicolas Dufresne <nicolas.dufresne@collabora.com>
+
+    - Codec drivers
+    - M2M driver not otherwise delegated
+
+  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+
+    - Qualcomm drivers
+
 Submit Checklist Addendum
 -------------------------
 
-- 
2.51.0

