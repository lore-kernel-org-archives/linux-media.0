Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1AC433E9
	for <linux-media@archiver.kernel.org>; Fri, 19 Mar 2021 01:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6E664E22
	for <linux-media@archiver.kernel.org>; Fri, 19 Mar 2021 01:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhCSBS2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Mar 2021 21:18:28 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49442 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhCSBSS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Mar 2021 21:18:18 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DDBB34FD;
        Fri, 19 Mar 2021 02:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616116697;
        bh=YEXdxWFP7PTveEU2AoCtzBGpti0RCBLIcQaLlI+Ulfs=;
        h=From:To:Cc:Subject:Date:From;
        b=OiFnB3UwCpn+WuVzLFA0NDFYZsv4VzC/rjnXSDE/VT/U6C0Ie9/88MoEMjRS3YecY
         FvuGwjNM20JB3Bz8yTN2P6S4onW0kEkFQTodgpgwev1KS1nAq71lf42/rI1o6R1v9c
         cEzVYWtAW3EDx9r66ryAnFV/bv+fWt04nI7xvksg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 0/3] staging: media: imx: imx7_mipi_csis: miscellaneous fixes
Date:   Fri, 19 Mar 2021 03:17:32 +0200
Message-Id: <20210319011735.26846-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

Here's a small set of additional fixes for the imx7_mipi_csis driver.
There's not much else to say here, please see individual patches for
details.

Laurent Pinchart (3):
  media: imx: imx7_mipi_csis: Runtime suspend in .s_stream() error path
  media: imx: imx7_mipi_csis: Don't take state->lock in .link_setup()
  media: imx: imx7_mipi_csis: Ensure pads are connected

 drivers/staging/media/imx/imx7-mipi-csis.c | 27 +++++++++++-----------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
Regards,

Laurent Pinchart

