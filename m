Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A42C7EE3A
	for <linux-media@archiver.kernel.org>; Fri,  3 Mar 2023 21:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCCVzz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 3 Mar 2023 16:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjCCVzU (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 3 Mar 2023 16:55:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A36B33E;
        Fri,  3 Mar 2023 13:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA15461921;
        Fri,  3 Mar 2023 21:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AC0C4339C;
        Fri,  3 Mar 2023 21:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677880134;
        bh=K320IATZViZ6p2z8opWgQ4B3i0XStvbTQyf1uRhNInQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHTt3TOdFA7G3QjYYnls5FBPtA1eb/XJ7rc7tdrmEePs9bkbuTTWdfH6VvSYvI+Ii
         5Y7EHsYVt7AG+84ZEqpbhxVjrtzSXSaEgi3CWO8nbxaBsBgEj6epfi+fvW5vxBHuLr
         aa/2yrIAwnXmPzsfLf8fBmZKTzdv3pZUqUrgCoiC2Jm3WCfgehTndxRVzAwidfo+oH
         QIa3Qz0+dvByp69K1jkvqYpThOZIPaYo/MsszwSXVtzEkTgfvJY1a/CYhUOUm2BNnK
         64ocGseNPTMl4YGpj+WT+rPyURQTMAuAEQmkjTmypqou98RUCv9if+PoM6unkkPcL6
         PxANmWLg4FWVA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        syzbot <syzkaller@googlegroups.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/16] media: uvcvideo: Handle cameras with invalid descriptors
Date:   Fri,  3 Mar 2023 16:48:35 -0500
Message-Id: <20230303214849.1454002-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303214849.1454002-1-sashal@kernel.org>
References: <20230303214849.1454002-1-sashal@kernel.org>
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
index f2457953f27c6..0d5aaaa7e2d96 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -42,7 +42,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
 			continue;
 
 		remote = uvc_entity_by_id(chain->dev, entity->baSourceID[i]);
-		if (remote == NULL)
+		if (remote == NULL || remote->num_pads == 0)
 			return -EINVAL;
 
 		source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
-- 
2.39.2

