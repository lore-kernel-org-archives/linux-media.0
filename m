Return-Path: <SRS0=8nip=A3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B979EC433FC
	for <linux-media@archiver.kernel.org>; Thu, 16 Jul 2020 14:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A247320787
	for <linux-media@archiver.kernel.org>; Thu, 16 Jul 2020 14:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgGPOYU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:24:20 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36557 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGPOYT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Jul 2020 10:24:19 -0400
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 228CE1BF206;
        Thu, 16 Jul 2020 14:24:14 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund+renesas@ragnatech.se,
        kieran.bingham@ideasonboard.com, dave.stevenson@raspberrypi.com,
        hyun.kwon@xilinx.com, jmkrzyszt@gmail.com, robert.jarzmik@free.fr,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v7 07/10] staging: media: imx: Update TODO entry
Date:   Thu, 16 Jul 2020 16:27:10 +0200
Message-Id: <20200716142713.110655-8-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716142713.110655-1-jacopo+renesas@jmondi.org>
References: <20200716142713.110655-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Update the TODO entry that mentioned a potential use case for the now
removed g_mbus_config video operation.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/staging/media/imx/TODO | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/media/imx/TODO b/drivers/staging/media/imx/TODO
index a371cdedcdb0..9cfc1c1e78dc 100644
--- a/drivers/staging/media/imx/TODO
+++ b/drivers/staging/media/imx/TODO
@@ -10,6 +10,10 @@
   driver uses the parsed DT bus config method until this issue is
   resolved.
 
+  2020-06: g_mbus has been removed in favour of the get_mbus_config pad
+  operation which should be used to avoid parsing the remote endpoint
+  configuration.
+
 - This media driver supports inheriting V4L2 controls to the
   video capture devices, from the subdevices in the capture device's
   pipeline. The controls for each capture device are updated in the
-- 
2.27.0

