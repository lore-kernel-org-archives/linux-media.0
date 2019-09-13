Return-Path: <SRS0=xE+E=XI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDC7C49ED7
	for <linux-media@archiver.kernel.org>; Fri, 13 Sep 2019 06:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE78208C0
	for <linux-media@archiver.kernel.org>; Fri, 13 Sep 2019 06:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfIMGu3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 13 Sep 2019 02:50:29 -0400
Received: from retiisi.org.uk ([95.216.213.190]:35278 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbfIMGu2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 13 Sep 2019 02:50:28 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 029F3634C87;
        Fri, 13 Sep 2019 09:50:07 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl
Subject: [PATCH v2 6/6] smiapp: Avoid fall-through in switch
Date:   Fri, 13 Sep 2019 09:47:22 +0300
Message-Id: <20190913064722.11415-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819124728.10511-7-sakari.ailus@linux.intel.com>
References: <20190819124728.10511-7-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Remove switch fall-through cases in the driver.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/smiapp/smiapp-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index 76d7d204ec17..c6202f3a4015 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -1674,13 +1674,14 @@ static void smiapp_propagate(struct v4l2_subdev *subdev,
 				sensor->binning_vertical = 1;
 			}
 		}
-		/* Fall through */
+		break;
 	case V4L2_SEL_TGT_COMPOSE:
-		*crops[SMIAPP_PAD_SRC] = *comp;
 		break;
 	default:
-		BUG();
+		WARN_ON(1);
+		return;
 	}
+	*crops[SMIAPP_PAD_SRC] = *comp;
 }
 
 static const struct smiapp_csi_data_format
@@ -2062,7 +2063,7 @@ static int __smiapp_sel_supported(struct v4l2_subdev *subdev,
 		    && sensor->limits[SMIAPP_LIMIT_SCALING_CAPABILITY]
 		    != SMIAPP_SCALING_CAPABILITY_NONE)
 			return 0;
-		/* Fall through */
+		return -EINVAL;
 	default:
 		return -EINVAL;
 	}
@@ -2716,7 +2717,7 @@ static struct smiapp_hwconfig *smiapp_get_hwconfig(struct device *dev)
 		case 180:
 			hwcfg->module_board_orient =
 				SMIAPP_MODULE_BOARD_ORIENT_180;
-			/* Fall through */
+			break;
 		case 0:
 			break;
 		default:
-- 
2.20.1

