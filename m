Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201EC321420
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524794; cv=none; b=qk5yqzD0fvSCMn85W5AU6sF1sNebwy7tU/b7Pws7NOShCY9skt67ivK1uL12T9y06h8ikyTsToo1z2jJIU386m4bE9BW+FlxTTpIV7F/KTP0+0Ed7KRqElHOwjkklBAmpnw/lBHeySsexYxbVcJZCwVKsSscb9NzLk1HiLvdGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524794; c=relaxed/simple;
	bh=MREIJFcZ2rp1rmZfWwvS3zaB6eT7Dhlq5P2feIRtluo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bF3LhqHJdJ+d66s3rk7xah7Xui/8zd1zpJgdwtGYit40FmXjaERS6Ri7DLr/BjEyJhxRSrdkZR8VaoRlxpRM2SSnoI+6+AOx51QpomxAYub4x6SJdiiC6wY2ePRyYn0oS8RwI2hJuBVCVA0MayS1yDHogU1pzCTiKb1RPubJhac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HnAockRi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HnAockRi"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632d45c9so5237995e9.2
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762524790; x=1763129590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zya9CDjAWwz/YQhtW3O1MV9PxrsdkYyA1iOu9tElgJc=;
        b=HnAockRiA75xWEDQyNFcwrmKxWLGRhYFd3mtTuIAGYtZeRCctXd15tg+Z8kYkl+n53
         g9kKC52aT22ODg3iwr4J4oUswOMh1hQgj5KaalkJjyJVp0s2kUzbws20pG+DHcoGXAUo
         hyJCaqytVHLiI0/5yLcWT+JbLMfmvM3TsThgq29Mxowp38lCabLVDBcoVjiX/D1YOvil
         TT8YGIPPl4pGsiFN0hI2LN63cDk97MccmEJY56A+tXLh3V54IYp9Qoa6NBzynTp5AAHL
         f8LO6D0tq/3NTQKQO8Jb0d0UPNGEj16dUYdkD+qucyvdjTl/i4mDeKA4w5ZDOAs+O5We
         W0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524790; x=1763129590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zya9CDjAWwz/YQhtW3O1MV9PxrsdkYyA1iOu9tElgJc=;
        b=AUqPRcM7Ox8ar37easlLASjtLoPKZ3G9nt0YCStER3N+QUtuqxRIOjygAns/FysKNd
         YWii4La8PHUtcJl17YFhAKZtZ/l6RM5mMk+TjY1XcXFoUsMOOcvK/YRYJn9wp1ofhbr+
         fw/Zn1SklYRn4iHVyeejoKgJgiAc0FrXCI5jubrzAirbQ0N9bO0pIcDZE0LN0Qsc9oem
         8k/AviLTKkx1rXkx7pC8OynRb/hzKCb0ODcltWVzi93HYboF4+uPczBHdLXKCrtyo/Es
         LRTRG43fH/aud6oPe47cVsN0p7O82L6ghrywByqJDGx14vG5IjhRfaYamaGwncIMj9KG
         Uimg==
X-Forwarded-Encrypted: i=1; AJvYcCVrzFV2kqo6ipWMu9J2+/9E1h4NJazxXmUm0h+mYogzYnoq8q5IXtWDhbpvJPCkWToWunzHYPAZCWakEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1O6JM1DXGCACYk9j/ha+DSqWqcZcRqGkwqnPSTvxdPE0qIyi+
	/WA/sqcs7o3E0n/n8ti9zijEKN2OzmhfUPnShdlr2JoQclbx7RZ1TnLZcftxz51fMrs=
X-Gm-Gg: ASbGnct+1jKiUNO+K4uh3r43SiXYtg5BxfJjIC4gDgjRwppKMb6TssGvzjVrqNgGIW2
	rbWcB3F8v6huwb0FLT0fPB7ZOMPKdDWL+pEncrI5ciJYHC3ViiqcvO9k+vLwNDmfxhUFL2na93J
	Bftpt9wmzxefSrjTvTtfOXGZjFFOAJfNRejM4D7qdAoJEXCkHADIdyn5ZGs/4Nfw3WCPM0qruAF
	IN0IJR4q6jZy8buXvUW4oaMlVlA4XLwjrQmcuR4eLftZwZAA0yPaHPHtiswP2BcG6uUeScbaYpK
	Nuqu8tcQr/NLnQIWCR2OpkgdI4021A4D2Psms646MV6q7XgazH6+XW1TMGWeFheDu3t4ASFxP4n
	eFOZbi96E5KnWfPJv8s51iyLoRhjmYn2oes/iCal3qtwaWQccPm+wg/hKDQXuiR5t+WbLXsVtkJ
	V/TXm6lBQRKSmS+bgiIJ65zeSdbsyOWog/3QI=
X-Google-Smtp-Source: AGHT+IGp7Uv+Rz0H0a9Tbxc8WVcxFYh+xPnB3f9zZgNkWgNSCruoFQ5+kEx67gRvEzujnx6ZhHmG0g==
X-Received: by 2002:a05:600c:1f10:b0:475:dbb5:23a2 with SMTP id 5b1f17b1804b1-4776bc904efmr24244345e9.16.1762524790118;
        Fri, 07 Nov 2025 06:13:10 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477641b622asm42998605e9.4.2025.11.07.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:13:09 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] media: platform: mtk-mdp3: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:13:03 +0100
Message-ID: <20251107141303.223254-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 6559d72d5d42..9083367ae2e4 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -255,14 +255,16 @@ static int mdp_probe(struct platform_device *pdev)
 		goto err_free_mutex;
 	}
 
-	mdp->job_wq = alloc_workqueue(MDP_MODULE_NAME, WQ_FREEZABLE, 0);
+	mdp->job_wq = alloc_workqueue(MDP_MODULE_NAME,
+				      WQ_FREEZABLE | WQ_PERCPU, 0);
 	if (!mdp->job_wq) {
 		dev_err(dev, "Unable to create job workqueue\n");
 		ret = -ENOMEM;
 		goto err_deinit_comp;
 	}
 
-	mdp->clock_wq = alloc_workqueue(MDP_MODULE_NAME "-clock", WQ_FREEZABLE,
+	mdp->clock_wq = alloc_workqueue(MDP_MODULE_NAME "-clock",
+					WQ_FREEZABLE | WQ_PERCPU,
 					0);
 	if (!mdp->clock_wq) {
 		dev_err(dev, "Unable to create clock workqueue\n");
-- 
2.51.1

