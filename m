Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78053E21
	for <linux-media@vger.kernel.org>; Mon,  8 Jan 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Matthias Schwarzott <zzam@gentoo.org>
To: linux-media@vger.kernel.org
Cc: Matthias Schwarzott <zzam@gentoo.org>,
	Ulrich Mueller <ulm@gentoo.org>
Subject: [PATCH] media: zl10036: Fix my email address
Date: Mon,  8 Jan 2024 17:57:14 +0100
Message-ID: <20240108165714.8769-1-zzam@gentoo.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been wrong from the beginning.

Signed-off-by: Matthias Schwarzott <zzam@gentoo.org>
Reported-by: Ulrich Mueller <ulm@gentoo.org>
---
 drivers/media/dvb-frontends/zl10036.c | 2 +-
 drivers/media/dvb-frontends/zl10036.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/zl10036.c b/drivers/media/dvb-frontends/zl10036.c
index 7ba575e9c55f..3df055be66d6 100644
--- a/drivers/media/dvb-frontends/zl10036.c
+++ b/drivers/media/dvb-frontends/zl10036.c
@@ -3,7 +3,7 @@
  * Driver for Zarlink zl10036 DVB-S silicon tuner
  *
  * Copyright (C) 2006 Tino Reichardt
- * Copyright (C) 2007-2009 Matthias Schwarzott <zzam@gentoo.de>
+ * Copyright (C) 2007-2009 Matthias Schwarzott <zzam@gentoo.org>
  *
  **
  * The data sheet for this tuner can be found at:
diff --git a/drivers/media/dvb-frontends/zl10036.h b/drivers/media/dvb-frontends/zl10036.h
index ad83e6344e7f..23c2964a928c 100644
--- a/drivers/media/dvb-frontends/zl10036.h
+++ b/drivers/media/dvb-frontends/zl10036.h
@@ -3,7 +3,7 @@
  * Driver for Zarlink ZL10036 DVB-S silicon tuner
  *
  * Copyright (C) 2006 Tino Reichardt
- * Copyright (C) 2007-2009 Matthias Schwarzott <zzam@gentoo.de>
+ * Copyright (C) 2007-2009 Matthias Schwarzott <zzam@gentoo.org>
  */
 
 #ifndef DVB_ZL10036_H
-- 
2.43.0

