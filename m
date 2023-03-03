Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919DAC61DA4
	for <linux-media@archiver.kernel.org>; Fri,  3 Mar 2023 23:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCCXX2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 3 Mar 2023 18:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCCXX1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 3 Mar 2023 18:23:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE5975F;
        Fri,  3 Mar 2023 15:23:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0FCA5CE22A4;
        Fri,  3 Mar 2023 21:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972ECC433A1;
        Fri,  3 Mar 2023 21:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677880090;
        bh=ICUo+3AoOR3DSqV/0peJ+lnKr4GOBjTwhw8DibwD7nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1HNA9QUe77485DMp6NjXu8U5XosnhFjPihPE522iPZUuTgCJCForD0t5PE8mEdFN
         phr4o1b1gV6pClerDcRn3ewTpBZH14J3JvvhcTs0Klhyk7eBuZ9uqW81Zg5rEdZH0I
         5zy7ZXobhWtUOaMD25zdUBHAvSCq7Wi/vSimcGZqsJb0wecHyVe+ymLrZ72IREP1lj
         4WzW/mfSKhXjADtJ7gGohBC+lSZSwR5vYpqA2isFPvItPbdmRnMprH9CziFccGpd8I
         PlXdU3CA5xmELGbYmntQr6OSOGGTvK4jl/Hvll50WAHHTnvnksLsjffcdE8oK57xKq
         99VTEoczk30xg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        syzbot <syzkaller@googlegroups.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/20] media: uvcvideo: Handle cameras with invalid descriptors
Date:   Fri,  3 Mar 2023 16:47:48 -0500
Message-Id: <20230303214806.1453287-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303214806.1453287-1-sashal@kernel.org>
References: <20230303214806.1453287-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 41ddb251c68ac75c101d3a50a68c4629c9055e4c ]

If the source entity does not contain any pads, do not create a link.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index ca3a9c2eec271..7c9895377118c 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -37,7 +37,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
 			continue;
 
 		remote = uvc_entity_by_id(chain->dev, entity->baSourceID[i]);
-		if (remote == NULL)
+		if (remote == NULL || remote->num_pads == 0)
 			return -EINVAL;
 
 		source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
-- 
2.39.2

