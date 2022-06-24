Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23AAC433EF
	for <linux-media@archiver.kernel.org>; Fri, 24 Jun 2022 01:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiFXBtT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 23 Jun 2022 21:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXBtS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 23 Jun 2022 21:49:18 -0400
X-Greylist: delayed 126 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Jun 2022 18:49:17 PDT
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78FE4F446
        for <linux-media@vger.kernel.org>; Thu, 23 Jun 2022 18:49:17 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id SXT00008;
        Fri, 24 Jun 2022 09:47:08 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2308.27; Fri, 24 Jun 2022 09:47:08 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] ovl: Modify the section of Return Value
Date:   Thu, 23 Jun 2022 21:47:07 -0400
Message-ID: <20220624014707.2057-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2022624094708aa64e8432438a3da5e1286aae8e3b087
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Delete duplicate words of "the".

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 Documentation/userspace-api/media/dvb/frontend_f_open.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/dvb/frontend_f_open.rst b/Documentation/userspace-api/media/dvb/frontend_f_open.rst
index bb37eded0870..70e169b8f601 100644
--- a/Documentation/userspace-api/media/dvb/frontend_f_open.rst
+++ b/Documentation/userspace-api/media/dvb/frontend_f_open.rst
@@ -91,7 +91,7 @@ appropriately.
        -  The caller has no permission to access the device.
 
     -  - ``EBUSY``
-       -  The the device driver is already in use.
+       -  The device driver is already in use.
 
     -  - ``EMFILE``
        -  The process already has the maximum number of files open.
-- 
2.27.0

