Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10663C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67012082E
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfDJMde (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:33:34 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:50920 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728821AbfDJMdd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 08:33:33 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id ECPyhkd55NG8zECPzh0rHW; Wed, 10 Apr 2019 14:33:31 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] Remove deprecated zoran driver
Message-ID: <2370199f-c709-b138-602f-3f192d3f5f70@xs4all.nl>
Date:   Wed, 10 Apr 2019 14:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAqHF3x9m4CYcxRj9z+aSdkjscXyD5JJyrR9+m3gVp2Qlg7ECoNmmHWeEgVMcuJcMfoYYGKTm6SLJQqcgdLNvzGA0fgx7+lIz+8k0aVNx7SV/izLNz5+
 dcLbbE97uE8bkVaTs425UGMj8ujZS1g0Oq4lGtDoUds8UWsjIaOUQlhY2VzRRs7YQO5e4oRp3Mix7cDnJYs6t4izM76qQ0jIAQwCBlGdx6BkzNWR2uius60s
 9fQOGZ5wGWkdAWal1YDJr7hFnI9mBvfdl2QyIUTCPoc=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remove the deprecated zoran driver.

Regards,

	Hans

The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-zoran

for you to fetch changes up to 54af579ead7b55c803b28f122bce0f08ec525810:

  zoran: remove deprecated driver (2019-04-10 13:02:49 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (1):
      zoran: remove deprecated driver

 Documentation/media/v4l-drivers/index.rst  |    1 -
 Documentation/media/v4l-drivers/zoran.rst  |  583 ------------
 drivers/staging/media/Kconfig              |    2 -
 drivers/staging/media/Makefile             |    1 -
 drivers/staging/media/zoran/Kconfig        |   75 --
 drivers/staging/media/zoran/Makefile       |    7 -
 drivers/staging/media/zoran/TODO           |    4 -
 drivers/staging/media/zoran/videocodec.c   |  391 --------
 drivers/staging/media/zoran/videocodec.h   |  349 --------
 drivers/staging/media/zoran/zoran.h        |  402 ---------
 drivers/staging/media/zoran/zoran_card.c   | 1524 --------------------------------
 drivers/staging/media/zoran/zoran_card.h   |   50 --
 drivers/staging/media/zoran/zoran_device.c | 1619 ---------------------------------
 drivers/staging/media/zoran/zoran_device.h |   91 --
 drivers/staging/media/zoran/zoran_driver.c | 2850 -----------------------------------------------------------
 drivers/staging/media/zoran/zoran_procfs.c |  221 -----
 drivers/staging/media/zoran/zoran_procfs.h |   32 -
 drivers/staging/media/zoran/zr36016.c      |  516 -----------
 drivers/staging/media/zoran/zr36016.h      |  107 ---
 drivers/staging/media/zoran/zr36050.c      |  896 -------------------
 drivers/staging/media/zoran/zr36050.h      |  179 ----
 drivers/staging/media/zoran/zr36057.h      |  164 ----
 drivers/staging/media/zoran/zr36060.c      | 1006 ---------------------
 drivers/staging/media/zoran/zr36060.h      |  216 -----
 24 files changed, 11286 deletions(-)
 delete mode 100644 Documentation/media/v4l-drivers/zoran.rst
 delete mode 100644 drivers/staging/media/zoran/Kconfig
 delete mode 100644 drivers/staging/media/zoran/Makefile
 delete mode 100644 drivers/staging/media/zoran/TODO
 delete mode 100644 drivers/staging/media/zoran/videocodec.c
 delete mode 100644 drivers/staging/media/zoran/videocodec.h
 delete mode 100644 drivers/staging/media/zoran/zoran.h
 delete mode 100644 drivers/staging/media/zoran/zoran_card.c
 delete mode 100644 drivers/staging/media/zoran/zoran_card.h
 delete mode 100644 drivers/staging/media/zoran/zoran_device.c
 delete mode 100644 drivers/staging/media/zoran/zoran_device.h
 delete mode 100644 drivers/staging/media/zoran/zoran_driver.c
 delete mode 100644 drivers/staging/media/zoran/zoran_procfs.c
 delete mode 100644 drivers/staging/media/zoran/zoran_procfs.h
 delete mode 100644 drivers/staging/media/zoran/zr36016.c
 delete mode 100644 drivers/staging/media/zoran/zr36016.h
 delete mode 100644 drivers/staging/media/zoran/zr36050.c
 delete mode 100644 drivers/staging/media/zoran/zr36050.h
 delete mode 100644 drivers/staging/media/zoran/zr36057.h
 delete mode 100644 drivers/staging/media/zoran/zr36060.c
 delete mode 100644 drivers/staging/media/zoran/zr36060.h
