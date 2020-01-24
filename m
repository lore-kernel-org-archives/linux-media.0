Return-Path: <SRS0=bEWJ=3N=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A15EC2D0DB
	for <linux-media@archiver.kernel.org>; Fri, 24 Jan 2020 11:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201DA206D5
	for <linux-media@archiver.kernel.org>; Fri, 24 Jan 2020 11:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="AdULU56Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgAXLxf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:53:35 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:49923 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730785AbgAXLxf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 24 Jan 2020 06:53:35 -0500
Received: from [IPv6:2001:983:e9a7:1:dded:8f92:97b:fe6e]
 ([IPv6:2001:983:e9a7:1:dded:8f92:97b:fe6e])
        by smtp-cloud7.xs4all.net with ESMTPA
        id uxWmivmF9rNgyuxWni4tfG; Fri, 24 Jan 2020 12:53:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1579866813; bh=CNI++yUw+DobxIwUMm3/J9+Jd0/RHOt9mRtcKye8z7Q=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=AdULU56Q3s5RonTkzOKq5DAztLlrv+AvlTLc3xK8RDkymv9dneIXRq/VjZD7eu3ba
         +DOZj6820XSS0FbnXGUb4N1BG6cdo9ozHX00t4r105q2SnEV0LMJbReXn+ARIkfjzs
         l9U4uJhXU6Df46EXscjrLuiVh7mwQ1QWeKKdO1ZpEZ4xIIIypdhQtVb3jyuvE/qpfV
         RsWYfTWoVVfmyWT8H0HQU6NT9M8A0iQv4H7OyEZFaRCeZocjy0dSkjrPmZs/8M4YHR
         uJYtcjFQ6pKx/BXTE0drfPsNE5lE8wmIosLdRWoKQV2oS+Fdez9+zsMVqOT9B9WfY+
         DKx6vQOEXVo1w==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH for v5.6] pulse8-cec: INIT_DELAYED_WORK was called too late
Message-ID: <7bec3c31-67e2-a565-70ff-bb45899b0b15@xs4all.nl>
Date:   Fri, 24 Jan 2020 12:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIib+dGOY0/d0sr3q1pdJhVigO8uc4+nahCUrwvDsmmzfYVnDTOGcWbf3IbeQguaqnsC4kueFgAzCMogtd+aGCsadisbBhLPDHKZpMZi7IUtwlzISpgM
 gOFSSr7Q1/IdUkj4nQQYB907FwRpY9qDVffFqEBBa8mPtl368AKWZyfYJ25pJIKIzrkRyzow3sq0j6x6BBlRAOA30zL3+bilMRiVIEtfLTlumsPRbFPB/VKE
 kbMlWOQ84Cr/Vab4BPbfnKelLIXO6QG1Ji16FDgqaUo=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If earlier in the connect() an error occurred, then pulse8_cec_adap_free
was called by cec_delete_adapter, and that free function tried to
cancel the ping_eeprom_work workqueue, but that workqueue hasn't
been initialized yet, resulting in a kernel warning.

Move the initialization of that workqueue up to where the other
workqueues are initialized.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Fixes: 601282d65b96 ("media: pulse8-cec: use adap_free callback")
---
 drivers/media/usb/pulse8-cec/pulse8-cec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/pulse8-cec/pulse8-cec.c b/drivers/media/usb/pulse8-cec/pulse8-cec.c
index afda438d4e0a..8d61bcec14bb 100644
--- a/drivers/media/usb/pulse8-cec/pulse8-cec.c
+++ b/drivers/media/usb/pulse8-cec/pulse8-cec.c
@@ -840,6 +840,8 @@ static int pulse8_connect(struct serio *serio, struct serio_driver *drv)
 	serio_set_drvdata(serio, pulse8);
 	INIT_WORK(&pulse8->irq_work, pulse8_irq_work_handler);
 	INIT_WORK(&pulse8->tx_work, pulse8_tx_work_handler);
+	INIT_DELAYED_WORK(&pulse8->ping_eeprom_work,
+			  pulse8_ping_eeprom_work_handler);
 	mutex_init(&pulse8->lock);
 	spin_lock_init(&pulse8->msg_lock);
 	pulse8->config_pending = false;
@@ -865,8 +867,6 @@ static int pulse8_connect(struct serio *serio, struct serio_driver *drv)
 		pulse8->restoring_config = true;
 	}

-	INIT_DELAYED_WORK(&pulse8->ping_eeprom_work,
-			  pulse8_ping_eeprom_work_handler);
 	schedule_delayed_work(&pulse8->ping_eeprom_work, PING_PERIOD);

 	return 0;
-- 
2.23.0

