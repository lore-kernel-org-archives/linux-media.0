Return-Path: <SRS0=xaSx=B3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2D2C433E4
	for <linux-media@archiver.kernel.org>; Mon, 17 Aug 2020 14:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A324420729
	for <linux-media@archiver.kernel.org>; Mon, 17 Aug 2020 14:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgHQOcI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:32:08 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48911 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgHQOcH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 17 Aug 2020 10:32:07 -0400
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C80F9C0008;
        Mon, 17 Aug 2020 14:32:01 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        sakari.ailus@iki.fi, hverkuil@xs4all.nl, hyunk@xilinx.com,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH 0/4] media: i2c: max9286: Use remote endpoint image format
Date:   Mon, 17 Aug 2020 16:35:36 +0200
Message-Id: <20200817143540.247340-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In order to prepare to support multiple camera modules, which deliver image
streams in different formats, modify the max9286 driver in order to remote
the hardcoded formats it currently exposes.

The image formats, both for ACTIVE and TRY formats, are retrieved from
the remote subdevices instead of being hard-coded.

This series also dis-allow setting any format on the max9286 sink pads, as
the format only depends on the remote end and the MAX9286 chip cannot
perform any transformation of the image stream it de-serialize from GMSL
bus.

Thanks
   j

Jacopo Mondi (4):
  media: i2c: max9286: Initialize try formats
  media: i2c: max9286: Get format from remote ends
  media: i2c: max9286: Do not allow changing format
  media: i2c: max9286: Remove cached formats

 drivers/media/i2c/max9286.c | 124 +++++++++++++++---------------------
 1 file changed, 51 insertions(+), 73 deletions(-)


base-commit: f45882cfb152f5d3a421fd58f177f227e44843b9
--
2.27.0

