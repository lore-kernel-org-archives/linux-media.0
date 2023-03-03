Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90455C7EE33
	for <linux-media@archiver.kernel.org>; Fri,  3 Mar 2023 21:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjCCVpC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 3 Mar 2023 16:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjCCVoR (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 3 Mar 2023 16:44:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965154B82A;
        Fri,  3 Mar 2023 13:43:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ECDC61941;
        Fri,  3 Mar 2023 21:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E88DC4339B;
        Fri,  3 Mar 2023 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677879803;
        bh=+O1tPn4wrXUQ1XEJE0xzcUDk4ho6GG93RTc/wxWagL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTYOSNiSpgsoVZBBxjYKBv0SSDz27lczlVWgLUIdgFi5e1y1lfhhq6QUQyeGVK12l
         dH5WWNFH6cNE6mvDLCeTgY87UPSYxdXEjDrKendBIdIC0jc7gtzQEkn8rx8zCSCj8r
         JLaKr4rXWh4MgZr1IJ+WDzPTbqJqGJKjn0Df5u1h/jjc/aX3wPsB/9Tw0IFLv3bkxh
         A5PSdRO9TvAbel5YMTzIdAgJBR3pc1mJS2NdINf+OQcMAHQKwGPtSlPpfd792y2ByA
         Gt10Z8mUnxH2Wyl8fRuiTYbrQ26w5CjVn8PAmg5EnCoGJHO5g/rb+uO/euf+WjLfs6
         tibPPrxsDuX+g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        syzbot <syzkaller@googlegroups.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/60] media: uvcvideo: Handle cameras with invalid descriptors
Date:   Fri,  3 Mar 2023 16:42:19 -0500
Message-Id: <20230303214315.1447666-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303214315.1447666-1-sashal@kernel.org>
References: <20230303214315.1447666-1-sashal@kernel.org>
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
index 7c4d2f93d3513..cc68dd24eb42d 100644
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

