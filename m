Return-Path: <SRS0=lLmD=X4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80C5C32792
	for <linux-media@archiver.kernel.org>; Thu,  3 Oct 2019 07:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E18921D71
	for <linux-media@archiver.kernel.org>; Thu,  3 Oct 2019 07:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0xYk/81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfJCHTQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:19:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34604 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfJCHTQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 3 Oct 2019 03:19:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so1211566pgl.1
        for <linux-media@vger.kernel.org>; Thu, 03 Oct 2019 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yHhsXxK0PdjvrEP2oyButSCFP7rZMOADjklF42mJfCk=;
        b=q0xYk/81qkd7rofEbzelbcHKkJQMxh31uZUjhV/rVYDav9XpuvgetTKUcNnCjkl4jz
         QcPZVK4YgZzSl6tnJvYZ+4GgEAYgRgEiA2cse/RbQx2NdcRFZRbyfrKDt4bCXPxz+6td
         fUf8mvQHEoH8dYnJm1u5aCPdOnyGqI7QlstzEnyUUxYQPkTXRPuF3OlgG4XAPS3TBpAN
         J21M2rzQ+c3vKH/FCrmcTsMquon/dB3/Mi1pebNKeribIS6dudXjb7vB2900seXeBpH+
         5iJFn1bljdMDQxzld4qN29a4cwUdTWejh3Nn069FkPifB5MbkElIvEumCtLEdOiP66C3
         eYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yHhsXxK0PdjvrEP2oyButSCFP7rZMOADjklF42mJfCk=;
        b=JcJgTRYGnE7UUm3ml0U52onAUFr5hIY+WpCT//zxBJbSGEAnCshq16O85pcV+uaRkQ
         vlwbJZ/iBXYJEEaIrIyP5gkXUUAabZWkhF/jLd4dtV6yWvnjVft5/XzrFHQET80umOOZ
         nmzyVeqo1xKwSB6CNSJzA6KIPyUwe+0y/RMioj6YlAOqqsQKzVhm1nKRBy19qVDnoBPS
         NrqvIfEhot6fO5IwdobFNO9jJv/XsF0o41oC6q3Cvca2ik2F6YnTaST6StyfPpLMIZtn
         NScTXI0SeaUfZaozkejNx/2k/6Jlhu38hbo3NHfJBOKXQ8jpW6FeSC9Ev9VDDPlc9/Dz
         tk6g==
X-Gm-Message-State: APjAAAXlHKUFq4y3iGms9l4cF291WLArYBuitEj1vmrceD8yvG09rXY4
        t4/BDi5WACIfwKBFSCwUCEQFwt61
X-Google-Smtp-Source: APXvYqy0NpnpbL5guzII+0rjs8+YaOD5jIVZg3fHzhFpDpzhwXXMPyOzaHka4BjosZOi4Lm29bDmXA==
X-Received: by 2002:a63:121c:: with SMTP id h28mr7975257pgl.336.1570087154851;
        Thu, 03 Oct 2019 00:19:14 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.241.207.214])
        by smtp.gmail.com with ESMTPSA id y17sm2645109pfo.171.2019.10.03.00.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 00:19:14 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     hverkuil@xs4all.nl, Vandana BN <bnvandana@gmail.com>
Subject: [PATCH 1/2] v4l2-core: Add new metadata format
Date:   Thu,  3 Oct 2019 12:48:55 +0530
Message-Id: <20191003071856.23664-2-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003071856.23664-1-bnvandana@gmail.com>
References: <20191003071856.23664-1-bnvandana@gmail.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add new metadata format to support metadata output in vivid.

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 include/uapi/linux/videodev2.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 20b3107dd4e8..34c1a2bd7f28 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1340,6 +1340,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_VSP1_HGT:	descr = "R-Car VSP1 2-D Histogram"; break;
 	case V4L2_META_FMT_UVC:		descr = "UVC Payload Header Metadata"; break;
 	case V4L2_META_FMT_D4XX:	descr = "Intel D4xx UVC Metadata"; break;
+	case V4L2_META_FMT_VIVID:       descr = "Vivid Output Metadata"; break;
 
 	default:
 		/* Compressed formats */
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 530638dffd93..a32335fcd064 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -755,6 +755,7 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_VSP1_HGT    v4l2_fourcc('V', 'S', 'P', 'T') /* R-Car VSP1 2-D Histogram */
 #define V4L2_META_FMT_UVC         v4l2_fourcc('U', 'V', 'C', 'H') /* UVC Payload Header metadata */
 #define V4L2_META_FMT_D4XX        v4l2_fourcc('D', '4', 'X', 'X') /* D4XX Payload Header metadata */
+#define V4L2_META_FMT_VIVID	  v4l2_fourcc('V', 'I', 'V', 'D') /* Vivid Output Metadata */
 
 /* priv field value to indicates that subsequent fields are valid. */
 #define V4L2_PIX_FMT_PRIV_MAGIC		0xfeedcafe
-- 
2.17.1

