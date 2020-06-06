Return-Path: <SRS0=TTqz=7T=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA39C433E3
	for <linux-media@archiver.kernel.org>; Sat,  6 Jun 2020 10:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68012073E
	for <linux-media@archiver.kernel.org>; Sat,  6 Jun 2020 10:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgFFK4G (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 6 Jun 2020 06:56:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46286 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgFFK4D (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 6 Jun 2020 06:56:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 13945260258
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org, skhan@linuxfoundation.org,
        p.zabel@pengutronix.de
Subject: [PATCH v4l-utils 3/4] v4l2-ctl: subdev: Add support for the CSC API in the subdevices
Date:   Sat,  6 Jun 2020 12:55:37 +0200
Message-Id: <20200606105538.30147-4-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200606105538.30147-1-dafna.hirschfeld@collabora.com>
References: <20200606105538.30147-1-dafna.hirschfeld@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The CSC API allows userspace to configure the quantization and
(ycbcr/hsv)_enc fields when setting the formats, so those fields
are not read only in userspace. This patch adds support for
this API in subevices.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 utils/v4l2-ctl/v4l2-ctl-subdev.cpp | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/utils/v4l2-ctl/v4l2-ctl-subdev.cpp b/utils/v4l2-ctl/v4l2-ctl-subdev.cpp
index c0f36eab..bc9ee101 100644
--- a/utils/v4l2-ctl/v4l2-ctl-subdev.cpp
+++ b/utils/v4l2-ctl/v4l2-ctl-subdev.cpp
@@ -428,10 +428,14 @@ void subdev_set(cv4l_fd &_fd)
 				fmt.format.colorspace = ffmt.colorspace;
 			if (set_fmt & FmtXferFunc)
 				fmt.format.xfer_func = ffmt.xfer_func;
-			if (set_fmt & FmtYCbCr)
+			if (set_fmt & FmtYCbCr) {
 				fmt.format.ycbcr_enc = ffmt.ycbcr_enc;
-			if (set_fmt & FmtQuantization)
+				fmt.format.flags |= V4L2_MBUS_FRAMEFMT_SET_CSC;
+			}
+			if (set_fmt & FmtQuantization) {
 				fmt.format.quantization = ffmt.quantization;
+				fmt.format.flags |= V4L2_MBUS_FRAMEFMT_SET_CSC;
+			}
 
 			if (options[OptSetSubDevFormat])
 				printf("Note: --set-subdev-fmt is only for testing.\n"
-- 
2.17.1

