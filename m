Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BDBC433DB
	for <linux-media@archiver.kernel.org>; Tue, 12 Jan 2021 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A85622EBE
	for <linux-media@archiver.kernel.org>; Tue, 12 Jan 2021 13:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbhALNY4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 12 Jan 2021 08:24:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40414 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbhALNY4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 12 Jan 2021 08:24:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id F0ABC1F451E0
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kernel@collabora.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 11/13] media: v4l2-async: Drop v4l2_fwnode_reference_parse_sensor_common mention
Date:   Tue, 12 Jan 2021 10:23:37 -0300
Message-Id: <20210112132339.5621-12-ezequiel@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112132339.5621-1-ezequiel@collabora.com>
References: <20210112132339.5621-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The v4l2_async_notifier_cleanup documentation mentions
v4l2_fwnode_reference_parse_sensor_common, which doesn't exist.
Drop it.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 include/media/v4l2-async.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 76be1e01222e..2429ac55be1c 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -290,9 +290,8 @@ void v4l2_async_notifier_unregister(struct v4l2_async_notifier *notifier);
  * sub-devices allocated for the purposes of the notifier but not the notifier
  * itself. The user is responsible for calling this function to clean up the
  * notifier after calling
- * @v4l2_async_notifier_add_subdev,
- * @v4l2_async_notifier_parse_fwnode_endpoints or
- * @v4l2_fwnode_reference_parse_sensor_common.
+ * @v4l2_async_notifier_add_subdev or
+ * @v4l2_async_notifier_parse_fwnode_endpoints.
  *
  * There is no harm from calling v4l2_async_notifier_cleanup in other
  * cases as long as its memory has been zeroed after it has been
-- 
2.29.2

