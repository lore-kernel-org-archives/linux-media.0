Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D50EC43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8FE206A3
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 01:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWEqatyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfDZB0z (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:26:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39413 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfDZB0z (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 21:26:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id l18so745148pgj.6
        for <linux-media@vger.kernel.org>; Thu, 25 Apr 2019 18:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P1LxeqOhkTMaWGpf4YGKrqKHM2vgygwQ5P6gc0h8pCs=;
        b=TWEqatyCZy/ZPx4dBPksy1W0mgBZaF0yGPkpkN6w1uQDEj62S01WYlNptiIbxUjVI7
         FILVAzQncGZxQXGxjrjUAqh3xcQAukPDk5aFkZUoT04kHwE9VdxBocBubUkCBjlNmSwS
         xNwFta+V1fUjXDUU8ENFqLNFwqQicimEawHI4pXEXYHmP6BBy+3b7YgV/PhhBS0RJxWU
         Isk18qei6emxk9MOADZZ9Rj1KmOuVsm/yL8/FZ9dG0NUb51hxYr/hR+cNFXmtA3Dr7zZ
         NGAjjob/9WuEusdVRoP0b9qOxvuTvuXoUUipv/XLX3KoLt17EGwJq+NVWEoG563KLQrU
         lf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P1LxeqOhkTMaWGpf4YGKrqKHM2vgygwQ5P6gc0h8pCs=;
        b=hD8sp3K3mY7C7mbXbl6ngmq2BgMBvi856KWP0t9VNNXr2/fm/Y8mOX7p3RrBJmnAuK
         gab+4NBqEdc+8wyQmB/twPXj4QuVeMjxLH+yJZHtNt+uPhyh7jR1q1H5oUsPNo18/bt5
         5tuzbr4V0fHTtKydH77AZQDqZjiGan0PMNitH3EjqoxWdIikNnt4aEm2Jpu7mJOrfUvg
         gbERg0ORr0DJlWxRJ4SlmoHpWwlDmxg9T+dzVe5ZjMyNR+MO29zHEFd731X7SNPJR/cy
         TdJ5xJJMIHVYqOBf0YBeGs6PhoLASRrQy8HivUbdLg2LWTNwY0NL+TTpRyGDeFh6EMy1
         3ezg==
X-Gm-Message-State: APjAAAVBW50dNjvLG0Nlxs7v7yBeADc4HOhiqjp59JBt43skDJsJc3Da
        zIfc4XEe4wthp2Gzpl1RJUS06CK3
X-Google-Smtp-Source: APXvYqwZi4OlqUYDrEcCdrC/Diib2PZEDr0YvxLNqUnv7wmLFjvKnepUe38jcqrgBUi4GxNC/ZWEqw==
X-Received: by 2002:aa7:81d0:: with SMTP id c16mr43034489pfn.132.1556242014472;
        Thu, 25 Apr 2019 18:26:54 -0700 (PDT)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id l184sm46494230pfc.98.2019.04.25.18.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 18:26:53 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>
Subject: [PATCH 0/6] Switch to sync registration for IPU subdevs
Date:   Thu, 25 Apr 2019 18:26:41 -0700
Message-Id: <20190426012647.7128-1-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Switch to sync registration for the IPU internal sub-devices, re-organize
modules, and a few other miscellaneous cleanups.

Steve Longerbeam (6):
  media: staging/imx: Switch to sync registration for IPU subdevs
  media: staging/imx: Pass device to alloc/free_dma_buf
  media: staging/imx: Move add_video_device into capture_device_register
  Revert "media: imx: Set capture compose rectangle in
    capture_device_set_format"
  media: staging/imx: Remove capture_device_set_format
  media: staging/imx: Re-organize modules

 drivers/staging/media/imx/Makefile            |  18 +-
 drivers/staging/media/imx/imx-ic-common.c     |  70 +--
 drivers/staging/media/imx/imx-ic-prp.c        |  34 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c   |  88 ++--
 drivers/staging/media/imx/imx-ic.h            |   7 +-
 drivers/staging/media/imx/imx-media-capture.c |  70 ++-
 drivers/staging/media/imx/imx-media-csi.c     |  32 +-
 .../staging/media/imx/imx-media-dev-common.c  | 345 +++++++++++++-
 drivers/staging/media/imx/imx-media-dev.c     | 449 +-----------------
 drivers/staging/media/imx/imx-media-fim.c     |   5 -
 .../staging/media/imx/imx-media-internal-sd.c | 356 ++++++--------
 drivers/staging/media/imx/imx-media-of.c      |  41 +-
 drivers/staging/media/imx/imx-media-utils.c   |  42 +-
 drivers/staging/media/imx/imx-media-vdic.c    |  85 +---
 drivers/staging/media/imx/imx-media.h         |  97 ++--
 drivers/staging/media/imx/imx7-media-csi.c    |  41 +-
 16 files changed, 765 insertions(+), 1015 deletions(-)

-- 
2.17.1

