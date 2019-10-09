Return-Path: <SRS0=1xwk=YC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB762ECE58C
	for <linux-media@archiver.kernel.org>; Wed,  9 Oct 2019 19:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C707F21920
	for <linux-media@archiver.kernel.org>; Wed,  9 Oct 2019 19:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJITJx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:09:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36930 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITJw (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 9 Oct 2019 15:09:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 093672904C0
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, andre.almeida@collabora.com,
        skhan@linuxfoundation.org, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH] media: vimc: remove unused struct declaration vimc_platform_data
Date:   Wed,  9 Oct 2019 21:09:26 +0200
Message-Id: <20191009190926.14070-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

the struct vimc_platform_data is not used anymore and can be removed.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/media/platform/vimc/vimc-common.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-common.h b/drivers/media/platform/vimc/vimc-common.h
index 698db7c07645..31be5109c1eb 100644
--- a/drivers/media/platform/vimc/vimc-common.h
+++ b/drivers/media/platform/vimc/vimc-common.h
@@ -57,21 +57,6 @@ do {									\
 		(fmt)->xfer_func = V4L2_XFER_FUNC_DEFAULT;		\
 } while (0)
 
-/**
- * struct vimc_platform_data - platform data to components
- *
- * @entity_name:	The name of the entity to be created
- *
- * Board setup code will often provide additional information using the device's
- * platform_data field to hold additional information.
- * When injecting a new platform_device in the component system the core needs
- * to provide to the corresponding submodules the name of the entity that should
- * be used when registering the subdevice in the Media Controller system.
- */
-struct vimc_platform_data {
-	char entity_name[32];
-};
-
 /**
  * struct vimc_pix_map - maps media bus code with v4l2 pixel format
  *
-- 
2.20.1

