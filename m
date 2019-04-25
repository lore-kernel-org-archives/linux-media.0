Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3E0C10F03
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 08:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B162D217D7
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 08:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfDYIJV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:09:21 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:35051 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbfDYIJV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 04:09:21 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JZRUhQf76ZVjxJZRXhduI9; Thu, 25 Apr 2019 10:09:20 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] stm32 fix, aspeed fixes
Message-ID: <985cadf1-717c-c408-df66-5aff7b193182@xs4all.nl>
Date:   Thu, 25 Apr 2019 10:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNJvQzNBe5AmbexRmOWCvdAaqwdvhB+FbRP07o1ikLplkMg8nFawgLwW68UoTr2W3RsrvU0XPhj6pnoa/QdV/tNe0qBY52qZuJWZnLo9oyPcIa8wKboG
 R75THWNz0+2oZKU3nn4D3jNpFxX2xKk//x5EOW+m+DQn4M2hPxbAtGipd2yaXGAuWp+LT5wfW9verw==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit a4dfc8a24796ff312d1d307e11f26f8ca466e938:

  media: MAINTAINERS: Update AO CEC with ao-cec-g12a driver (2019-04-22 13:16:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2h

for you to fetch changes up to f89d90bbdcc0c0606edab1a8a3490ea87ba48507:

  media: dt-bindings: aspeed-video: Add missing memory-region property (2019-04-25 09:23:07 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Eddie James (3):
      media: platform: Aspeed: Remove use of reset line
      media: platform: Aspeed: Make reserved memory optional
      media: dt-bindings: aspeed-video: Add missing memory-region property

Fabien Dessenne (1):
      media: stm32-dcmi: return appropriate error codes during probe

 Documentation/devicetree/bindings/media/aspeed-video.txt |  6 ++++++
 drivers/media/platform/aspeed-video.c                    | 33 ++++++---------------------------
 drivers/media/platform/stm32/stm32-dcmi.c                | 14 ++++++++------
 3 files changed, 20 insertions(+), 33 deletions(-)
