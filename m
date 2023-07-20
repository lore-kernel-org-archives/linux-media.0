Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0237BEB64DA
	for <linux-media@archiver.kernel.org>; Thu, 20 Jul 2023 07:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjGTHvN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 20 Jul 2023 03:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGTHvF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 20 Jul 2023 03:51:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FAF269F
        for <linux-media@vger.kernel.org>; Thu, 20 Jul 2023 00:51:03 -0700 (PDT)
Received: from desky.lan (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0D229B9;
        Thu, 20 Jul 2023 09:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689839407;
        bh=tBWTpiGZ0wQCh08nERIYZ8Lu1JBHGGOEukEX/nDM1j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JP0dA2sxesHz3dMgPHhtySAD1Q8fQ6+okLLlCBm9wfpqtLtT3WVKfbvd8jQSXUymq
         gOj4DzGASubBo7twMBV7kNk0RMb3b+kvOFR74HWTOPQZPBz9YDmUHGN55BVbb8A1Oh
         9sLgcYZeUaa9b6s5YS3CSxdqt5u5314JsgEh0kJU=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v6 1/8] v4l2-ctl: Improve sub-device options help text
Date:   Thu, 20 Jul 2023 10:50:37 +0300
Message-Id: <20230720075044.442021-2-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720075044.442021-1-tomi.valkeinen@ideasonboard.com>
References: <20230720075044.442021-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Explicitly mention that all the parameters to the options are optional,
and default to 0, and remove the one place where the default of 0 was
mentioned.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 utils/v4l2-ctl/v4l2-ctl-subdev.cpp | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/v4l2-ctl/v4l2-ctl-subdev.cpp b/utils/v4l2-ctl/v4l2-ctl-subdev.cpp
index 33cc1342..22fd9052 100644
--- a/utils/v4l2-ctl/v4l2-ctl-subdev.cpp
+++ b/utils/v4l2-ctl/v4l2-ctl-subdev.cpp
@@ -36,8 +36,9 @@ static double set_fps;
 void subdev_usage()
 {
 	printf("\nSub-Device options:\n"
+	       "Note: all parameters below (pad, code, etc.) are optional unless otherwise noted and default to 0\n"
 	       "  --list-subdev-mbus-codes <pad>\n"
-	       "                      display supported mediabus codes for this pad (0 is default)\n"
+	       "                      display supported mediabus codes for this pad\n"
 	       "                      [VIDIOC_SUBDEV_ENUM_MBUS_CODE]\n"
 	       "  --list-subdev-framesizes pad=<pad>,code=<code>\n"
 	       "                     list supported framesizes for this pad and code\n"
-- 
2.34.1

