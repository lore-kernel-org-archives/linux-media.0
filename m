Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD4322C98
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524669; cv=none; b=MKy+54845jjoPa4CoNytbXu5I44cfmCKJDa77lYD0O5Ulg6RT0WJ98HZcIkjMPJy2kLUeQLRu6fCsncaaPe/SH1a5VzR7y9iAidl4d399gTE/CuuhbykuwcPvOFrN0hB5qkiiM0NzcgPaHcrg0NRV8Bbu8S4uoBKVYduynrmgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524669; c=relaxed/simple;
	bh=7oY4W8cvYI7cWgk2hDetziaayLxMm08O1hUX9ep82XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=okHzE0JrT188tN816u7YUkzDjAgNqfrJMIdbuZiAvWGddZOckf1bG1oAYuSBSKH5NGPP2QTQLAHVRUp2SNw7JDzUe6RiqmU28DpPcXktg3cKPswFp34x8JsPtQLRfGt9+LZUxEdoKJIENK58ANRug/br+0YLGXjcUzvlAyl+x+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=auhHcOML; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="auhHcOML"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711b95226dso7944945e9.0
        for <linux-media@vger.kernel.org>; Fri, 07 Nov 2025 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762524664; x=1763129464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=saC/xSM2GWNzn8WIqniCyfPLhsnZ0TcGnftuhkvfXXw=;
        b=auhHcOMLR7gD0N4E3861Gj/sjnXMjFRFpmAtuUguqrZ9RTObr5luCVIJOitseYOxA5
         87dsyTnEmmk5wQyA0WeRV6K9e4tK2lH18xnFtpsO847x6wilOjbrj/fTGa5new9G4qPn
         Lp7roOcyC/fq1n0Kpi4GCj833dvGRmp+xrLQL2wP6HkULw6XwgaHL2dVZnHiLksdRJLU
         cU22xFFEH+3TWo5rg/Kwe5WpFkwaZsSmqD4C1RfXhS3ay6oh+2FLPJUGu5uxyYeZvMLq
         v9E9GxnZMk1L5VKLq7B/MKOAZtjdBgttKTv8YsXbB+W80FKFjg5/PXq7vE0XMBbt1Olm
         4v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524664; x=1763129464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saC/xSM2GWNzn8WIqniCyfPLhsnZ0TcGnftuhkvfXXw=;
        b=ZbUgAfHP7Fs5R/pBJVPFBxq08M3eLFMK02yAwRMDXJPEM4l0LiviCwsTgwHSgsn+57
         5oQqmX542nm5VgOLqhATqZlZahXOvUC4fO2tSk11m6/fEah1hip5d+lh4wi97BB22Jj9
         f1R8qxNZBdlsd2C/nd/kLg0ECIqoOzcG4dPkMgJ2t/Z1k0lmSPHnzfrnhj05ICeL0zId
         I8h5GuG66hXJ3pQFJufbO+9FAMWbwhDsoRmhvRdIlMFz5osMQFsxM04g4eYRd/l/YmNL
         HTAMpwedY6VN3Jn9J52uqXCNYVTjNT9XAVPLNWRO99lNZfpfkMsRzjbdUnae4/aBSWOz
         DBLg==
X-Forwarded-Encrypted: i=1; AJvYcCUDZebk0cFhFyOWGZ/CjfNu1mAj/hTfYmz+Tn6ZqiSqBb+UrAucz/nwiA3WjG+JQLKVzdu+hDbsa3oK5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46hBr7mmeZve5JchC/DIvAE5p/THG7zsLWmwa/VZmWzcxHoDN
	wh3aR0EgnPkbSDMTulYdqmO3hh5Dj1829GIcnCQEOA016nubFHZnyk9eZC3hZsa3KFU=
X-Gm-Gg: ASbGncsC6okZsS9BvKBF0X0orDC9IL8v7YHRoAwLFyb3Dg1N3SHRZ83+t4uv9RcUEKD
	P8rYA4YyTOSWEwtlPMSQCXgX0Rv08nlq3uVex74yJUAxLb1onmFeBbC7tK6uPXuCp45835KmVAA
	O4/9+SzM8M9YURImYsLc58QPCxCfkRrm3GItPklN6o8OogOe2Ab2ftJQASpDssNltrFYUK4sBHy
	mNSovWpAxZB8XW7VkOtWrwVqAN6zg1zEOzED2+FtjVGYWHlm0Fdni+ARUmPVkFC8G2hNJmhPhnn
	/Kvk4JiQMylPPJDA2CsZ8bL60mjRNvMaVrwkmK3taM2LgYiRftlxfoPiJmE8t/vCuXohJeI3bxD
	1CmvawCPWkz0959HQvHkQ8rpihWJZMr6HWeobRNp6gXQHskwR72dV6BhwKL2EanLA9efGZMCZiA
	92HX5xrs4uEaSuauOE1QISDxAQ
X-Google-Smtp-Source: AGHT+IGKyGh79+Bwp1DW6zyVUm25mj+TgdIHaXGyejMxXcxObw2DsmyhhvrgTD7xRs8ge4kMqfNcTw==
X-Received: by 2002:a05:600c:1f0d:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-4776bcb8963mr24846865e9.24.1762524663735;
        Fri, 07 Nov 2025 06:11:03 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm181174875e9.6.2025.11.07.06.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:11:03 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] media: ddbridge: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:10:52 +0100
Message-ID: <20251107141052.221108-1-marco.crivellari@suse.com>
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
 drivers/media/pci/ddbridge/ddbridge-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-core.c b/drivers/media/pci/ddbridge/ddbridge-core.c
index 40e6c873c36d..d240e291ba4f 100644
--- a/drivers/media/pci/ddbridge/ddbridge-core.c
+++ b/drivers/media/pci/ddbridge/ddbridge-core.c
@@ -3430,7 +3430,7 @@ int ddb_init_ddbridge(void)
 
 	if (ddb_class_create() < 0)
 		return -1;
-	ddb_wq = alloc_workqueue("ddbridge", 0, 0);
+	ddb_wq = alloc_workqueue("ddbridge", WQ_PERCPU, 0);
 	if (!ddb_wq)
 		return ddb_exit_ddbridge(1, -1);
 
-- 
2.51.1

