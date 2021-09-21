Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F114C433EF
	for <linux-media@archiver.kernel.org>; Tue, 21 Sep 2021 22:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096FE61019
	for <linux-media@archiver.kernel.org>; Tue, 21 Sep 2021 22:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhIUWML (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhIUWMK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 21 Sep 2021 18:12:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B05C061574;
        Tue, 21 Sep 2021 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=v9xs1pYnvq2mMhHNuk00kIzDTAiGnzqh/c77kIT9Xwo=; b=IuB0pESrmsLN+qF56rKwzt+fTj
        MjAkC6L5Plz6ts38t5SkUqZmZyy/0099PNFEi9rmrroQmmPVvtB454rmu7pQls1eRb5UESbtRIihW
        FlJQYa8z8fr0RbDSk/suhcIO5i7oPPHGJLGr8U4XO/KVMNw2e1vb7YTtOyMan1HJnvwQpRNhTFaKt
        RiIJ4CnXVxyEJhsKXJTJDDDpZUBD8DPAGGcRZGgF2B+0Jn/cIYGQZeXsfE3Kb4XXbjMTdfwlUAAj8
        uNd4luTQFzKAGOCy1melNP7t7HN07hGqRN6H5rhtJMbWJCOHMuLFf3cwl0GmSDER8LSrNsNDh22vM
        wtcnHOrQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSnyL-00695J-67; Tue, 21 Sep 2021 22:10:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Sean Young <sean@mess.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2] media: CEC: keep related menu entries together
Date:   Tue, 21 Sep 2021 15:10:40 -0700
Message-Id: <20210921221040.14515-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Keep all of the CEC menu items grouped together.
By grouping all of these menu entries inside a menu/endmenu block,
they are forced to be kept together and they are displayed/presented
in a group for users.

Tested with xconfig, gconfig, menuconfig, and nconfig.

Fixes: 46d2a3b964dd ("media: place CEC menu before MEDIA_SUPPORT")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sean Young <sean@mess.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
v2: use CEC support menu as suggested by Hans Verkuil

 drivers/media/cec/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20210921.orig/drivers/media/cec/Kconfig
+++ linux-next-20210921/drivers/media/cec/Kconfig
@@ -8,6 +8,8 @@ config CEC_NOTIFIER
 config CEC_PIN
 	bool
 
+menu "CEC support"
+
 config MEDIA_CEC_RC
 	bool "HDMI CEC RC integration"
 	depends on CEC_CORE && RC_CORE
@@ -37,3 +39,5 @@ source "drivers/media/cec/i2c/Kconfig"
 source "drivers/media/cec/platform/Kconfig"
 source "drivers/media/cec/usb/Kconfig"
 endif
+
+endmenu
