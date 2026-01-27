Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F41354AF2;
	Tue, 27 Jan 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517811; cv=none; b=cZiONXMo98MTdHYvsXy/LeTGcepyMcR5buALn+Dyzc6uWJNmgrtqkA1EdVGd5uPmAEEaVreZYhROeGwxeZg9YPpno2n82/w1TwAg2txV8EbhnEiIYjy4FMrChHdtY1HEdavtiZpEjsIkJPCr8KVAVVbHsk4KfW0cGjIokESJ3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517811; c=relaxed/simple;
	bh=lOdKCHEDzphPiNP1atzxxggJiPvn2NtykgaGwTIRVGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M/ETPtOvrEVBZjCFOvwDzKtPChThWCm54pc/lq5L5dnjs1c7nCvUf6qQ4wVx2WtM7JMHahOVHico4iMBVBgbl9wASkF0ZyF7dhFYTFyfzQ918Mlwk22Zb3BBZtKHU+o0eno8jAUOtvGPkLS4hMM/EdC1ab3uGsvQLYbeQ/7i+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from localhost (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 1C64786FD1;
	Tue, 27 Jan 2026 13:43:24 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 0/2] media:pci:mgb4: Add zDML color mapping support
Date: Tue, 27 Jan 2026 13:43:06 +0100
Message-ID: <20260127124308.344380-1-tumic@gpxsee.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Add zDML (a special signal mapping as used in Audi Digital Matrix Lights)
color mapping support.

Changes in v2:
- Do not break the previous property show/store tuple when adding the new
  one.

Martin Tůma (2):
  media:pci:mgb4: Add zDML color mapping support
  media:admin-guide:mgb4: Add zDML color mapping info

 Documentation/admin-guide/media/mgb4.rst |  8 +++
 drivers/media/pci/mgb4/mgb4_sysfs_in.c   | 18 +++++--
 drivers/media/pci/mgb4/mgb4_sysfs_out.c  | 62 ++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 3 deletions(-)


base-commit: eb4ee870747c3a77a9c3c84d84efb64bd481013a
-- 
2.52.0

