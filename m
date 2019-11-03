Return-Path: <SRS0=tKnt=Y3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B52C47E49
	for <linux-media@archiver.kernel.org>; Sun,  3 Nov 2019 11:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12A32084D
	for <linux-media@archiver.kernel.org>; Sun,  3 Nov 2019 11:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfKCLXo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 3 Nov 2019 06:23:44 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:41813 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727425AbfKCLXo (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 3 Nov 2019 06:23:44 -0500
Received: from tschai.fritz.box ([46.9.232.237])
        by smtp-cloud8.xs4all.net with ESMTPA
        id RDysiydASTzKrRDyvigk6i; Sun, 03 Nov 2019 12:23:42 +0100
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH 1/8] am437x: fix smatch warning
Date:   Sun,  3 Nov 2019 12:23:31 +0100
Message-Id: <20191103112338.22569-2-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103112338.22569-1-hverkuil-cisco@xs4all.nl>
References: <20191103112338.22569-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHeaQRNmE7HXqnD3RDKc8r8MtUbGWQJZJ2jvNtuH5alFf4RPImjTd1ZYzmngj6WmEPSGQ//4kf4r/L/g2sH4UTfhjQGSOT7aiTKTuLvjXWhLqIjb/nTO
 YwYht/6HSUpjpOMXA5NJLyzoUq1h3oXqw0NWeqd3J6wiObbCZy6/zWmfNxvuZBF0Q96ySIT5KNIf5Mg3/GO+wpg9LXJnVw3k6pl/UWB8e3aTeYMZ/qY+cvxm
 c6mopC6Gf/bmDY4KeF5K9g==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes this warning:

drivers/media/platform/am437x/am437x-vpfe.c:288 vpfe_ccdc_validate_param() warn: unsigned 'ccdcparam->alaw.gamma_wd' is never less than zero.

by dropping the gamma_wd < VPFE_CCDC_GAMMA_BITS_15_6 check
since VPFE_CCDC_GAMMA_BITS_15_6 is 0.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/am437x/am437x-vpfe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
index 447610b67db4..09104304bd06 100644
--- a/drivers/media/platform/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/am437x/am437x-vpfe.c
@@ -285,7 +285,6 @@ vpfe_ccdc_validate_param(struct vpfe_ccdc *ccdc,
 	max_data = ccdc_data_size_max_bit(ccdcparam->data_sz);
 
 	if (ccdcparam->alaw.gamma_wd > VPFE_CCDC_GAMMA_BITS_09_0 ||
-	    ccdcparam->alaw.gamma_wd < VPFE_CCDC_GAMMA_BITS_15_6 ||
 	    max_gamma > max_data) {
 		vpfe_dbg(1, vpfe, "Invalid data line select\n");
 		return -EINVAL;
-- 
2.23.0

