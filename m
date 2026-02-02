Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672138A702
	for <linux-media@vger.kernel.org>; Mon,  2 Feb 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054646; cv=none; b=dOnjubWTJybLbwdAHPGX/QxbjFOM5beBLh9cT7W2qZMMLcEokB74jPIgokG7zgR0O9u/CnNvlbeXZPXqjXfCrWYhxIuMEePVE6pNnRymQR3H7iszR5k1cbNu2iHdlFuEjs9vsGy6OZkXohYjpmLyc2s6yHotK11efkiuufKVCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054646; c=relaxed/simple;
	bh=n2buX5VudVRgU7PL7UJfJORunqQ2AVjMcYcWLb2KfbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJi6SmJuXE9+3Ze4gVTqvjR/0p/4pKkIkZxNM7g3kFBYKT1FKrC+hglvJ0O1thyIeIhGI11RWPjzv1MmGroQPe6uqifMTW8RUws+ScVvTNS0DuIEgyIlEFwXhT6ZhNmIokUEzjgtZucI5nTOKvTehuJhcp8N8Avdy0ZDWccO2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMWEJk1I; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMWEJk1I"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso49167085e9.2
        for <linux-media@vger.kernel.org>; Mon, 02 Feb 2026 09:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770054644; x=1770659444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rCAwVYKU83hcXqCu+Y7xeDCP8XJjgg0MwhJ+CwyuNk=;
        b=HMWEJk1IJ2OzDdTGeKhcFnV0Hw8K0Lb/OBd7PsnwF3FmNbcH+T7BlM8FRxIbH68mtq
         hn8C0OI06WCUAMDQmzLY3eCP79x9dMTRrxaw32s7etAIDNCjXpwYu42Y0sGXenEoQBqq
         /41JiWOPo4AxLlwjz8UTOIYnTxfJ4cwxTFUZGF0sR8HuXmajxbV58euENt5761FL7+Ic
         /skjHXl9dQRe8Kt6+WU7mAoXYeBfE14opWIwSDvrt7EH7Wtoi8YyXMattY8jRUZRL+kH
         yBKtleZA5DUpMRDO1XnnjgB3ZP6IBmqyJW9ZMgzspJbbwtIYeifqXKO4FENdaA00J6Vm
         cjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054644; x=1770659444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4rCAwVYKU83hcXqCu+Y7xeDCP8XJjgg0MwhJ+CwyuNk=;
        b=KXDFQX9VzQ2gr+OY5todDioo3TgqG+6I5L69ofAOfit7IiZrBSz0FH7NqHkwNvpxtR
         XrwaRf4q2H7ohV4+o7831zYbBhYijD343uKfDqEOHyZKSZJ+/RLkUUfCViTADmAIHmWX
         iJtDvNXE5mkJuRLOlwYPjXtKuhrLqVV9oamkog2NhYBGWi6V+9TTKHVzUv35c2TtSR66
         FQzUyF2h3Hwtj8dJdqXoxmvOE0sBaJgGR/syF/2XUQ6KhcWo546OsoM71ai/VXAU6I5r
         dUztkKHy+GHvVATVJi0lghirZnDyv4jjna9WXOfKP3h7WJHDh1VDormLTULuYLlr4r1u
         yhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwdYk09NXh1n2InXZjcLjxRSGdad363yF42Q5uDFMsyNNTiPqUTcWKQ3g/IQBfZrZy/dNW/lVZp7eo4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsLBRNrw7Fjy2vftLC+Ab6WwoCl8xNFDDgU+RS/WpmNIEjCB6
	1euksd2n2DwRO2v/8hf46fI8frj+wTPu+59iWdsgfS8Nb1UVGZdvYI6E9lAnKw==
