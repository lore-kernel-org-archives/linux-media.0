Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4337E318
	for <linux-media@vger.kernel.org>; Fri, 30 Jan 2026 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777403; cv=none; b=OkNceTWb/PZfs36K6zGBRM4cfHYK5tCEnAv0qyW7fcukI2A4NgYyQVgL1e5LdGut055KUtQlBJaZz/XnrGYpupJFkME+5kpdJu7qT1M6Bzdj0LkQIhbMG51VmJmRexpuQe7cZ8iAb9ZSBOEas3cAyLZXq0IVRON3vAFgJybsWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777403; c=relaxed/simple;
	bh=4Y6GlT1FtG8VTSEqElibSSfmV/oqQEBBF3NI80Dhu3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s49782BFdZGSVLJbCIoVnotKqKX6RxzAz9j0MCeMCb2jp/KuKXrQQtf+DolUd8xVpTBHrfv3FIAKODEeOXhK+TEuPO8IoaGzWRAXhYldC+bwMVK90xRrb7JAZZ4TwdVjyVNwBc9J1tKkyNvFhFeBFJLocu4/5TSmmTWC/Pj2/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyJ/9VxK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyJ/9VxK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so21659535e9.2
        for <linux-media@vger.kernel.org>; Fri, 30 Jan 2026 04:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769777399; x=1770382199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZTvAgzsdLyPVb7r9icvoh5jhK/kCdwgL9RfYNjUTH0=;
        b=LyJ/9VxKH8qG4HIkajVqD+yx8jJ34L/TPUKCDM5oTP8QdBExhQ2HFUfNkzvM/ynTLQ
         Nc/GG1r0L8w5mOwzDzCMSa05SI87FacWcIdEi51vGRQGTopwyrUb6DsXZMEVso4ge6l0
         pDB0vz6r6GAY8L2RE70H7a2OcoBnv4rKz5ewy3eUq8fck92eF9sKoaq9lrocFk3NzdkZ
         95FdMhhVi0Fg+glk3Ac7uldmaAnNFwv3GnxhkZjP2iYrEyG7PWS9rl0zcB8LA1VlR1iR
         gov8P3jrWxWNX5mV9Gl0LatjHECTNa6R2cMwZX1ZIKGxx/2dPyRWQGQaszTDRX1slLw3
         OinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777399; x=1770382199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZTvAgzsdLyPVb7r9icvoh5jhK/kCdwgL9RfYNjUTH0=;
        b=By63lIRv9o9RjL3Ut+839ZEiJWBbgBAklmfTC6pcTjwn1H/+A/KRqqkPChwQGwrzMc
         9somddN4shw78+fuPmXY89t+Q4x3PCdX3C+oQpRQmKQxSV63jyXaZQC50u+97qoxktNP
         ce0nkQwHdRHxqe1D01F3zJ6xZ7lVOFnxLAn7MCErflI+EBxoqDXOWy6iogKI4mWLhEY5
         m7978lasFDvhDBoRtvPEaukb40aCzr3EgVmzdLLFSOkNhItIuOPIRvzxhOJTkHUQMmdr
         EPkekGmIay+oh1JWoF6BPNs004CR7E/0YgeAiCPL1rIck4J+hbcx5HUSaA+3gk9l4VoR
         2e0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr8BVUxxXOBSp02OH2hQhh3zFAw+KIiTKrj5dql9bIlz35G2UEOEfMYVQ1OnOsyYZHEe1SZDBIMNPWNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAyTHJ8IFAaRF1qgqkQRpfK0J6J6P0A7aPKOkLrYzY1VjljiE
	XVgWU8AN050zr4P+TvdOrg2heTLRrfB/bMSlVAl8PMifRvt3rTAfuEMj
X-Gm-Gg: AZuq6aKJmtXgHXAr5ymd9fPXEPn9lNlVRazsJeCdgaEU096eASEf/EOqaINOxPv5lmD
	zfwKHyUMo1o9ZjlWvFxL0bqAig5jR4aaGEjv589lu/TfXLh4k8BVY3XDmX5tLipKwvtV5TK0G/T
	14lT7QLjsMHQ152Gj3CsA2eQ9KVq3BH4dO6/QDdbQBlETh/6lhq97On0nhBLz8Kx2Y01WYcArpf
	gLgfg/qrZthmhokwv6/MYB4Yz9v3f5SmXbt9043T0uGeR5UWgnr0T3A+ZjsAiAxJexL6i1ph01D
	E+QhNAH6N0zHBJfpNRfN7niJBbnzUzOm0UHgRd58KZZmao/D9XqeIvPs7t1InOVQ5bY9X9nEvMq
	iSzV/GCEbMS6xRpYe2Mk4JFvextdevMV3fdaxz66tExc3bbvflxUR8N3rOZXNjjTXmeYHKntns0
	A0
X-Received: by 2002:a05:600c:a08c:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-482db491ef7mr36328755e9.22.1769777398808;
        Fri, 30 Jan 2026 04:49:58 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4757sm22738783f8f.5.2026.01.30.04.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 04:49:58 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v6 04/15] staging: media: tegra-video: csi: move CSI helpers to header
Date: Fri, 30 Jan 2026 14:49:21 +0200
Message-ID: <20260130124932.351328-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130124932.351328-1-clamor95@gmail.com>
References: <20260130124932.351328-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move CSI helpers into the header for easier access from SoC-specific video
driver parts.

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # tegra20, parallel camera
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/staging/media/tegra-video/csi.c | 11 -----------
 drivers/staging/media/tegra-video/csi.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/tegra-video/csi.c b/drivers/staging/media/tegra-video/csi.c
index 3c3f6e3fd1ec..894583d48b35 100644
--- a/drivers/staging/media/tegra-video/csi.c
+++ b/drivers/staging/media/tegra-video/csi.c
@@ -20,17 +20,6 @@
 
 #define MHZ			1000000
 
-static inline struct tegra_csi *
-host1x_client_to_csi(struct host1x_client *client)
-{
-	return container_of(client, struct tegra_csi, client);
-}
-
-static inline struct tegra_csi_channel *to_csi_chan(struct v4l2_subdev *subdev)
-{
-	return container_of(subdev, struct tegra_csi_channel, subdev);
-}
-
 /*
  * CSI is a separate subdevice which has 6 source pads to generate
  * test pattern. CSI subdevice pad ops are used only for TPG and
diff --git a/drivers/staging/media/tegra-video/csi.h b/drivers/staging/media/tegra-video/csi.h
index 609c5952e050..2b4d586d3845 100644
--- a/drivers/staging/media/tegra-video/csi.h
+++ b/drivers/staging/media/tegra-video/csi.h
@@ -155,6 +155,16 @@ struct tegra_csi {
 	struct list_head csi_chans;
 };
 
+static inline struct tegra_csi *host1x_client_to_csi(struct host1x_client *client)
+{
+	return container_of(client, struct tegra_csi, client);
+}
+
+static inline struct tegra_csi_channel *to_csi_chan(struct v4l2_subdev *subdev)
+{
+	return container_of(subdev, struct tegra_csi_channel, subdev);
+}
+
 void tegra_csi_error_recover(struct v4l2_subdev *subdev);
 void tegra_csi_calc_settle_time(struct tegra_csi_channel *csi_chan,
 				u8 csi_port_num,
-- 
2.51.0

