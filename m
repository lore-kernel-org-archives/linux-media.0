Return-Path: <SRS0=tBT7=DP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC815C46466
	for <linux-media@archiver.kernel.org>; Thu,  8 Oct 2020 11:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581D621527
	for <linux-media@archiver.kernel.org>; Thu,  8 Oct 2020 11:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="a40Ztuxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgJHL7W (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Oct 2020 07:59:22 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:48873 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728972AbgJHL7V (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 8 Oct 2020 07:59:21 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id QUZlkBbKmTHgxQUZrkHmqY; Thu, 08 Oct 2020 13:59:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1602158359; bh=v1uKh0FNfHWEpVaLoHrFNlYRLmTsn718f8sp7b+cfyQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=a40ZtuxkpOOwADILfyAUmITJhF9pjy/xQIRSaJL/RQ0RHMcKYzbkNnuQ87JkSJWDP
         99S98WSNssdGJaZFtKyVILfyNhlln1Dr4k8qG3a9sbANOUhHUa39yXf6gm7YsOb2vd
         iRmcPe0KvNGkqCjaJ4rf1ZqMbXydOOURQyCSYm1uNHbOf39gJ/yYSah1DxB5k705uQ
         VXI+rikjtBWy6mXy8ZZsIJ5ZZ/fhkfjov9M27QOnRUggxjqGAPJjV/pJi3W50OpHqr
         qJKM/cwCCAE00CbCPBOEL84T3yb5G1t4N2SFHEUKAjwdCN4px5l+tO8S/iLCDlcF56
         fUhBmNeGW6qOg==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2 2/3] tvp7002: fix uninitialized variable warning
Date:   Thu,  8 Oct 2020 13:59:12 +0200
Message-Id: <20201008115913.3579973-3-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008115913.3579973-1-hverkuil-cisco@xs4all.nl>
References: <20201008115913.3579973-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfM102tBGkuFk8PcQeK1P/KOfyjMeZev73FPNYGzzWuTDcVzAzy2koiP6zgzgcv+989TSJSnhXSqjU++FO7fzSr8PNy9kqurOnwm8cPkgpVloXbEhSnEA
 y4hMCnjUki40jdCgzOcR1JGDKatp3VdtQC33jh5eJPByGFHwvdKMSmBxFp74fAlYAai5yMfYIgxt7WT2JP3AFg1EdLnBU8Kh815Hdh1cj4CvNj+AdVS/RsK6
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

tvp7002.c: In function 'tvp7002_g_register':
tvp7002.c:691:11: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
  691 |  reg->val = val;
      |  ~~~~~~~~~^~~~~

Just return without setting 'reg' if tvp7002_read returns an error.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/i2c/tvp7002.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tvp7002.c b/drivers/media/i2c/tvp7002.c
index de313b1306da..ada4ec5ef782 100644
--- a/drivers/media/i2c/tvp7002.c
+++ b/drivers/media/i2c/tvp7002.c
@@ -688,9 +688,11 @@ static int tvp7002_g_register(struct v4l2_subdev *sd,
 	int ret;
 
 	ret = tvp7002_read(sd, reg->reg & 0xff, &val);
+	if (ret < 0)
+		return ret;
 	reg->val = val;
 	reg->size = 1;
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.28.0