X-Gm-Gg: AZuq6aIGD91gkCpU8+SH9Nip1Zg1ZsAUaIPwF5C0urq4GUnUQYZde3ox5NwiEuRd6Dd
	vydYWefTtkVasmfXtGRp0cNje7UkLSV2d0UYMaYfo2OyownhliyaLfE9W1b28SYXMmyL1Kxv8wd
	GMm99Ambe3FSu4InEgu8YF/brgQeahBobHPD8pedxHDmoUitiBEXFv0rATvEuFxPFP+h4zMqmpw
	hz3JHeaxddicT/26mDcC8vNM5AsQi0ZZQ9xeIfoUrnHMv2AX6T/oWEjPllxPRSpfFlxYgvBCKv0
	ZGy/QG9OkEnxl5CtFGGEK0jwdCMc7nqP7LrVYDtJ3JPjGadGZphjtHcR+fBXoOBFZ+DuJdSdWww
	Toz95xSJFNYXudJXHufvh3ZEIC4qGTjM+MDNjbNazX+Wf5cI6e3k/ZgpWOBttHTzkEkTm3Yg0iY
	HCn8ubbPuxRpybZUilTekgWL3fP0OfuXwcvTc7Pg==
X-Received: by 2002:a05:600c:1548:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-482db45e124mr148875905e9.5.1770054643324;
        Mon, 02 Feb 2026 09:50:43 -0800 (PST)
Received: from DESKTOP-VOVUFNJ.localdomain ([5.14.81.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce70sm47011359f8f.27.2026.02.02.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:50:43 -0800 (PST)
From: Bogdan Sandu <bogdanelsandu2011@gmail.com>
To: gregkh@linuxfoundation.org
Cc: bingbu.cao@intel.com,
	bogdanelsandu2011@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	tian.shu.qiu@intel.com
Subject: [PATCH v2 4/4] media: ipu3: use BIT()
Date: Mon,  2 Feb 2026 19:50:33 +0200
Message-ID: <20260202175033.8640-5-bogdanelsandu2011@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202175033.8640-1-bogdanelsandu2011@gmail.com>
References: <2026020258-very-numbly-b36b@gregkh>
 <20260202175033.8640-1-bogdanelsandu2011@gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer BIT() macro over manual bitshift.

Signed-off-by: Bogdan Sandu <bogdanelsandu2011@gmail.com>
---
 drivers/staging/media/ipu3/ipu3-mmu.c | 2 +-
 drivers/staging/media/ipu3/ipu3-mmu.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-mmu.c b/drivers/staging/media/ipu3/ipu3-mmu.c
index cb9bf5fb2..95ce34ad8 100644
--- a/drivers/staging/media/ipu3/ipu3-mmu.c
+++ b/drivers/staging/media/ipu3/ipu3-mmu.c
@@ -21,7 +21,7 @@
 #include "ipu3-mmu.h"
 
 #define IPU3_PT_BITS		10
-#define IPU3_PT_PTES		(1UL << IPU3_PT_BITS)
+#define IPU3_PT_PTES		(BIT(IPU3_PT_BITS))
 #define IPU3_PT_SIZE		(IPU3_PT_PTES << 2)
 #define IPU3_PT_ORDER		(IPU3_PT_SIZE >> PAGE_SHIFT)
 
diff --git a/drivers/staging/media/ipu3/ipu3-mmu.h b/drivers/staging/media/ipu3/ipu3-mmu.h
index a5f0bca7e..990482f10 100644
--- a/drivers/staging/media/ipu3/ipu3-mmu.h
+++ b/drivers/staging/media/ipu3/ipu3-mmu.h
@@ -5,8 +5,10 @@
 #ifndef __IPU3_MMU_H
 #define __IPU3_MMU_H
 
+#include <linux/bitops.h>
+
 #define IPU3_PAGE_SHIFT		12
-#define IPU3_PAGE_SIZE		(1UL << IPU3_PAGE_SHIFT)
+#define IPU3_PAGE_SIZE		(BIT(IPU3_PAGE_SHIFT))
 
 /**
  * struct imgu_mmu_info - Describes mmu geometry
-- 
2.51.0

