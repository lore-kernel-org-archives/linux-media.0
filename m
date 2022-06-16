Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F2BC433EF
	for <linux-media@archiver.kernel.org>; Thu, 16 Jun 2022 17:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiFPRaB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiFPRaA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Jun 2022 13:30:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36A2AE0E
        for <linux-media@vger.kernel.org>; Thu, 16 Jun 2022 10:29:59 -0700 (PDT)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C73E415;
        Thu, 16 Jun 2022 19:29:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655400597;
        bh=WbAYZ5u1wKQ4eIQQXlSTvgnp1/aug6c6lSjWDEieIic=;
        h=From:To:Cc:Subject:Date:From;
        b=W4OXlL4lj+nbi2bYADeFi3MpIASyz/rD3FYlxJLNZDFHhq/VT1Yh6hdC1LBdc8F4H
         SDiNMWZcLWK+jN+6Cl4i5s3bgESj1swx/DbLndQvwPkilRZmPPU4u2lx3KydgSyq6G
         fddz4EFStIFMBK4PKhRiXKQ+z6E3KLKBOcIucFjk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH] libv4l2subdev: Fix compilation error by including missing header
Date:   Thu, 16 Jun 2022 20:29:43 +0300
Message-Id: <20220616172943.31221-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The uintptr_t type is defined in stdint.h, which wasn't included. Fix
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 utils/media-ctl/libv4l2subdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/utils/media-ctl/libv4l2subdev.c b/utils/media-ctl/libv4l2subdev.c
index eb9e1cc43b7e..e2d6d6bb7558 100644
--- a/utils/media-ctl/libv4l2subdev.c
+++ b/utils/media-ctl/libv4l2subdev.c
@@ -27,6 +27,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdbool.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
Regards,

Laurent Pinchart

