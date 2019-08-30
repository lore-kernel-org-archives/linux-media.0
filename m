Return-Path: <SRS0=bMJ1=W2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E57BC3A5A7
	for <linux-media@archiver.kernel.org>; Fri, 30 Aug 2019 09:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3A023427
	for <linux-media@archiver.kernel.org>; Fri, 30 Aug 2019 09:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfH3J0b (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:26:31 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:44167 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727635AbfH3J0a (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 30 Aug 2019 05:26:30 -0400
Received: from tschai.fritz.box ([46.9.232.237])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 3dAmiY5dCDqPe3dApiRKh4; Fri, 30 Aug 2019 11:26:28 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 0/3] cedrus: v4l2-compliance fixes
Date:   Fri, 30 Aug 2019 11:26:21 +0200
Message-Id: <20190830092624.18228-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfK4OYPJHY1sqD+Z5IOqh8Hgm5+CKyndrROiHCcdYchq5IV/z5BDqSnkF0daf4bAryKGWA9WmfYlsySO2954QZx6MQB0eTcrM2kpakwTHsQ3znV8sUPZP
 f6gr3yyOaUvtF1K2i7SYUL0hBrLEdhkyll53dFCZy9w2lewqbiGAioNyTMrMMjw9jLEGE8xfzhtH3xbatd15PiO9ChENjjCEwCjIu6vJ7HNIeLgYGiWY4NZr
 X6Z1s+GwezyXJHa74SzWAejRS8JoNtr/Zt9SoX2FF4+bzEL0YVXc2FZFNoPJF4BZWw8t3zVTxtD9xAeHnlMF9Q==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

When testing the cedrus driver on my Cubieboard I noticed
various v4l2-compliance failures. This series fixes them.

Not tested with the -s option since v4l2-compliance doesn't yet
support stateless MPEG-2/H.264 decoders.

Regards,

	Hans

Hans Verkuil (3):
  cedrus: fill in bus_info for media device
  cedrus: choose default pixelformat in try_fmt
  cedrus: fix various format-related compliance issues

 drivers/staging/media/sunxi/cedrus/cedrus.c   | 12 +++
 .../staging/media/sunxi/cedrus/cedrus_video.c | 74 ++++++-------------
 .../staging/media/sunxi/cedrus/cedrus_video.h |  1 +
 3 files changed, 36 insertions(+), 51 deletions(-)

-- 
2.23.0.rc1

