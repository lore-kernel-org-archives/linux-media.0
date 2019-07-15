Return-Path: <SRS0=PKt4=VM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81CBC76191
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 14:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7CE217D8
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199579;
	bh=wfjeoNZCyMmMMrxJxGPDpO4/20rNHgyYfaAi7vIUTvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PR41z8rkUBhNbD+2HGK2JVPSQq7/nMl8cbiI9Ekw9sfG+FAzB3RyvhhcARwV5cPSJ
	 Y06myzk2ML8e439B8oe2alLEksixyNGRAdPXU+ObaR2j8Zj7qDjqcgM7i+TYscuYQK
	 ZJ4AjSQx+P8+QiGju8/kvU0i8YUPzYSLPA0AMzAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbfGOOGS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbfGOOGG (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Jul 2019 10:06:06 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0548217D8;
        Mon, 15 Jul 2019 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199566;
        bh=wfjeoNZCyMmMMrxJxGPDpO4/20rNHgyYfaAi7vIUTvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1v2AjfOUegPmxEy1QRsWLJMwUM909V8ki/jkD0jITkVqCQlbdB/C5fpV/QW6DiLz5
         OgFw9Eab/p6RXPIS0D3IKQ5KkJo5CBS4Yhj2kn0uOAoXbKcNL02u8hK62hce6glpaW
         ojXkk5Gi42uTLapSL0xTh6wkGAIlJXmLfFzPuL+4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 044/219] media: mc-device.c: don't memset __user pointer contents
Date:   Mon, 15 Jul 2019 10:00:45 -0400
Message-Id: <20190715140341.6443-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit 518fa4e0e0da97ea2e17c95ab57647ce748a96e2 ]

You can't memset the contents of a __user pointer. Instead, call copy_to_user to
copy links.reserved (which is zeroed) to the user memory.

This fixes this sparse warning:

SPARSE:drivers/media/mc/mc-device.c drivers/media/mc/mc-device.c:521:16:  warning: incorrect type in argument 1 (different address spaces)

Fixes: f49308878d720 ("media: media_device_enum_links32: clean a reserved field")

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/media-device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/media-device.c b/drivers/media/media-device.c
index 6893843edada..8e2a66493e62 100644
--- a/drivers/media/media-device.c
+++ b/drivers/media/media-device.c
@@ -518,8 +518,9 @@ static long media_device_enum_links32(struct media_device *mdev,
 	if (ret)
 		return ret;
 
-	memset(ulinks->reserved, 0, sizeof(ulinks->reserved));
-
+	if (copy_to_user(ulinks->reserved, links.reserved,
+			 sizeof(ulinks->reserved)))
+		return -EFAULT;
 	return 0;
 }
 
-- 
2.20.1

