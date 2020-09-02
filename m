Return-Path: <SRS0=Cf27=CL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D3C433E7
	for <linux-media@archiver.kernel.org>; Wed,  2 Sep 2020 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE97207EA
	for <linux-media@archiver.kernel.org>; Wed,  2 Sep 2020 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599063076;
	bh=9dhD+Wjohk46Ke51HQQMWLMkqd0e9PqJih4Q6OfTONc=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=fO98QDuoALyM9xGxnKtVBmbwnhQE9a+RDdfJVjmLW/8XNlkWfWkp/yhTWzmRV9ZDr
	 Z5Cy8tXqmHi5YQJABt1OfgR4dlAFjaPKnR4AFblUl+NfboXKsUiVtvzCYQcFV0Zvtc
	 6XIz6jEH3umLsj0gu+BjACsu8rkbgYh55LHSkgVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBQLM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbgIBQK4 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 2 Sep 2020 12:10:56 -0400
Received: from mail.kernel.org (ip5f5ad5c3.dynamic.kabel-deutschland.de [95.90.213.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9164E221E8;
        Wed,  2 Sep 2020 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599063046;
        bh=9dhD+Wjohk46Ke51HQQMWLMkqd0e9PqJih4Q6OfTONc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0VEbQoNKyc2Yz9vgdO8iQB/m3f1cvgbKN/GG6tSlHCa+1ucLPHyBu7SXJhxPS+ke
         G2yA/i8zGXE1gKJBhz5n59/tgjpWS8VOyNLEttP07h2JOEXy+cjR1SHV185qjv78+1
         Niujss0KYm2fmxGeZEDRjEQqhXwa1gYSrLlaYAwg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kDVLQ-000tBH-P7; Wed, 02 Sep 2020 18:10:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 34/38] media: atomisp: remove compile-time tests from input_system_global.h
Date:   Wed,  2 Sep 2020 18:10:37 +0200
Message-Id: <8154b39cf94a2aca6dfea194a63cc5acc3e0c2d1.1599062230.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599062230.git.mchehab+huawei@kernel.org>
References: <cover.1599062230.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Now that there's no duplication between ISP2400 and ISP2401
input system functions, we can include both at the system
global.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/input_system_global.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/input_system_global.h b/drivers/staging/media/atomisp/pci/input_system_global.h
index 5929d529950b..1450964445f6 100644
--- a/drivers/staging/media/atomisp/pci/input_system_global.h
+++ b/drivers/staging/media/atomisp/pci/input_system_global.h
@@ -24,10 +24,7 @@ typedef enum {
 	INPUT_SYSTEM_ERR_PARAMETER_NOT_SUPPORTED,
 } input_system_err_t;
 
-#ifdef ISP2401
-#  include "isp2401_input_system_global.h"
-#else
-#  include "isp2400_input_system_global.h"
-#endif
+#include "isp2401_input_system_global.h"
+#include "isp2400_input_system_global.h"
 
 #endif /* __INPUT_SYSTEM_GLOBAL_H_INCLUDED__ */
-- 
2.26.2

