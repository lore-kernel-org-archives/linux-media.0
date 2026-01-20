Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24424428464
	for <linux-media@vger.kernel.org>; Tue, 20 Jan 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913973; cv=none; b=BPI54b5V5cDGgWOukwisHUkcikqm83JiG5HcMO2zNLTVtrQkn5yj0DL6SSIa9i5vhfAdFKo3kybVxKXbREQIQn+AXhHuwjSCwr5NOpunAzgAaO0//CLZZDiZ5SpGJfrGFwjV7m5z1ChCwa+7acnFzZ4JcxvoL4jqiLpbpmmzmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913973; c=relaxed/simple;
	bh=cNcDj+RFhExnfdoTZ1CCA5z3Qtg9/E1f9e/PlSdbuEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGmon+ErdkPGk55Wq2WaxJDi7XeeNoPRJRfhzqZaB+Sfv6DLXj+Cxy/bm5O9qQNKd6iMWANsCr5sovaLP/opEP2v6ZTv1k70HxlLf3uqVqldaDg9KEOS5QmWVFYqI0L00HgeWFqXzI/yOZD+Nq/Xt2+CaEhUzdv2tSj+6vnLyCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WouMjQKd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WouMjQKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B825C16AAE;
	Tue, 20 Jan 2026 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768913972;
	bh=cNcDj+RFhExnfdoTZ1CCA5z3Qtg9/E1f9e/PlSdbuEM=;
	h=From:To:Cc:Subject:Date:From;
	b=WouMjQKdzBcsw4+aJUAONaKyK9ypmioPDrDxMFRNyL2xBr6ZlPY5xJtRSoqfzfj3K
	 rbK/Qwgg/ZnH7903qSJ/0HKYBRkuKhvRlEAM7U52uVHMZsnpmC1MdffnIuBkASBpSI
	 0Gh4nUKrXe5HEiLOWV1k7Bzd5sV3caX7ar4qrZY5spsi58/gtyb0OZ1SxGebbYlRWW
	 pKfm+hwIrJzCccrgSF/BKZSgIFYV5JIn63wNGLXDCzI3Uw02WVvCa017g1MiG+kP0P
	 pfUaWTvM59+jjccDCq0CFYOfGV+tR2vn2vKq/errAqR7UQiMYet4Cui7xqf1Cz0exB
	 AiTw7pqDa8f3g==
From: bod@kernel.org
To: bod@kernel.org,
	linux-media@vger.kernel.org,
	hans@jjverkuil.nl
Cc: bryan.odonoghue@linaro.org
Subject: [GIT PULL FOR 6.20] Please pull platform-qcom-iris-6.20-fixes
Date: Tue, 20 Jan 2026 12:59:18 +0000
Message-ID: <20260120125929.4795-1-bod@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan O'Donoghue <bod@kernel.org>

The following changes since commit eb4ee870747c3a77a9c3c84d84efb64bd481013a:

  Documentation: admin-guide: media: mgb4: Add GMSL1 & GMSL3-coax modules info (2026-01-17 09:08:02 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/linux-media/users/bodonoghue.git tags/platform-qcom-iris-6.20-fixes

for you to fetch changes up to 4a2207a3736d0dc78ac2f16325189b307964a2cb:

  media: iris: Prevent output buffer queuing before stream-on completes (2026-01-19 09:50:34 +0000)

----------------------------------------------------------------
There are eleven fixes in this cycle including

- A revert for a commit which caused buffer leaks - Dikshita Agarwal
- A buffer flag fix host -> firmware - Vishnu Reddy
- FPS calculation bug found by cocci - Ricardo Ribalda
- Fallback frame size fix - Val Packett
- A fix to negate freeing a potentially in-use buffer - Dikshita Agarwal
- Add in missing platform data fields sm8750 - Dikshita Agarwal
- A Potential leak fix - Dikshita Agarwal
- Skip setting resolution doing reconfig - Dikshita Agarwal
- Iris/gen1 another buffer leak fixed - Dikshita Agarwal
- Fix a NULL pointer deference during stop_streaming - Dikshita Agarwal
- Stop firmware processing buffers too early - Dikshita Agarwal

----------------------------------------------------------------
Dikshita Agarwal (7):
      Revert "media: iris: Add sanity check for stop streaming"
      media: iris: remove v4l2_m2m_ioctl_{de,en}coder_cmd API usage during STOP handling
      media: iris: Add missing platform data entries for SM8750
      media: iris: Add buffer to list only after successful allocation
      media: iris: Skip resolution set on first IPSC
      media: iris: gen1: Destroy internal buffers after FW releases
      media: iris: gen2: Add sanity check for session stop

Ricardo Ribalda (1):
      media: iris: Fix fps calculation

Val Packett (1):
      media: iris: use fallback size when S_FMT is called without width/height

Vishnu Reddy (2):
      media: iris: Fix ffmpeg corrupted frame error
      media: iris: Prevent output buffer queuing before stream-on completes

 drivers/media/platform/qcom/iris/iris_buffer.c         |  7 +++++--
 .../media/platform/qcom/iris/iris_hfi_gen1_command.c   |  6 ++++--
 .../media/platform/qcom/iris/iris_hfi_gen2_command.c   |  3 +++
 drivers/media/platform/qcom/iris/iris_platform_gen2.c  |  2 ++
 drivers/media/platform/qcom/iris/iris_vb2.c            | 18 ++++++++++--------
 drivers/media/platform/qcom/iris/iris_vdec.c           |  8 ++++++++
 drivers/media/platform/qcom/iris/iris_venc.c           | 15 +++++----------
 drivers/media/platform/qcom/iris/iris_vidc.c           | 10 ++++++----
 8 files changed, 43 insertions(+), 26 deletions(-)
