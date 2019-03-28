Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2B6C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF722184C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553798251;
	bh=/fW1d6xDy+ZF87MirTGV2EScepAwJ9W8ZZ2LAOxc3Fw=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=2qkneidLQQjOSZIkKpKbLWNDCupV3TMavAiPazcDLCAHHFqHehmx46ESR3kDWmU/T
	 v3CuWPWG8RhbmQ+H1TWFHXiQD0jlc2FvK5QZCAaBJURpY3w8T5IzVx3sgmBq/2X3Zi
	 6c3PHuq1M3qXd3rT+MyOayBZ8TS07UfJrnYx8xOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfC1Sha (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:37:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfC1Sha (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 14:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lPmDLxKg/uTMb2IH4189A+J6GZedGkJCwG4ugVxCwWU=; b=EkMYZpOE+lY2esJ75G4VUW132
        PvJHOHgPHBRhBARH4HQIaTFJrGAdC8lg0uDNmqb+Q0op6x0aHp6qxyfunF57w0Asg8iFPYnVSzPBK
        oLLrJyV2h5eC9ZIB0hIeVK7zaLxf/tFuH/3/3/LbIyH1H6kSu34pKsJ61si6GxBA4ML4VfUZ/xd9f
        bmxSFaYYcpm6tMz/t26ZpGUM0jf8JdRu8oNTwyzWO3QnGPARwvNXIqQaVe3DShvhVwx3TfSI0bckn
        AwMKgdvbqyDSQpsT8Wk3qXEmdfxE265RcfsgbcK8UXYWTCOjf3sfw90+DdqJG8R0svKQJu5lVzLou
        TTAg4fX5w==;
Received: from [179.183.99.176] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9Zu5-0003Bo-Qx; Thu, 28 Mar 2019 18:37:29 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1h9Ztz-00025c-Fv; Thu, 28 Mar 2019 14:37:23 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Max Kellermann <max.kellermann@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH] media: dvbdev: remove double-unlock
Date:   Thu, 28 Mar 2019 14:37:22 -0400
Message-Id: <122d0e8dd050cc5dc3fb9e9b5f2dee3c5276ce35.1553798238.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As warned by smatch:
	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:529 dvb_register_device() error: double unlock 'sem:&minor_rwsem'

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 4a5834a1c3b7..a3393cd4e584 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -526,7 +526,6 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		kfree(dvbdevfops);
 		kfree(dvbdev);
-		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
-- 
2.20.1

