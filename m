Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D79C4167B
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 04:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16F8208C3
	for <linux-media@archiver.kernel.org>; Mon,  7 Dec 2020 04:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgLGE2I (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 6 Dec 2020 23:28:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8703 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgLGE1f (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 6 Dec 2020 23:27:35 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cq9H92pr6zkm5X;
        Mon,  7 Dec 2020 12:26:13 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 12:26:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        "Ricardo Ribalda" <ribalda@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/4] dt-bindings: media: eliminate yamllint warnings
Date:   Mon, 7 Dec 2020 12:23:56 +0800
Message-ID: <20201207042400.1498-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

These patches are based on the latest linux-next code.

Zhen Lei (4):
  dt-bindings: media: adv7604: eliminate yamllint warnings
  dt-bindings: media: nokia,smia: eliminate yamllint warnings
  dt-bindings: media: ov772x: eliminate yamllint warnings
  dt-bindings: media: imx214: eliminate yamllint warnings

 Documentation/devicetree/bindings/media/i2c/adv7604.yaml     |  4 ++--
 Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml    | 11 ++++++-----
 Documentation/devicetree/bindings/media/i2c/ovti,ov772x.yaml | 12 ++++++------
 Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml | 12 ++++++------
 4 files changed, 20 insertions(+), 19 deletions(-)

-- 
1.8.3


