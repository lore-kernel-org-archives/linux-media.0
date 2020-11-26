Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FD1C64E75
	for <linux-media@archiver.kernel.org>; Thu, 26 Nov 2020 09:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FE7206B2
	for <linux-media@archiver.kernel.org>; Thu, 26 Nov 2020 09:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbgKZJgr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Nov 2020 04:36:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39252 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbgKZJgr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Nov 2020 04:36:47 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 3A1CC1F450FA
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v5 02/14] media: controls: Add validate failure debug message
Date:   Thu, 26 Nov 2020 06:36:06 -0300
Message-Id: <20201126093618.137292-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201126093618.137292-1-ezequiel@collabora.com>
References: <20201126093618.137292-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add a debug message for control validation (validate_new)
failures. This is useful to debug issues with ioctls such
as VIDIOC_TRY_EXT_CTRLS and VIDIOC_S_EXT_CTRLS.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 7febfbb256a6..3979e7924007 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -4112,8 +4112,13 @@ static int try_set_ext_ctrls_common(struct v4l2_fh *fh,
 			struct v4l2_ctrl *ctrl = helpers[idx].ref->ctrl;
 
 			ret = user_to_new(cs->controls + idx, ctrl);
-			if (!ret && ctrl->is_ptr)
+			if (!ret && ctrl->is_ptr) {
 				ret = validate_new(ctrl, ctrl->p_new);
+				if (ret)
+					dprintk(vdev,
+						"failed to validate control %s (%d)\n",
+						v4l2_ctrl_get_name(ctrl->id), ret);
+			}
 			idx = helpers[idx].next;
 		} while (!ret && idx);
 
-- 
2.27.0

