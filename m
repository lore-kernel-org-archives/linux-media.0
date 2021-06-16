Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86379C48BE5
	for <linux-media@archiver.kernel.org>; Wed, 16 Jun 2021 12:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B66761351
	for <linux-media@archiver.kernel.org>; Wed, 16 Jun 2021 12:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhFPMrp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:47:45 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58307 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFPMro (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Jun 2021 08:47:44 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B30001C000E;
        Wed, 16 Jun 2021 12:45:35 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/15] media: gmsl: Reliability improvements
Date:   Wed, 16 Jun 2021 14:46:01 +0200
Message-Id: <20210616124616.49249-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,
   series following:
v1: https://patchwork.linuxtv.org/project/linux-media/list/?series=4650
v2: https://patchwork.linuxtv.org/project/linux-media/list/?series=4861
v3: https://patchwork.linuxtv.org/project/linux-media/list/?series=4904
v4: https://patchwork.linuxtv.org/project/linux-media/list/?series=5149

I've dropped from this version the last two patches of the previous version
as it is still subject to discussion.

Compared to the previous version I've collected review tags and fixed some
minors in the commit messages.

I've tested on Eagle with RDACM20 and compared to the full series the success
rate is slightly lower (1 error on 20 boots) but still better than the current
mainline version.

On top of this series a rework of the initialization sequence deferring
resulting from Hans suggestions will follow.

Hans, can a pull request for this series be sent for v5.14 ?
I applied it on top of
https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=for-v5.14j
and found no issues.

Thanks
   j

Jacopo Mondi (15):
  media: i2c: max9286: Adjust parameters indent
  media: i2c: max9286: Rename reverse_channel_mv
  media: i2c: max9286: Cache channel amplitude
  media: i2c: max9286: Define high channel amplitude
  media: i2c: max9286: Rework comments in .bound()
  media: i2c: max9271: Check max9271_write() return
  media: i2c: max9271: Introduce wake_up() function
  media: i2c: rdacm21: Add delay after OV490 reset
  media: i2c: rdacm21: Fix OV10640 powerup
  media: i2c: rdacm21: Power up OV10640 before OV490
  media: i2c: rdacm20: Enable noise immunity
  media: i2c: rdacm20: Embed 'serializer' field
  media: i2c: rdacm20: Report camera module name
  media: i2c: rdacm20: Check return values
  media: i2c: rdacm20: Re-work ov10635 reset

 drivers/media/i2c/max9271.c | 42 +++++++++++++++----
 drivers/media/i2c/max9271.h |  9 ++++
 drivers/media/i2c/max9286.c | 41 +++++++++---------
 drivers/media/i2c/rdacm20.c | 84 +++++++++++++++++++++----------------
 drivers/media/i2c/rdacm21.c | 67 +++++++++++++++++++----------
 5 files changed, 161 insertions(+), 82 deletions(-)

--
2.31.1

