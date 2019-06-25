Return-Path: <SRS0=f2lN=UY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC26C48BD5
	for <linux-media@archiver.kernel.org>; Tue, 25 Jun 2019 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B52208CA
	for <linux-media@archiver.kernel.org>; Tue, 25 Jun 2019 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561469377;
	bh=4wFVsU2DxSOH0P6KByfdUscQMMiAECoSsph8ttXErEk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kKB3tz8l4Vayvbe3/glnlv6ODnbw40Qq0RTum2HXYE7duUH4aQDIcD26gkwcw1jxN
	 OB0S1M34sYj4R7HA38PMspD+JUkL2s8XzvngrsidLVSHBOLFDsElT/v9DrUQFjtIIB
	 q3LeIdKVJXTX67RI3w/R96YkdUaLa3mFgmbXRNSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfFYN3h (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:29:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfFYN3h (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 25 Jun 2019 09:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9k+mVU6LNBtQ9tm2F57T/9S4d+T+Ih3heCxPZ7EQYb4=; b=HpmcgKhl3XxNdFT6Ri8smpVmr
        EU2LTTbYPut44Joz1ViYfaqSyxRT5qn/I5I3h1mOOz7uQQTNMitWjQ3okwApItDuS/KvjdPC0B3/U
        yikPnzGHy4s8IfZbcjjzp3faQ9KBubXpmuytSQsT8Wdd6+pVLsIax5uRT7W0KeAWCPrCBLGntot73
        ziA33OAwvNgGSqpIN2N+XK/jQE0msedb2HJmkn6/o3NrT6iHTuR6mHUATSpdjKjUCHNiKddtudpHS
        F93FknWzJA2M4JFYkygN0H5ZkjzTCPoDmJDhOXOg78HTUREW/5K9pSshuXCmGIZ+qFGc1h0RukNfo
        jNkwMlO5w==;
Received: from 177.205.71.220.dynamic.adsl.gvt.net.br ([177.205.71.220] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hflVw-0000ZO-Jo; Tue, 25 Jun 2019 13:29:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hflVs-0007kJ-Pw; Tue, 25 Jun 2019 10:29:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Joe Perches <joe@perches.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] MAINTAINERS: mark soc_camera as Orphan/Obsolete
Date:   Tue, 25 Jun 2019 10:29:31 -0300
Message-Id: <0a378212a291ed769f4004ccf162527c411d8a97.1561469369.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The soc_camera is obsolete, and it is in process of being
stripped out of the Linux Kernel

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 866969b36a13..a673c1e78121 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14565,7 +14565,7 @@ F:	drivers/net/ethernet/smsc/smsc9420.*
 SOC-CAMERA V4L2 SUBSYSTEM
 L:	linux-media@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
-S:	Orphan
+S:	Orphan / Obsolete
 F:	include/media/soc_camera.h
 F:	drivers/staging/media/soc_camera/
 
-- 
2.21.0

