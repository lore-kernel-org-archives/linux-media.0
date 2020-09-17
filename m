Return-Path: <SRS0=7MnB=C2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ED1C433E2
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86AB2076D
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="hkDkKZOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIQJnR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Sep 2020 05:43:17 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:38269 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgIQJnR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Sep 2020 05:43:17 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id IqRakLWcKPTBMIqRcklP2d; Thu, 17 Sep 2020 11:43:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1600335793; bh=ZYzYjSqX6detw/aA6S2hcK0cZCLj/HNVOQw8jJMcBuU=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=hkDkKZOMy4qs1upXOjEo5NaMKzqNcxwXX6NTTKMx00bPw8QBqlgPrVIX7HGX+j6s4
         ksZMALJa64ZaHc8giN1icZifJdrHHA99tjvtvlExcZoDbossodQboS0kmZ7m6zLytW
         p+QNhrucGJAZ45ZqvGOwG/pQdG1Zd2BobDtQG9H22dm/v5gJLSb+GwcVPFdmYvQ1ml
         T/OLt360zfxitnv1+dlqv3AnlImLQaB5cwhqobpD9G8VaAu7fQgjMI3MvgCG6ajOAf
         54IXgYdhp25DGC2YuovlteUZKM0OOHuDMswDYliYOZG3nIq2ERh70Un8cUi5t1XJOO
         ttc5Y2afQdgPg==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] atomisp/pci/atomisp_ioctl.c: strlcpy -> strscpy
Message-ID: <8493f131-1b0f-37b5-a9d3-66dabf76bf70@xs4all.nl>
Date:   Thu, 17 Sep 2020 11:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfODiTo3rclpE+NdpVvqAYbvJ+nKBb2DJG54QSlO3ORWMSwlR4OwQunjZzvt8ZLkjV2ddbCRQ8J6UPknIlfZ41soipehA3w3l57+SXOQW8CJk55XbgshY
 lgisENfIwIYitIBpr8h94lSq2P8SKQMCzK0M8rYoDkmsNCjVVOT8SkpRZ0NYhZl2Eq5csxtce4rJgESVm+LhekHv4+frcrutGQJjMO7GbYuQAmK2Xu2g8Vvc
 0prPUuJtnMohs9FaVYz7ao324W46Z9drhiuT5UAcZrs=
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

strscpy is preferred over strlcpy and is the standard in the media subsystem.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index 105c58059d17..2ae50decfc8b 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -797,7 +797,7 @@ static int atomisp_enum_fmt_cap(struct file *file, void *fh,
 			continue;
 		}

-		strlcpy(f->description, format->description,
+		strscpy(f->description, format->description,
 			sizeof(f->description));
 		f->pixelformat = format->pixelformat;
 		return 0;
