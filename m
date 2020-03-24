Return-Path: <SRS0=HLWw=5J=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD72C54FD0
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE17020789
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585059996;
	bh=zox53D8AS0dECcLfbWUc6+iE0tL+4cdEzB4u0Q7B4a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yehp0WNHnQCATMpPpsNEPsZdPKhqm5Tu2V7JEhC7kz6n14vrwt4NbUvPyYIOaNQ5I
	 V5loM35MerC428mfTFNBtxFnW1c51+8rLC7o1BQe8BKzrf3hF4DkuTLhDxvvs0Y7fY
	 6jCn/jVNn2wjqDKZ0s8ks0/uqGDgsI7T7kHCD3IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgCXO0f (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgCXO00 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Mar 2020 10:26:26 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3F6C21841;
        Tue, 24 Mar 2020 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585059986;
        bh=zox53D8AS0dECcLfbWUc6+iE0tL+4cdEzB4u0Q7B4a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWp8U0q5Z5D+y6YRmGpMlVtiq9EuFW1Sn277equPMJFxKzSbA2XbAowtjgU3jeerC
         /UieKb+2arYZJmQNZU5wckROq+/RJTFe+NNG2DtHrbZ/wEohPZvxPfyq2GWny4FD4F
         TMgWrjDe9Mmd8vbiu9QcpjPUAG0pwg6Nx1QrXFQ0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGkVc-00267c-47; Tue, 24 Mar 2020 15:26:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 16/20] media: Kconfig: better organize menu items
Date:   Tue, 24 Mar 2020 15:26:17 +0100
Message-Id: <39461aec16de5b70a23f4fc353bc41cf995a4c42.1585059897.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585059896.git.mchehab+huawei@kernel.org>
References: <cover.1585059896.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Place all API specific bits together

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 86cf4f12a70d..7d4088cfe3ef 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -126,10 +126,6 @@ endmenu # media device types
 
 comment "Media core options"
 
-source "drivers/media/cec/Kconfig"
-
-source "drivers/media/mc/Kconfig"
-
 #
 # Video4Linux support
 #	Only enables if one of the V4L2 types (ATV, webcam, radio) is selected
@@ -149,8 +145,6 @@ config MEDIA_CONTROLLER
 
 	  This API is mostly used by camera interfaces in embedded platforms.
 
-source "drivers/media/v4l2-core/Kconfig"
-
 #
 # DVB Core
 #	Only enables if one of DTV is selected
@@ -166,7 +160,10 @@ config DVB_CORE
 
 	help
 
+source "drivers/media/v4l2-core/Kconfig"
+source "drivers/media/mc/Kconfig"
 source "drivers/media/dvb-core/Kconfig"
+source "drivers/media/cec/Kconfig"
 
 comment "Media drivers"
 
-- 
2.24.1

