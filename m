Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AED9C4320A
	for <linux-media@archiver.kernel.org>; Mon, 30 Aug 2021 11:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353326112D
	for <linux-media@archiver.kernel.org>; Mon, 30 Aug 2021 11:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhH3LDU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Aug 2021 07:03:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43892 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbhH3LDL (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Aug 2021 07:03:11 -0400
Received: from deskari.lan (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0278146F;
        Mon, 30 Aug 2021 13:02:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1630321336;
        bh=MrJ4HkADrgP9n/o3SsEiZg1PZ2QwedPdLMqwSWtdQp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3Y700105/d0i+YhGtpUptRxEE8AKBIzgJjjkeEf/vJnQ3DWnvgNjrJenxCYZgdtd
         8nFnbXtpEPUvuMLz2cKaKuu3O5lYoZA9ZLlmtFYNipVb3tJrInZY35HK49605FWlMA
         YC7rS1UlkJqlJyJDsz+8HUgc5wcLHfQkQJagP/G0=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v8 07/36] media: Documentation: add documentation about subdev state
Date:   Mon, 30 Aug 2021 14:00:47 +0300
Message-Id: <20210830110116.488338-8-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830110116.488338-1-tomi.valkeinen@ideasonboard.com>
References: <20210830110116.488338-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add documentation about centrally managed subdev state.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../driver-api/media/v4l2-subdev.rst          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/driver-api/media/v4l2-subdev.rst b/Documentation/driver-api/media/v4l2-subdev.rst
index 7736da077fb8..b28607c3fc79 100644
--- a/Documentation/driver-api/media/v4l2-subdev.rst
+++ b/Documentation/driver-api/media/v4l2-subdev.rst
@@ -518,6 +518,31 @@ The :c:func:`v4l2_i2c_new_subdev` function will call
 :c:type:`i2c_board_info` structure using the ``client_type`` and the
 ``addr`` to fill it.
 
+Centrally managed subdev active state
+-------------------------------------
+
+Traditionally V4L2 subdev drivers maintained internal state for the active
+configuration for the subdev. This is often implemented as an array of struct
+v4l2_mbus_framefmt, on entry for each pad.
+
+In addition to the active configuration, each subdev filehandle has contained
+an array of struct v4l2_subdev_pad_config, managed by V4L2 core, which
+contains the TRY configuration.
+
+To simplify the subdev drivers the V4L2 subdev API now optionally supports a
+centrally managed active configuration. A subdev driver must use
+v4l2_subdev_alloc_state() to initialize the active state between calls to
+media_entity_pads_init() and v4l2_*_register_subdev().
+
+The active state must be locked before access, and can be done with e.g.
+v4l2_subdev_lock_state() or v4l2_subdev_lock_active_state().
+
+The V4L2 core will pass either the TRY or ACTIVE state to various subdev ops.
+Unfortunately all the subdev drivers do not comply with this yet, and may
+pass NULL for the ACTIVE case, so the called subdev ops must also handle the
+NULL case. This can be easily managed by the helpers
+v4l2_subdev_validate_state() or v4l2_subdev_validate_and_lock_state().
+
 V4L2 sub-device functions and data structures
 ---------------------------------------------
 
-- 
2.25.1

