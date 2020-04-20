Return-Path: <SRS0=ZgJ+=6E=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F22C3815B
	for <linux-media@archiver.kernel.org>; Mon, 20 Apr 2020 16:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D78E20B1F
	for <linux-media@archiver.kernel.org>; Mon, 20 Apr 2020 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587401156;
	bh=fv/lZWyp1Aft98ogIw8t/4eMXXzbCLcv2G1lVAOZ1yc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JeVFczVMrRTGF2jJxUmcTa+ZyKcBwhrj93ROTpENOduD8Xio0fWgUiiKPEqhd2Scu
	 tqV6m7po0zpps4+zro6/OiXR0gzAgPf87OWSO9W9SoKL5c8lzOQmdyY6YQGo4XEBsl
	 lf3EYgbuLcU2rxcNS4M3CCfGDkclE3FICcGmVsro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDTQpz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTQpz (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 20 Apr 2020 12:45:55 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7C42082E;
        Mon, 20 Apr 2020 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587401154;
        bh=fv/lZWyp1Aft98ogIw8t/4eMXXzbCLcv2G1lVAOZ1yc=;
        h=From:To:Cc:Subject:Date:From;
        b=FytvsLPO1qjDOsqBLmjS8rlHk5u6Gxu6b5ozlwazJJeDui4mL32amBn+k9YBU8U2T
         pfKXden7VKuQf0iELAMaXVMV9xFy7OvI1Ho3k+bTh9drJVPqqGbQGSAJ5YYWO0hLFp
         lT/HuYCyrzkf2HcIXNMC/l170xqFXQD8aXh0SPTM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQZYO-009jWn-V1; Mon, 20 Apr 2020 18:45:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] media: staging: rkisp1 Kconfig: depends on OF
Date:   Mon, 20 Apr 2020 18:45:47 +0200
Message-Id: <56aaef4ea1c26d90952841fa32b2a14bcc27582a.1587401141.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

building it with a random config causes a warning:

WARNING: unmet direct dependencies detected for PHY_ROCKCHIP_DPHY_RX0
  Depends on [n]: STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=y] && (ARCH_ROCKCHIP || COMPILE_TEST [=y]) && OF [=n]
  Selected by [y]:
  - VIDEO_ROCKCHIP_ISP1 [=y] && STAGING [=y] && STAGING_MEDIA [=y] && MEDIA_SUPPORT [=y] && VIDEO_V4L2 [=y] && (ARCH_ROCKCHIP || COMPILE_TEST [=y])

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/rkisp1/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkisp1/Kconfig b/drivers/staging/media/rkisp1/Kconfig
index 5ecbefa0f5ec..07e4a6e4458e 100644
--- a/drivers/staging/media/rkisp1/Kconfig
+++ b/drivers/staging/media/rkisp1/Kconfig
@@ -2,7 +2,7 @@
 
 config VIDEO_ROCKCHIP_ISP1
 	tristate "Rockchip Image Signal Processing v1 Unit driver"
-	depends on VIDEO_V4L2
+	depends on VIDEO_V4L2 && OF
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
-- 
2.25.2

