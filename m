Return-Path: <SRS0=g+iK=CT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66587C433E2
	for <linux-media@archiver.kernel.org>; Thu, 10 Sep 2020 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395ED2064B
	for <linux-media@archiver.kernel.org>; Thu, 10 Sep 2020 17:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgIJRVR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:21:17 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41903 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgIJQRl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 10 Sep 2020 12:17:41 -0400
X-Originating-IP: 93.34.118.233
Received: from uno.lan (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7C504C000A;
        Thu, 10 Sep 2020 16:17:22 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 0/3]  dt-bindings: media: ov772x: Convert to json-schema
Date:   Thu, 10 Sep 2020 18:20:52 +0200
Message-Id: <20200910162055.614089-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Convert the ov722x bindings to json-schema and add endpoint properties and
bus-type.

Compared to v4 in 2/3 I have not documented endpoint properties and deferred it
to a forthcoming of-graph.yaml by using 'unevaluatedProperties: false'
in the endpoint properties.

Thanks
  j

Jacopo Mondi (3):
  dt-bindings: media: ov772x: Convert to json-schema
  dt-bindings: media: ov772x: Make bus-type mandatory
  dt-bindings: media: ov772x: Document endpoint props

 .../devicetree/bindings/media/i2c/ov772x.txt  |  40 ------
 .../bindings/media/i2c/ovti,ov772x.yaml       | 134 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 135 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov772x.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov772x.yaml

--
2.28.0

