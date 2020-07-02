Return-Path: <SRS0=5iRl=AN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD1CC433DF
	for <linux-media@archiver.kernel.org>; Thu,  2 Jul 2020 13:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5881C20772
	for <linux-media@archiver.kernel.org>; Thu,  2 Jul 2020 13:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="nqeMrFHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgGBNwI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:52:08 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:34221 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728989AbgGBNwI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 2 Jul 2020 09:52:08 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id qzdDjmyIL40yDqzdHjemvp; Thu, 02 Jul 2020 15:52:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1593697927; bh=VYIDg1ek/1VDkRlbKuQIAe4GYNHf6Lb7fUyc2BuNA9U=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=nqeMrFHFDPIJf1NVGuHmwrsoHRQz6ypaqte9Dih0s2cpffdXVPOanxkxLWZnKKl4b
         5Lj/Q585EjiSF3UZnreEzUESQ3kOYZRxU6TDbWeCrMviRxmjXCX7ZoW+Vy/dHuzEUv
         okqjrPi0kmh9NAjgSuNL0VjPm2kvBkZDSCOWxU8iqgfScigqUd7AwSdBq9FuxqkU0b
         XwFs9WOH1tWJgYmmHAtVfTgdnU02YdYxmqdz4Fb4oTnVRfWWM/puhfPwta18k+GI7V
         LFa0r9ca0LQCk2vybDbFYsHNlOw0fpqbWRKmdH5aNx0OubUaFUqSbT9MEUz07zjouG
         G1ek7R4Og3SJg==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] imx274: fix frame interval handling
Message-ID: <9f73f763-3b1f-bf18-0b4e-b69cfa22620b@xs4all.nl>
Date:   Thu, 2 Jul 2020 15:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAF/sReeQ5S1Tiawn3C4E8iuXFDufMmNk483kEHkeEq/uX+lTUtQ65azYwldrcuidI6NPGJg/NDqrhauTUdn6QI15oPME+CNGpAh3TS14S+nnz3gzx6n
 zsps2pK0PlQ1FBuqbJ/2Gp+jj3uN+Hm/elxNTW+Dc03f0LvKd0GApekJq8L8UWNjMbmMwR08mKPMpsi7UUuHPtvMo6HGka/R/GQ=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

1) the numerator and/or denominator might be 0, in that case
   fall back to the default frame interval. This is per the spec
   and this caused a v4l2-compliance failure.

2) the updated frame interval wasn't returned in the s_frame_interval
   subdev op.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/i2c/imx274.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index 6011cec5e351..a9304b98f7af 100644
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
+	if (frame_interval.numerator == 0 || frame_interval.denominator) {
+		frame_interval.denominator = IMX274_DEF_FRAME_RATE;
+		frame_interval.numerator = 1;
 	}

 	req_frame_rate = (u32)(frame_interval.denominator
-- 
2.27.0


