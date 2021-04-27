Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC24C43460
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 10:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A296613C3
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 10:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhD0KPc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235436AbhD0KOh (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Apr 2021 06:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0800C6144E;
        Tue, 27 Apr 2021 10:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619518432;
        bh=RKkiGoCDSW3lMHxV9n7JS+4PruB0khbogVRD1m+DqBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6VDr6dwIJolCY10j21zp1uwzMJ0eHGRXGAUPe0G3g76CHmhQ4dcPDDS0WKLBzjKr
         azh3dTGR8k4GrtVdFU7HGW3hwLAKDrnjnF1i06zvSblzjZ+NBuHUgsB6ZPTeJGU56j
         AUWBd67x3D4W0YwsBHly4M5V8nrnOZVj06Zw0TgRv62SAaSWYeLDu6XJza6dt4zeQc
         cekbm5ps+D+8ZxMVq10zcsaCXw1kcuhUPBh3VgJ3gc9YIcujOUFQAoNxb+YfxDIS0N
         rbL8GgQtiAv6Tc/0dNfEHrOEy3p+5ufIvJFzJT8RYkqN6RGiOI1kRTSHJLvZYvpTVl
         AfzW1wZ6uMQDg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lbKiz-000j6N-W0; Tue, 27 Apr 2021 12:13:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 37/79] media: i2c: imx274: use pm_runtime_resume_and_get()
Date:   Tue, 27 Apr 2021 12:13:04 +0200
Message-Id: <85bafd645269ad1e5392e7e113483563e28a072f.1619518193.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619518193.git.mchehab+huawei@kernel.org>
References: <cover.1619518193.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
added pm_runtime_resume_and_get() in order to automatically handle
dev->power.usage_count decrement on errors.

Use the new API, in order to cleanup the error check logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/i2c/imx274.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index cdccaab3043a..ee2127436f0b 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -1441,9 +1441,8 @@ static int imx274_s_stream(struct v4l2_subdev *sd, int on)
 	mutex_lock(&imx274->lock);
 
 	if (on) {
-		ret = pm_runtime_get_sync(&imx274->client->dev);
+		ret = pm_runtime_resume_and_get(&imx274->client->dev);
 		if (ret < 0) {
-			pm_runtime_put_noidle(&imx274->client->dev);
 			mutex_unlock(&imx274->lock);
 			return ret;
 		}
-- 
2.30.2

