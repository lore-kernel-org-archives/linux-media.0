Return-Path: <SRS0=ny0S=XF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D76C49ED7
	for <linux-media@archiver.kernel.org>; Tue, 10 Sep 2019 19:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4932171F
	for <linux-media@archiver.kernel.org>; Tue, 10 Sep 2019 19:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfIJTIZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:08:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:50161 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfIJTIZ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 10 Sep 2019 15:08:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 12:08:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; 
   d="scan'208";a="200347624"
Received: from maru.jf.intel.com ([10.54.51.77])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2019 12:08:24 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH -next 0/2] media: aspeed: refine mode detection flow
Date:   Tue, 10 Sep 2019 12:07:54 -0700
Message-Id: <20190910190756.31432-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch series refines mode detection flow by adding and fixing of
hsync/vsync polarity setting register handling. Please review this change.

Thanks,
-Jae

Jae Hyun Yoo (2):
  media: aspeed: refine hsync/vsync polarity setting logic
  media: aspeed: set hsync and vsync polarities to normal before
    starting mode detection

 drivers/media/platform/aspeed-video.c | 45 ++++++++++++++-------------
 1 file changed, 23 insertions(+), 22 deletions(-)

-- 
2.23.0

