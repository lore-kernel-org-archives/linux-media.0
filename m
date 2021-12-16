Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F88EC433F5
	for <linux-media@archiver.kernel.org>; Thu, 16 Dec 2021 09:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhLPJDy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 16 Dec 2021 04:03:54 -0500
Received: from comms.puri.sm ([159.203.221.185]:54744 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhLPJDy (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 16 Dec 2021 04:03:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B3D68DFFA2;
        Thu, 16 Dec 2021 01:03:53 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Gtz_jEq0aJ8; Thu, 16 Dec 2021 01:03:53 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm, festevam@gmail.com,
        laurent.pinchart@ideasonboard.com, p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        mchehab@kernel.org, slongerbeam@gmail.com, kernel@puri.sm
Subject: [PATCH v2 0/2] media: imx: imx8mq-mipi-csi2 fixes
Date:   Thu, 16 Dec 2021 10:03:34 +0100
Message-Id: <20211216090336.451665-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

hi Laurent and all interested,

these are fixes for the imx8mq mipi controller driver I collected recently.

thank you very much for any review,

                            martin

revision history
----------------
v2:
* refactor the suspend/resume callbacks to be more intuitive

v1:
https://lore.kernel.org/linux-media/20211206131242.2697464-1-martin.kepplinger@puri.sm/

Martin Kepplinger (2):
  media: imx: imx8mq-mipi-csi2: remove wrong irq config write operation
  media: imx: imx8mq-mipi_csi2: fix system resume

 drivers/staging/media/imx/imx8mq-mipi-csi2.c | 74 +++++++++++++-------
 1 file changed, 47 insertions(+), 27 deletions(-)

-- 
2.30.2

