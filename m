Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7D4A32
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387719; cv=none; b=oHkeNsdNnj9W9B73eledijbt9HVDOV7tjEugsr4EsH+dGuRP5eqh0fSrmGcRoCWdSNWmSiH4ieAEHo4Mh+6Htv/rez8UerHAr9sWUIhaMa/Y8GXw4gbh2HxfS50UMbSijtKKSKV8y4A+7TU8PVv6yrhpW14LpffAXnn4bfZUTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387719; c=relaxed/simple;
	bh=zypA2Ea7MO6G7ANMP3zXx3V0rhwniOFJbtXz4UhIIjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXJLlxPENhc9aFJz9qJteWWWhgZDxnZZcu1PG+5rZcD9w8WeLa8O8YZsT3NwUzC/Yp0Yw+o3TAGFzBt44tiu0woICGD1KyQjFZGcJk58vPXaTRxuTjzy5at+aOsm3Y8o3/NTr5AcFw9FA/hAmB89xJugwtbhH3vYHzcebM86LjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7VooTMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7VooTMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B61C4CEFB;
	Thu,  6 Nov 2025 00:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762387719;
	bh=zypA2Ea7MO6G7ANMP3zXx3V0rhwniOFJbtXz4UhIIjM=;
	h=From:To:Cc:Subject:Date:From;
	b=s7VooTMY6W7L86OkQzJ1KOyUC967MT/V+K25FAMnIaKhPjKJxqfMvhJD6a6ucvr+S
	 p4O7Hh9PQWQ4UAO1XGPc7+JOhlp+zW/phbGYpSqhjO2oX4yyYgw7oLyrk8fi3Bcz5v
	 Z1RWT6FvBj2VjBU3gzgHZf4RdPwxbEcjZQvUDoBc29uvx1u/dyCiSDtTW4LklsTw/z
	 BJjzj1IU6JmlFdJNp23IcfcB4tQQnbrSiAoWkjQzf3YqRwWFOSYm+7vZghKBc00Zph
	 RWn/r9VHlUwewjeoga41rtZazQ3F3nDHpGWXc4N4/IgE2chjj2bz1R0jvLJQD8u2+H
	 1h5SOaDP+AFUQ==
From: bod@kernel.org
To: bod@kernel.org,
	linux-media@vger.kernel.org,
	hans@jjverkuil.nl
Cc: bryan.odonoghue@linaro.org
Subject: [GIT PULL FOR 6.19] Please pull platform-qcom-camss-for-6.19
Date: Thu,  6 Nov 2025 00:08:23 +0000
Message-ID: <20251106000828.6446-1-bod@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bryan O'Donoghue <bod@kernel.org>

The following changes since commit 8efac3545ac7b90234863214a4f4e13d86a70b0a:

  Merge branch media-committers:next into next (2025-11-05 16:22:03 +0000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/linux-media/users/bodonoghue.git tags/platform-qcom-camss-for-6.19

for you to fetch changes up to e672f18d3e6e2e1e53bf37b3be3faca971f2fb67:

  media: qcom: camss: Add support for MSM8939 (2025-11-05 16:23:42 +0000)

----------------------------------------------------------------
This CAMSS tag contains:

- Adds support for MSM8939 - Vincent Knecht, André Apitzsch
- Adds support for SM8650 - Vladimir Zapolskiy
- Adds an additional clock as prep work for a new SoC - Hangxiang
- Various fixes and code improvements
  Johan, Hangxiang, Krsysztof

----------------------------------------------------------------
Hangxiang Ma (2):
      media: qcom: camss: Use a macro to specify the initial buffer count
      media: qcom: camss: Enable setting the rate to camnoc_rt_axi clock

Johan Hovold (1):
      media: qcom: camss: drop unused module alias

Krzysztof Kozlowski (1):
      media: dt-bindings: qcom,x1e80100-camss: Fix typo in CSIPHY supply description

Vincent Knecht (3):
      media: dt-bindings: Add qcom,msm8939-camss
      media: qcom: camss: vfe: Add VBIF setting support
      media: qcom: camss: Add support for MSM8939

Vladimir Zapolskiy (3):
      dt-bindings: media: Describe Qualcomm SM8650 CAMSS IP
      media: qcom: camss: Add Qualcomm SM8650 CAMSS support
      media: qcom: camss: Add CSIPHY 2.2.0 lane configuration for SM8650

 .../bindings/media/qcom,msm8939-camss.yaml         | 254 +++++++++++
 .../bindings/media/qcom,sm8650-camss.yaml          | 375 ++++++++++++++++
 .../bindings/media/qcom,x1e80100-camss.yaml        |   2 +-
 drivers/media/platform/qcom/camss/Makefile         |   1 +
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 102 +++++
 drivers/media/platform/qcom/camss/camss-csiphy.c   |   1 +
 drivers/media/platform/qcom/camss/camss-ispif.c    |   8 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c  |  12 +
 drivers/media/platform/qcom/camss/camss-vfe-vbif.c |  31 ++
 drivers/media/platform/qcom/camss/camss-vfe-vbif.h |  19 +
 drivers/media/platform/qcom/camss/camss-vfe.c      |  17 +-
 drivers/media/platform/qcom/camss/camss-vfe.h      |   3 +
 drivers/media/platform/qcom/camss/camss.c          | 483 ++++++++++++++++++++-
 drivers/media/platform/qcom/camss/camss.h          |   3 +
 14 files changed, 1305 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,msm8939-camss.yaml
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sm8650-camss.yaml
 create mode 100644 drivers/media/platform/qcom/camss/camss-vfe-vbif.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-vfe-vbif.h
