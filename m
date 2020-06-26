Return-Path: <SRS0=LydW=AH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B41C433DF
	for <linux-media@archiver.kernel.org>; Fri, 26 Jun 2020 10:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41E42070A
	for <linux-media@archiver.kernel.org>; Fri, 26 Jun 2020 10:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="sDV6hXWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgFZKoc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:44:32 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:53553 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728023AbgFZKob (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Jun 2020 06:44:31 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id olqMjjEiJrl4BolqQjQGAb; Fri, 26 Jun 2020 12:44:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1593168270; bh=uSBfdi+2BUF3+Mbqg1LD+6YkAIY3RkIXV0gm7iZsCTs=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=sDV6hXWGWYKgeignI0DmFay2f5VD6VTuR3Q8tX6RtLPi9wYeIih5PBnlI0OBPXX0S
         DlECCAJ661IyHzDXN8mft4DpHsigkOm8/W8lA9zPCbEc1tRX3GjFxKkkbWKocLx4iY
         QNHobQBuHV6KD8t4skv/fo2lyqfIJblHBEls5HvhF7YeD+jJ1kjfFbNPCnrl3u0ED0
         rZoZXfk46g7hEHq6YN3KqLutWMQiY6rj7VEgW66tI+YMjdU7GZTtdThJJUrFvY0qAY
         RQ9pNkgDSHSu3d//VSBiHmA7VSQSwP24M8nqEnUPq5aOKbrbpgDjQUfdsr3xuYeuyI
         boYiuQRGil6jw==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] cec-api: prevent leaking memory through hole in structure
Message-ID: <5b82f96b-1e25-a3a8-220c-0b9817ab5d36@xs4all.nl>
Date:   Fri, 26 Jun 2020 12:44:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCEhAztNtSxQqSW6W1RXYwV5xBClHlXWbnpPxFaGze+zv3iNG+HTGtoDbfJ4EFOvJwvTUS5QT5WlG8GxMKzDg3BaSzaaK7bImeAnU7HA0IFK48a734ka
 B7UpXIiHC3D4rkFbUXPnJ3U6/Aq8NJqfmf2u82LlBP86RiZHWC2Xkg49SZ7Egaw/4Gy748RVBhtdWw==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix this smatch warning:

drivers/media/cec/core/cec-api.c:156 cec_adap_g_log_addrs() warn: check that 'log_addrs' doesn't leak information (struct has a hole after
'features')

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/cec/core/cec-api.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index 17d1cb2e5f97..511ea30c41e3 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -147,7 +147,13 @@ static long cec_adap_g_log_addrs(struct cec_adapter *adap,
 	struct cec_log_addrs log_addrs;

 	mutex_lock(&adap->lock);
-	log_addrs = adap->log_addrs;
+	/*
+	 * We use memcpy here instead of assignment since there is a
+	 * hole at the end of struct cec_log_addrs that an assignment
+	 * might ignore. So when we do copy_to_user() we could leak
+	 * one byte of memory.
+	 */
+	memcpy(&log_addrs, &adap->log_addrs, sizeof(log_addrs));
 	if (!adap->is_configured)
 		memset(log_addrs.log_addr, CEC_LOG_ADDR_INVALID,
 		       sizeof(log_addrs.log_addr));
-- 
2.27.0

