Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BECC4361B
	for <linux-media@archiver.kernel.org>; Tue, 15 Dec 2020 17:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525D62224C
	for <linux-media@archiver.kernel.org>; Tue, 15 Dec 2020 17:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgLORKs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:10:48 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35319 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgLORKj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 15 Dec 2020 12:10:39 -0500
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B43B51C0010;
        Tue, 15 Dec 2020 17:09:52 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, geert@linux-m68k.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hyun Kwon <hyunk@xilinx.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sergei.shtylyov@gmail.com
Subject: [PATCH v6 0/5]  media: i2c: Add RDACM21 camera module
Date:   Tue, 15 Dec 2020 18:09:52 +0100
Message-Id: <20201215170957.92761-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello, this v6 renames the 'maxim,initial-reverse-channel-mV' property
to 'maxim,reverse-channel-microvolt' to use standard suffix as suggested
by Rob.

v5: https://patchwork.linuxtv.org/project/linux-media/list/?series=3876
v4: https://patchwork.linuxtv.org/project/linux-media/list/?series=3847
v3: https://patchwork.linuxtv.org/project/linux-media/list/?series=3657
Background in v1 cover letter:
https://www.spinics.net/lists/linux-renesas-soc/msg52886.html

Jacopo Mondi (5):
  media: i2c: Add driver for RDACM21 camera module
  dt-bindings: media: max9286: Document
    'maxim,reverse-channel-microvolt'
  media: i2c: max9286: Break-out reverse channel setup
  media: i2c: max9286: Make channel amplitude programmable
  media: i2c: max9286: Configure reverse channel amplitude

 .../bindings/media/i2c/maxim,max9286.yaml     |  23 +
 MAINTAINERS                                   |  12 +
 drivers/media/i2c/Kconfig                     |  13 +
 drivers/media/i2c/Makefile                    |   2 +
 drivers/media/i2c/max9286.c                   |  61 +-
 drivers/media/i2c/rdacm21.c                   | 595 ++++++++++++++++++
 6 files changed, 693 insertions(+), 13 deletions(-)
 create mode 100644 drivers/media/i2c/rdacm21.c

--
2.29.2

