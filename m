Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009B2DA763;
	Mon,  2 Feb 2026 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025700; cv=none; b=A92blbqjN9kwhOrqTMTUwUgztbEcx1evxzPtQJUdwFVSDBgnsnCv3eVuu9wkbaUHa+EGpurjZFm6T+LXA6/Cf2oGBwUEbFwk1uSgq8eE8ulM1VW1Am2Lh44zEknpYm6MqoajBUfr/L/ZR7uFYADCxFEzF0SyBgx2Gi/HZMQpecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025700; c=relaxed/simple;
	bh=Bm7qdPpSoR5RRd8RoFj0NDJeq7mpHyYT/MEjRskwOdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6wdwE1nw4xI+fFXcM7E+h0JVLSoLPYGinU8u4YbleK1+A2zYAST6e0OrBT6hFtAci/GbdnTbfxdHpfG5u41vmRgUCDg41V3jKcesxHY/80Uk+mnelivnzVQLvs828xCfUITik3lJMpoWzL2ALN3leHxQGWJXJJ6/7HJczs8ZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwOBVfGt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwOBVfGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9CBC116D0;
	Mon,  2 Feb 2026 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770025700;
	bh=Bm7qdPpSoR5RRd8RoFj0NDJeq7mpHyYT/MEjRskwOdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwOBVfGtz4+jEDqeo9pQ5HBte1t/4o1Bebg2wlqQVp+8zfvUwoZx2qcUw0XJ5XPxD
	 9BxEnOWVyvYE2GN1hj0ZZ/AFb9hvN8N/6snz3XZx4cziJ0mHkfuKNK6UFegAMT/7Wi
	 +jkgf/wDOo06SjM9msgv2Ihg08bFz+OQyeDBJUflNwSsPYNE33UBA8osjSfu9hpepb
	 KS2QMaYynMFhQ7xBQzjT/MtJ8ROb9Ka7D9pHpcwyKhi/FhgXOxYkxOHSgU+4p1JDeO
	 K1NUWVli90AZOgK6G6Kwq3k+7IX7qtU+MxBlJEtB5kRrgH5tgceLSbPlMyLhgUP7mt
	 19U9Zh9m8ufLA==
From: Arnd Bergmann <arnd@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Jonas Karlman <jonas@kwiboo.se>,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/2] media: rkvdec: reduce stack usage in rkvdec_init_v4l2_vp9_count_tbl()
Date: Mon,  2 Feb 2026 10:47:51 +0100
Message-Id: <20260202094804.1231706-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260202094804.1231706-1-arnd@kernel.org>
References: <20260202094804.1231706-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The deeply nested loop in rkvdec_init_v4l2_vp9_count_tbl() needs a lot
of registers, so when the clang register allocator runs out, it ends up
spilling countless temporaries to the stack:

drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c:966:12: error: stack frame size (1472) exceeds limit (1280) in 'rkvdec_vp9_start' [-Werror,-Wframe-larger-than]

Marking this function as noinline_for_stack keeps it out of
rkvdec_vp9_start(), giving the compiler more room for optimization.

The resulting code is good enough that both the total stack usage
and the loop get enough better to stay under the warning limit,
though it's still slow, and would need a larger rework if this
function ends up being called in a fast path.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c b/drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c
index ba51a7c2fe55..1c875d5a2bac 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c
@@ -893,7 +893,8 @@ static void rkvdec_vp9_done(struct rkvdec_ctx *ctx,
 	update_ctx_last_info(vp9_ctx);
 }
 
-static void rkvdec_init_v4l2_vp9_count_tbl(struct rkvdec_ctx *ctx)
+static noinline_for_stack void
+rkvdec_init_v4l2_vp9_count_tbl(struct rkvdec_ctx *ctx)
 {
 	struct rkvdec_vp9_ctx *vp9_ctx = ctx->priv;
 	struct rkvdec_vp9_intra_frame_symbol_counts *intra_cnts = vp9_ctx->count_tbl.cpu;
-- 
2.39.5

