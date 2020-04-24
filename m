Return-Path: <SRS0=poVo=6I=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532CFC54FCB
	for <linux-media@archiver.kernel.org>; Fri, 24 Apr 2020 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFA62075A
	for <linux-media@archiver.kernel.org>; Fri, 24 Apr 2020 15:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Ba4u3TGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDXPvK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:51:10 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:43447 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbgDXPvK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 24 Apr 2020 11:51:10 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id S0bYjHbgslKa1S0bcjPu9l; Fri, 24 Apr 2020 17:51:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1587743468; bh=SBEkrspu+em6W1HwCyrE9wRUDRDjyoE8FuCvel9RWWc=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=Ba4u3TGh5MwifWUGIR8EczbLzvfxjAwldvafXPyOyUqQ++0vRCHfyoeevqWIliUnY
         tNtttRRM0kgfu2b8UxCZVPkEwELeFKf6nBwpqB1esGXVTsM6XRhycD8xlu9Q4RfIYl
         LYFt76PTS2tIeW1qtWHNu2o659ub3O4b+t1TC/FO8WF9HfRfpLzy96EnISo280G4rZ
         JQilNo8gIUtqxmvkkJJWHtNyvBvql91e3f5m2SLeXKb0Z0PTH+NLHmj346U5i5kDYW
         yCX7a7A37v2yYcUn7ywbPaZpAoTRwFxiyEiWGmVJwrkXffvWsT/mIpwM7b91XPnt9I
         YDyIK1LmCWtiA==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.8] Various fixes
Message-ID: <b1f48b3f-e762-b54f-2bf4-f99d61b964c8@xs4all.nl>
Date:   Fri, 24 Apr 2020 17:51:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGK0fBE6EmrvpAkVuMLrqw/HBkn+v0GFVviMheWoN77O09/nyMqq3R5PRHXu+grjrUWoYTy5wDppH1ZQ0qPUmoQ7MOo09zmRvaK57+2Z7Bw0DiVTPoNs
 w2Jt0FFB6klCFm7cXzYQ9cFcleU1G+a1no4WhzGIFz3lMumhzwFv47f3sQlQc3oKQX0TPcQtaKm4Aw==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 4bdbff4da40584ec2225bb429b7c66ad54d19cda:

  media: tuners: Kconfig: add some missing VIDEO_V4L2 dependencies (2020-04-23 07:57:27 +0200)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.8d

for you to fetch changes up to c02407e73792d3a1149370314f6cc17de8bed7d2:

  v4l2-ctrls.h: clarify the p_def argument of v4l2_ctrl_new_std_compound (2020-04-24 16:01:33 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (3):
      vidioc-reqbufs/create-bufs.rst: fix typo
      cec-gpio: handle gpiod_get_value errors correctly
      v4l2-ctrls.h: clarify the p_def argument of v4l2_ctrl_new_std_compound

Lukas Bulwahn (1):
      MAINTAINERS: adjust entries to moving CEC USB drivers

Niklas Söderlund (1):
      vimc: cap: Report a colorspace

 Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst |  2 +-
 Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst     |  2 +-
 MAINTAINERS                                                  |  4 ++--
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                       |  2 +-
 drivers/media/cec/platform/cec-gpio/cec-gpio.c               | 18 +++++++++++-------
 drivers/media/test-drivers/vimc/vimc-capture.c               |  5 ++++-
 drivers/media/test-drivers/vimc/vimc-debayer.c               |  2 +-
 drivers/media/test-drivers/vimc/vimc-scaler.c                |  2 +-
 drivers/media/test-drivers/vimc/vimc-sensor.c                |  2 +-
 include/media/cec-pin.h                                      | 16 +++++++---------
 include/media/v4l2-ctrls.h                                   |  4 +++-
 11 files changed, 33 insertions(+), 26 deletions(-)
