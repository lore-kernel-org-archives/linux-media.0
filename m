Return-Path: <SRS0=OtTt=3F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3EDC33CAF
	for <linux-media@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B16E206D7
	for <linux-media@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201234;
	bh=ez2yAsRvFLLawmV9jKSDXs2Og8ukBee7MRN+9q7bKV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MbY9bH0wnQcfw9XamQHue6UxU5mtJfaGRl8iflbHUUv8JWpr3G/2GfpDPUEgR0+hm
	 4kxOKmTB8tjLnMJFNuiPr36PVxwunZXNaTM7XW70f94VaLmVDOXI+UEkR35rZ+QwAz
	 RXp9JI1Jm5T7rU0qMJ1T3CLG3UdSQBAzTjqwima0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbgAPRGO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388875AbgAPRGN (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8547724679;
        Thu, 16 Jan 2020 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194373;
        bh=ez2yAsRvFLLawmV9jKSDXs2Og8ukBee7MRN+9q7bKV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIoadlFxXFHSCEnMOgLD/sz00OKGJq4BwHgGMvJ8cZs3Quh3I2EhSvDz9010A5kEZ
         PUb4yozqjacLNXiChXKACm3pDPlamOmy83li+3lkk6iMD2HgUD0/6RJr+hbRQ0rSs2
         4SgLLB0aybVyPJ7pJbH2z45mzJDBHmCfN/MjDrLI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        "Lad Prabhakar" <prabhakar.csengg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 306/671] media: ov2659: fix unbalanced mutex_lock/unlock
Date:   Thu, 16 Jan 2020 11:59:04 -0500
Message-Id: <20200116170509.12787-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 384538bda10913e5c94ec5b5d34bd3075931bcf4 ]

Avoid returning with mutex locked.

Fixes: fa8cb6444c32 ("[media] ov2659: Don't depend on subdev API")

Cc: "Lad Prabhakar" <prabhakar.csengg@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Lad Prabhakar <prabhakar.csengg@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index 4b6be3b0fd52..5cdda9d6ca31 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -1136,7 +1136,7 @@ static int ov2659_set_fmt(struct v4l2_subdev *sd,
 		mf = v4l2_subdev_get_try_format(sd, cfg, fmt->pad);
 		*mf = fmt->format;
 #else
-		return -ENOTTY;
+		ret = -ENOTTY;
 #endif
 	} else {
 		s64 val;
-- 
2.20.1

