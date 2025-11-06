Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB822339
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387576; cv=none; b=UNDz1aG3CwlT9KaP/ItYdWlTxJKUAu/MNNi9rILpX5zWeIkwlw4m/3SsFWb/QhNkKyzDei92FKdbv4O+u1e7R0145dkVi4bEvIyAIMz2ZpYm/QZfgQ1KlNSa3IN52Il0cJQpCl5fxXQkNT0ruGHVYrS0eJ0CBslW2xxXNH16C+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387576; c=relaxed/simple;
	bh=zhpV8ointK8R0Qxn/2qtsejfTImOXXtLDgGwSIsLJiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihkNoZZfqQeVR6ccdBjDa21OwId63RFTZKmJQZo3lXjW7N8Fqkx69X7uU8XYPtBDJIRUBCrAj4ENNfwpUGxDq/DMEsB9A3qhjCozutelpva7PgQfD1qUfU9Wc2HYArVpK1ACBrBc7Q+Jh6j5WBTwYX1gcIq8nMJXdYb5H8jMLug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbCmL1ui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbCmL1ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BB3C4CEF5;
	Thu,  6 Nov 2025 00:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762387574;
	bh=zhpV8ointK8R0Qxn/2qtsejfTImOXXtLDgGwSIsLJiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=WbCmL1uiYkwpuC+tHh4lXyRuXcZz+MmQca6MBConq2MF/gPqvgVz8EbJ5tGyreAEy
	 1YTtvPKi69M74jahVAr57yY8ACESysyGSxWOX9AOHPEfuBX1ZE8LAFTwszVRvX2zY9
	 k13nTBjdUT6JbhZoFe0lYnfY2qBBCkp5qwgb+ZqAO2xZDMxvdnTv+b4CRv6L+AalY7
	 YAyG1Z69K7a6hl+tpTeh+ckbft0dLePGvBJWW8U3drMycvC3aDHTVqxtlUkUVrme3A
	 zFo/dwQq69rHc2ff0152rSLopI3kYiZomAghmCYRrtRLBR9Dy2o2efo9GfHjviMIIR
	 9FuNMXfY5bNgg==
From: bod@kernel.org
To: bod@kernel.org,
	linux-media@vger.kernel.org,
	hans@jjverkuil.nl
Cc: bryan.odonoghue@linaro.org
Subject: [GIT PULL FOR 6.19] Please pull platform-qcom-vpu-for-6.19
Date: Thu,  6 Nov 2025 00:06:00 +0000
Message-ID: <20251106000603.6078-1-bod@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan O'Donoghue <bod@kernel.org>

The following changes since commit 8efac3545ac7b90234863214a4f4e13d86a70b0a:

  Merge branch media-committers:next into next (2025-11-05 16:22:03 +0000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/linux-media/users/bodonoghue.git tags/platform-qcom-vpu-for-6.19

for you to fetch changes up to 1a18c8ef2773c17a560e0fb9f53aacc0a5cb3f45:

  media: iris: Add sanity check for stop streaming (2025-11-05 16:28:03 +0000)

----------------------------------------------------------------
This tag brings a number of updates for Qcom Venus and Iris

- Fixes for deferrals and aliases in Venus - Johan
- Using of_reserved_mem_region_to_resource() - Rob
- Add QC08C pixel format support to Iris - Dikshita
- Add sc7280 support to Iris - Dmitry
- Additional fixes and tidy-ups from
  Dmitry, Diksita, Laurent and Wangoa

----------------------------------------------------------------
Dikshita Agarwal (4):
      media: iris: Add support for HFI_PROP_OPB_ENABLE to control split mode
      media: iris: Add support for QC08C format for decoder
      media: iris: Add support for QC08C format for encoder
      media: iris: Refine internal buffer reconfiguration logic for resolution change

Dmitry Baryshkov (6):
      media: iris: turn platform caps into constants
      media: iris: turn platform data into constants
      media: iris: stop encoding PIPE value into fw_caps
      media: iris: remove duplication between generic gen2 data and qcs8300
      media: iris: rename sm8250 platform file to gen1
      media: iris: enable support for SC7280 platform

Johan Hovold (2):
      media: venus: drop bogus probe deferrals
      media: venus: drop unused module aliases

Laurent Pinchart (1):
      media: iris: Constify iris_v4l2_file_ops

Rob Herring (Arm) (1):
      media: Use of_reserved_mem_region_to_resource() for "memory-region"

Wangao Wang (1):
      media: iris: Add sanity check for stop streaming

 drivers/media/platform/amphion/vpu_core.c          |  40 +-
 drivers/media/platform/qcom/iris/Makefile          |   2 +-
 drivers/media/platform/qcom/iris/iris_buffer.c     |  17 +-
 drivers/media/platform/qcom/iris/iris_common.c     |   7 +-
 drivers/media/platform/qcom/iris/iris_ctrls.c      |  18 +-
 drivers/media/platform/qcom/iris/iris_firmware.c   |  18 +-
 .../platform/qcom/iris/iris_hfi_gen1_command.c     |  15 +-
 .../platform/qcom/iris/iris_hfi_gen2_command.c     |  21 +-
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |   1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |   7 +-
 .../platform/qcom/iris/iris_platform_common.h      |  18 +-
 ...iris_platform_sm8250.c => iris_platform_gen1.c} |  63 ++-
 .../media/platform/qcom/iris/iris_platform_gen2.c  |  26 +-
 .../platform/qcom/iris/iris_platform_qcs8300.h     | 535 +--------------------
 .../platform/qcom/iris/iris_platform_sc7280.h      |  26 +
 drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
 drivers/media/platform/qcom/iris/iris_resources.c  |   2 +-
 drivers/media/platform/qcom/iris/iris_utils.c      |   3 +-
 drivers/media/platform/qcom/iris/iris_vb2.c        |   8 +-
 drivers/media/platform/qcom/iris/iris_vdec.c       |  61 ++-
 drivers/media/platform/qcom/iris/iris_venc.c       |  59 ++-
 drivers/media/platform/qcom/iris/iris_vidc.c       |   2 +-
 drivers/media/platform/qcom/iris/iris_vpu2.c       |   6 +
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  34 +-
 drivers/media/platform/qcom/venus/core.c           |   1 -
 drivers/media/platform/qcom/venus/firmware.c       |  19 +-
 drivers/media/platform/qcom/venus/vdec.c           |   6 +-
 drivers/media/platform/qcom/venus/venc.c           |   6 +-
 28 files changed, 346 insertions(+), 679 deletions(-)
 rename drivers/media/platform/qcom/iris/{iris_platform_sm8250.c => iris_platform_gen1.c} (82%)
 create mode 100644 drivers/media/platform/qcom/iris/iris_platform_sc7280.h
