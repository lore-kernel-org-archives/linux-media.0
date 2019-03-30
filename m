Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F29C43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 13:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE7D218A6
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553953768;
	bh=HtkiZX4oCE20NAU6dIvsA44vRUR6Xa/+eZsfAGDy6B8=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=ofmeZtoZnVbdX3gpS+XSY5GnNipJO2sUUhPZg3ifrBT30GaTyP6BXguyGNBaWpAgY
	 KwD5MxPTC1oRo4ZmcqlFALsk3Ab0Duea3U43DshJBD1KEvaBDmAakBsBORIYhuuk7X
	 jbTB1PBV4kEISHe46xgbnqfYtJ1mPmb+h09Qu6CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbfC3Nt2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 09:49:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfC3Nt1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 09:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iSyWmDhVrzdC8ssmOyTT1/oJoKmEQk44Edj7/c0ANDE=; b=EsIjxjC8E6uRgGA0zR/xrBV/Z
        /CbY1SiGJXIHRv810cUigMxru5cpyHY7KnMN0Cg+QxrnYVtwH3XENI6PTD9o3iCTY8llVzRtw/lOF
        3sEWIWlXQKP/qn8dd3UvTYrb8LlG7pxN1vhf4RY+ACUdlrlqPY/DznMCxejJ9yqs+mo5I0t0tGQ47
        6XWxFjG6ztBdOGXRWG+EpI3xFlxQ8TqVUIK0RDplt6zGyZnC0mq2Mxe69I829738yusS34ZGlT9Lm
        5siVtAxg9A6qqQZJ2kv02xh3jGxqb+KoU0CKSrvyIZn8r92Izp3vZRafJ8er5xQKwY514SekRghvv
        PK1VMYJqw==;
Received: from [179.95.36.211] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAEMR-00041W-El; Sat, 30 Mar 2019 13:49:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hAEMP-0008Lb-Cx; Sat, 30 Mar 2019 09:49:25 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH] media: index.rst: exclude Indexes section from latex/pdf output
Date:   Sat, 30 Mar 2019 09:49:24 -0400
Message-Id: <1c3ec30bb23023d738b538e64ac3028902d53692.1553953762.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

With LaTex, the Index at the end will always be present. Having
an extra chapter for it there will just add extra noise to the
document.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/media/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/media/index.rst b/Documentation/media/index.rst
index 0a222fc1d7ca..0301c25ff887 100644
--- a/Documentation/media/index.rst
+++ b/Documentation/media/index.rst
@@ -18,7 +18,7 @@ Linux Media Subsystem Documentation
    v4l-drivers/index
    cec-drivers/index
 
-.. only::  subproject
+.. only:: html and subproject
 
    Indices
    =======
-- 
2.20.1

