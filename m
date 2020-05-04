Return-Path: <SRS0=C6Fs=6S=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E672DC3A5A9
	for <linux-media@archiver.kernel.org>; Mon,  4 May 2020 09:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88B3206B9
	for <linux-media@archiver.kernel.org>; Mon,  4 May 2020 09:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="F+C7RpeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgEDJ0p (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 May 2020 05:26:45 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56720 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgEDJ0p (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 4 May 2020 05:26:45 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 140D94F7;
        Mon,  4 May 2020 11:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1588584401;
        bh=LDVliL/PHYd5kyS/hZzNxXnIFRr/vN4pjrGIE4byH18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+C7RpeD3Gv11vmgfuqprB6zM5suvET9/PUzPmp7kTFmnV2AUUvKlhBpuirRbFLa+
         UOeoCrRjs8/3RO7yjK4WtQVD1oiVCbjsrdv2i9gVxK1ATARJUtdSfOI6N/pXtxl9X1
         NspMn8sSl2hZnex8Ikw3L+uQZ+Kzg03EnGkITNu8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Naushir Patuck <naush@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Subject: [PATCH v2 22/34] staging: mmal-vchiq: Free the event context for control ports
Date:   Mon,  4 May 2020 12:25:59 +0300
Message-Id: <20200504092611.9798-23-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504092611.9798-1-laurent.pinchart@ideasonboard.com>
References: <20200504092611.9798-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

vchiq_mmal_component_init calls init_event_context for the
control port, but vchiq_mmal_component_finalise didn't free
it, causing a memory leak..

Add the free call.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 9fc1a29f9f1a..95437d9c519c 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1976,6 +1976,8 @@ int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
 	for (idx = 0; idx < component->clocks; idx++)
 		free_event_context(&component->clock[idx]);
 
+	free_event_context(&component->control);
+
 	mutex_unlock(&instance->vchiq_mutex);
 
 	return ret;
-- 
Regards,

Laurent Pinchart

