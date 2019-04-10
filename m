Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D65AC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 15:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698BF20818
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 15:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfDJPcz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:32:55 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:58849 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729313AbfDJPcy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 11:32:54 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EFDYhlqhmNG8zEFDZh1y42; Wed, 10 Apr 2019 17:32:53 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] coda & rcar-csi2 fixes
Message-ID: <d83c3c03-a051-f1d3-8f17-723da7de680e@xs4all.nl>
Date:   Wed, 10 Apr 2019 17:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPAwO1/T1RgFCopBEduMfMUqu38ugwuVsAR3vZZDXjRVh/0B6W5xPlBFcHgoOggRFwZ7M/TmoZj19IDD2fX832UR75dFfFxn5It1QHh8KnL9131d8IYG
 nflNMsZDqWirhKDwkryMACkp8ZI3v2UQL0Md8p6GPekAcWyD7ZQ1L80tMjd7xotoFgjBBvM8opetaFar2miMyF45lA4O3dpAr+GblKiugrgq0M/XnjJ4v9Z1
 /6fZRSgb/nbl58aEN4M6GBg7URRelfKYrMczGUXCjnvI1bpTr7jARnBWdAVd9JCAMS1VngmVjhk429GoqCPnXeNEDZ7g/J0OSM7jnCF01KaaFxdbURGrh3RH
 p/mhK9L8ApOaY85HD8V3T4zqclYzCg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2e2

for you to fetch changes up to 58e7ff104f038eaedc72b275f7388be1687abc98:

  rcar-csi2: Move setting of Field Detection Control Register (2019-04-10 16:40:45 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Niklas Söderlund (5):
      dt-bindings: rcar-csi2: List resets as a mandatory property
      rcar-csi2: Use standby mode instead of resetting
      rcar-csi2: Update V3M and E3 start procedure
      rcar-csi2: Update start procedure for H3 ES2
      rcar-csi2: Move setting of Field Detection Control Register

Philipp Zabel (8):
      media: coda: set codec earlier
      media: coda: remove mask from decoder h.264 level control
      media: coda: clear error return value before picture run
      media: coda: add min number of buffers controls
      media: coda: disable encoder command on decoder and vice versa
      media: coda: implement encoder frame size enumeration
      media: coda: allow encoder to set colorimetry on the output queue
      media: coda: throw error on create_bufs with too small size

 Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt |   3 +-
 drivers/media/platform/coda/coda-bit.c                        |   3 ++
 drivers/media/platform/coda/coda-common.c                     | 120 ++++++++++++++++++++++++++++-------------
 drivers/media/platform/rcar-vin/Kconfig                       |   1 +
 drivers/media/platform/rcar-vin/rcar-csi2.c                   | 116 +++++++++++++++++++++++++--------------
 5 files changed, 166 insertions(+), 77 deletions(-)
