Return-Path: <SRS0=Yp04=2C=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BBAC43603
	for <linux-media@archiver.kernel.org>; Thu, 12 Dec 2019 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EF522B48
	for <linux-media@archiver.kernel.org>; Thu, 12 Dec 2019 08:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="kbw4oy20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfLLImG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:42:06 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:55799 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728110AbfLLImF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Dec 2019 03:42:05 -0500
Received: from [IPv6:2001:983:e9a7:1:1c4a:480a:7ba1:9c65]
 ([IPv6:2001:983:e9a7:1:1c4a:480a:7ba1:9c65])
        by smtp-cloud9.xs4all.net with ESMTPA
        id fK2siYDkSGyJwfK2tixK90; Thu, 12 Dec 2019 09:42:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1576140124; bh=AzglUBD1Tln9oM5STPFj4gFfvEGRLMtUBvGDhz2y2VU=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=kbw4oy209Ip2kyFkkh7KIzk+PLPIE4jNguKU/zaTpNfqJq7fjyxVCndWfXuubZYEJ
         wOhwvZM7E7maho1w7Z6JxSQIc4bGlw5lFzyoBXmkTmYnYMAvK2jw8qImNF9h0SINF9
         aY1glexpFDkCGmHxHTAjkT8N+98klvxffpKOPWg2vqc993KRW31Qmg8UwUGzQ6X+Cm
         lsYLBrJdlgNgRi9IgNbgPrpPKzB9vGf7tE4tMn1noPZVw5L4OPmhiMqdtRm4D8Yawv
         VdP9XUz/suZzj41nGjovpVWSnGnXzaYlk8iceUIxexzqQab3WykEwNI1RuzKwfaMOe
         64//n7E2ZGzgQ==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v5.5] cec: four fixes
Message-ID: <d12cd8de-0ee0-7f8a-c970-bda9949b3d84@xs4all.nl>
Date:   Thu, 12 Dec 2019 09:42:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA4aLiAbIl95ENQnaCjbO4yxHKGuNMVIujaAAU88kRe5gUOZlDVwLuS8f5dmcHl9u0LEGHdmJI8j4RMYxX1nTVyN4/3dssq4/ey+0iHuxxL0S24SfEcy
 J8TgzbH1uY639ChBKk+9B7hxE8Mfl3yACG955e350uMDu0ZgkI2N58RbT/8SX+f6KnhA8jGWB5wKJYvdlF+L0q8/6x9x395DaF87PCwjt6ZPIjYD5rDX9IBd
 fN7zHPYXpZEKMO0N/RzYmcycpcPBD3ovdKfUcS0GRxg=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Three fixes for the CEC framework, and one for the pulse8-cec driver.

All were found in the last two weeks during extensive testing with the
pulse8-cec driver.

All these fixes have a CC to stable since they should all be backported.

Regards,

	Hans

The following changes since commit 2099ef02c6c024751e4d16ace67dd6b910c875e4:

  media: dt-bindings: media: cal: convert binding to yaml (2019-12-09 11:43:47 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.5a

for you to fetch changes up to fea8ea467c7d488dd5c2448dc2d0f1fe57b6064e:

  pulse8-cec: fix lost cec_transmit_attempt_done() call (2019-12-11 17:27:50 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (4):
      cec: CEC 2.0-only bcast messages were ignored
      cec: avoid decrementing transmit_queue_sz if it is 0
      cec: check 'transmit_in_progress', not 'transmitting'
      pulse8-cec: fix lost cec_transmit_attempt_done() call

 drivers/media/cec/cec-adap.c              | 40 +++++++++++++++++++++++++++-------------
 drivers/media/usb/pulse8-cec/pulse8-cec.c | 17 +++++++++++++----
 2 files changed, 40 insertions(+), 17 deletions(-)
