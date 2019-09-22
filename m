Return-Path: <SRS0=gF/f=XR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AC8C3A5A2
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 19:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE96421907
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179336;
	bh=sySXfSKrLyVqmxbZDPppgpdYcTudYJC6EBHWPkUDGCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q3dpUSwK4dj26w6+6l5pCqnxOPcoCYtWAVDgPjoLPbQwAPRsdiv8IBi3XlpFUJ3hB
	 wCYawqAgK9hPHX2hbY2dvOxqjURv7UMGpn5/+x6Nk6hqoqk87YggmyVuvWN38c2HM1
	 fsodOvat+HyS2OIYpfTOPWENRn6UB/OqbW49qDwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406441AbfIVTIw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393449AbfIVS73 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 22 Sep 2019 14:59:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2472F214D9;
        Sun, 22 Sep 2019 18:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178769;
        bh=sySXfSKrLyVqmxbZDPppgpdYcTudYJC6EBHWPkUDGCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lb7nrKbEqEvWREUw4CBe5IxM32UPE8nYBteLtFCJS9tyPfMUPhXWaxaZHVTYoo06e
         4YACuQHmkwzDifqscSIsyS3hFXOMVMAU0vH/gTqrHEgOt6Td+4EGkR+is9JA19DAB2
         nOky6fPX/XwAnlotgGZU11nIf0BScf/i2umgUfKI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+0522702e9d67142379f1@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 87/89] media: ttusb-dec: Fix info-leak in ttusb_dec_send_command()
Date:   Sun, 22 Sep 2019 14:57:15 -0400
Message-Id: <20190922185717.3412-87-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>

[ Upstream commit a10feaf8c464c3f9cfdd3a8a7ce17e1c0d498da1 ]

The function at issue does not always initialize each byte allocated
for 'b' and can therefore leak uninitialized memory to a USB device in
the call to usb_bulk_msg()

Use kzalloc() instead of kmalloc()

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+0522702e9d67142379f1@syzkaller.appspotmail.com
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/ttusb-dec/ttusb_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/ttusb-dec/ttusb_dec.c b/drivers/media/usb/ttusb-dec/ttusb_dec.c
index cdefb5dfbbdcd..cad2746158160 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -330,7 +330,7 @@ static int ttusb_dec_send_command(struct ttusb_dec *dec, const u8 command,
 
 	dprintk("%s\n", __func__);
 
-	b = kmalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
+	b = kzalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
 	if (!b)
 		return -ENOMEM;
 
-- 
2.20.1

