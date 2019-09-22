Return-Path: <SRS0=gF/f=XR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C46C3A5A2
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752112184D
	for <linux-media@archiver.kernel.org>; Sun, 22 Sep 2019 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179241;
	bh=egiD3HlchjuA3kjYlfvJDgaix+zmh6+yq/vEbpt6MAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gz4eJ3NAg78Ha1eSbw5UY8uzUCJgf2rERq5npePMzXYsiqbxfkcWbJDBauRiOQPEV
	 2s+LdMq3Giw4x7QVqHhSCHmevlGIpa8PGY1XEbtVnyK8ySFSqZHNGgXlcJpcklPLYC
	 r8JSG1AY2uS76fLODaF9UDNlH2gCIZ+1Mvc0gTd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438971AbfIVTAL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438959AbfIVTAL (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 22 Sep 2019 15:00:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D08F0208C2;
        Sun, 22 Sep 2019 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178810;
        bh=egiD3HlchjuA3kjYlfvJDgaix+zmh6+yq/vEbpt6MAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxJpunO1m046BSM3YthZlYvB/I2iRud9xUGgxM0KPXOPNpED1WJVcfzelmncEJXjf
         1O1yvgkl4/0BQJRDAfGwNYGgN0GTKO3f0ZNqllfiG9U7W1xOk2Ej07dEnwrzaD0k4F
         lwO72r53ACm+yNykWEAo273KEER00kaYgd5VxLGw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 25/60] media: omap3isp: Don't set streaming state on random subdevs
Date:   Sun, 22 Sep 2019 14:58:58 -0400
Message-Id: <20190922185934.4305-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185934.4305-1-sashal@kernel.org>
References: <20190922185934.4305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 7ef57be07ac146e70535747797ef4aee0f06e9f9 ]

The streaming state should be set to the first upstream sub-device only,
not everywhere, for a sub-device driver itself knows how to best control
the streaming state of its own upstream sub-devices.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/omap3isp/isp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index a21b12c5c0853..ce651d3ca1b82 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -726,6 +726,10 @@ static int isp_pipeline_enable(struct isp_pipeline *pipe,
 					s_stream, mode);
 			pipe->do_propagation = true;
 		}
+
+		/* Stop at the first external sub-device. */
+		if (subdev->dev != isp->dev)
+			break;
 	}
 
 	return 0;
@@ -840,6 +844,10 @@ static int isp_pipeline_disable(struct isp_pipeline *pipe)
 						      &subdev->entity);
 			failure = -ETIMEDOUT;
 		}
+
+		/* Stop at the first external sub-device. */
+		if (subdev->dev != isp->dev)
+			break;
 	}
 
 	return failure;
-- 
2.20.1

