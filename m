Return-Path: <SRS0=whLO=76=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB66C433E0
	for <linux-media@archiver.kernel.org>; Wed, 17 Jun 2020 18:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E76217D9
	for <linux-media@archiver.kernel.org>; Wed, 17 Jun 2020 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592419959;
	bh=i+KcznjcHmFJXCMts75e4liweyEkr+LWYq1E5sBldjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HBRgl3HS7AoM7ed3Q6rGUkFeWwI8+YhaS5AK9722J4/LPulzmG/OzJTB+tAKAVRHj
	 kdcvoJc1+RsOmWo1+APgjfS03KGwerrdNYTcbFp6bwxlqbCFDCy1q4h1MscX+c6qse
	 c1nzjqQLr9un+1/gv0uw6Mq1Iuta+ptMtni/gvxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgFQSwU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgFQSwT (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Jun 2020 14:52:19 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C65D21532;
        Wed, 17 Jun 2020 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592419938;
        bh=i+KcznjcHmFJXCMts75e4liweyEkr+LWYq1E5sBldjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8x3VHksnMc+dVcBrz+GahrAmkWlsXQ1Le2LfObX/8lArJAAg3fukisN3Ck389ahO
         MA2xNEyDPaXO0J72l9tEm5XtpJBWd7hbHLGmuDb4B78ppAQ759UMVzNssAZfFEabeq
         sbAyg6qXNI3SiHKnxFu17/+jFpBJw1c4qbtlBqGc=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jldAV-00C8Al-Vq; Wed, 17 Jun 2020 20:52:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Brad Love <brad@nextdimension.cc>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/4] media: atomisp: fix help message for ISP2401 selection
Date:   Wed, 17 Jun 2020 20:52:12 +0200
Message-Id: <52b8bb5c7ebf039b4b7f72f250cbe897a0671b34.1592419750.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592419750.git.mchehab+huawei@kernel.org>
References: <cover.1592419750.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

I'm pretty sure I named this right, but it sounds that I ended
doing something weird maybe while solving some conflict.

So, fix the title of this config var.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
index fea06cb0eb48..37577bb72998 100644
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -22,7 +22,7 @@ config VIDEO_ATOMISP
 	  module will be called atomisp
 
 config VIDEO_ATOMISP_ISP2401
-	bool "VIDEO_ATOMISP_ISP2401"
+	bool "Use Intel Atom ISP on Cherrytail/Anniedale (ISP2401)"
 	depends on VIDEO_ATOMISP
 	help
 	  Enable support for Atom ISP2401-based boards.
-- 
2.26.2

