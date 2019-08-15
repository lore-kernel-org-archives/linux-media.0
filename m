Return-Path: <SRS0=Aqrg=WL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE08DC3A589
	for <linux-media@archiver.kernel.org>; Thu, 15 Aug 2019 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B2620644
	for <linux-media@archiver.kernel.org>; Thu, 15 Aug 2019 14:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfHOOpE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:45:04 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:59365 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733106AbfHOOpD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 15 Aug 2019 10:45:03 -0400
Received: from cobaltpc1.rd.cisco.com ([IPv6:2001:420:44c1:2579:f038:4b04:f67a:276f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id yGzohwQmCDqPeyGzthYZP1; Thu, 15 Aug 2019 16:45:02 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv3 06/12] media: vicodec: set flags for vdec/stateful OUTPUT coded formats
Date:   Thu, 15 Aug 2019 16:44:50 +0200
Message-Id: <20190815144456.54583-7-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815144456.54583-1-hverkuil-cisco@xs4all.nl>
References: <20190815144456.54583-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEVmg7r1+iI3dut7kcz+9DwmB+KDZagkyu7n1AWRquLnKCoNr/A8M0smKgGnPBvAET01QNzw5hNRDifQUwRPjVI3SGaGXhvLDi0rS5LnaTKOi+U3ENjo
 c5ZJZsPVl7YrD3IK6a7zMclkLTA5yNqNxyOG7AyCZg8fPzr1bPtTUR+w1BbXkxPplNMqJ/AFmNQjH0Mh1eafOxRD6Ju7zbZWc/pAmDnp2oeB3WO9T+3Asf4L
 45VpRLw27BC01zZYy3nsaVs5oO+ekXN4dXcCKXnTAFTcpg65FSyLv3YpO6UCEoP/r4dIcyU0SeDV+PGO//KN1ob65+S9GIAC7GwF20zPOPjiId/A9wcf19xT
 LMzRNVqE7vN5DosCZcZRthftX9Q52JBksq+pcfIkZJ/i2Oa6SFsokADcYcE8TVeqFMjuW8qE
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Maxime Jourdan <mjourdan@baylibre.com>

Tag all the coded formats where the vicodec stateful decoder supports
dynamic resolution switching and bytestream parsing.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/vicodec/vicodec-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 7e7c1e80f29f..5152f44bcc0a 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -742,6 +742,9 @@ static int enum_fmt(struct v4l2_fmtdesc *f, struct vicodec_ctx *ctx,
 			return -EINVAL;
 		f->pixelformat = ctx->is_stateless ?
 			V4L2_PIX_FMT_FWHT_STATELESS : V4L2_PIX_FMT_FWHT;
+		if (!ctx->is_enc && !ctx->is_stateless)
+			f->flags = V4L2_FMT_FLAG_DYN_RESOLUTION |
+				   V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM;
 	}
 	return 0;
 }
-- 
2.20.1

