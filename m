Return-Path: <SRS0=7xhz=A4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1248FC433DF
	for <linux-media@archiver.kernel.org>; Fri, 17 Jul 2020 14:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D4120734
	for <linux-media@archiver.kernel.org>; Fri, 17 Jul 2020 14:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="wWwuHdnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgGQONA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:13:00 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:36437 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbgGQOM7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 17 Jul 2020 10:12:59 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id wR6bjYKzPyPEdwR6ej5SoA; Fri, 17 Jul 2020 16:12:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1594995178; bh=6Jnqifz1mI3zjgUKchEg5ThnJmrQ/ZJsHCX6tyYChh0=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=wWwuHdnXBpwr4WEolEmcfhEQT73VJ9toz1PFW7NOfzDPE9pvHsfSm8ZszrFI6TGu4
         U0STDgZrTMUWtx+9V2xbo4nGQoTL4LpSgJfR5IyE+BPZIK9PfEsOeoXEk5PBjlWyww
         mDTiUxDi0qUvsS17ix2qza8fxnmIEq2gfZ9/WjyCQXRFpWKAvHk3YJpqc9A8FSIEmI
         CVIgxH9hdRDZCQTLq+8zu0XzI2+wr/yT9ZS2xyfoeZa7ngHW0lOxQmAqDfE5TW3aa8
         cNkh5EvHPa3lxf2ZEJkKuTAHfkZsiM1h0CjTrNhp631h01S97ZzcGsUBLnQ92vy1NP
         C1CnHZmIZ4sDw==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.9] Various fixes/enhancements
Message-ID: <2722f996-2891-5991-f14a-680e75a69cad@xs4all.nl>
Date:   Fri, 17 Jul 2020 16:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAno/u5pjl3nVemX8CRLYcJjGaWNMjj1/vYnbdAusD2dTFi86S+jHPT1dU65DvOTMoZa5vKrtjy5B5DDRZAETmk/+FsTj4WoP2ZL+Y9A3y0FhZ157vTp
 /lblvG1OGDIdQ0O77gz+kYPlx5FPEiWCVn06OsN+tmzOh5Fn8CV9jIQtNTWTJTDm2qg6jqhOOlmCRfmvq2j+KfvVk8QZfLHd6e0=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 6f01dfb760c027d5dd6199d91ee9599f2676b5c6:

  media: cros-ec-cec: do not bail on device_init_wakeup failure (2020-07-04 12:45:45 +0200)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.9i

for you to fetch changes up to 52e3da59341a6d416915a5e5c7ef0d8daf19992d:

  dvbdev.h: keep * together with the type (2020-07-17 15:58:18 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Ezequiel Garcia (1):
      media: videobuf2: Print videobuf2 buffer state by name

Hans Verkuil (3):
      colorspaces-details.rst: fix V4L2_COLORSPACE_JPEG description
      v4l2-subdev.h: keep * together with the type
      dvbdev.h: keep * together with the type

Vaibhav Gupta (6):
      sta2x11: use generic power management
      cx23885: use generic power management
      cx25821: use generic power management
      cx88: use generic power management
      meye: use generic power management
      tw68: use generic power management

 Documentation/userspace-api/media/v4l/colorspaces-details.rst |  4 +--
 drivers/media/common/videobuf2/videobuf2-core.c               | 35 +++++++++++++++++-----
 drivers/media/pci/cx23885/cx23885-core.c                      |  3 --
 drivers/media/pci/cx25821/cx25821-core.c                      |  3 --
 drivers/media/pci/cx88/cx88-video.c                           | 60 ++++++++++----------------------------
 drivers/media/pci/meye/meye.c                                 | 15 ++++------
 drivers/media/pci/sta2x11/sta2x11_vip.c                       | 63 ++++++++++------------------------------
 drivers/media/pci/tw68/tw68-core.c                            | 30 +++++++------------
 include/media/dvbdev.h                                        |  4 +--
 include/media/v4l2-subdev.h                                   | 25 ++++++++--------
 10 files changed, 91 insertions(+), 151 deletions(-)
