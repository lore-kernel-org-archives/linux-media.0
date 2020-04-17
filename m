Return-Path: <SRS0=fNsq=6B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CB6C2D0EF
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 16:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5035322243
	for <linux-media@archiver.kernel.org>; Fri, 17 Apr 2020 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587142741;
	bh=oU9vHFsJgKh2goYQCM4HsG47VtXKYTeS6/Dj+CidDT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PJ/+FsRP8N2o2RtAHIr2lnGqSlx1L4EDfLf2wumuqO/I4bFpfTiCo9LbPSf5g5FFK
	 dPAc/0tcT/uopW+7JaUj/qZf/hh0ttvxgMxuPAyS35kg108s5gX2yy9hmfBYFD50ej
	 WNbYTEJ1yAUnLTJeeUyys63aSTtXNt+/f2ZgL1jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgDQQ7A (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgDQQ7A (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 17 Apr 2020 12:59:00 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73B322202;
        Fri, 17 Apr 2020 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587142740;
        bh=oU9vHFsJgKh2goYQCM4HsG47VtXKYTeS6/Dj+CidDT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLisvGYvPZB3mOVLafQ4uBIHSCCkGIdNOfZ+5uTOpjSHzSILe2boJ/kHsN1iD07eP
         D5+99oYfb1Y3WukbLwx+785f7EqvuW2c6Vf3HaF3dkICrOuz5P4mQ1E3rNWZax6Zag
         iqK5yFBbxaDkrDtxz/ThQQ9fCTVBv9brxp/YxjjM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jPUKP-007wLX-5D; Fri, 17 Apr 2020 18:58:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 06/15] media: admin-guide: update em28xx cardlist
Date:   Fri, 17 Apr 2020 18:58:47 +0200
Message-Id: <a2becbab596bb60f04540fe1b621e517bd6c64b3.1587142382.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587142382.git.mchehab+huawei@kernel.org>
References: <cover.1587142382.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

A new em28xx card was added upstream. Update cards list
accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/media/em28xx-cardlist.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/media/em28xx-cardlist.rst b/Documentation/admin-guide/media/em28xx-cardlist.rst
index cb2e693a56a2..a5f0e6d22a1a 100644
--- a/Documentation/admin-guide/media/em28xx-cardlist.rst
+++ b/Documentation/admin-guide/media/em28xx-cardlist.rst
@@ -430,3 +430,7 @@ EM28xx cards list
      - Magix USB Videowandler-2
      - em2861
      - 1b80:e349
+   * - 104
+     - PCTV DVB-S2 Stick (461e v2)
+     - em28178
+     - 2013:0461, 2013:0259
-- 
2.25.2

