Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BABBC2D0E4
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 03:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3698C221FF
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 03:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbgK0Du4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Nov 2020 22:50:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:37738 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgK0Du4 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Nov 2020 22:50:56 -0500
IronPort-SDR: r6y05z5mTQw4VoRkC3ku5Duq053NNy7FW21iXYy9UKair9f6MSyjX9HP5dxrUtwbjaZW2ERmsk
 k51LO2nuqdTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="160120365"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="160120365"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 19:50:56 -0800
IronPort-SDR: 7GRKnbNfsgKbff3PxDmBfatt13B0MdSoBFpoUs6KPSlTaOvukWUybMacev2ogyChopXuMJUlv8
 MweC/KpKgjpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="363006124"
Received: from ipu5-build.bj.intel.com ([10.238.232.196])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 19:50:54 -0800
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com
Cc:     senozhatsky@chromium.org, tfiga@chromium.org, bingbu.cao@intel.com,
        bingbu.cao@linux.intel.com
Subject: [PATCH] media: ov9734: hold lock to check streaming state
Date:   Fri, 27 Nov 2020 11:48:12 +0800
Message-Id: <1606448892-19167-1-git-send-email-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The lock in ov9734 is used to protect the streaming state and
serialize the stream on and off callbacks, it should be hold before
checking the streaming state in ov9734_set_stream().

Reported-by: Tomasz Figa <tfiga@chromium.org>
Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
---
 drivers/media/i2c/ov9734.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov9734.c b/drivers/media/i2c/ov9734.c
index 4b9a2e9288e7..e212465489e8 100644
--- a/drivers/media/i2c/ov9734.c
+++ b/drivers/media/i2c/ov9734.c
@@ -637,10 +637,12 @@ static int ov9734_set_stream(struct v4l2_subdev *sd, int enable)
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	int ret = 0;
 
-	if (ov9734->streaming == enable)
+	mutex_lock(&ov9734->mutex);
+	if (ov9734->streaming == enable) {
+		mutex_unlock(&ov9734->mutex);
 		return 0;
+	}
 
-	mutex_lock(&ov9734->mutex);
 	if (enable) {
 		ret = pm_runtime_get_sync(&client->dev);
 		if (ret < 0) {
-- 
2.7.4

