Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3F383A0
	for <linux-media@vger.kernel.org>; Fri, 29 Mar 2024 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711683177; cv=none; b=HTlvpD119m8jp5Ik9ebHH+ut8NpwUtgAJVoLI6diFpLZskuGkgNmOyQsu7UqrqUHigLVxDW9syF99ch9j60vCjaQ31vI6C2DoFKgbHsOYNY3K7UK4ce1HaJp27NtjEpAjf8x+JCcjSS7M+kNn1qO9RUKFFEMKJEVRFWYlSRSjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711683177; c=relaxed/simple;
	bh=WUeGK1JZaF1ZIhjP9bDwWVjUBpJ9g+vt3g59rlmB90o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m/eMHZzSunYslxw0STJ5HKouSBk0cK5o7kmZArL2hudw+MA+S68FUAz1tOPAQv9UxPhPPXRXgaVldVOZaeeaGsdm0zCrVM+qEwn8pvC83UtT7fuYOJP3zt6gxhzwrJKzV1GfyUIePBocKuch70qvqueuukPtbK7Xe2iSAikqsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id ZWI00039;
        Fri, 29 Mar 2024 11:31:39 +0800
Received: from localhost.localdomain (10.94.15.229) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server id
 15.1.2507.35; Fri, 29 Mar 2024 11:31:39 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, hanchunchao <hanchunchao@inspur.com>
Subject: [PATCH] media: docs: Remove the repeated word "the" in docs.
Date: Fri, 29 Mar 2024 11:31:37 +0800
Message-ID: <20240329033137.66401-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024329113139196c4a829ecb0300075897c7545fb42b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

From: hanchunchao <hanchunchao@inspur.com>

Signed-off-by: hanchunchao <hanchunchao@inspur.com>
---
 Documentation/userspace-api/media/dvb/frontend_f_open.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/dvb/frontend_f_open.rst b/Documentation/userspace-api/media/dvb/frontend_f_open.rst
index bb37eded0870..70e169b8f601 100644
--- a/Documentation/userspace-api/media/dvb/frontend_f_open.rst
+++ b/Documentation/userspace-api/media/dvb/frontend_f_open.rst
@@ -91,7 +91,7 @@ appropriately.
        -  The caller has no permission to access the device.
 
     -  - ``EBUSY``
-       -  The the device driver is already in use.
+       -  The device driver is already in use.
 
     -  - ``EMFILE``
        -  The process already has the maximum number of files open.
-- 
2.39.3

