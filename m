Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E301A3154
	for <linux-media@vger.kernel.org>; Mon, 30 Jun 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282040; cv=none; b=ZvXe06IDjIoMKeyjZTNAXcQINX7cpJ4gPgEFHQg+2/chkTdIh6KTi9CxdM66Igklrn4miiX7VP0AHaIA+YShALfdsO5TxmpEE5ATRpeANZ3HXaQOj7XeEGSLlD6mhC2VxyA/pqzITg0XJeCCvkCoM/piQ4eqoFhXBDjhguCXWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282040; c=relaxed/simple;
	bh=SHLKGg1Ha7DMgap9ZnXPmUuHb73cki/V4wxuxqCtitQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OjRXTz6DetFBmcZTSFnJqZj9gFQoom/SKCE4rfr7Zcw6OLhi2Aixpdq4ihjLXXRpOaQdlOW/v2Jxc4luHb+Jhk0FEhyEiTc23qeSgoHEgOtO3HCTdCXwC4a3iafckb4J2WCnqHuPvAgtoaErv5THdg8R7FgYV2iFjwPXdnOFydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AD1C4CEEB
	for <linux-media@vger.kernel.org>; Mon, 30 Jun 2025 11:13:59 +0000 (UTC)
From: Hans Verkuil <hverkuil@xs4all.nl>
To: linux-media@vger.kernel.org
Subject: [PATCH 0/5] media: cec: improve err inj and cec-gpio
Date: Mon, 30 Jun 2025 13:08:45 +0200
Message-ID: <cover.1751281730.git.hverkuil@xs4all.nl>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for injecting 'glitches' in the CEC
pulses. Proper CEC hardware will have 'deglitch' support to ignore
short spikes, but if this is not done well it can actually reply
with a 'Low Drive' condition, effectively making CEC impossible to
use.

It is hard to reproduce this in real life, so being able to create
this situation helps debugging bad CEC hardware.

The last two patches relax the requirements for the HPD and 5V
interrupts: reading the HPD/5V value is allowed to sleep. These
signals are not time-sensitive, so that's fine.

Regards,

	Hans

Hans Verkuil (5):
  media: cec: core: add glitch error injection
  media: cec: core: add rx-no-low-drive setting
  Documentation: media: cec: update error inj doc
  media: cec: cec-gpio: rename functions
  media: cec: cec-gpio: reading hpd/5v is allowed to sleep

 .../media/cec/cec-pin-error-inj.rst           | 42 ++++++++++++
 drivers/media/cec/core/cec-pin-error-inj.c    | 59 +++++++++++++++-
 drivers/media/cec/core/cec-pin-priv.h         |  8 +++
 drivers/media/cec/core/cec-pin.c              | 31 ++++++++-
 .../media/cec/platform/cec-gpio/cec-gpio.c    | 68 ++++++++++---------
 5 files changed, 173 insertions(+), 35 deletions(-)

-- 
2.47.2

