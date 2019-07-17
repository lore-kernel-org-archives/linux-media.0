Return-Path: <SRS0=lr8S=VO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B6CC76186
	for <linux-media@archiver.kernel.org>; Wed, 17 Jul 2019 09:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36BE2077C
	for <linux-media@archiver.kernel.org>; Wed, 17 Jul 2019 09:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfGQJDv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:03:51 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:60001 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbfGQJDv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Jul 2019 05:03:51 -0400
Received: from tschai.fritz.box ([46.9.252.75])
        by smtp-cloud7.xs4all.net with ESMTPA
        id nfqjhuob40SBqnfqmhZQVS; Wed, 17 Jul 2019 11:03:49 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/4] via-camera/ov7670: various fixes/improvements
Date:   Wed, 17 Jul 2019 11:03:41 +0200
Message-Id: <20190717090345.26521-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKYHYsr0K2oSeFvQJX37sysaUM/sAdPejtCXJIgQooqWWkvHcfaDowwz23KkX1mbF1eoj04dCgvOUsUEfhQ8yTYROPoZLpHbElzAyfagUA/HZUDxsGid
 8ucihqE/6eX+IkkFRgGW7oyKe+Yx7v4rk+2Lm0NVja2VKpO+dCG9TawSCiuzuNv4LFUoPoP3wAaH0KS9bCalufChNjfJzuxddZE=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The main purpose of this series was to make via-camera use struct v4l2_fh,
since it was one of the few drivers that didn't use that struct.

While testing I found a bunch of other issues with this driver and the
ov7670 driver, which are also fixed.

The next step will be to convert this driver to use vb2, but that's
still work in progress.

This series has been tested on an OLPC 1.5 laptop.

Regards,

	Hans

Hans Verkuil (4):
  via-camera: call viafb_pm_unregister in remove()
  via-camera: use struct v4l2_fh
  ov7670: don't return ENOTTY if SUBDEV_API is not set
  via-camera: fix v4l2-compliance fails

 drivers/media/i2c/ov7670.c          |  6 +-
 drivers/media/platform/via-camera.c | 94 +++++++++++++++++------------
 2 files changed, 58 insertions(+), 42 deletions(-)

-- 
2.20.1

