Return-Path: <SRS0=4kUN=CX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21781C2BC11
	for <linux-media@archiver.kernel.org>; Mon, 14 Sep 2020 09:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB62121741
	for <linux-media@archiver.kernel.org>; Mon, 14 Sep 2020 09:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600074250;
	bh=h332aqwhjT3i19kg1+fjgVYyFutF+KieRzVuzn/JuFU=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=WdLBTKvywNggnAR/0rR/G88sx6y5r5M2tUnT97IxlmLSMWkQo7vUi7VMLIF9pVO5X
	 LGSITqLR6bdldjp8aqhpVQSnBxknduAdkTJUE38nRKMqdsN2Mey+J7vF1hIlluTFYE
	 cYABnPs0SBTpBZpfH6AJ9KzVSl5OWcUvN3g33usg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgINJEJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Sep 2020 05:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgINJDg (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Sep 2020 05:03:36 -0400
Received: from mail.kernel.org (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46EB42222B;
        Mon, 14 Sep 2020 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600074212;
        bh=h332aqwhjT3i19kg1+fjgVYyFutF+KieRzVuzn/JuFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJNuBwXEdwsQ4tFr075Djr+gb9yIUXUxZZGvoT1v3j/7+prjzQxMTVzMYWne7Z9C8
         5s7wgu+e4JsYzoR1SM92YbxKny8AAol5IBenEnsV0Vjy67h/YG+sMsWHcP7FRumaeC
         eRK9U6gKTmigAJd3VoAXoTKsqyNkOIL6DYb5Kp9s=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kHkOV-002dzR-T5; Mon, 14 Sep 2020 11:03:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH RFC 01/11] media: vidtv: add modaliases for the bridge driver
Date:   Mon, 14 Sep 2020 11:03:16 +0200
Message-Id: <84d83d54ea230c27cdba521fb2f1d916571512f8.1600073975.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600073975.git.mchehab+huawei@kernel.org>
References: <cover.1600073975.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As this virtual driver is probed manually, add modaliases
for this driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_bridge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index 82e375048b99..9f0e53e9fe69 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -530,3 +530,5 @@ module_exit(vidtv_bridge_exit);
 MODULE_DESCRIPTION("Virtual Digital TV Test Driver");
 MODULE_AUTHOR("Daniel W. S. Almeida");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("vidtv");
+MODULE_ALIAS("dvb_vidtv");
-- 
2.26.2

