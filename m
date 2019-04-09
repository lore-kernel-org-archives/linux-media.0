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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C685AC282CE
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936872084F
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjWZrKAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDIMjA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:39:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43327 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIMjA (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 08:39:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so14285596lja.10
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jaR1tZINzpIPijy6aornrvZC+Rv9wHDbKeMRDATMYz8=;
        b=VjWZrKAvrEc9m6cfP5HJq3+JkRZsp3xGiNWOnydZoYOuaPbQcjG+zi1EaKabfhzOt9
         F+Xj8FmTgxjtuyT1rENOYE2BcWbDM4uBji7aMcDMaoWONQrnV+HCYcmEDa4P6IMgzFAW
         jZtATT5EBxufbUgRjhyNQKfydhZD7HXZAhvp5lHmMvVqfAnGIWcKvoAJR+5W9oCP0ThW
         vmi0iRXDnsBvGDtT+fxKToa/jNqsNXmY+Kn3DCCRX0d7TBZKpSB/nLcSzLFJkp0yYktZ
         FCFmFgiKjbla0cWIzKTmAU22dNPz+QrsYb/E/aRHldux46bjLQLeFNXSYpoVDbyEV78U
         oEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaR1tZINzpIPijy6aornrvZC+Rv9wHDbKeMRDATMYz8=;
        b=i5Uq5B5rO6YS60xufmNbAe54gEIgFaC3NnX7vXz1ebEmts8tjCu/dV3O8orHtgrO8a
         mpbW5UQ7o3DjTBfVmUHvOANT0piy6X/IjZyDjqUwoymNuLRH6DUV2T2sgEAspZhKa8gi
         A1Tn3E0snLOn4kCR7euYOUdVwrGTeBx5Z2hqUDqNuovnq/niYjiBcY/GFYaJdPHGix8i
         MdM48FgoBCrPkFdvSicPp6yArPXGh935inf5IlH42PW2wM/i6RJd3cSv0abAwWqr4U88
         C0m3ClqKMuOygoNjH6D8lRAYFMFhp5eceFGxw4Ke9seShFQZKBZUyyTg7/63ezZ/nzZP
         MKtg==
X-Gm-Message-State: APjAAAWLmvqNNFf02R/HEnvLms2ii2HxHdSAnStadL6hzplo2hqFigoT
        Yipj9HXi60U9zeG+KA3wxozZtx3d
X-Google-Smtp-Source: APXvYqyKaC11VhufmknXyiyapS+F9ZDoRTeAONHESPCJzDLrwsQU+CW8gke+ZumYE/64Qc5t3k5ZQg==
X-Received: by 2002:a2e:9211:: with SMTP id k17mr19273255ljg.46.1554813538115;
        Tue, 09 Apr 2019 05:38:58 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-200-6.ip.moscow.rt.ru. [95.84.200.6])
        by smtp.gmail.com with ESMTPSA id t23sm6749976ljc.13.2019.04.09.05.38.56
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:38:56 -0700 (PDT)
From:   =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD=20=D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D0=B2?= 
        <lrn1986@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 1/8] [PATCH for ZBar] Include windows.h for vfw
Date:   Tue,  9 Apr 2019 12:38:35 +0000
Message-Id: <20190409123842.19600-2-lrn1986@gmail.com>
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

vfw.h can't be included without windows.h to supply basic type definitions.

Signed-off-by: Руслан Ижбулатов <lrn1986@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 58b97ec..6e092e0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -257,7 +257,7 @@ configure --disable-video to skip building video support.])],
         )],
   [AC_CHECK_HEADERS([vfw.h], [with_video="vfw"],
     [AC_MSG_FAILURE([test for VfW video support failed!
-configure --disable-video to skip building video support.])])])
+configure --disable-video to skip building video support.])],[#include <windows.h>])])
 
 AS_IF([test "x$have_libv4l" = "xyes"],
    [PKG_CHECK_MODULES([V4L2], [libv4l2], [],
-- 
2.4.0

