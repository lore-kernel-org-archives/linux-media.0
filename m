Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E226C433B4
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 10:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F327D613E2
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 10:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhD0KPa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235442AbhD0KOh (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Apr 2021 06:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CCF76144F;
        Tue, 27 Apr 2021 10:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619518432;
        bh=KnK+ScvrOSmF+XC/C/B4F8IBvu/svp7LsuDeKcM5sXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqihrh0JAD8KKS8o/OcOWWXmdSVGOb2l7EZAL+asEwxCgNzzBP9iouzl8SVV2Nwtv
         RKr7CVPyKw9C5z4EnbHXn361hNTMJh3o/jZ0zvbfTldYf85U+D2VjNR7c75zQ18NlF
         OyWVEKUe0+zMKR0BwMnOT2v4JUn3qkkRiqFfcBGD0hSJx3aA3DRq55nISThq00a3Y7
         P11MfLAyQKBgIYyd7ODtpOHSRHBwzeTLk4w5FEgAVRsldBpqtnbU2XHfoKR896Rw3I
         Q2i+TI+hkg3PJYog8TLDkBW5Y2hP8HN9AYSLfBfE92osYzrt4ZaCWS25va+Kmcw8Cg
         Wv06c43fhslLw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lbKiz-000j6E-Q3; Tue, 27 Apr 2021 12:13:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 34/79] media: i2c: imx214: use pm_runtime_resume_and_get()
Date:   Tue, 27 Apr 2021 12:13:01 +0200
Message-Id: <0fc752194f213f2f97b7bb8c8e89d29c0d10747c.1619518193.git.mchehab+huawei@kernel.org>
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
 drivers/media/i2c/imx214.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index e8b281e432e8..1a770a530cf5 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -776,11 +776,9 @@ static int imx214_s_stream(struct v4l2_subdev *subdev, int enable)
 		return 0;
 
 	if (enable) {
-		ret = pm_runtime_get_sync(imx214->dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(imx214->dev);
+		ret = pm_runtime_resume_and_get(imx214->dev);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = imx214_start_streaming(imx214);
 		if (ret < 0)
-- 
2.30.2

