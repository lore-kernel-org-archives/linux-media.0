Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BE1C388F7
	for <linux-media@archiver.kernel.org>; Tue, 10 Nov 2020 10:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D4A2076E
	for <linux-media@archiver.kernel.org>; Tue, 10 Nov 2020 10:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mess.org header.i=@mess.org header.b="jIDxo/pS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgKJK6w (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 10 Nov 2020 05:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJK6w (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 10 Nov 2020 05:58:52 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22AFC0613CF
        for <linux-media@vger.kernel.org>; Tue, 10 Nov 2020 02:58:51 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 7E01EC635E; Tue, 10 Nov 2020 10:58:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1605005930; bh=aokA0Hr/bcu+G/jYD68sGBsrhQel2wH4YXjz33tdqbY=;
        h=Date:From:To:Subject:From;
        b=jIDxo/pSC5iIGpzIja52KUZr+iyTd6+5uy5Txt5rOEYU4o0ceKzoykVMer4oVTpzx
         Xe18Bn1y5b5KW085N4W16qfumGoygpJPOSV0CuFgwu6v6GdTfE/Qr5ZsUjgYzSFC20
         SxaKjM++XL+VvMCKLJYzH1lRwiHmfXbYdl86aVzTu/3nBEZl20+4nuVe8Ro0fmnl+K
         PfjMGEyB2VSLx9uhZdCdhmURqC+0X68AQYnBN0JB78KOtGeuIeyhfi0anpRnu9S3YZ
         wbVo8B3da91ElI08HY8VlAe5lrXtGA4ZCaIRFQX/5vJu4KJ9ayx5RbEeWChkyg5G4y
         5BypDiPETe6EQ==
Date:   Tue, 10 Nov 2020 10:58:50 +0000
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.11] Minor DVB & RC fixes
Message-ID: <20201110105850.GA27501@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 0ab4f9087ea94ff92dc2ae68180faaf6bd443021:

  media: platform: add missing put_device() call in mtk_jpeg_probe() and mtk_jpeg_remove() (2020-11-05 18:03:11 +0100)

are available in the Git repository at:

  git://linuxtv.org/syoung/media_tree.git tags/v5.11a

for you to fetch changes up to 24b0887fbf24b58278ae60d02ee41c642f5b1d84:

  media: dvbdev: Fix memleak in dvb_register_device (2020-11-10 10:42:01 +0000)

----------------------------------------------------------------
v5.11a

----------------------------------------------------------------
Dan Carpenter (1):
      media: rc: validate that "rc_proto" is reasonable

Dinghao Liu (1):
      media: dvbdev: Fix memleak in dvb_register_device

Qinglang Miao (1):
      media: usb: dvb-usb-v2: zd1301: fix missing platform_device_unregister()

 drivers/media/dvb-core/dvbdev.c       | 3 +++
 drivers/media/rc/lirc_dev.c           | 3 ++-
 drivers/media/usb/dvb-usb-v2/zd1301.c | 2 +-
 include/uapi/linux/lirc.h             | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)
