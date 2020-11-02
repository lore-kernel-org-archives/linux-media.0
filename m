Return-Path: <SRS0=t7pd=EI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF26C388F9
	for <linux-media@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6AC22275
	for <linux-media@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKBSzA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:00 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:7352 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbgKBSzA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:00 -0500
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Nov 2020 10:55:00 -0800
X-QCInternal: smtphost
Received: from veeras-linux.qualcomm.com ([10.134.68.137])
  by ironmsg01-sd.qualcomm.com with ESMTP; 02 Nov 2020 10:55:00 -0800
Received: by veeras-linux.qualcomm.com (Postfix, from userid 330320)
        id 676202192E; Mon,  2 Nov 2020 10:55:00 -0800 (PST)
From:   Veera Sundaram Sankaran <veeras@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        sumit.semwal@linaro.org, gustavo@padovan.org
Cc:     Veera Sundaram Sankaran <veeras@codeaurora.org>,
        robdclark@gmail.com, pdhaval@codeaurora.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org
Subject: [PATCH 2/2] drm/drm_vblank: set the dma-fence timestamp during send_vblank_event
Date:   Mon,  2 Nov 2020 10:54:46 -0800
Message-Id: <1604343286-3262-2-git-send-email-veeras@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604343286-3262-1-git-send-email-veeras@codeaurora.org>
References: <1604343286-3262-1-git-send-email-veeras@codeaurora.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The explicit out-fences in crtc are signaled as part of vblank event,
indicating all framebuffers present on the Atomic Commit request are
scanned out on the screen. Though the fence signal and the vblank event
notification happens at the same time, triggered by the same hardware
vsync event, the timestamp set in both are different. With drivers
supporting precise vblank timestamp the difference between the two
timestamps would be even higher. This might have an impact on use-mode
frameworks using these fence timestamps for purposes other than simple
buffer usage. For instance, the Android framework uses the retire-fences
as an alternative to vblank when frame-updates are in progress Set the
fence timestamp during send vblank event to avoid discrepancies.

Signed-off-by: Veera Sundaram Sankaran <veeras@codeaurora.org>
---
 drivers/gpu/drm/drm_vblank.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index b18e1ef..b38e50c 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -24,6 +24,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/dma-fence.h>
 #include <linux/export.h>
 #include <linux/kthread.h>
 #include <linux/moduleparam.h>
@@ -999,6 +1000,14 @@ static void send_vblank_event(struct drm_device *dev,
 		e->event.seq.time_ns = ktime_to_ns(now);
 		break;
 	}
+
+	/*
+	 * update fence timestamp with the same vblank timestamp as both
+	 * are signaled by the same event
+	 */
+	if (e->base.fence)
+		e->base.fence->timestamp = now;
+
 	trace_drm_vblank_event_delivered(e->base.file_priv, e->pipe, seq);
 	drm_send_event_locked(dev, &e->base);
 }
-- 
2.7.4

