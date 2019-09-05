Return-Path: <SRS0=7WK4=XA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98B0C3A5A5
	for <linux-media@archiver.kernel.org>; Thu,  5 Sep 2019 07:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984482341C
	for <linux-media@archiver.kernel.org>; Thu,  5 Sep 2019 07:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbfIEHV4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:21:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57695 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730778AbfIEHV4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 5 Sep 2019 03:21:56 -0400
X-UUID: 36acc9336a7841b1a881216978b3a93a-20190905
X-UUID: 36acc9336a7841b1a881216978b3a93a-20190905
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dongchun.zhu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1222208114; Thu, 05 Sep 2019 15:21:50 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Sep 2019 15:21:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Sep 2019 15:21:46 +0800
From:   <dongchun.zhu@mediatek.com>
To:     <mchehab@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <sakari.ailus@linux.intel.com>, <drinkcat@chromium.org>,
        <tfiga@chromium.org>, <matthias.bgg@gmail.com>,
        <bingbu.cao@intel.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sj.huang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sam.hung@mediatek.com>, <shengnan.wang@mediatek.com>,
        <dongchun.zhu@mediatek.com>
Subject: [V2, 0/2] media: i2c: add support for DW9768 VCM driver
Date:   Thu, 5 Sep 2019 15:21:40 +0800
Message-ID: <20190905072142.14606-1-dongchun.zhu@mediatek.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dongchun Zhu <dongchun.zhu@mediatek.com>

Hello,

Add a v4l2 sub-device driver for Dongwoon's DW9768 lens voice coil.
This is a voice coil module using the i2c bus to control the focus position.

The DW9768 can control the position with 10 bits value and
consists of two 8 bit registers show as below.
register 0x04(DW9768_REG_POSITION):
     +---+---+---+---+---+---+---+---+
     |D07|D06|D05|D04|D03|D02|D01|D00|
     +---+---+---+---+---+---+---+---+
register 0x03:
     +---+---+---+---+---+---+---+---+
     |---|---|---|---|---|---|D09|D08|
     +---+---+---+---+---+---+---+---+

This driver supports:
 - set DW9768 to standby mode once suspend and turn it back to active if resume
 - set the position via V4L2_CID_FOCUS_ABSOLUTE ctrl

Mainly changes of v2 are addressing the comments from Tomasz, Bingbu, Andy,
including,
 - Use i2c_smbus_write_byte_data/i2c_smbus_write_block_data to write I2C register
 - Adopt the runtime PM suspend/resume callbacks to powering off/on
 - Check the PM runtime status before powering off in dw9768_remove function
 - Add one more regulator vin for the I2C interface
 - Remove or refine redundant log print
 - Fix other reviewed issues in v1

Dongchun Zhu (2):
  media: i2c: dw9768: Add DT support and MAINTAINERS entry
  media: i2c: Add DW9768 VCM driver

 .../bindings/media/i2c/dongwoon,dw9768.txt         |   9 +
 MAINTAINERS                                        |   8 +
 drivers/media/i2c/Kconfig                          |  10 +
 drivers/media/i2c/Makefile                         |   1 +
 drivers/media/i2c/dw9768.c                         | 349 +++++++++++++++++++++
 5 files changed, 377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.txt
 create mode 100644 drivers/media/i2c/dw9768.c

-- 
2.9.2

