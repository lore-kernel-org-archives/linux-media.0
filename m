Return-Path: <SRS0=Gwua=7V=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CB9C433E0
	for <linux-media@archiver.kernel.org>; Mon,  8 Jun 2020 23:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FC1208B6
	for <linux-media@archiver.kernel.org>; Mon,  8 Jun 2020 23:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591657752;
	bh=Hun363eN4I4GDgnv/6/COhdFYcOMePNwa8J/7LCfEME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T51jH4jC3DMUoQFafDKXJF1JfYvxdyye5go6FbjVu3ydbJPU7xC4XyTxVUwdiPLC5
	 4m3nVxqWTja5zvQO/crja6hjyaMFVLEGy0l2q3jpIqWAT04tFj1naefckpeJWDWUh3
	 Kh3MBDc1ntYAXSwL60hmLsveYxvU7F9JNTf5uLb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgFHXJL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbgFHXJJ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Jun 2020 19:09:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC9220890;
        Mon,  8 Jun 2020 23:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657749;
        bh=Hun363eN4I4GDgnv/6/COhdFYcOMePNwa8J/7LCfEME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5doac0DPx8c74LExRa5qpRlKU05BT6ObGaJj21u4ciFh563GEHaIiVQiIjtccs0B
         VomK2h8dlcpr8RUHu4X1HrcnvNXXrceHn1AM+puhu5xGdbClfMPF+8nlXVA4BgAWlp
         UGCSWIy9AqsdYgTJktw6AF/PPFkFWZsQ6DHeX2PQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Young <sean@mess.org>,
        coverity-bot <keescook+coverity-bot@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 136/274] media: m88ds3103: error in set_frontend is swallowed and not reported
Date:   Mon,  8 Jun 2020 19:03:49 -0400
Message-Id: <20200608230607.3361041-136-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Sean Young <sean@mess.org>

[ Upstream commit c4ed27cfed45c16c2dd16c9fa3b883e306177e40 ]

Bail out if registers can not be updated.

Addresses-Coverity-ID: 1461655 ("Code maintainability issues")

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Fixes: e6089feca460 ("media: m88ds3103: Add support for ds3103b demod")
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/m88ds3103.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index d2c28dcf6b42..abddab02db9e 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -980,6 +980,8 @@ static int m88ds3103_set_frontend(struct dvb_frontend *fe)
 			goto err;
 
 		ret = m88ds3103_update_bits(dev, 0xc9, 0x08, 0x08);
+		if (ret)
+			goto err;
 	}
 
 	dev_dbg(&client->dev, "carrier offset=%d\n",
-- 
2.25.1

