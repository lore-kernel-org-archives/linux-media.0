Return-Path: <SRS0=7MnB=C2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABDDC2BBD1
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 09:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DA920770
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600336304;
	bh=QlHe+U52015mxf4TFIS9GCufQdr91cOPdMVOcyksJ/4=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=ICIyuxAqrRXcGn2mhs/kv4u9Lbo0O9ln/C+cFY1S/6dm3QD0cEOLKqdky71qiYZTY
	 3xvq7Y4ocr+pb1/dkbnBzX/1AVVPYN76o9A69qU/WdHFUr6MfRvOQzBNkB7kWBQUaa
	 EwmSBbkslZE4hwlDbzAgDSL/j1WPOybZ+qzauNdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIQJvm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Sep 2020 05:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgIQJvk (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Sep 2020 05:51:40 -0400
Received: from mail.kernel.org (ip5f5ad5d2.dynamic.kabel-deutschland.de [95.90.213.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E7720838;
        Thu, 17 Sep 2020 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600336300;
        bh=QlHe+U52015mxf4TFIS9GCufQdr91cOPdMVOcyksJ/4=;
        h=From:To:Cc:Subject:Date:From;
        b=Vwe8vPSXg+JzrX7NmBx/Z4rc4J2su5QZPBA56MAmAHulv3BmhjAEVzrFhaQtkYpZa
         oJ4ojy25hPtM0/99ISosQBhhlKypJWvIAPk/J0roFMSqAHvvHbbbGwzctp2Z+Bf1Do
         E2V5xiJHOX4IPQENhKdkbjee76BKq8y/6lJ6XKok=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kIqZl-0055p9-82; Thu, 17 Sep 2020 11:51:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 1/2] media: vidtv: cleanup the logic which estimates buffer size
Date:   Thu, 17 Sep 2020 11:51:35 +0200
Message-Id: <87e2446460f3feed58c89954529151645b959b19.1600336293.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There's no need to use u64 over there. In a matter of fact,
the div is not even needed, as it is multiplying by 1000 and
dividing by 1000.

So, simplify the logic.

While here, constrain the buffer size to a certain range
(between the current value and 10 times it)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../media/test-drivers/vidtv/vidtv_bridge.c   | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index fe4e496acc34..74b054947bbe 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -106,26 +106,28 @@ static unsigned int mux_buf_sz_pkts;
 module_param(mux_buf_sz_pkts, uint, 0);
 MODULE_PARM_DESC(mux_buf_sz_pkts, "Size for the internal mux buffer in multiples of 188 bytes");
 
+#define MUX_BUF_MIN_SZ 90164
+#define MUX_BUF_MAX_SZ (MUX_BUF_MIN_SZ * 10)
+
 static u32 vidtv_bridge_mux_buf_sz_for_mux_rate(void)
 {
-	u64 max_elapsed_time_msecs =  VIDTV_MAX_SLEEP_USECS / 1000;
+	u32 max_elapsed_time_msecs =  VIDTV_MAX_SLEEP_USECS / USEC_PER_MSEC;
 	u32 nbytes_expected;
 	u32 mux_buf_sz = mux_buf_sz_pkts * TS_PACKET_LEN;
-	u32 slack;
 
-	nbytes_expected = div64_u64(mux_rate_kbytes_sec * 1000, MSEC_PER_SEC);
+	nbytes_expected = mux_rate_kbytes_sec;
 	nbytes_expected *= max_elapsed_time_msecs;
 
 	mux_buf_sz = roundup(nbytes_expected, TS_PACKET_LEN);
-	slack = mux_buf_sz / 10;
+	mux_buf_sz += mux_buf_sz / 10;
 
-	//if (mux_buf_sz < MUX_BUF_MIN_SZ)
-	//	mux_buf_sz = MUX_BUF_MIN_SZ;
+	if (mux_buf_sz < MUX_BUF_MIN_SZ)
+		mux_buf_sz = MUX_BUF_MIN_SZ;
 
-	//if (mux_buf_sz > MUX_BUF_MAX_SZ)
-	//	mux_buf_sz = MUX_BUF_MAX_SZ;
+	if (mux_buf_sz > MUX_BUF_MAX_SZ)
+		mux_buf_sz = MUX_BUF_MAX_SZ;
 
-	return mux_buf_sz + slack;
+	return mux_buf_sz;
 }
 
 static bool vidtv_bridge_check_demod_lock(struct vidtv_dvb *dvb, u32 n)
-- 
2.26.2

