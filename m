Return-Path: <SRS0=KtNH=5L=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5503C43331
	for <linux-media@archiver.kernel.org>; Thu, 26 Mar 2020 15:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6412145D
	for <linux-media@archiver.kernel.org>; Thu, 26 Mar 2020 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585236096;
	bh=jaXOoxsB9V3Ec73tf4/uNSABbYjfXiMokiDK1af+5RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qC4CdTJckSPY/cRIe8Bf3jwFxaUnLtA/7xQlns7Y4eYsjK5ZgollDpUIQIZ5GpxXK
	 StIMwv/Jd6T/QIzLJ4mATny6nA6+iQB5WZzHhFuz2/GJUzXhygn7vL1fD+UxRyBtH5
	 drfoRRcrEaehSiw8/MJ+ZWSLTVGNshgTOnn2KNMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgCZPVg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbgCZPVf (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Mar 2020 11:21:35 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F4C420774;
        Thu, 26 Mar 2020 15:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585236095;
        bh=jaXOoxsB9V3Ec73tf4/uNSABbYjfXiMokiDK1af+5RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdBCEeMtpTHXgMMjSbeMbG1bY97FLVQ0YPL0INtYfepu45ReqnHAkChqh8CPc7obN
         UOYGwVc/YtYithXQ53b5MHvDeBs1kK2hdCDIb53uJvf3ydSEcvEcF4I6kZn+aHmsxO
         Xhd2JwqVhsQH0Ux9lsxMU07avY/bEDYni5z5AGjM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jHUK5-003die-LT; Thu, 26 Mar 2020 16:21:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH 1/7] media: Kconfig: warn if drivers are filtered
Date:   Thu, 26 Mar 2020 16:21:26 +0100
Message-Id: <f1f670a19be82d195dabf2736eafcc791f4b29c3.1585235736.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585235736.git.mchehab+huawei@kernel.org>
References: <cover.1585235736.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As per a tester feedback, add an option to report when
the drivers are filtered at the Kconfig menu.

Cc: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index e880c7fae664..bb8148f2d4c0 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -19,7 +19,7 @@ menuconfig MEDIA_SUPPORT
 if MEDIA_SUPPORT
 
 config MEDIA_SUPPORT_FILTER
-	bool "Filter devices by their types"
+	bool "Filter media drivers"
 	depends on MEDIA_SUPPORT
 	default y if !EMBEDDED && !EXPERT
 	help
@@ -213,6 +213,9 @@ menu "HDMI CEC options"
 source "drivers/media/cec/Kconfig"
 endmenu
 
+comment "Drivers filtered as selected at 'Filter media drivers'"
+	depends on MEDIA_SUPPORT_FILTER
+
 menu "Media drivers"
 
 source "drivers/media/usb/Kconfig"
-- 
2.25.1

