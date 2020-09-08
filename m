Return-Path: <SRS0=7dE9=CR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E1C433E2
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3F72078B
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 10:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Xsv/0Y/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgIHKMP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:12:15 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:58583 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgIHKMN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 8 Sep 2020 06:12:13 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id FabhkWuesMeQuFabikfZoY; Tue, 08 Sep 2020 12:12:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1599559930; bh=sxVu0qUjrj5jfLjg4lwT3nNnTbXGLE6nt99G/f8XCYo=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=Xsv/0Y/UT+z/eI+zBIjBfoPvuYWDtUyeHi1bFA9bq7prKXa8Wq2nIjyun7eAadWhn
         KaWZqxtvcnTfs+yBRZ0zQd0m3MjoIvxAlcWhz4LxI2+NPoz8M+KRVQrI1LJv2ZuGAY
         RmHwGeEvjiUOzbKtQnWVbkwdgH8xeGQp8zjN9eXohRfg4zkWXo2/VoJr4INEKQzRio
         CJA+2oQgWNZGwEM919GZhByenyxSrev5XXyp2CU8Ff/+UIX1WSx662vuJJ/wu/CVQa
         laMxCjRpdjjWJWBHbmsEBmxZ/EohzjkSRcbGE6x4rdhe/+M8PmActdxpvf8gRSS66w
         ow9ibHiIOMC1A==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH for v5.9] cec-adap.c: don't use flush_scheduled_work()
Message-ID: <e21bceca-e5b0-7405-6497-ea80f08d0080@xs4all.nl>
Date:   Tue, 8 Sep 2020 12:12:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLC0MbvKX0H1aWvgFQnY75QgH6Uc+c4GFSO+7rO29YAAnSZt9MoSoHMbB4ev7sgU3c69Qp/NzEaRni/kqdFfmfbnGu1SRV9jf1J6XgV7aOXPpu2oQ4dU
 ikM8jgFCCdDNZwferAb34+Khm/QteX06qfwn7m4hfvj2W+8G5AptyN8qjNnEVlFaKMGEmGD6lfxyyJ+RTjt3Y0a890lOvxZnyF0K7zYBMxO5iaBO4tvxCi++
 9Bo5TIYhlGGFQdN3JqLuISrxgN57uJ+VJg6AndtgGO4=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

For some inexplicable reason I decided to call flush_scheduled_work()
instead of cancel_delayed_work_sync(). The problem with that is that
flush_scheduled_work() waits for *all* queued scheduled work to be
completed instead of just the work itself.

This can cause a deadlock if a CEC driver also schedules work that
takes the same lock. See the comments for flush_scheduled_work() in
linux/workqueue.h.

This is exactly what has been observed a few times.

This patch simply replaces flush_scheduled_work() by
cancel_delayed_work_sync().

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: <stable@vger.kernel.org>      # for v5.8 and up
Fixes: 9881fe0ca187 ("[media] cec: add HDMI CEC framework (adapter)")
---
 drivers/media/cec/core/cec-adap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 80fd5165f658..3153c401cb65 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1199,7 +1199,7 @@ void cec_received_msg_ts(struct cec_adapter *adap,
 			/* Cancel the pending timeout work */
 			if (!cancel_delayed_work(&data->work)) {
 				mutex_unlock(&adap->lock);
-				flush_scheduled_work();
+				cancel_delayed_work_sync(&data->work);
 				mutex_lock(&adap->lock);
 			}
 			/*
-- 
2.27.0

