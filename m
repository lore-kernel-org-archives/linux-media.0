Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E81AC1B0D8
	for <linux-media@archiver.kernel.org>; Mon, 14 Dec 2020 11:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69675229C6
	for <linux-media@archiver.kernel.org>; Mon, 14 Dec 2020 11:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbgLNLLe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Dec 2020 06:11:34 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:36556 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729479AbgLNLLV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Dec 2020 06:11:21 -0500
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2020 06:11:06 EST
Received: from cipterm0.informatik.uni-erlangen.de (cipterm0.cip.cs.fau.de [IPv6:2001:638:a000:4130:131:188:30:90])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 7D615240B55;
        Mon, 14 Dec 2020 12:10:20 +0100 (CET)
Received: by cipterm0.informatik.uni-erlangen.de (Postfix, from userid 67858)
        id D1D893280440; Mon, 14 Dec 2020 12:05:05 +0100 (CET)
From:   Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>,
        ij72uhux@stud.informatik.uni-erlangen.de,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@i4.cs.fau.de, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, mchehab@kernel.org
Subject: [PATCH v2 09/12] media: atomisp: Fix PARENTHESIS_ALIGNMENT
Date:   Mon, 14 Dec 2020 12:03:55 +0100
Message-Id: <20201214110358.7102-10-Philipp.Gerlesberger@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

You can sum up the two lines, because the maximum line length of
100 columns is not exceeded.

Co-developed-by: Andrey Khlopkov <ij72uhux@stud.informatik.uni-erlangen.de>
Signed-off-by: Andrey Khlopkov <ij72uhux@stud.informatik.uni-erlangen.de>
Signed-off-by: Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>
---
 drivers/staging/media/atomisp/pci/runtime/spctrl/src/spctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/spctrl/src/spctrl.c b/drivers/staging/media/atomisp/pci/runtime/spctrl/src/spctrl.c
index 753a99703f1e..38f86764ccfc 100644
--- a/drivers/staging/media/atomisp/pci/runtime/spctrl/src/spctrl.c
+++ b/drivers/staging/media/atomisp/pci/runtime/spctrl/src/spctrl.c
@@ -37,8 +37,7 @@ static struct spctrl_context_info spctrl_cofig_info[N_SP_ID];
 static bool spctrl_loaded[N_SP_ID] = {0};
 
 /* Load firmware */
-int ia_css_spctrl_load_fw(sp_ID_t sp_id,
-				      ia_css_spctrl_cfg *spctrl_cfg)
+int ia_css_spctrl_load_fw(sp_ID_t sp_id, ia_css_spctrl_cfg *spctrl_cfg)
 {
 	ia_css_ptr code_addr = mmgr_NULL;
 	struct ia_css_sp_init_dmem_cfg *init_dmem_cfg;
-- 
2.20.1

