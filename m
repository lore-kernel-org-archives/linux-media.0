Return-Path: <SRS0=Zegy=33=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4580CC352A2
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 09:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2328420838
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 09:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgBGJAG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:00:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50422 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgBGJAG (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 7 Feb 2020 04:00:06 -0500
Received: from localhost.localdomain (p200300CB87166A00301E621E2266094E.dip0.t-ipconnect.de [IPv6:2003:cb:8716:6a00:301e:621e:2266:94e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 468AE295A80;
        Fri,  7 Feb 2020 09:00:04 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org
Subject: [PATCH 0/4] media: staging: rkisp1: add serialization to the isp and resizer ops
Date:   Fri,  7 Feb 2020 09:59:47 +0100
Message-Id: <20200207085951.5226-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Subdevices' ops callbacks can be called either through uAPI with
ioctl or through kAPI with the v4l2_subdev_call macro. Therefore
the lock of the subdevice node is not set and instead the driver
itself is responsible for serializing the ops.
This patchset adds serialization to the isp and resizer subdevices.
A mutex field 'ops_lock' is added to the inner struct of each of them.

The ops_lock is then used in the following operations:

set_fmt, get_fmt, set_selection, get_selection, s_stream

Serialization for enum_mbus_code is not needed since this operation
is independent of the specific configuration.

Patches summary:

patch 1 Changes two functions that return int to return void
        and removes a redundant check of error since the functions don't fail.

patch 2 moves the check that the bus type is DPHY before initializing registers
        in the s_stream callback of the isp.

patch 3 adds serialization for the isp subdevice.

patch 4 adds serialization for the resizer subdevice.


Dafna Hirschfeld (4):
  media: staging: rkisp1: change function to return void instead of int
  media: staging: rkisp1: isp: check for dphy bus before initializations
    in s_stream
  media: staging: rkisp1: add serialization to the isp subdev ops
  media: staging: rkisp1: add serialization to the resizer subdev ops

 drivers/staging/media/rkisp1/rkisp1-common.h  |  3 ++
 drivers/staging/media/rkisp1/rkisp1-isp.c     | 51 ++++++++++---------
 drivers/staging/media/rkisp1/rkisp1-resizer.c | 16 +++++-
 3 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.17.1

