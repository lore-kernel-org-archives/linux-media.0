Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323BCC433EC
	for <linux-media@archiver.kernel.org>; Mon, 22 Mar 2021 16:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217216199F
	for <linux-media@archiver.kernel.org>; Mon, 22 Mar 2021 16:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhCVQf6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhCVQfr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Mar 2021 12:35:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F5C061574;
        Mon, 22 Mar 2021 09:35:46 -0700 (PDT)
Received: from Q.local (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BBBDA1023;
        Mon, 22 Mar 2021 17:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616430942;
        bh=c9WqrAEYLGWr3A1YY6oyOpbP+Sa0/dyXdVIosbEFhcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyN1tEnWZUqX+G9kVkyKCBxjN0wuu1mPK2uqHUOGHyrunwn+L+G+cnmBc810EyGmN
         qY1T9k2gj+/DiHSloRwwoWhe84RIsLuB+QASsbCqQbZuNo8s7+CQLdhcmsG2y82H8n
         DirlRA4xO2oXQshsLhZTQXSLUGkCRpwtj30EpdaA=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v5 03/10] drm: rcar-du: Convert to the new VSP atomic API
Date:   Mon, 22 Mar 2021 16:35:28 +0000
Message-Id: <20210322163535.1090570-4-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322163535.1090570-1-kieran.bingham+renesas@ideasonboard.com>
References: <20210322163535.1090570-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The configuration API between the VSP and the DU has been updated to
provide finer grain control over modesetting, and enablement.

Split rcar_du_vsp_enable() into rcar_du_vsp_modeset() and
rcar_du_vsp_enable() accordingly, and update each function to use the
new VSP API.

There are no further users of the deprecated vsp1_du_setup_lif() which
can now be removed.

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
Changes since v2:

- Minor formatting changes

Changes since v3:
- Minor formatting for checkpatch.pl --strict

- Fix inlinc typo in disabled option code paths.
  Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c |  4 +++-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c  | 20 ++++++++++++++------
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h  |  3 +++
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index ea7e39d03545..53838dde2f29 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -533,8 +533,10 @@ static void rcar_du_crtc_setup(struct rcar_du_crtc *rcrtc)
 	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR, 0);
 
 	/* Enable the VSP compositor. */
-	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
+	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE)) {
+		rcar_du_vsp_modeset(rcrtc);
 		rcar_du_vsp_enable(rcrtc);
+	}
 
 	/* Turn vertical blanking interrupt reporting on. */
 	drm_crtc_vblank_on(&rcrtc->crtc);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index 23e41c83c875..16bd5bbf7b6c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -47,16 +47,14 @@ static void rcar_du_vsp_complete(void *private, unsigned int status, u32 crc)
 	drm_crtc_add_crc_entry(&crtc->crtc, false, 0, &crc);
 }
 
-void rcar_du_vsp_enable(struct rcar_du_crtc *crtc)
+void rcar_du_vsp_modeset(struct rcar_du_crtc *crtc)
 {
 	const struct drm_display_mode *mode = &crtc->crtc.state->adjusted_mode;
 	struct rcar_du_device *rcdu = crtc->dev;
-	struct vsp1_du_lif_config cfg = {
+	struct vsp1_du_modeset_config cfg = {
 		.width = mode->hdisplay,
 		.height = mode->vdisplay,
 		.interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE,
-		.callback = rcar_du_vsp_complete,
-		.callback_data = crtc,
 	};
 	struct rcar_du_plane_state state = {
 		.state = {
@@ -93,12 +91,22 @@ void rcar_du_vsp_enable(struct rcar_du_crtc *crtc)
 	 */
 	crtc->group->need_restart = true;
 
-	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
+	vsp1_du_atomic_modeset(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
+}
+
+void rcar_du_vsp_enable(struct rcar_du_crtc *crtc)
+{
+	struct vsp1_du_enable_config cfg = {
+		.callback = rcar_du_vsp_complete,
+		.callback_data = crtc,
+	};
+
+	vsp1_du_atomic_enable(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
 }
 
 void rcar_du_vsp_disable(struct rcar_du_crtc *crtc)
 {
-	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, NULL);
+	vsp1_du_atomic_disable(crtc->vsp->vsp, crtc->vsp_pipe);
 }
 
 void rcar_du_vsp_atomic_begin(struct rcar_du_crtc *crtc)
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.h b/drivers/gpu/drm/rcar-du/rcar_du_vsp.h
index 9b4724159378..82f2ffc9887f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.h
@@ -58,6 +58,7 @@ to_rcar_vsp_plane_state(struct drm_plane_state *state)
 #ifdef CONFIG_DRM_RCAR_VSP
 int rcar_du_vsp_init(struct rcar_du_vsp *vsp, struct device_node *np,
 		     unsigned int crtcs);
+void rcar_du_vsp_modeset(struct rcar_du_crtc *crtc);
 void rcar_du_vsp_enable(struct rcar_du_crtc *crtc);
 void rcar_du_vsp_disable(struct rcar_du_crtc *crtc);
 void rcar_du_vsp_atomic_begin(struct rcar_du_crtc *crtc);
@@ -73,6 +74,8 @@ static inline int rcar_du_vsp_init(struct rcar_du_vsp *vsp,
 {
 	return -ENXIO;
 }
+
+static inline void rcar_du_vsp_modeset(struct rcar_du_crtc *crtc) { };
 static inline void rcar_du_vsp_enable(struct rcar_du_crtc *crtc) { };
 static inline void rcar_du_vsp_disable(struct rcar_du_crtc *crtc) { };
 static inline void rcar_du_vsp_atomic_begin(struct rcar_du_crtc *crtc) { };
-- 
2.25.1

