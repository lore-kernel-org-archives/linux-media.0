Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69595C71155
	for <linux-media@archiver.kernel.org>; Wed,  2 Dec 2020 07:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173B12224C
	for <linux-media@archiver.kernel.org>; Wed,  2 Dec 2020 07:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgLBHwQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgLBHwQ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 2 Dec 2020 02:52:16 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] media: vidtv: fix kernel-doc markups
Date:   Wed,  2 Dec 2020 08:51:28 +0100
Message-Id: <7d86a4c4aa112f87149ba4e247fcf8904153884c.1606895475.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Some functions has a different name between their prototypes
and the corresponding kernel-doc markups.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.h b/drivers/media/test-drivers/vidtv/vidtv_psi.h
index 340c9fb8d583..6651cc91bda1 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.h
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.h
@@ -420,7 +420,7 @@ void vidtv_psi_desc_assign(struct vidtv_psi_desc **to,
 			   struct vidtv_psi_desc *desc);
 
 /**
- * vidtv_psi_pmt_desc_assign - Assigns a descriptor loop at some point in a PMT section.
+ * vidtv_pmt_desc_assign - Assigns a descriptor loop at some point in a PMT section.
  * @pmt: The PMT section that will contain the descriptor loop
  * @to: Where in the PMT to assign this descriptor loop to
  * @desc: The descriptor loop that will be assigned.
@@ -434,7 +434,7 @@ void vidtv_pmt_desc_assign(struct vidtv_psi_table_pmt *pmt,
 			   struct vidtv_psi_desc *desc);
 
 /**
- * vidtv_psi_sdt_desc_assign - Assigns a descriptor loop at some point in a SDT.
+ * vidtv_sdt_desc_assign - Assigns a descriptor loop at some point in a SDT.
  * @sdt: The SDT that will contain the descriptor loop
  * @to: Where in the PMT to assign this descriptor loop to
  * @desc: The descriptor loop that will be assigned.
@@ -474,7 +474,7 @@ void vidtv_psi_pmt_stream_assign(struct vidtv_psi_table_pmt *pmt,
 struct vidtv_psi_desc *vidtv_psi_desc_clone(struct vidtv_psi_desc *desc);
 
 /**
- * vidtv_psi_create_sec_for_each_pat_entry - Create a PMT section for each
+ * vidtv_psi_pmt_create_sec_for_each_pat_entry - Create a PMT section for each
  * program found in the PAT
  * @pat: The PAT to look for programs.
  * @pcr_pid: packet ID for the PCR to be used for the program described in this
-- 
2.28.0

