Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF66C48BE5
	for <linux-media@archiver.kernel.org>; Mon, 21 Jun 2021 08:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D55F611BD
	for <linux-media@archiver.kernel.org>; Mon, 21 Jun 2021 08:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFUImE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Jun 2021 04:42:04 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:36261 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhFUImD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Jun 2021 04:42:03 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id vFT6lBOQjhg8ZvFTAlc2GT; Mon, 21 Jun 2021 10:39:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1624264788; bh=xv8ATVFRKS2StRFufPpb/y838sdHvtAzPB0WjC1baSM=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=V2iCZBVgtWjcalyNmG+pwIiNMcSOu79uIt4HEdG0tivURFls4s0A+DLLVZD40U/pu
         +MEOY4YOu3RigW1Kzou6HRmc2gp0jIvlksM1Hdr6GEYuj5OICw27IzRE8e/TZ8VRTz
         sFqOh/A25tk9UwLUe6NKKHIwl3WE2Z/ygEnqjLYKRkBfdgeMEopCQ0LxeeLXQbnNtv
         20kJZbMioXR804L9PpB5CXDi/0wQhFT7AxZ42t2fzZ8AmBeboPbSEI96rvbt6G+OQT
         BESSUu8WD8t2qXSrXvuF904SXu7DQU9cItT+ziJaJvxCiBp2B/fjiZdVrwWHV/jxpp
         tcr5Rusk2g6fA==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v5.14] Two fixes
Message-ID: <4bfdcbdd-6d03-9f6b-437a-3132477af788@xs4all.nl>
Date:   Mon, 21 Jun 2021 10:39:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEcepu/Nc1IjZOD1uqHLB5pd3RKysnVL8LVcjYhRVgiskL7Iq3vdB2r/fnyoMHZR72vausK4zH3Tzf7KTSsCxNWy0mhOOVTxlsoyn7+lQzoEWhxyAZgp
 m5z4QZWMOQWVcCoA8rkzLp6YucpGBlUMztTr2/8Id3rv28sAfpFXfvZA1jh+o0ifjfpTOjo+HsmYQU0r5OuxZ+wAOu50ht803vg=
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 198bb646e8553e8abd8d83492a27b601ab97b75d:

  media: i2c: rdacm20: Re-work ov10635 reset (2021-06-17 12:08:55 +0200)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.14s

for you to fetch changes up to 2f54e1302f04f7c047ca381bf725ebd9e2b13b9f:

  media: gspca: Drop default m (2021-06-21 10:29:38 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Ezequiel Garcia (1):
      media: gspca: Drop default m

Hans Verkuil (1):
      include/uapi/linux/cec.h: typo: SATERDAY -> SATURDAY

 Documentation/userspace-api/media/cec.h.rst.exceptions | 2 +-
 drivers/media/usb/gspca/Kconfig                        | 1 -
 include/uapi/linux/cec.h                               | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
