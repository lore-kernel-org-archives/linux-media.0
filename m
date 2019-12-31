Return-Path: <SRS0=JS7/=2V=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A73C2D0C2
	for <linux-media@archiver.kernel.org>; Tue, 31 Dec 2019 18:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633F620718
	for <linux-media@archiver.kernel.org>; Tue, 31 Dec 2019 18:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLaSfl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 31 Dec 2019 13:35:41 -0500
Received: from gofer.mess.org ([88.97.38.141]:36807 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfLaSfl (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 31 Dec 2019 13:35:41 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id A3C8A11A001; Tue, 31 Dec 2019 18:35:40 +0000 (GMT)
Date:   Tue, 31 Dec 2019 18:35:40 +0000
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     Andrew Thornton <art27@cantab.net>
Subject: [PATCH v4l-utils] lircd2toml: warn when scancode has duplicate
 definitions
Message-ID: <20191231183540.GB10946@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In lircd.conf files, it is possible that the same scancode has multiple
key definitions. In our rc keymap toml format, one scancode can only
have one key definition.

Possibly we should allow alternate names for scancode for transmitting;
however, as a first step, we should warn if there are multiple
definitions for the same scancode.

Signed-off-by: Sean Young <sean@mess.org>
---
 contrib/lircd2toml.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/lircd2toml.py b/contrib/lircd2toml.py
index 54ea12fc..ba4b14ec 100755
--- a/contrib/lircd2toml.py
+++ b/contrib/lircd2toml.py
@@ -131,7 +131,11 @@ class LircdParser:
             for s in a:
                 if s[0] == '#':
                     break
-                codes[int(s, 0)] = k
+                scancode = int(s, 0)
+                if scancode in codes:
+                    self.warning("scancode 0x{:x} has duplicate definition {} and {}".format(scancode, codes[scancode], k))
+
+                codes[scancode] = k
 
     def read_raw_codes(self):
         raw_codes = []
-- 
2.24.1

