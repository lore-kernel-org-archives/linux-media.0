Return-Path: <SRS0=fNsq=6B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7771C2BB85
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 07:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD35C22252
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 07:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587107283;
	bh=b5nw/cypuMOVWxhnvLyVdRg0uHDAxnO+NY+IaA0SAuU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SV2pvOl1N4zdI0h/8njiqcm2MgZ+3jzj/f1Nv5RuEQMj+G9cyDMzC3NJDrAl8OAYg
	 F3BC9Y7KR0yt5+r90OGvWF+8gTCBAa7r3tc2UvifCgAUYiYtIx/VpNGkIGKcMdgWDj
	 cNW/O1pRN8MTrXD5QpjzbVf7rs+HLeaBOvnTfUZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgDQHID (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgDQHIC (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 17 Apr 2020 03:08:02 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40ED221F7;
        Fri, 17 Apr 2020 07:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587107282;
        bh=b5nw/cypuMOVWxhnvLyVdRg0uHDAxnO+NY+IaA0SAuU=;
        h=From:To:Cc:Subject:Date:From;
        b=I0SrMPiy1JgtZkKn59m5Iil9sbmE+xQdsD7fy8k6FZCInB8NxRASOx6eGL150IyxA
         2ZeHTNqL9t8HRFHgnezwyohfhVxtRTit5lz9D16R2cFqK8fIB+3UHbbNEKjTIss3cl
         KeuWI7eljQj0NhxedM3cDTquSmQcB1EbQX8bV6/0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jPL6V-007nc8-Oz; Fri, 17 Apr 2020 09:07:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] media: cec: don't select PCI & DMI
Date:   Fri, 17 Apr 2020 09:07:57 +0200
Message-Id: <6af5797c76c11d8c08ae1f5a73c3711fcf89ab6f.1587107273.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

While select would be a great idea for most archs, this
causes a breakage with s390:

	"I don't think that's a good idea, as it suddenly enables selecting all PCI
	 drivers on platforms that do not have PCI.

	    WARNING: unmet direct dependencies detected for PCI
	      Depends on [n]: HAVE_PCI [=n]
	      Selected by [m]:
	      - CEC_SECO [=m] && MEDIA_CEC_SUPPORT [=y] && (X86 || IA64 || COMPILE_TEST [=y])

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/cec/platform/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/cec/platform/Kconfig b/drivers/media/cec/platform/Kconfig
index 2c4dd7401dd8..350533cd8261 100644
--- a/drivers/media/cec/platform/Kconfig
+++ b/drivers/media/cec/platform/Kconfig
@@ -100,8 +100,7 @@ config CEC_TEGRA
 config CEC_SECO
 	tristate "SECO Boards HDMI CEC driver"
 	depends on (X86 || IA64) || COMPILE_TEST
-	select PCI
-	select DMI
+	depends on PCI && DMI
 	select CEC_CORE
 	select CEC_NOTIFIER
 	help
-- 
2.25.2

