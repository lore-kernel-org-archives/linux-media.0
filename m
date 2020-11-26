Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC68C63697
	for <linux-media@archiver.kernel.org>; Thu, 26 Nov 2020 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA5D206B2
	for <linux-media@archiver.kernel.org>; Thu, 26 Nov 2020 18:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Od9viEE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404973AbgKZSMB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Nov 2020 13:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404527AbgKZSMB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Nov 2020 13:12:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C97C0613D4;
        Thu, 26 Nov 2020 10:12:01 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c9000558d893f9f23e622.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9000:558d:893f:9f23:e622])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2886E1EC053C;
        Thu, 26 Nov 2020 19:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606414318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=5BLwUS4p0NnmZmEmK/q6ireDuvIHVZDCQbvulzT8+Sg=;
        b=Od9viEE2UWHMiNOvudBmLnoE+eWhlc8eOITmhU5RZ1UqJljbC3ngVElvIyAVb8QLbGWyzL
        t99CSz2jJl2wXOMMjBAeWYy+c+bWB7hfzBS1s6yDOWMsVaGwdhTwx/5K/LivGRJdyMjjle
        OE+bIXZpdi/ZgOnw9XVzOV4ESBz3Cu4=
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: atomisp: Fix size_t format specifier in hmm_alloc() debug statemenet
Date:   Thu, 26 Nov 2020 19:11:50 +0100
Message-Id: <20201126181150.10576-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fix this build warning on 32-bit:

  drivers/staging/media/atomisp/pci/hmm/hmm.c: In function ‘hmm_alloc’:
  drivers/staging/media/atomisp/pci/hmm/hmm.c:272:3: warning: format ‘%ld’ \
     expects argument of type ‘long int’, but argument 6 has type ‘size_t {aka unsigned int}’ [-Wformat=]
     "%s: pages: 0x%08x (%ld bytes), type: %d from highmem %d, user ptr %p, cached %d\n",
     ^

Fixes: 03884c93560c ("media: atomisp: add debug for hmm alloc")
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/staging/media/atomisp/pci/hmm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
index e0eaff0f8a22..6a5ee4607089 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
@@ -269,7 +269,7 @@ ia_css_ptr hmm_alloc(size_t bytes, enum hmm_bo_type type,
 		hmm_set(bo->start, 0, bytes);
 
 	dev_dbg(atomisp_dev,
-		"%s: pages: 0x%08x (%ld bytes), type: %d from highmem %d, user ptr %p, cached %d\n",
+		"%s: pages: 0x%08x (%zu bytes), type: %d from highmem %d, user ptr %p, cached %d\n",
 		__func__, bo->start, bytes, type, from_highmem, userptr, cached);
 
 	return bo->start;
-- 
2.21.0

