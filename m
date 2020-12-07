Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE49CC433FE
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 19:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691C7238E1
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgLGTkQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGTkQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 7 Dec 2020 14:40:16 -0500
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C077C061794
        for <linux-media@vger.kernel.org>; Mon,  7 Dec 2020 11:39:36 -0800 (PST)
Received: from cipterm0.informatik.uni-erlangen.de (cipterm0.cip.cs.fau.de [IPv6:2001:638:a000:4130:131:188:30:90])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id B05F8240BD5
        for <linux-media@vger.kernel.org>; Mon,  7 Dec 2020 20:39:34 +0100 (CET)
Received: by cipterm0.informatik.uni-erlangen.de (Postfix, from userid 67858)
        id DEB773280304; Mon,  7 Dec 2020 20:30:39 +0100 (CET)
From:   Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org,
        ij72uhux@stud.informatik.uni-erlangen.de, linux-kernel@i4.cs.fau.de
Subject: [PATCH 12/12] media: atomisp: Fix LOGICAL_CONTINUATIONS
Date:   Mon,  7 Dec 2020 20:26:39 +0100
Message-Id: <20201207192638.15219-13-Philipp.Gerlesberger@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201207192638.15219-1-Philipp.Gerlesberger@fau.de>
References: <20201207192638.15219-1-Philipp.Gerlesberger@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Logical continuations should be on the previous line

Co-developed-by: Andrey Khlopkov <ij72uhux@stud.informatik.uni-erlangen.de>
Signed-off-by: Andrey Khlopkov <ij72uhux@stud.informatik.uni-erlangen.de>
Signed-off-by: Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>
---
 drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c b/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c
index 2f1c2df59f71..7d44070c7114 100644
--- a/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c
+++ b/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c
@@ -24,8 +24,8 @@
  *****************************************************************************/
 int ia_css_queue_local_init(ia_css_queue_t *qhandle, ia_css_queue_local_t *desc)
 {
-	if (NULL == qhandle || NULL == desc
-	    || NULL == desc->cb_elems || NULL == desc->cb_desc) {
+	if (NULL == qhandle || NULL == desc ||
+	    NULL == desc->cb_elems || NULL == desc->cb_desc) {
 		/* Invalid parameters, return error*/
 		return -EINVAL;
 	}
-- 
2.20.1

