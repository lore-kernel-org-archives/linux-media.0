Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C3FC282CE
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F782084C
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfXq5J6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDIMjK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:39:10 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:36527 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDIMjK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 08:39:10 -0400
Received: by mail-lf1-f48.google.com with SMTP id u17so2901369lfi.3
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W2Z+crpWWQ9K3AKqFVjRw49NJa9T6n13L/n1Aj8d1K0=;
        b=lfXq5J6qUSqVVQYv8D+LtMHt0EJFxwCVdpE7sdi8tsuqT8ivJMKT6HcoFg4OxeDKon
         6N6YGK22o4oPjQPqr2Eu/s1JorQjpeFKaA6rE5WvoS1LXsXGkY0jadWkjdXMa/iG8lbK
         uduTM5aPHMT/7M8tWgWi7Xf4psPjnbunNmIg5IJJIeGeTjtG1FJQGxVhlKKpPJxW6Ru0
         0SEGuko+xSKqBUpqsZevOd2aC5vH8S+ihTE8rbOLjGVPHaNhFShcp1v/QL/gNoiJqf3E
         Cr+5hiPh8XNNXMupyms18gooArGOAIxRwRK4eaM1S/3rDKtVSdl5kz3pqwb+kHwPqODz
         A/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2Z+crpWWQ9K3AKqFVjRw49NJa9T6n13L/n1Aj8d1K0=;
        b=dHHay/xsxJ0QYicDqRxPgSPNOysmyV0ujfg/IqdyNhfX3eleMtkBopIj8sAsDFJ8KL
         G3uUzWRybtFrnCuZn//HMKp2mUyxSCMyjr3zloFblMdImE7QExxwXgYCKVU+6IJTFZmY
         3+iMnsGIQwm6/OG9meBNtEMoPctrXKwU5xUXq2RHFQ2cLF3ZqG9mFzHp3JZ5Jw4Aruae
         3Gb6IfHXP21fHeGTUC+ifWBi6lSwyLz5S9TwyuWa3UwWVdraeNYEB38eHs8iPXAUa2N5
         f1B9LceJEibM7oRpuZHux763Qx+b5KKQLXm1z6q5CSPmom/oL6lhPwkvlk62h4zuct9l
         jHUQ==
X-Gm-Message-State: APjAAAU98L2HwUYBtkJgSWY5YfEvQ26lFgDaAqEP5KRO1csQT7P0ucDO
        +34mqHBMq2jfHrejwX+Q7PRwZ5hE
X-Google-Smtp-Source: APXvYqya6Z8OiGJTCvdxboDzxNMs3PGEt91hU6EX31wMoQ9V6JoA/6EmlyP+XfnqO9fRdFy7I3e4cA==
X-Received: by 2002:a19:2804:: with SMTP id o4mr5180931lfo.139.1554813547904;
        Tue, 09 Apr 2019 05:39:07 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-200-6.ip.moscow.rt.ru. [95.84.200.6])
        by smtp.gmail.com with ESMTPSA id t23sm6749976ljc.13.2019.04.09.05.39.06
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:39:06 -0700 (PDT)
From:   =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD=20=D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D0=B2?= 
        <lrn1986@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 8/8] [PATCH for ZBar] Correctly generate version.xml and reldate.xml
Date:   Tue,  9 Apr 2019 12:38:42 +0000
Message-Id: <20190409123842.19600-9-lrn1986@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409123842.19600-1-lrn1986@gmail.com>
References: <20190409123842.19600-1-lrn1986@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The buildsystem expects these files to be in srcdir, so
put them there. Otherwise documentation won't build
(xmlto complains that it can't find the files. Note that
it uses an absolute path, so there's no way to solve this
with its --searchpath argument).

Signed-off-by: Руслан Ижбулатов <lrn1986@gmail.com>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3224888..41d77fd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -667,14 +667,14 @@ AC_CONFIG_COMMANDS([doc/version.xml],
   [AS_IF([test -f doc/version.xml && \
           ! echo $VERSION | diff doc/version.xml - >/dev/null 2>&1 || \
           ! echo $VERSION | diff $srcdir/doc/version.xml - >/dev/null 2>&1 ],
-    [echo "writing new doc/version.xml" ; echo $VERSION > doc/version.xml ])],
+    [echo "writing new doc/version.xml" ; echo $VERSION > $srcdir/doc/version.xml ])],
   [VERSION="$VERSION"]
 )
 AC_CONFIG_COMMANDS([doc/reldate.xml],
   [AS_IF([test -f doc/reldate.xml && \
           ! echo $RELDATE | diff doc/reldate.xml - >/dev/null 2>&1 || \
           ! echo $RELDATE | diff $srcdir/doc/reldate.xml - >/dev/null 2>&1 ],
-    [echo "writing new doc/reldate.xml" ; echo $RELDATE > doc/reldate.xml ])],
+    [echo "writing new doc/reldate.xml" ; echo $RELDATE > $srcdir/doc/reldate.xml ])],
   [RELDATE="$RELDATE"]
 )
 
-- 
2.4.0

