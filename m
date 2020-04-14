Return-Path: <SRS0=F69p=56=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB66C2BA19
	for <linux-media@archiver.kernel.org>; Tue, 14 Apr 2020 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD7C206E9
	for <linux-media@archiver.kernel.org>; Tue, 14 Apr 2020 08:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586854294;
	bh=G5ftr++M+uLa9IXqYDxk2clzvEvu6m2squ9r7F6RcoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MH2ayf/uhDPh0rHRQIAUuNdDOb0zZ4HwQMqWMya/tWip379anCtBM4w7TxFEyzScY
	 ZK7Y/Ph6QFi3571oORj6/tlcNABGdvw4upCc84FErkWyziOQYge7TXyZqQBfOqlgDM
	 RNcx1MAaTn2gHaDYWKAdXaK1lQf27JIRxTiE3iL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437127AbgDNIvc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437107AbgDNIvQ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Apr 2020 04:51:16 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A2321734;
        Tue, 14 Apr 2020 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586854269;
        bh=G5ftr++M+uLa9IXqYDxk2clzvEvu6m2squ9r7F6RcoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHrCEIUtaphAE4WgNkqKE53MvAjA6mdheSJFwpsUhoGVY8m5Hi4sXPtL15j0rUzLC
         1fsWtM27Lqa8LyDnTsQK7wcmHhWEGqZDAF2I9B4pSZDPwvFJn/Y3RCRXtIL7Xjl7Rw
         PL7bvfCJY0xfoxh31YRuwF0cpDgasyqzBRtgksu4=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOHHf-002wzz-HW; Tue, 14 Apr 2020 10:51:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 16/19] media: docs: fix references for vimc
Date:   Tue, 14 Apr 2020 10:51:02 +0200
Message-Id: <e6c0fda674b3c29d84a5ccde715be968c7d0d9e2.1586854191.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586854191.git.mchehab+huawei@kernel.org>
References: <cover.1586854191.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As the test drivers got moved, we need to update the
cross-references accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/media/drivers/vimc-devel.rst | 4 ++--
 MAINTAINERS                                           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/media/drivers/vimc-devel.rst b/Documentation/driver-api/media/drivers/vimc-devel.rst
index b2aa2ee79205..1584abba6ee0 100644
--- a/Documentation/driver-api/media/drivers/vimc-devel.rst
+++ b/Documentation/driver-api/media/drivers/vimc-devel.rst
@@ -9,7 +9,7 @@ Source code documentation
 vimc-streamer
 ~~~~~~~~~~~~~
 
-.. kernel-doc:: drivers/media/platform/vimc/vimc-streamer.h
+.. kernel-doc:: drivers/media/test_drivers/vimc/vimc-streamer.h
    :internal:
 
-.. kernel-doc:: drivers/media/platform/vimc/vimc-streamer.c
+.. kernel-doc:: drivers/media/test_drivers/vimc/vimc-streamer.c
diff --git a/MAINTAINERS b/MAINTAINERS
index f0e7b4d17fcc..be4b59f25839 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17833,7 +17833,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-F:	drivers/media/platform/vimc/*
+F:	drivers/media/test_drivers/vimc/*
 
 VIRT LIB
 M:	Alex Williamson <alex.williamson@redhat.com>
-- 
2.25.2

