Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387E37880B
	for <linux-media@vger.kernel.org>; Mon,  9 Feb 2026 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645443; cv=none; b=BEJq89RNxaMGH6q0twYsebwMTmuUnQmpMzII3qhSFiN+B98EqSYqPbLkPAsxPEqnO0g9495ToGOGPioI8+EhHjHmL5CAVvGxojcb6gOF3dr3e4ReKI2Ypw2SS8jzykEL5XFv0PEQYgordjdm0qr0bkb/EDmUsKHQviqlbn5TPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645443; c=relaxed/simple;
	bh=iGhhjjJs+s1Ah+V7ivZow4oJHRXO0o2RtPrKfOZyuow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OC4K6VC9fep2X2CwcLaMUip6K5mI24kcIaFJsYWoolXZWc40CfDoUyeNdRSdZ/M6yt+J1Txo8HBtMR7KD6kMFogEEYVC4MGNwmUhF2xOxVjUhP+aLazw8eDHoas1CmIfWHZdh3aOgPJQhzXqRvYKCqaG/9L1dOn+s3ckbZVKt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfDsUGmA; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfDsUGmA"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c56188aef06so1738781a12.2
        for <linux-media@vger.kernel.org>; Mon, 09 Feb 2026 05:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770645442; x=1771250242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r79carKhU9SJM27BLT6kiyLph+5RAI9QjCUOkCO2w44=;
        b=VfDsUGmAtvGQwcp4BpVvTJIrhLkLSRykXgJHn3xKhWCZFx99HO9fE/4m72OTbZ4ywH
         hgIVPQ8HyJEFjCYPBJtszfT6jBI4+joG1MVB0Tbyq+beadASwX37fmuIGaHVmPwzlfbA
         Srzc8jFyc7ml1a3JGaJhRvNWceEbsTbe87ityTbhXI5Cssj6jOLBgCXKShPSSSHKpMdC
         pX+/u10HNqOX4m9GJ0wg0n6iQqxtYqem0f0giVCHZsUbkY62lcDZCUlvC5WWe/SAUROl
         s7h8Aow/Yjm8BW1boW2Z2gSiZtUvTXuSkZufQaCjaZAuko+Xz6c0TZtFk7lKOGZo8vWm
         i8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770645442; x=1771250242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r79carKhU9SJM27BLT6kiyLph+5RAI9QjCUOkCO2w44=;
        b=l31HXogjIYe83CyyqIh4ipRsjxr0NuTLSc4Xu7O39QVj9WlZQ+tyPtQ1pSsoWnM+zB
         d4DTq7NjvSVKVs5G42DYE7IW3moX/GT8/02qSiu1sxDigxbaW0orLFiqRIpyftIH3xP+
         /6xuUKO4BxPuuMR2pGsFHqZRtKRuquc6MbH532hnHHneU2MHcuVRc65ZBt3oPMXIAuWh
         PerwrOc1w4bq3z1gx5le54lQqaLTlizSWaZk9pOcIf2AXXXAG+7jJUhcYcyGzQtuu2Pn
         91EYO446/41ihbv1HgGZyHB/fjEBDAnvi12A3bkKESECqsy5cNSLW5bGE6lGxFc2xcBY
         IS+w==
X-Forwarded-Encrypted: i=1; AJvYcCWWLeNge8TSPWwCotKbUM6X04s+Mkfg3icQSCnk9ppsPdb2dvuSpXCM/+KhC2c7hu1sAme7/Nx4CoMibw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVnAcw/jfadxWNmunjHrpZ6GbIs2CJJW3TQ7YBx3O3VFLJtr6
	Izg2ouv+TExE7qqUaylQkaIaR4FL42hzeXXT8cT4Ph2/r22whxAphjQq
X-Gm-Gg: AZuq6aLwdC/GtPqpTtA3eCH6wtEKWtlnFlH2bNYQGN7sEiv2UIlb8NBaJt9ari50pEx
	UwVS85VbdLvLrsy65T3NPWVz1D/vtt+kcQDY9VmE/FfIxTq3j1vW7RINRdC8QX7zjvPRFpsoU+g
	q2QMSgYLu6pa5jUxLGyL037bZ9jGriGgs5MPtOYHF/J0t7kQeLy9tKFwOQjG6Xmq4AqyxdNBuCk
	pXG16Z9vZ5jBKyX3zEQ4gHACPoCmAPiWmKn5Uqfdcrwvxp5wSZ4pVqs7Ua/Ifx/vTfY1LCN5QSD
	SRaKaH/RB3YxVCQhiUVVpfPHh6FN5siavJQm9BJRk4mltdLApqDHc9yMr9+yDFE42yL8Pfp7XY9
	jYMjNNof8AyUEQ8VUn5XKKATBINf+jrdH1d0rnrxyPC/C5kYQ+lz/ROteveXf+I8e3zASZJ/YFp
	M3
X-Received: by 2002:a17:902:d4c4:b0:2a0:d629:903c with SMTP id d9443c01a7336-2a9516f888amr120987755ad.30.1770645442189;
        Mon, 09 Feb 2026 05:57:22 -0800 (PST)
Received: from deadibone.. ([118.141.233.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166f6dfsm11008905b3a.2.2026.02.09.05.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:57:21 -0800 (PST)
From: Ethan Lam <ethanlxkernel@gmail.com>
To: hansg@kernel.org,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org
Cc: sakari.ailus@linux.intel.com,
	andy@kernel.org,
	hverkuil@kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Lam <ethanlxkernel@gmail.com>
Subject: [PATCH] staging: media: atomisp: fix block comment style
Date: Mon,  9 Feb 2026 21:57:14 +0800
Message-ID: <20260209135714.48216-1-ethanlxkernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed block comment style warning by checkpatch.pl

Signed-off-by: Ethan Lam <ethanlxkernel@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 3a4eb4f6d3be..d53f2015014b 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -1380,8 +1380,11 @@ static void atomisp_update_grid_info(struct atomisp_sub_device *asd,
 	if (atomisp_css_get_grid_info(asd, pipe_id))
 		return;
 
-	/* We must free all buffers because they no longer match
-	   the grid size. */
+	/*
+	 * We must free all buffers because they no longer match
+	 * the grid size.
+	 */
+
 	atomisp_css_free_stat_buffers(asd);
 
 	err = atomisp_alloc_css_stat_bufs(asd, ATOMISP_INPUT_STREAM_GENERAL);
-- 
2.43.0

