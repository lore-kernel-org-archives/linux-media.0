Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C533C19E;
	Tue, 27 Jan 2026 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515785; cv=none; b=ixz8AqatoE+eXhqlrFbRp3EvQc9lLyGQwGPPLl5+WxQDbT42kKnSkP4sSkTQ0U/AY3gqYlbFcCVZLh1g+WeW5gL2kFfHbPiMNzcu9yXctBYxEbyhbLoHU2tUvqMb8Xt7u53ixQysssEn0E2COqnfCs/9T8ksA7YkBI7K/QVLqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515785; c=relaxed/simple;
	bh=uOLOd9dBA2bJobdrOcZ2vVXDqEReXwZ+6jy5YKUsQD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cdjepJP3BigzbX2QyDQUjtnCTf/9zuAAdzNL4XUmVPArfq3ac6NUIl9fg5Qcw7MAsREmhri/rfI/7JoCL32ppoWO+tCL9H71bTfmJKA+wtR4lasbPU+LkA3jJXCy8JcOm4VBdcr8WByeUhN+HirWsnskf12Ifwl7EUhluGAmK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from localhost (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 9BE7686EC9;
	Tue, 27 Jan 2026 13:09:32 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH 0/2] media:pci:mgb4: Add zDML color mapping support
Date: Tue, 27 Jan 2026 13:09:11 +0100
Message-ID: <20260127120913.4690-1-tumic@gpxsee.org>
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

Martin Tůma (2):
  media:pci:mgb4: Add zDML color mapping support
  media:admin-guide:mgb4: Add zDML color mapping info

 Documentation/admin-guide/media/mgb4.rst |  8 +++
 drivers/media/pci/mgb4/mgb4_sysfs_in.c   | 18 +++++--
 drivers/media/pci/mgb4/mgb4_sysfs_out.c  | 63 ++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 3 deletions(-)


base-commit: eb4ee870747c3a77a9c3c84d84efb64bd481013a
-- 
2.52.0

