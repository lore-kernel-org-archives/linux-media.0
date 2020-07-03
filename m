Return-Path: <SRS0=uRfZ=AO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5BEC433DF
	for <linux-media@archiver.kernel.org>; Fri,  3 Jul 2020 09:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5057E20723
	for <linux-media@archiver.kernel.org>; Fri,  3 Jul 2020 09:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="pTxlAmB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGCJUh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:20:37 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:52777 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgGCJUh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 3 Jul 2020 05:20:37 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id rHs0j8SE5mVFqrHs3j7Ti5; Fri, 03 Jul 2020 11:20:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1593768036; bh=Jtg8OpwfXazhtCizxQ2XJr3u0jBGE6zWqejvk6CZxpc=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=pTxlAmB5rls9ktNZEDb/On+B0E4X7v2mson+v2ef48x94Zs3yJ87p3ZVTVYjRSzmT
         6Y3T112lMxbsTB1Ixp7ufV5q2qC2AeXcwxAkSz2rTtMWoCLKLduPIFmEZdShj7BS0l
         aoVTULGcLBg++zGY6EgJvc9F7Frf0SI5OL4dTgaz/goGhy7IfrlgHorC2E1byZcqOc
         KRpVbZkZXo6/jQXnznFsUEakYHew1yFCM8kQ9AKuY5hOddDi9iBssSAZB+c5yrjeWR
         7fphb3KkTquEIYj9eMUNBrly3i/Q8rcYwEVkVnbFj31l/KP/KboXndauuMy0gZDSDg
         bsgjNeimo9N0A==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Leon Luo <leonl@leopardimaging.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCHv2] imx274: fix frame interval handling
Message-ID: <e2733203-53ac-335b-cd4c-eccc1bb40319@xs4all.nl>
Date:   Fri, 3 Jul 2020 11:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNFHLpCBtec/9SwjJcZrGkQazKRHdn4k5f0rfMF7BgWhcCf/52qVcFCt4pH7uZAUTXfDQeOZnLEKtJ+XMQCM3T4NH16ABfflFWaP6CsgmB88vzLRpDKS
 FZmNXZRbUtE3BiswPnxH+seWQQ86hWgVPJOKKGg3FQ6Yijo/YAj32UD6Dp2kbmSRqsrLwpizeTkIV3C7F3rhhxNiOe/TZAg9gaNAG5g0SDJs/+1wnjMou7Rr
 gRs+o90TMI0uHS0a32IwmPtSLMQLTeEOezWLIIPW14fB6uR0yelOhH7TR/kaPQGL
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
Changes in v2:
- fix wrong frame_interval.denominator check (was missing ' == 0')
---
 drivers/media/i2c/imx274.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index 6011cec5e351..e6aa9f32b6a8 100644
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
2.27.0

