Return-Path: <SRS0=pJLX=BG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AEBC433E1
	for <linux-media@archiver.kernel.org>; Mon, 27 Jul 2020 03:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E73520773
	for <linux-media@archiver.kernel.org>; Mon, 27 Jul 2020 03:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrS/rUrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgG0DPF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 26 Jul 2020 23:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgG0DPE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 26 Jul 2020 23:15:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81901C0619D2
        for <linux-media@vger.kernel.org>; Sun, 26 Jul 2020 20:15:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gc9so8329847pjb.2
        for <linux-media@vger.kernel.org>; Sun, 26 Jul 2020 20:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uE6CSq3nUAPMkn1pPgsyKkDXvAyvil/3IWYm1Cfdltg=;
        b=SrS/rUrqFkIY7Xcpyscl9CFFXDMFpPfBy4RIA598zw5+MavANWbeUUKVBjZJ+yakLq
         LsWUOxoXjE50WIOyiJnHhpuQBSsOb3hlZtv5DOzZZFpNotCLczpmN0aWU8StP9YXFK7z
         UW8Il4+UmZ2neMGcFS4fsDLHxBFLE4dSnu3Zx6AKFWg9bDKWQ58qoCMlKkq3fBWDLiV+
         7b/DYmI4koZ4oMrrDhcIhfVp3l+maZ1y3GioHNWI1gWBHVu82JyzZ/PUkjOD5orOcL8s
         mHOW1JyMJsy/cxMEj5RUz6tOh1PYH/P3b2R1ovWyAczdY8G7+nBacLf2TPaJ9AOQ0cLg
         znjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uE6CSq3nUAPMkn1pPgsyKkDXvAyvil/3IWYm1Cfdltg=;
        b=PJVE0X8qFQ92hdXZHGha52wLay9VwfH0Z3fGFVr786z3gY9846MaJWcMQxkOtgkp2f
         oEPzktpOgZ+S0Ci9U2pJf9GZ2KMqgsgJ5w8quGx4TxL32219cyACMUQSMn100y1qBqFE
         fx2E3iUM5th/wbr9qQSaT1/yAWM0Hhm7erLs+TbE4kUjxZh0qBYAsxZAD+JaRSRQ9JBp
         LfK2nzIxwhmATkrtySC0p7HSCWI2/Y0X0CtuWsfCvElN1n3+t/GEhXwg/5rJhPDEn7o2
         8139ky8iMK4HHwslt9Zuhtv0uTUFyyf1qk2Hz1RHfh/OnzSkvk442LuztY3dQd6Pl0tA
         WoHA==
X-Gm-Message-State: AOAM531Z5NLbIa6DO5GixFvyaGVUy3nNAP4YUutrZ6mgG4akVtU4pnBR
        5dEU3Fw2fZE2KApuLit+NZqzzjBAFoM=
X-Google-Smtp-Source: ABdhPJwGrNybzyTYXGV8hdLSOhAlAXz2YDrGIVkOoOUih3+3+nDeKXvtM+DoBuwNiqC7gWjZH1nqbg==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7mr17043896plv.90.1595819703799;
        Sun, 26 Jul 2020 20:15:03 -0700 (PDT)
Received: from mangix-trapnet.lan ([2001:470:1f05:79e::a89])
        by smtp.gmail.com with ESMTPSA id t126sm13259345pfd.214.2020.07.26.20.15.02
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 20:15:03 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 6/8] [clang-tidy] convert files to reference
Date:   Sun, 26 Jul 2020 20:14:54 -0700
Message-Id: <20200727031456.232955-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727031456.232955-1-rosenp@gmail.com>
References: <20200727031456.232955-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Found with performance-unnecessary-value-param

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 utils/rds-ctl/rds-ctl.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/rds-ctl/rds-ctl.cpp b/utils/rds-ctl/rds-ctl.cpp
index f58c1fa2..cabfa538 100644
--- a/utils/rds-ctl/rds-ctl.cpp
+++ b/utils/rds-ctl/rds-ctl.cpp
@@ -299,7 +299,7 @@ static bool is_radio_dev(const char *name)
 	return !memcmp(name, "radio", 5);
 }
 
-static void print_devices(dev_vec files)
+static void print_devices(const dev_vec& files)
 {
 	dev_map cards;
 	int fd = -1;
-- 
2.26.2

