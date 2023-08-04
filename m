Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88ACC41513
	for <linux-media@archiver.kernel.org>; Fri,  4 Aug 2023 03:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjHDDRA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Aug 2023 23:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHDDPx (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 3 Aug 2023 23:15:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40674EE4
        for <linux-media@vger.kernel.org>; Thu,  3 Aug 2023 20:14:10 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RH9j83kmYzJrMj;
        Fri,  4 Aug 2023 11:11:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 11:14:08 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <j.neuschaefer@gmx.net>, <u.kleine-koenig@pengutronix.de>,
        <linux-media@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/3] media: Remove unnecessary ternary operators
Date:   Fri, 4 Aug 2023 11:13:20 +0800
Message-ID: <20230804031323.2105187-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Ther are a little ternary operators, the true or false judgement
of which is unnecessary in C language semantics.

Ruan Jinjie (3):
  media: dvb-frontends: drx39xyj: Remove an unnecessary ternary operator
  media: radio-wl1273: Remove an unnecessary ternary operator
  media: dvb-usb: gp8psk: Remove an unnecessary ternary operator

 drivers/media/dvb-frontends/drx39xyj/drxj.c | 2 +-
 drivers/media/radio/radio-wl1273.c          | 2 +-
 drivers/media/usb/dvb-usb/gp8psk.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

