Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A7C25B06
	for <linux-media@archiver.kernel.org>; Wed, 10 Aug 2022 12:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiHJMLo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Aug 2022 08:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiHJMLm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Aug 2022 08:11:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C516AA0B
        for <linux-media@vger.kernel.org>; Wed, 10 Aug 2022 05:11:41 -0700 (PDT)
Received: from deskari.lan (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C023A576;
        Wed, 10 Aug 2022 14:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660133498;
        bh=96jozUYbU2FtZp4+Kiv5v+4o9WhSyX5tkfq5XS8jzlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9z+XuuUO/gZnnjTkkslcYmouq//rovPnwXjiME8wz1Z+4IPCNUMuVSRU/FtjxurT
         vIgL7ifkk4ezcAbvb0J/M7K//LNQ8f8yvF0e3FB9G3TGGVNzAaWrlaiJf6o7ZJIM9h
         xAj8OSaG87aQ3F7v6TOxX5W9SXMN9OLBnqMoQcMM=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham <kishon@ti.com>,
        satish.nagireddy@getcruise.com, Tomasz Figa <tfiga@chromium.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v13 02/34] media: media-entity.h: add include for min()
Date:   Wed, 10 Aug 2022 15:10:50 +0300
Message-Id: <20220810121122.3149086-3-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810121122.3149086-1-tomi.valkeinen@ideasonboard.com>
References: <20220810121122.3149086-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

./include/media/media-entity.h:595:34: error: implicit declaration of function ‘min’

Include kernel.h to get the definition for min().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 include/media/media-entity.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index a9a1c0ec5d1c..3e3d06c1ec36 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -15,6 +15,7 @@
 #include <linux/bug.h>
 #include <linux/container_of.h>
 #include <linux/fwnode.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/media.h>
 #include <linux/types.h>
-- 
2.34.1

