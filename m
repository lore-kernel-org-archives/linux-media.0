Return-Path: <SRS0=Zg/f=EC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF0FC64E90
	for <linux-media@archiver.kernel.org>; Tue, 27 Oct 2020 00:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370552080A
	for <linux-media@archiver.kernel.org>; Tue, 27 Oct 2020 00:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603759569;
	bh=SK9zudvrywtJq/m9EgjmbBefuNPDXV6s1teD0suvgyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DymOYEqVshM63r8Z0wJFjRUdMgCWMJO41USDlI/bjSFsMEijSuGVlQvFGm2pdSdEp
	 Snxv6Iit1Jiz/+tzBn8kMZILnW3NzL1w7wU+J7CXrgV359gBs6LpmUM4+NiJFS7rgf
	 a6PnRZT9MnlP9JhVRveXmWCqTucg1Aj2l99/PvRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502359AbgJ0An3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408771AbgJZXuJ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Oct 2020 19:50:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB26B216FD;
        Mon, 26 Oct 2020 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756208;
        bh=SK9zudvrywtJq/m9EgjmbBefuNPDXV6s1teD0suvgyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzmZsZ6s86NaTvL1SO/REsuPvcWqA4U5MWMJH/quYpj4OFrFo9QV7tb5EsHt2V/wc
         wbHisav7LHISYLc6xl9AREllX/i3Dv4mvL9BnSDPx22w13Jsc3gzOgXOvmeN/MZAbp
         +Amltw22o0WjIABwT+yVxcNbxCDcgif7HO0KeWiw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 050/147] media: imx274: fix frame interval handling
Date:   Mon, 26 Oct 2020 19:47:28 -0400
Message-Id: <20201026234905.1022767-50-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026234905.1022767-1-sashal@kernel.org>
References: <20201026234905.1022767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit 49b20d981d723fae5a93843c617af2b2c23611ec ]

1) the numerator and/or denominator might be 0, in that case
   fall back to the default frame interval. This is per the spec
   and this caused a v4l2-compliance failure.

2) the updated frame interval wasn't returned in the s_frame_interval
   subdev op.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx274.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index 6011cec5e351d..e6aa9f32b6a83 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -1235,6 +1235,8 @@ static int imx274_s_frame_interval(struct v4l2_subdev *sd,
 	ret = imx274_set_frame_interval(imx274, fi->interval);
 
 	if (!ret) {
+		fi->interval = imx274->frame_interval;
+
 		/*
 		 * exposure time range is decided by frame interval
 		 * need to update it after frame interval changes
@@ -1730,9 +1732,9 @@ static int imx274_set_frame_interval(struct stimx274 *priv,
 		__func__, frame_interval.numerator,
 		frame_interval.denominator);
 
-	if (frame_interval.numerator == 0) {
-		err = -EINVAL;
-		goto fail;
+	if (frame_interval.numerator == 0 || frame_interval.denominator == 0) {
+		frame_interval.denominator = IMX274_DEF_FRAME_RATE;
+		frame_interval.numerator = 1;
 	}
 
 	req_frame_rate = (u32)(frame_interval.denominator
-- 
2.25.1

