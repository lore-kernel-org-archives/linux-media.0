Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03759C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 04:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C625320880
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 04:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8Juy+W9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfDHEfl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 00:35:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45199 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHEfk (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 00:35:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so13862038qtv.12
        for <linux-media@vger.kernel.org>; Sun, 07 Apr 2019 21:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JY/pmMTl9QIIoeg9ozlbygaf+ANzc0sq3fWOz2KluZo=;
        b=p8Juy+W9Roh/y1d9AL464VWE+x0VXBlSbh/QZYSsj5Z5GQ+i1GIMRgu+KmUuSdHOll
         lbXDa2mi/Mhs/NnN++6DNNzEY/VsrT4E5Z5SAxMkONAMIxsdaoSXDg/AVcUO0RTMlROx
         H+c0RoxntX1t2tPWiyV5E3qCBJdpmDpzBzDKJLyzcrcHum3I+eGZuWVliKrob62x6Hu1
         ofTGEgaO95tocWIs46tfdu8jUbib0vkwlfHccQyZfhXNyKVbNkUXflXSgUGacc9CedWk
         6NMzPblk2zX4U5Y5U7z0PzLQ30dqeXN4VEIpvt7u+L5QoZF4PgmQYTheRQ9PxkQPQmlw
         yDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JY/pmMTl9QIIoeg9ozlbygaf+ANzc0sq3fWOz2KluZo=;
        b=n5kh+E94X024Cc45MhuR453Cj7OHdbtcGijeCama6nkPnufmTpj68+nQf2yrRgmBZz
         RJvGkLEF7/VQHUzPRnBvUkD1QvgA8jCeyvxmfGKIBue0InK1x9QMPyWLnMwUJXoc1BOB
         uWBKCFmYYAe425PTuhFTJPbpUp7iR317ppBylEIZ3peLvCu9Go8ZkaEg5h7s450OF/1i
         sq0O0TBAcMmPwkZdDc5ir7cmmaJkZAqSARXpZjJU7DN7hSb5X7akI8pcG5bVNpRixdI8
         NdU6ooh8TEYwWUG1y+OCxOTzY/oXS2FBkzFypWOLoMqss6mk8mUd4UX8jzHw1WSFq91d
         PIfA==
X-Gm-Message-State: APjAAAX197Emv3gwp9sV4096Isb3h7Wcty4m2ppiOGDxpdZl2PENqCOS
        E/pReiDBfWuzVDDrZcaxfFs=
X-Google-Smtp-Source: APXvYqw/kKWhIk/KdLv+OUuNf5U9uv5/U8O4S+9PEF+Gd8t0McquoXv8xLpHDGfK0vkF2taJDPUgsA==
X-Received: by 2002:a0c:9973:: with SMTP id i48mr22380316qvd.9.1554698139836;
        Sun, 07 Apr 2019 21:35:39 -0700 (PDT)
Received: from localhost.localdomain ([187.56.54.93])
        by smtp.gmail.com with ESMTPSA id m41sm18218955qtb.58.2019.04.07.21.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 21:35:39 -0700 (PDT)
From:   Arthur Moraes do Lago <arthurmoraeslago@gmail.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.or,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: media: zoran: fix trailing whitespaces
Date:   Mon,  8 Apr 2019 01:35:30 -0300
Message-Id: <20190408043530.21594-1-arthurmoraeslago@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There were several form feeds(^L) in the file, this patch removes them
to conform with the coding style.

Signed-off-by: Arthur Moraes do Lago <arthurmoraeslago@gmail.com>
---
 drivers/staging/media/zoran/videocodec.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
index 4946791fce0d..c37c0e4fb624 100644
--- a/drivers/staging/media/zoran/videocodec.h
+++ b/drivers/staging/media/zoran/videocodec.h
@@ -49,7 +49,7 @@
    device dependent and vary between MJPEG/MPEG/WAVELET/... devices. (!!!!)
    ----------------------------------------------------------------------------
 */
-
+
 
 /* ========================================== */
 /* description of the videocodec_io structure */
@@ -96,7 +96,7 @@
 		the calls include frame numbers and flags (even/odd/...)
 		if needed and a flag which allows blocking until its ready
 */
-
+
 /* ============== */
 /* user interface */
 /* ============== */
@@ -116,7 +116,7 @@ M                       zr36055[0] 0001 0000c001 00000000 (zr36050[0])
 M                       zr36055[1] 0001 0000c001 00000000 (zr36050[1])
 
 */
-
+
 
 /* =============================================== */
 /* special defines for the videocodec_io structure */
@@ -195,7 +195,7 @@ M                       zr36055[1] 0001 0000c001 00000000 (zr36050[1])
 /*  -> used in get_image, put_image                                        */
 #define CODEC_TRANSFER_KERNEL 0	/* use "memcopy" */
 #define CODEC_TRANSFER_USER   1	/* use "to/from_user" */
-
+
 
 /* ========================= */
 /* the structures itself ... */
@@ -309,7 +309,7 @@ struct videocodec_master {
 			  __u16 reg,
 			  __u32 value);
 };
-
+
 
 /* ================================================= */
 /* function prototypes of the master/slave interface */
-- 
2.21.0

