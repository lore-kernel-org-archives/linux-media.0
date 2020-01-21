Return-Path: <SRS0=XjDO=3K=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F3C2D0CE
	for <linux-media@archiver.kernel.org>; Tue, 21 Jan 2020 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E06021569
	for <linux-media@archiver.kernel.org>; Tue, 21 Jan 2020 16:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAUQwO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:52:14 -0500
Received: from gofer.mess.org ([88.97.38.141]:51785 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgAUQwN (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 21 Jan 2020 11:52:13 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id BA174C635E; Tue, 21 Jan 2020 16:52:12 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     Camden Lindsay <camden.lindsay+kernel@gmail.com>
Subject: [PATCH v4l-utils] keytable: keymap without protocol is invalid
Date:   Tue, 21 Jan 2020 16:52:12 +0000
Message-Id: <20200121165212.441-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Without a protocol, keymap cannot be loaded and causes a segfault.

Reported-by: Camden Lindsay <camden.lindsay+kernel@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
---
 utils/common/keymap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/utils/common/keymap.c b/utils/common/keymap.c
index d06deb59..6ca33745 100644
--- a/utils/common/keymap.c
+++ b/utils/common/keymap.c
@@ -169,6 +169,11 @@ static error_t parse_plain_keymap(char *fname, struct keymap **keymap, bool verb
 	}
 	fclose(fin);
 
+	if (!map->protocol) {
+		fprintf(stderr, _("Missing protocol in %s\n"), fname);
+		return EINVAL;
+	}
+
 	*keymap = map;
 
 	return 0;
-- 
2.24.1

