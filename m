Return-Path: <SRS0=tKnt=Y3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B12CA9ED0
	for <linux-media@archiver.kernel.org>; Sun,  3 Nov 2019 11:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1852A2080F
	for <linux-media@archiver.kernel.org>; Sun,  3 Nov 2019 11:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfKCLXo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 3 Nov 2019 06:23:44 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:55889 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727488AbfKCLXo (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 3 Nov 2019 06:23:44 -0500
Received: from tschai.fritz.box ([46.9.232.237])
        by smtp-cloud8.xs4all.net with ESMTPA
        id RDysiydASTzKrRDywigk6p; Sun, 03 Nov 2019 12:23:42 +0100
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 2/8] smiapp: smiapp_start_streaming(): replace return by goto
Date:   Sun,  3 Nov 2019 12:23:32 +0100
Message-Id: <20191103112338.22569-3-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103112338.22569-1-hverkuil-cisco@xs4all.nl>
References: <20191103112338.22569-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHeaQRNmE7HXqnD3RDKc8r8MtUbGWQJZJ2jvNtuH5alFf4RPImjTd1ZYzmngj6WmEPSGQ//4kf4r/L/g2sH4UTfhjQGSOT7aiTKTuLvjXWhLqIjb/nTO
 YwYht/6HSUpjpOMXA5NJLyzoUq1h3oXqw0NWeqd3J6wiObbCZy6/zWmfNxvuZBF0Q96ySIT5KNIf5Mg3/GO+wpg9LXJnVw3k6pkg7Fw/BLDJsVZCByxEt14K
 tEKSeFKqZhAKIJg2zA3F7b+wxJLE6QZ1E4HDtrk/wnA=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There were still two returns in smiapp_start_streaming() that should
have been a goto to ensure mutex_unload was called before returning.

This fixes this smatch warning:

drivers/media/i2c/smiapp/smiapp-core.c:1483 smiapp_start_streaming() warn: inconsistent returns 'mutex:&sensor->mutex'.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/smiapp/smiapp-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index 77dfce7c3be9..84f9771b5fed 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -1362,13 +1362,13 @@ static int smiapp_start_streaming(struct smiapp_sensor *sensor)
 		rval = smiapp_write(
 			sensor, SMIAPP_REG_U8_BINNING_TYPE, binning_type);
 		if (rval < 0)
-			return rval;
+			goto out;
 
 		binning_mode = 1;
 	}
 	rval = smiapp_write(sensor, SMIAPP_REG_U8_BINNING_MODE, binning_mode);
 	if (rval < 0)
-		return rval;
+		goto out;
 
 	/* Set up PLL */
 	rval = smiapp_pll_configure(sensor);
-- 
2.23.0

