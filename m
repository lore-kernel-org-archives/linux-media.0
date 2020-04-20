Return-Path: <SRS0=ZgJ+=6E=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D65C54F70
	for <linux-media@archiver.kernel.org>; Mon, 20 Apr 2020 00:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E342145D
	for <linux-media@archiver.kernel.org>; Mon, 20 Apr 2020 00:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kotv2GrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDTAkJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 19 Apr 2020 20:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbgDTAkJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 19 Apr 2020 20:40:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4D2C061A0C
        for <linux-media@vger.kernel.org>; Sun, 19 Apr 2020 17:40:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so3313885plt.2
        for <linux-media@vger.kernel.org>; Sun, 19 Apr 2020 17:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aulrQ6oHsIqioAIw97gNvp4/kCTJRc3i88m+9ebFRaM=;
        b=Kotv2GrZlVTn6Fwq+WfnD4JosEIApxK+mT1flcliLm62ptxFVLGCyqGlXCv40/1n0Q
         GJ0AqNuwz45Tiia6ZWyIdsrDBkWTCBwUqfKNm+xP8YaehonGRO2weXnHIWCekutpj/Rp
         YjwFMk+/bHB+Tgy/yBuyCiBElgaJamDYQ3ZOIJnlHvFI973zjNA90pWVd1CffWQTTbqa
         w2A3P9MptBhP/d3S5oVeRj8CZKfwb1kYf4O9YVioHQSgEY9fMShEB/PB305ZbnZAdYoA
         b0HH59vZskkhRFqJBsJ6Xdl3WhjEyT9HDtqD8JMORNzOQ/JfS+tS39QqPMxkD6M3b4HG
         5ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aulrQ6oHsIqioAIw97gNvp4/kCTJRc3i88m+9ebFRaM=;
        b=cKjQHUYsxVaJMTXZsOEQK8CGqdn+m9Vs0wcy69HSGtyC73gKn861TA+WKZ8rM9TW50
         dcl+vTqo9aCf6+6AU36Z9qLrjuhL/tnia/x+1yjeQGxSiPwtGmm7WBs9YxjjTPa9sGgx
         b6036SPS8am1SRPWce9dGCPXxk3xZptsx++owzpfoBLh+FhpJ/DAHYm13aeDln8QoDdO
         WpI90Vz4Tk+IkNAHjs6EyENCxRRYPSoXC564tOlKDD0CN4A4ZQlcQwuMJfoExDGZ5bCi
         srN9UF+yEVDh7Z+gZZ5f1pmJ58QBqP/dE9JGiOyyn8qDEZLRf7+RzEVbkmbQZrUlPti+
         r7zw==
X-Gm-Message-State: AGi0PubgTd15ddktUZTvgEQJLwsuDwdHcuJNNmKKjx4CJSVcZExmuj4V
        uXEEuvrG6p+ME0h/C3mHSUNNO17GEzQ=
X-Google-Smtp-Source: APiQypLy99jpD7URhWxITUarmfCMQTVEpiRrm1LiuL+BVmf/IE6m/Q7YHpzGkgwBCnmRbsTre56xrg==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr13026031plc.209.1587343208341;
        Sun, 19 Apr 2020 17:40:08 -0700 (PDT)
Received: from mappy.hsd1.ca.comcast.net (c-107-3-184-99.hsd1.ca.comcast.net. [107.3.184.99])
        by smtp.gmail.com with ESMTPSA id f30sm12313701pje.29.2020.04.19.17.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 17:40:07 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Longerbeam <slongerbeam@gmail.com>
Subject: [PATCH v5 22/23] media: imx: silence a couple debug messages
Date:   Sun, 19 Apr 2020 17:39:29 -0700
Message-Id: <20200420003930.11463-23-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420003930.11463-1-slongerbeam@gmail.com>
References: <20200420003930.11463-1-slongerbeam@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Convert to dev_dbg the "subdev bound" and IPU-internal media-link
creation messages.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/staging/media/imx/imx-media-dev-common.c  | 4 +++-
 drivers/staging/media/imx/imx-media-dev.c         | 2 +-
 drivers/staging/media/imx/imx-media-internal-sd.c | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-dev-common.c b/drivers/staging/media/imx/imx-media-dev-common.c
index f6ad9631fa0e..5fe4b22ab847 100644
--- a/drivers/staging/media/imx/imx-media-dev-common.c
+++ b/drivers/staging/media/imx/imx-media-dev-common.c
@@ -24,7 +24,9 @@ static int imx_media_subdev_bound(struct v4l2_async_notifier *notifier,
 				  struct v4l2_subdev *sd,
 				  struct v4l2_async_subdev *asd)
 {
-	v4l2_info(sd->v4l2_dev, "subdev %s bound\n", sd->name);
+	struct imx_media_dev *imxmd = notifier2dev(notifier);
+
+	dev_dbg(imxmd->md.dev, "subdev %s bound\n", sd->name);
 
 	return 0;
 }
diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index 2c3c2adca683..6d2205461e56 100644
--- a/drivers/staging/media/imx/imx-media-dev.c
+++ b/drivers/staging/media/imx/imx-media-dev.c
@@ -32,7 +32,7 @@ static int imx_media_subdev_bound(struct v4l2_async_notifier *notifier,
 			return ret;
 	}
 
-	v4l2_info(&imxmd->v4l2_dev, "subdev %s bound\n", sd->name);
+	dev_dbg(imxmd->md.dev, "subdev %s bound\n", sd->name);
 
 	return 0;
 }
diff --git a/drivers/staging/media/imx/imx-media-internal-sd.c b/drivers/staging/media/imx/imx-media-internal-sd.c
index d4237e1a4241..da4109b2fd13 100644
--- a/drivers/staging/media/imx/imx-media-internal-sd.c
+++ b/drivers/staging/media/imx/imx-media-internal-sd.c
@@ -142,9 +142,9 @@ static int create_internal_link(struct imx_media_dev *imxmd,
 				   &sink->entity.pads[link->remote_pad]))
 		return 0;
 
-	v4l2_info(&imxmd->v4l2_dev, "%s:%d -> %s:%d\n",
-		  src->name, link->local_pad,
-		  sink->name, link->remote_pad);
+	dev_dbg(imxmd->md.dev, "%s:%d -> %s:%d\n",
+		src->name, link->local_pad,
+		sink->name, link->remote_pad);
 
 	ret = media_create_pad_link(&src->entity, link->local_pad,
 				    &sink->entity, link->remote_pad, 0);
-- 
2.17.1

