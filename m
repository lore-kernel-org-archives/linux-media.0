Return-Path: <SRS0=gF/f=XR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BB4C3A5A2
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30347214D9
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180103;
	bh=3vz0jGokF/tADKiAtasvrTU/In2SROOiBNXQon2ojrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Za++JdsQQeQay0QC/cStSKEpFK6Tj5HFgREAAJ0xTJiBGR6WoA32eQUIlHQS2BGRv
	 0MkCE54Mfuhz9bmQr9XPDMBur+9+fgxtdzqHD7ovQcTKhr9PhOQUjbnoiqEjCImH0J
	 javEOSAmlfnIupSEFj+bSlAkuU0OmSo6xX3Z/pQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfIVTVj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394501AbfIVSyE (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 22 Sep 2019 14:54:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261A921479;
        Sun, 22 Sep 2019 18:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178444;
        bh=3vz0jGokF/tADKiAtasvrTU/In2SROOiBNXQon2ojrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avNTH3Qe6nwqj2HaHud5TwOC8N+2ewJHHbbeWdTiwyWqctiXhNUqFiugQw4h2D7wE
         tWhnmEb6QVfEgCzir5Hg332j7RYFzZ3dbtgMJRlgL9sMU+FTN1RpQhW+lfMP2Ytd80
         5lMAxDzIh8di44apiUshCGmxAHtCzQaPQVi0AEpU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+0522702e9d67142379f1@syzkaller.appspotmail.com,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 176/185] media: ttusb-dec: Fix info-leak in ttusb_dec_send_command()
Date:   Sun, 22 Sep 2019 14:49:14 -0400
Message-Id: <20190922184924.32534-176-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
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
index 1d0afa340f47c..3198f9624b7c0 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -319,7 +319,7 @@ static int ttusb_dec_send_command(struct ttusb_dec *dec, const u8 command,
 
 	dprintk("%s\n", __func__);
 
-	b = kmalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
+	b = kzalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
 	if (!b)
 		return -ENOMEM;
 
-- 
2.20.1

