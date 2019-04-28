Return-Path: <SRS0=wpjx=S6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45184C43219
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 19:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F562067C
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 19:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtUGhqSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfD1TJ0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:09:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33957 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1TJ0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 28 Apr 2019 15:09:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id d5so3447563plr.1
        for <linux-media@vger.kernel.org>; Sun, 28 Apr 2019 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g8hOtglNjwZOHuYOvLFSPe7fXTOqO8IFp2lilXBWt/k=;
        b=YtUGhqSS+7WslfK2HxjyCadOlI8NSsyQWBp8WcmhDlkNp3zs0EuDz7QljpXMn1H4hK
         eGLiuntkxZaf41CGmN5WwJ4P8774S69XMvAX0Rs6PfEdH0MeIOhwxVDUB410a0oenrFC
         X16GvBk309VsfcDQbufJMoiyAnkv/t60wZODh2QVf3BZR0DWtc+Ii9XgvXmKjsAAno9+
         ugCj0K/ohhJqTakk2HLIPfcWnLBqg/QCryfhEv/N96aYlciEexRfCaap5kQyAIpQyc/n
         2/ne42/yHBCjRs3igyMWrZxTdlpvrfyeVxZOYoRrQ/JxA/THA3Zlv7kymBC0szHtJe6o
         oU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g8hOtglNjwZOHuYOvLFSPe7fXTOqO8IFp2lilXBWt/k=;
        b=D3Az8+oKG9ZXakmfSlrmbpt+Qgt7FuosEMeyuaHp9u8oDethz+mVBeD5N8dq2OsFr4
         TqWYBxxtpw4/6INjKOe4iw2meF97K4Yd0vWaIkDa4MdkJohQIXEGI30TskhOvgarl/Un
         KBNxHEK9zo+6PZXCE595mLztYOr8sTDopi+UP/TCvkoJjUGgwUA+JbfdN+AWK7PVS1/M
         6FsxZD1E3oyWzLvsCuzHgrbgWBGX/KIVPhue8uLciPPWXeWOZsPL/NEXSDwIxOlekSg3
         PI9gXuK1o7SKfkn2zPgP0Q+CqIcgrM4JguuQa4WFlNxubVtjEoXwTLsR0wOt4uYoxyb3
         TyDw==
X-Gm-Message-State: APjAAAXElj1YsP5rCI9emIpG48zUYWmSlhX1BgKLIeF/8ITwxHcW6ZYb
        9ty5pZzVSa+R5Ax25poKSZquuESF
X-Google-Smtp-Source: APXvYqzE0EbxRAP1p6PMjfmcAa+hwrR9a2cvY+UzvhTrS3vwUSg4NVf3kuczWCZEJWFwp2k2JfrasA==
X-Received: by 2002:a17:902:2ae6:: with SMTP id j93mr59393400plb.18.1556478565116;
        Sun, 28 Apr 2019 12:09:25 -0700 (PDT)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id o14sm34204712pgn.4.2019.04.28.12.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 12:09:24 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>
Subject: [PATCH v2 0/8] Switch to sync registration for IPU subdevs
Date:   Sun, 28 Apr 2019 12:09:08 -0700
Message-Id: <20190428190916.26567-1-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Switch to sync registration for the IPU internal sub-devices, re-organize
modules, and a few other miscellaneous cleanups.

History:
v2:
- Added a patch that improves the pipeline upstream/downstream search
  functions, which no longer require the media device.
- Add a patch to remove getting media device from v4l2_dev driver data.

Steve Longerbeam (8):
  media: staging/imx: Switch to sync registration for IPU subdevs
  media: staging/imx: Pass device to alloc/free_dma_buf
  media: staging/imx: Move add_video_device into capture_device_register
  Revert "media: imx: Set capture compose rectangle in
    capture_device_set_format"
  media: staging/imx: Remove capture_device_set_format
  media: staging/imx: Re-organize modules
  media: staging/imx: Improve pipeline searching
  media: staging/imx: Don't set driver data for v4l2_dev

 drivers/staging/media/imx/Makefile            |  18 +-
 drivers/staging/media/imx/imx-ic-common.c     |  68 +--
 drivers/staging/media/imx/imx-ic-prp.c        |  36 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c   |  88 ++--
 drivers/staging/media/imx/imx-ic.h            |   6 +-
 drivers/staging/media/imx/imx-media-capture.c |  75 ++-
 drivers/staging/media/imx/imx-media-csi.c     |  45 +-
 .../staging/media/imx/imx-media-dev-common.c  | 346 +++++++++++++-
 drivers/staging/media/imx/imx-media-dev.c     | 449 +-----------------
 drivers/staging/media/imx/imx-media-fim.c     |   9 -
 .../staging/media/imx/imx-media-internal-sd.c | 357 ++++++--------
 drivers/staging/media/imx/imx-media-of.c      |  41 +-
 drivers/staging/media/imx/imx-media-utils.c   | 170 +++----
 drivers/staging/media/imx/imx-media-vdic.c    |  84 +---
 drivers/staging/media/imx/imx-media.h         | 113 +++--
 drivers/staging/media/imx/imx7-media-csi.c    |  43 +-
 16 files changed, 848 insertions(+), 1100 deletions(-)

-- 
2.17.1

