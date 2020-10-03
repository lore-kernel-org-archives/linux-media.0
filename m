Return-Path: <SRS0=aNwB=DK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26943C4363D
	for <linux-media@archiver.kernel.org>; Sat,  3 Oct 2020 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D939120754
	for <linux-media@archiver.kernel.org>; Sat,  3 Oct 2020 08:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601714532;
	bh=r1d9UMV1FRCy3qUUZr6k4FtRW/rBPkyuBQ2m7N/qcVs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WRMjqAolUL+V7u3E86XmMXTr8EvH2Uxf1Zs616I1RdiVtFlh3hev/gSTkA9ta3oZY
	 90JyEqpZGh0VI2eEwCAn2h+eYsbO+9Jzpj4Yi2s/tGH0CaC3kjWblv17mc3Y8Rl9/E
	 ClFB2Lbsym2/PF+kO2QclTc5TMTwR6SU+E1vewmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgJCImB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 3 Oct 2020 04:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJCImB (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 3 Oct 2020 04:42:01 -0400
Received: from mail.kernel.org (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84AFC206DB;
        Sat,  3 Oct 2020 08:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601714520;
        bh=r1d9UMV1FRCy3qUUZr6k4FtRW/rBPkyuBQ2m7N/qcVs=;
        h=From:To:Cc:Subject:Date:From;
        b=V66y5vJV5kg1ipCMSeNJUnpOYEC0krMUKoIbkD5J24Tzz8zeHYVpAJNe1cvKVYarm
         /pfU38Q9AXOuIjWRnhfsZOWqUadGtAeMe8u3dGL6l6F68iRy1VGJKkWQzg5qbYXGk3
         SIIgJUOuiAnOxF8OB/EuP4IltJeMtLwzPw36ENbU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kOd77-0002Is-UA; Sat, 03 Oct 2020 10:41:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mjpeg-users@lists.sourceforge.net
Subject: [PATCH 1/4] media: zoran: move documentation file to the right place
Date:   Sat,  3 Oct 2020 10:41:54 +0200
Message-Id: <6b90346919d42ffc7c3ad283bfca2825b238147a.1601714147.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The zoran revert patch misplaced the Zoran doc file. Move it to
the right place.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/media/drivers/index.rst                 | 1 +
 .../{media => driver-api/media/drivers}/v4l-drivers/zoran.rst    | 0
 2 files changed, 1 insertion(+)
 rename Documentation/{media => driver-api/media/drivers}/v4l-drivers/zoran.rst (100%)

diff --git a/Documentation/driver-api/media/drivers/index.rst b/Documentation/driver-api/media/drivers/index.rst
index 5f340cfdb4cc..eb7011782863 100644
--- a/Documentation/driver-api/media/drivers/index.rst
+++ b/Documentation/driver-api/media/drivers/index.rst
@@ -25,6 +25,7 @@ Video4Linux (V4L) drivers
 	sh_mobile_ceu_camera
 	tuners
 	vimc-devel
+	zoran
 
 
 Digital TV drivers
diff --git a/Documentation/media/v4l-drivers/zoran.rst b/Documentation/driver-api/media/drivers/v4l-drivers/zoran.rst
similarity index 100%
rename from Documentation/media/v4l-drivers/zoran.rst
rename to Documentation/driver-api/media/drivers/v4l-drivers/zoran.rst
-- 
2.26.2

