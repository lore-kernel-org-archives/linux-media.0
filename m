Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BD79C4
	for <linux-media@vger.kernel.org>; Tue, 12 Nov 2024 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399449; cv=none; b=VX8iRMKr5mqAdFjHfJqhFk7p870IdIQ+ckD9jjpBeH4ZUzZCr4UT6gvLsgnqG2cipdHGHNstUZWiAteq4DRhUW5K4ndX7rQG/xa61hoWM62Kw7vjmyPp5S2zS/QIOL/XrN13rrx/U82HbPyKCKpz/onFe6nHoREjuquye6OI8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399449; c=relaxed/simple;
	bh=l0QePP8ZPeP1w3ImGlIIJTmTFPheBOAUfHqj1c+pzWs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e50oYg8DzXB1z2DTrscvU5MVcXm7kYMSSGxwkIj9dpO/fhzhNJF43pE4mIRx37WR9DOOCPgGvihjl8QGSrqzzXFNazXmko+dPU4MaldCV1IrFQey8YnKiVovtT5JXAAcsYLJGx2i8M69LzpwMiisOd5M8wr+Ovm854l6vCGMO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79B2C4CECD
	for <linux-media@vger.kernel.org>; Tue, 12 Nov 2024 08:17:28 +0000 (UTC)
From: Hans Verkuil <hverkuil@xs4all.nl>
To: linux-media@vger.kernel.org
Subject: [PATCHv3 0/2] media: v4l2-core: v4l2-ctrls: check for handler_new_ref misuse
Date: Tue, 12 Nov 2024 09:14:36 +0100
Message-ID: <cover.1731399278.git.hverkuil@xs4all.nl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This supersedes (1). 

The first patch fixes the tegra-video driver: it now creates the new
controls for the control handler first, before calling v4l2_ctrl_add_handler().

This prevents a warning, which is introduced in the next patch.

The second patch checks for adding a duplicate control to the same handler,
and returns an error, but it also adds a warning if new controls are added
to a handler after v4l2_ctrl_add_handler() is called.

Eventually this sequence should result in an error instead of a warning,
but I feel it is better to keep the warning for a few kernel cycles
to make sure any broken driver is fixed.

From my analysis it is only the tegra-video driver that has this issue,
but I may have missed a corner case somewhere.

Regards,

	Hans

1: https://patchwork.linuxtv.org/project/linux-media/patch/ddb6e006-7440-41c5-8aaa-685b058418b4@xs4all.nl/

Hans Verkuil (2):
  media: staging: tegra-video: postpone v4l2_ctrl_add_handler
  media: v4l2-core: v4l2-ctrls: check for handler_new_ref misuse

 drivers/media/v4l2-core/v4l2-ctrls-core.c | 46 ++++++++++++++++++++---
 drivers/staging/media/tegra-video/vi.c    | 11 +++---
 include/media/v4l2-ctrls.h                |  5 +++
 3 files changed, 50 insertions(+), 12 deletions(-)

-- 
2.45.2

