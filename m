Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B448C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28915218E2
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISJn5jJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfC3Upq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35672 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3Upq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so6716081wmd.0
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b0ei57Cu/k21r8C1uotyOlCHunhnCRiBKL/Y9ZizMM0=;
        b=ISJn5jJZgCi3GqZ5qTNHcNeSXfmRrmU3o0bTO6sNN8Cx8jdGeU/zDP8u8c+GJIbKB6
         bThdLDx7p1Hs8D2h8nJRDh5U97H6h7DzUTR9BR9f90uofthliQzewMRvY3pjI4fLPg6M
         X+L4C2MBnVKdo4XtnRUM43WRbUuPc6RFK3AQPtZof+Zh4yspY54YrSDloVEaxGm/ZEro
         hTExfbLaB2eGDvkbqToTonQ9jgsO0uKSu3UhxG9TfaVyFRu/5fF+MWAIKpLYIfCW3hMr
         GxGOd2QzWgtggAUrA/kzvp5Q9Ipa9yG9TuqVg65e6z5yCeJLacFbOaIm3GMSQJpybSl8
         A/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b0ei57Cu/k21r8C1uotyOlCHunhnCRiBKL/Y9ZizMM0=;
        b=pBlilg4zXMMz1qYK8m2Z52msEZ/2utySACEksOHUrSi+LaR3uOksrRQjvvYUj44gg6
         Vzbyi+dc8HlRi1WUmtWFb8iWYglc1WWcC7ESe88KyV4dHX1SBOlDQTD45FncbikULmkI
         CDdSbeMXf2nOrgAtCLQAkm6JCE78W2fXKMDakhUfWVl9Ip8Ol3JNNCK0AfYuGrP9p70b
         AIGL25blIhWfAQ+gRj76hmhWxTegv2rzuBhoMqPntzHMMv9DfU5fBFBXMPTCDPccX0yA
         qPxmufJ1kqKFrMC2znvVL7UVfIJ8MB2RCv4CEILrh8727R7TszxOD5obDNJdgM1v1GMS
         2/NA==
X-Gm-Message-State: APjAAAWuMbmpLhYF+VhY7TA5HVcx3h4Lbb8kX/TDE3PgxvG+xqJKs/uK
        2vdqRppxLXVHNzg+waqR9Se0XPMkHpo=
X-Google-Smtp-Source: APXvYqwc4P3HvJX6eDou/iF2NhOu+UYG6lsFQU64rrsZ1j6Fb2VCILe4UGjNZZlvvj2aaY3Ch2aUBQ==
X-Received: by 2002:a05:600c:2055:: with SMTP id p21mr6980546wmg.118.1553978744202;
        Sat, 30 Mar 2019 13:45:44 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:43 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 01/14] kernel/sysctl.c: bug fix
Date:   Sat, 30 Mar 2019 13:42:59 -0700
Message-Id: <20190330204311.107417-2-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190330204311.107417-1-dafna3@gmail.com>
References: <20190330204311.107417-1-dafna3@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e5da394d1ca3..3e959d67d619 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -124,7 +124,7 @@ static int sixty = 60;
 
 static int __maybe_unused neg_one = -1;
 
-static int zero;
+static long zero;
 static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
-- 
2.17.1

