Return-Path: <SRS0=iMag=6H=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93753C54FCB
	for <linux-media@archiver.kernel.org>; Thu, 23 Apr 2020 11:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377602084D
	for <linux-media@archiver.kernel.org>; Thu, 23 Apr 2020 11:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="QO4Ry4og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDWLmi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:42:38 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:40795 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbgDWLmi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 23 Apr 2020 07:42:38 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id RaFUjMINT7xncRaFXjQUIj; Thu, 23 Apr 2020 13:42:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1587642156; bh=G/RxCQ6ZLqSI+IKH5Yai+jke5GP0SmT+SLP4vCUA1Wo=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=QO4Ry4og4nxZTgx7dEn5e/a8yFWawTXo3KNB51RaD7erIjuwyUUUJ0ICoTmDnM8pC
         NXeL5KstJKl9zIag9umPReAI1N1eMMTN3fvKqTCi7/b+ftZiIK6N5qoi+s6TpgAFS8
         UQb5V3kaVco8TUZkbs33ilnYZV5kH0j93N4xpHfWt27rGkG72U/Yw7lrDLbmn7AE4C
         gIQYlB5GBfd7umZVxn4vCz8G4wf4sJQjTpkEBpFirtJVhHG4IS6dYa83x15tu/yf+6
         xpzNQnAIzk9sXRj5w1uU92Hn2vHIO1Ea10W/JDQCxFrI2IB0zsLS0ar2TcMWH/PFOv
         glDGbt4A0YMDw==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] v4l2-ctrls.h: clarify the p_def argument of
 v4l2_ctrl_new_std_compound
Message-ID: <855fa27b-d9cd-bc6b-d982-e67161f743e3@xs4all.nl>
Date:   Thu, 23 Apr 2020 13:42:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJB/LCDSnW4cQ+AN989UR9aE896Z4fR0ehOBetj5bt/J2vlPneGkChyJeFmdseIPrUMvWYHENN2f/M9mrqMtF+zlz/LN2WTrPS0xsuq1AezZvRNXoTgA
 RO7T3TBk9/EU47IRAbhXh3l+wTC658hp8oLhTun0L54ApagFa6qBbBF1tjkKsbJlpNizlb9PY0KAQFg4j5L0+BWuPgsU/BhygQM=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

It was not sufficiently clear how to create and use p_def.
Improve the documentation.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index 75a8daacb4c4..757a713bad41 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -685,7 +685,9 @@ struct v4l2_ctrl *v4l2_ctrl_new_std_menu_items(struct v4l2_ctrl_handler *hdl,
  * @p_def:     The control's default value.
  *
  * Sames as v4l2_ctrl_new_std(), but with support to compound controls, thanks
- * to the @p_def field.
+ * to the @p_def field. Use v4l2_ctrl_ptr_create() to create @p_def from a
+ * pointer. Use v4l2_ctrl_ptr_create(NULL) if the default value of the
+ * compound control should be all zeroes.
  *
  */
 struct v4l2_ctrl *v4l2_ctrl_new_std_compound(struct v4l2_ctrl_handler *hdl,
