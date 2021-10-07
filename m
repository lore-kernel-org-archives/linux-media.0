Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CDC433F5
	for <linux-media@archiver.kernel.org>; Thu,  7 Oct 2021 11:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488D961139
	for <linux-media@archiver.kernel.org>; Thu,  7 Oct 2021 11:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbhJGLdG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240939AbhJGLdG (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 7 Oct 2021 07:33:06 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAA3C061746
        for <linux-media@vger.kernel.org>; Thu,  7 Oct 2021 04:31:12 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 53CCAC6342; Thu,  7 Oct 2021 12:31:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1633606271; bh=Inm4kN/yTJcgieVvcT09O2zipXO0w3e6JTE6y3Xx99k=;
        h=From:To:Subject:Date:From;
        b=PCwZnVaiJrfCNyVrD0xpmc/6UdRx/mm7eC0XKPeevLJPZxb5A3aIvchGbdTvmcAOQ
         5X+7xNPBf62kRD6Ky0a8BTr4oMdWHEaoPDwKM9hvb/eBHmKQARmDl0hRvUYe583v9O
         ovMQrBBapd2cUOwiofUKtU7uzCFfFlswbY5oXbXB3i89SGLJRNine3H0EZKowRxRoj
         dtWAV1abAMG7t1eyJ4f1LBHVaXSedaSdvQk8Mrw2sNMcENRN6ruiP38RsKv1hYMz4k
         H+opG8OS2uuCDpZGNV4T8y+ETRgPjNON2Av/l/qBQJesljKuVNlFgNkqiOs2LWsaC/
         CwGiyqb9madFg==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH] media: remove myself from dvb media maintainers
Date:   Thu,  7 Oct 2021 12:31:11 +0100
Message-Id: <20211007113111.12021-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

I have not been able to give dvb the attention it needs, and now I have
even less time. Of course I will continue to maintain rc-core (infrared).

Unfortunately this means that dvb is unmaintained.

Signed-off-by: Sean Young <sean@mess.org>
---
 Documentation/driver-api/media/maintainer-entry-profile.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/maintainer-entry-profile.rst b/Documentation/driver-api/media/maintainer-entry-profile.rst
index eb1cdfd280ba..ffc712a5f632 100644
--- a/Documentation/driver-api/media/maintainer-entry-profile.rst
+++ b/Documentation/driver-api/media/maintainer-entry-profile.rst
@@ -71,7 +71,7 @@ media maintainers do the review.
 
 The media maintainers that work on specific areas of the subsystem are:
 
-- Digital TV and remote controllers:
+- Remote Controllers (infrared):
     Sean Young <sean@mess.org>
 
 - HDMI CEC:
-- 
2.31.1

