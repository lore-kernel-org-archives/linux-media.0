Return-Path: <SRS0=ILh3=DN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D0CC4727E
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 07:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B4720853
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 07:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="YUOC+nOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgJFHaN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 6 Oct 2020 03:30:13 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:57787 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726875AbgJFHaM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 6 Oct 2020 03:30:12 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id PhQEkHAOjv4gEPhQIkvAjO; Tue, 06 Oct 2020 09:30:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1601969410; bh=kwLD43K+JoahSCNFJTRi6J9gL0JFO9wJRUwCzB7VxRU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=YUOC+nORI+YDDazbAilWVqFey7Sd6qmENch1mzCA81mkpomsJyU/nHoj7e1qL1Wws
         kxgfhnrOFWg1vb2zzzKV2oD3VikRQyAJzG725aYqWzlWhs9dyUh1zMTmYmS2Qqfwzg
         TRpElIUCX5mtB4fuC+M28GxBPs+jqmvOFWg/mHJGo7EhAl3W/Th5c/2NJMi0SBer+P
         leGOFcRhMeXLYnBblLKIH3pYM4llgm1ASysen6q03FFU70Ous31UYjV/5rFicpjNYo
         0TRy0CRKMI9SYdijz4h5rGEYNrC7tJIm8KmcyJgnrC17APhA45B0tCIRW0TIcscnky
         8pmqmH3GMazJg==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 2/3] dvb-frontends/drxk_hard.c: fix uninitialized variable warning
Date:   Tue,  6 Oct 2020 09:30:05 +0200
Message-Id: <20201006073006.2315225-3-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006073006.2315225-1-hverkuil-cisco@xs4all.nl>
References: <20201006073006.2315225-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJ4GUOsLW1ZWlftxlFx5SVBWtEGjnen6WLhR+/T5rA7Gsgn1FgsGRqBtt7exQED2Y5jUcCUEe1DzO+CWRD9eQoYqB0QOivRnv0lsM5cYCoc/zWNKkmMW
 ESlClNCNU3pj5npsG9iv/NdLSt0UUsxSQNUVMKxy6aI0WYq0My9ayQ2TU0P5PsNlGDx54PFnc37305Ge1DOeKDzW4eM3RSkE04IS6sGOpRXEhIzePUd61LAV
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

drxk_hard.c: In function 'hi_command.constprop':
drxk_hard.c:1016:5: warning: 'wait_cmd' may be used uninitialized in this function [-Wmaybe-uninitialized]
 1015 |   } while ((status < 0) && (retry_count < DRXK_MAX_RETRIES)
      |            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1016 |     && (wait_cmd != 0));
      |     ^~~~~~~~~~~~~~~~~~

Just initialize wait_cmd to 0.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/dvb-frontends/drxk_hard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 32f9346deb3e..37882bc587f9 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -1004,7 +1004,7 @@ static int hi_command(struct drxk_state *state, u16 cmd, u16 *p_result)
 	if (!powerdown_cmd) {
 		/* Wait until command rdy */
 		u32 retry_count = 0;
-		u16 wait_cmd;
+		u16 wait_cmd = 0;
 
 		do {
 			usleep_range(1000, 2000);
-- 
2.28.0

