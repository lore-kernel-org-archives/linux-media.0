Return-Path: <SRS0=WnEk=WS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50971C3A5A1
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 19:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEEE23404
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 19:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566502782;
	bh=/fBE5dJY522R/VsqlV1fmQnnItqbJ1M3pIviRhRb9Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LUiXQ7LWLYBZfVdyW73nw5g4qMiA36IrwkHzR1bbS8+jQltM0R0R9WfT3QnMkO0ma
	 EL74/97bBsUF6wt0NuvQhKl1i/5wjJ4Kb24ofCbZ2TdX9XRLb0GaKVPGjAfdZMXACK
	 oDEHskpatQldFzL/tmjvQmnVhhTW1N4divC5PwjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390447AbfHVTjl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:39:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbfHVTjk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 22 Aug 2019 15:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LI0giQyXKlJYUsm6Oe8BstHkrhYsyBvRHUhzPolmrYg=; b=TWGhHWnZ9SBAItNektQ6pwyZUC
        AsvvjR+kOdKXPlGUeH8SuJIa+Sb8mcB7/9Cl13nSTHzyoKzIdhXuo8WxQBN2Zz3d6ce9KdT4eR2vw
        +73NC9aigOb1v+JidH/Pf3PRth+5/ndBQ5ZR+fWwEu+aXTq2aF9mO2w5JyelrEcjgVWcgQSMPXVk9
        90/Riab1RgE47olyRx4JGtC8wTyK38cW2SWpZG29PiY87HA58ADR6hke226ZN8oPp8s60kud84XmX
        eMqEQwtyIDqbVFqKUdbJc1mph1FEcAXyBYp3kS0T0rkWmrO2BJkFACN1xwQocvayRbT6tJmrFfUnn
        jHMH+S1g==;
Received: from [177.133.63.56] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0svr-0002lY-LE; Thu, 22 Aug 2019 19:39:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i0svo-0007IR-GC; Thu, 22 Aug 2019 16:39:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 4/7] media: ov9650: add a sanity check
Date:   Thu, 22 Aug 2019 16:39:31 -0300
Message-Id: <2868a99c83f1cfef93058f7e49aefa4b104b644f.1566502743.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <4a411ba155eb062b6575aba0824123c840806c0b.1566502743.git.mchehab+samsung@kernel.org>
References: <4a411ba155eb062b6575aba0824123c840806c0b.1566502743.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As pointed by cppcheck:

	[drivers/media/i2c/ov9650.c:706]: (error) Shifting by a negative value is undefined behaviour
	[drivers/media/i2c/ov9650.c:707]: (error) Shifting by a negative value is undefined behaviour
	[drivers/media/i2c/ov9650.c:721]: (error) Shifting by a negative value is undefined behaviour

Prevent mangling with gains with invalid values

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/i2c/ov9650.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/ov9650.c b/drivers/media/i2c/ov9650.c
index 8b56011446a9..cb49fda902fd 100644
--- a/drivers/media/i2c/ov9650.c
+++ b/drivers/media/i2c/ov9650.c
@@ -703,6 +703,11 @@ static int ov965x_set_gain(struct ov965x *ov965x, int auto_gain)
 		for (m = 6; m >= 0; m--)
 			if (gain >= (1 << m) * 16)
 				break;
+
+		/* Sanity check: don't adjust the gain with a negative val */
+		if (m < 0)
+			return -EINVAL;
+
 		rgain = (gain - ((1 << m) * 16)) / (1 << m);
 		rgain |= (((1 << m) - 1) << 4);
 
-- 
2.21.0

