Return-Path: <SRS0=nGM0=2A=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F15DC43603
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 22:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38FE208C3
	for <linux-media@archiver.kernel.org>; Tue, 10 Dec 2019 22:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576016033;
	bh=FOKD6FXWX6YBeDn+aiJmzV5MbF2npfo3geb+DF/JBBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UuYyNFwEPwTtj7KatxQ2o5mLKiQpDJNJBl+h8+XjNCP72OEYppkPXQClaqErRHhGg
	 lNKdRkimHod4GmoprO2TF58Jx2WgqHzIj3lJzNvrAwas62ePWgKwmQ8EzqnJz5NeC9
	 4fAx9UUW7CKjkrEz6ivhsr29VQe8ccWQQ0uNdPG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfLJWNr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfLJWDR (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 10 Dec 2019 17:03:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57272053B;
        Tue, 10 Dec 2019 22:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015396;
        bh=FOKD6FXWX6YBeDn+aiJmzV5MbF2npfo3geb+DF/JBBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAbzOqvbqNi8mD/fb4V8YA34UpPjKM2+RivhuXAxDkkwPLj0ia6DXsvsXFAex7Olq
         iPfJSpcpr/MJGMFA+WW0+z+vi4uHRvwCySJCabnAuqE7NCE1V7wJk4BsxDP7bMNoLX
         0twZbnTjmTpDpEZIa6D+B/T6mMAF+8pnCe1sJe1E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benoit Parrot <bparrot@ti.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 012/130] media: am437x-vpfe: Setting STD to current value is not an error
Date:   Tue, 10 Dec 2019 17:01:03 -0500
Message-Id: <20191210220301.13262-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Benoit Parrot <bparrot@ti.com>

[ Upstream commit 13aa21cfe92ce9ebb51824029d89f19c33f81419 ]

VIDIOC_S_STD should not return an error if the value is identical
to the current one.
This error was highlighted by the v4l2-compliance test.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Acked-by: Lad Prabhakar <prabhakar.csengg@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/am437x/am437x-vpfe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
index dfcc484cab898..e92c5b56be422 100644
--- a/drivers/media/platform/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/am437x/am437x-vpfe.c
@@ -1848,6 +1848,10 @@ static int vpfe_s_std(struct file *file, void *priv, v4l2_std_id std_id)
 	if (!(sdinfo->inputs[0].capabilities & V4L2_IN_CAP_STD))
 		return -ENODATA;
 
+	/* if trying to set the same std then nothing to do */
+	if (vpfe_standards[vpfe->std_index].std_id == std_id)
+		return 0;
+
 	/* If streaming is started, return error */
 	if (vb2_is_busy(&vpfe->buffer_queue)) {
 		vpfe_err(vpfe, "%s device busy\n", __func__);
-- 
2.20.1

