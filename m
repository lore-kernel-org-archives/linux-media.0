Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01373A7F52;
	Thu,  5 Feb 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287542; cv=none; b=u9E9Z6/2S/zN3js6NNQ62BDnkDaEOzBj0k1pjvZGwTHnhTVY7kL5dtsE1E3wE4emeHla/yRWTA2AOIC1CODLCIb7cRq1LA1MuL2prdUn03uxgVMbZiW/vbgJfxnZdMet7TQx/NtFD7qOPYznjrLPueP+8gcIexfVnU2VC3hftWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287542; c=relaxed/simple;
	bh=Gno9wHg1RzsBII1gmFbgZKmo/jhDPIpmzk80mPXXxVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNTcwb2Vz9AdSXGbtl1bhV/J2nqD4pqufN/BrW3iZgL1UfMFLNjmCybgG35/tPoPc/i1jesjXA/DZWtyD9BhJDKTDoJvR9uP9ddTgs7RuEe7tWjSrg3t8XXVQd5sNoCEKDNvd+lvEyTvU63YwWZbi5lV1cNxh1e4ouBwqOXh7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SSdAwE5o; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SSdAwE5o"
Received: from t16.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72CE446F;
	Thu,  5 Feb 2026 11:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770287498;
	bh=Gno9wHg1RzsBII1gmFbgZKmo/jhDPIpmzk80mPXXxVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSdAwE5oVxcWzhqRFFI0CpPrqowo5gRw7O+euCFegeg+tjbMzJloksq4dRk0ye7ck
	 qwDIBNNwhx9KZlsFCrq1Q4vf1iazd/6Mg8EnlnXrD52qGQOrXI6LG5uOTOrIscyOlQ
	 Nsmrqa8IPiQasgtb/eRdkzjRRjRkyIZpD8RbR+rE=
From: Isaac Scott <isaac.scott@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: dafna@fastmail.com,
	laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org,
	heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Isaac Scott <isaac.scott@ideasonboard.com>
Subject: [PATCH v2 2/2] media: rkisp1: Treat 8 bus width and 16 bus width formats the same
Date: Thu,  5 Feb 2026 10:32:07 +0000
Message-ID: <20260205103207.4020959-3-isaac.scott@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205103207.4020959-1-isaac.scott@ideasonboard.com>
References: <20260205103207.4020959-1-isaac.scott@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As MIPI CSI is a serial interface, we should be able to use a bit depth
of 16 in the same way as 8 bit depth. Add a fallthrough case to ensure
we don't reject 16 bit depth formats.

Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 21bfa0edbaf1..0fc1ca7f97a0 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -261,6 +261,7 @@ static int rkisp1_config_isp(struct rkisp1_isp *isp,
 
 		switch (sink_fmt->bus_width) {
 		case 8:
+		case 16:
 			acq_prop |= RKISP1_CIF_ISP_ACQ_PROP_IN_SEL_8B_ZERO;
 			break;
 		case 10:
-- 
2.43.0

