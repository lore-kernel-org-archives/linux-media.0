Return-Path: <SRS0=nwdt=VN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CFCC76188
	for <linux-media@archiver.kernel.org>; Tue, 16 Jul 2019 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C8620880
	for <linux-media@archiver.kernel.org>; Tue, 16 Jul 2019 12:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1k9j9xY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfGPM17 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:27:59 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53475 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGPM17 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Jul 2019 08:27:59 -0400
Received: by mail-qt1-f201.google.com with SMTP id h47so17838184qtc.20
        for <linux-media@vger.kernel.org>; Tue, 16 Jul 2019 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/bOkXYUTo+ONsBE31JFge3XwJortkoB3vocu6FHYM2A=;
        b=s1k9j9xY0P+wsWmBSuZUTTtXGFgkeQCPYvTdeJ4vjUDq3JHBu6uLj7d6F8pCwDPQrk
         n4oTKPuxYu4Lmogv5hWbiK2KREIo+9sDRaXGYhraaP/UdKo+dSLc32lXml3dPoI9ANZS
         cheJ5NRvx3ybbo/PeD/C1qagpxteXG9SlW+XNgotmwav2plUdy20VCW+m0T5y2a/HZcd
         SrgofDxLo2Q/bmEIL3HX5IJV6W2VR59FOkFaHPT10qXMA4yS/llq0yeveEmQkqnRF0Jp
         dqcNP4mgWzLFOfIM+I6nnW9oPwivDlboheXGc/kUebjbd9KHoq/kLuOvCVWcx+3JD2H7
         oAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/bOkXYUTo+ONsBE31JFge3XwJortkoB3vocu6FHYM2A=;
        b=edTkq0TX7WtjPX7NduVIJWQpTYOv2nPSbO0o6f5TmSW5bRRLBmPZTSZbzqVAgCrTPr
         WXm31Xh5BsAkFtwGRlQ8rhY6FoACehBGhpCqjHhRztCqwmyry709CESFVniz1HxsGP/w
         h1FurTpRicv1QKa3vUv5Wd6GNupVzroTnNg7uyfOeKmvUE4svGUFbPXDF0+qABjU9nz8
         iLx/LNBvN+8x4Gj7hpb9UUojQ6+/lfhzDvFsJG+s1mbZsjtR6wjo7RAB1mQY99koM8x6
         ewogD89QXaJ9P3mjfEMHbusgs4/ouupwu6Sf56nuqLFHcgAmU5yXoyafbWYqqjPsLuEh
         f43A==
X-Gm-Message-State: APjAAAW3LzfnY4OZitcqZMV/WaTDXCrYYqmHSXWF1AfN4ZMchZu9ODW3
        l0GLIBsf38/IU55qpPWCSPNCr0XmRtzcNsEX6lqO+263p62wryPXnt77IlbnwshFcKOQZJj3aKZ
        V6eLSgBenM9DKrGy05Z/qKbG8qnkHWswvjh/c3Tx9vCxehVKwSj6YAw2rlEyabY2H3uku
X-Google-Smtp-Source: APXvYqzl+OPaWf4U299jB/Awuj29sgi51K1KrBzd8Z45Lgrjh59a5V71pMx9ekZAw/J6TSgFLrRzwLKjkmA=
X-Received: by 2002:ac8:4a02:: with SMTP id x2mr22016334qtq.329.1563280077978;
 Tue, 16 Jul 2019 05:27:57 -0700 (PDT)
Date:   Tue, 16 Jul 2019 14:27:11 +0200
In-Reply-To: <20190716122718.125993-1-darekm@google.com>
Message-Id: <20190716122718.125993-3-darekm@google.com>
Mime-Version: 1.0
References: <20190716122718.125993-1-darekm@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v4 2/9] drm/i915/intel_hdmi: use cec_notifier_conn_(un)register
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl
Cc:     Dariusz Marcinkiewicz <darekm@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Use the new cec_notifier_conn_(un)register() functions to
(un)register the notifier for the HDMI connector, and fill in
the cec_connector_info.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/gpu/drm/i915/intel_hdmi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
index 187a2b828b975..db7953ce49c8e 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -2752,8 +2752,9 @@ intel_hdmi_connector_register(struct drm_connector *connector)
 
 static void intel_hdmi_destroy(struct drm_connector *connector)
 {
-	if (intel_attached_hdmi(connector)->cec_notifier)
-		cec_notifier_put(intel_attached_hdmi(connector)->cec_notifier);
+	struct cec_notifier *n = intel_attached_hdmi(connector)->cec_notifier;
+
+	cec_notifier_conn_unregister(n);
 
 	intel_connector_destroy(connector);
 }
@@ -3061,6 +3062,7 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
 	struct drm_device *dev = intel_encoder->base.dev;
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	enum port port = intel_encoder->port;
+	struct cec_connector_info conn_info;
 
 	DRM_DEBUG_KMS("Adding HDMI connector on port %c\n",
 		      port_name(port));
@@ -3113,8 +3115,11 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
 		I915_WRITE(PEG_BAND_GAP_DATA, (temp & ~0xf) | 0xd);
 	}
 
-	intel_hdmi->cec_notifier = cec_notifier_get_conn(dev->dev,
-							 port_identifier(port));
+	cec_fill_conn_info_from_drm(&conn_info, connector);
+
+	intel_hdmi->cec_notifier =
+		cec_notifier_conn_register(dev->dev, port_identifier(port),
+					   &conn_info);
 	if (!intel_hdmi->cec_notifier)
 		DRM_DEBUG_KMS("CEC notifier get failed\n");
 }
-- 
2.22.0.510.g264f2c817a-goog

