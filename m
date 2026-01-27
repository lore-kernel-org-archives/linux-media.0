Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCB354AF8;
	Tue, 27 Jan 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517811; cv=none; b=KJiDYaDxmmmU/r+Z7UqfvOh8dgwntNV4x2nF93sphJZWYZk59DU86tx/Bd0ot8jFZA7FgKrgQU4s/TuHDH6bkjXHuNL6wW1hkuf45Nu0SnSup1vAeZpHwO4VcEciYwkl5t7V57SijWeMVgcM5bjPrgdr8bcf+OLZV7s+Q3Intrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517811; c=relaxed/simple;
	bh=xVSArCsgkvc14SfDXsZ8Qcxa5lbmokjpA/ZJYEzxHUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWURMmR47tvEV78ErH/mmtX+BuEJooSPCgnjLv3DdYd06id/c4fP3akPV1laI8zGZljle7eMyJsM7NsoFgk7TfNmAMQRxL0VMuBb2PZ1JoVDEKE6Q5qfEyJaeB/dHmezFvHzy1b5CUG4eEBCZCAIRim8hGtdESxGEFcB3Z2s/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from localhost (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 345AB8574C;
	Tue, 27 Jan 2026 13:43:24 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 2/2] media:admin-guide:mgb4: Add zDML color mapping info
Date: Tue, 27 Jan 2026 13:43:08 +0100
Message-ID: <20260127124308.344380-3-tumic@gpxsee.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127124308.344380-1-tumic@gpxsee.org>
References: <20260127124308.344380-1-tumic@gpxsee.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Document the zDML (Audi Digital Matrix Light) color mapping option for
the inputs and the new outputs color mapping property.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 Documentation/admin-guide/media/mgb4.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
index 0a8a56e837f7..8e429fd77712 100644
--- a/Documentation/admin-guide/media/mgb4.rst
+++ b/Documentation/admin-guide/media/mgb4.rst
@@ -74,6 +74,7 @@ Common FPDL3/GMSL input parameters
 
     | 0 - OLDI/JEIDA
     | 1 - SPWG/VESA (default)
+    | 2 - ZDML
 
 **link_status** (R):
     Video link status. If the link is locked, chips are properly connected and
@@ -240,6 +241,13 @@ Common FPDL3/GMSL output parameters
     *Note: This parameter can not be changed while the output v4l2 device is
     open.*
 
+**color_mapping** (RW):
+    Mapping of the outgoing bits in the signal to the colour bits of the pixels.
+
+    | 0 - OLDI/JEIDA
+    | 1 - SPWG/VESA (default)
+    | 2 - ZDML
+
 **frame_rate** (RW):
     Output video signal frame rate limit in frames per second. Due to
     the limited output pixel clock steps, the card can not always generate
-- 
2.52.0

