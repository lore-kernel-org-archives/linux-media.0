Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7583F0756;
	Fri,  6 Feb 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387812; cv=none; b=SEcHozx4mZWJBOY4w6b+NiiyCG+sKgpRSYWCx9qST2fIMBV2cIb/niPSU+ov/7mE4qIqbzKVtSM6DcUMOK35s4nLfIZRY6J5Fwbe36hOjjtHRC8waJVhZgqqURxrDZkA4YnJ9Vzcx3njNV9VCoqlSlJSIUVm3OkXHVBdJQAE6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387812; c=relaxed/simple;
	bh=Ve+jI1VqI29oVmWkoIf+EGyGh47ZzyxaAvPHwe0L5RQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qPcYc+0FA5UFn1Q7Mzn8Fl2ZiMlMAQ3Ryd7YCCX2f989JY1VWn6CpH5q7QGz3ov2XVGepcvnVXiv8b6V8yh75mG7Gk9YZbs/VV7VfW5cPTslbUCW8bKtGYL5O7nTEZfei3ps3pAJUzr/vNs0fQ+R4hu5HRPIj++OZabuAyVVfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (213.87.133.64) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 6 Feb 2026
 17:23:20 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, <linux-media@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Olivier Grenie
	<olivier.grenie@parrot.com>, Patrick Boettcher <pboettcher@kernellabs.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RFT] media: dib8000: avoid division by 0 in dib8000_set_dds()
Date: Fri, 6 Feb 2026 17:22:26 +0300
Message-ID: <20260206142237.13040-1-s.shtylyov@auroraos.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

In dib8000_set_dds(), 1 << 26 (67108864) divided by e.g. 1 apparently can't
fit into 16-bit variable unit_khz_dds_val, being truncated to 0; this will
cause division by 0 while calling dprintk() with debugging enabled (via the
module parameter).  Use s32 instead of s16 to declare the variable, getting
rid of the cast to u16 in the *else* branch as well...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: 173a64cb3fcf ("[media] dib8000: enhancement")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
The patch is against the fixes branch of the linuxtv.org/media.git repo...

 drivers/media/dvb-frontends/dib8000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index d90f1b0b2051..f4e963cdb7f2 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -2695,7 +2695,7 @@ static void dib8000_viterbi_state(struct dib8000_state *state, u8 onoff)
 
 static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 {
-	s16 unit_khz_dds_val;
+	s32 unit_khz_dds_val;
 	u32 abs_offset_khz = abs(offset_khz);
 	u32 dds = state->cfg.pll->ifreq & 0x1ffffff;
 	u8 invert = !!(state->cfg.pll->ifreq & (1 << 25));
@@ -2716,7 +2716,7 @@ static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 			dds = (1<<26) - dds;
 	} else {
 		ratio = 2;
-		unit_khz_dds_val = (u16) (67108864 / state->cfg.pll->internal);
+		unit_khz_dds_val = 67108864 / state->cfg.pll->internal;
 
 		if (offset_khz < 0)
 			unit_khz_dds_val *= -1;
-- 
2.52.0
