Return-Path: <SRS0=iZ/e=73=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FD6C433E0
	for <linux-media@archiver.kernel.org>; Sun, 14 Jun 2020 12:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB6920747
	for <linux-media@archiver.kernel.org>; Sun, 14 Jun 2020 12:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgFNMIw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNMIw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jun 2020 08:08:52 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B4C05BD43
        for <linux-media@vger.kernel.org>; Sun, 14 Jun 2020 05:08:52 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 72BE4C637E; Sun, 14 Jun 2020 13:08:48 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH v4l-utils] lircd2toml: add option to keep lirc codes as they are
Date:   Sun, 14 Jun 2020 13:08:48 +0100
Message-Id: <20200614120848.26428-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When keymaps are only used for sending, they do not have to look like
KEY_*. Keeping the existing lirc names might be preferable.

Signed-off-by: Sean Young <sean@mess.org>
---
 contrib/lircd2toml.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/lircd2toml.py b/contrib/lircd2toml.py
index ba4b14ec..897ad765 100755
--- a/contrib/lircd2toml.py
+++ b/contrib/lircd2toml.py
@@ -13,10 +13,11 @@ import math
 import argparse
 
 class LircdParser:
-    def __init__(self, filename, encoding):
+    def __init__(self, filename, encoding, rename):
         self.lineno=0
         self.filename=filename
         self.encoding=encoding
+        self.rename=rename
 
     def getline(self):
         while True:
@@ -126,7 +127,7 @@ class LircdParser:
             k = a.pop(0)
             if k == 'end':
                 return codes
-            if not k.startswith('KEY_'):
+            if self.rename and not k.startswith('KEY_'):
                 k = 'KEY_' + k.upper()
             for s in a:
                 if s[0] == '#':
@@ -153,7 +154,7 @@ class LircdParser:
                 if codes:
                     raw_codes.append({ 'keycode': name, 'raw': codes })
                 name = line.split(maxsplit=2)[1]
-                if not name.startswith('KEY_'):
+                if self.rename and not name.startswith('KEY_'):
                     name = 'KEY_' + name.upper()
                 codes = []
             elif a[0] == 'end':
@@ -642,12 +643,14 @@ can be include with the package.""")
 parser.add_argument('input', metavar='INPUT', help='lircd.conf file')
 parser.add_argument('-o', '--output', metavar='OUTPUT', help='toml output file')
 parser.add_argument('--encoding', default='utf-8-sig', help='Encoding of lircd.conf')
+parser.add_argument('--preserve-codes', const=False, default=True,
+    dest='rename', action='store_const', help='Do not rename codes to KEY_*')
 
 args = parser.parse_args()
 
 remoteNo=1
 tomls=[]
-remotes=LircdParser(args.input, args.encoding).parse()
+remotes=LircdParser(args.input, args.encoding, args.rename).parse()
 if remotes == None:
     sys.exit(1)
 for remote in remotes:
-- 
2.26.2

