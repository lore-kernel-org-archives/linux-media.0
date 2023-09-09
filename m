Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677D4EEB57E
	for <linux-media@archiver.kernel.org>; Sat,  9 Sep 2023 01:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbjIIBhX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 8 Sep 2023 21:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbjIIBhU (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 8 Sep 2023 21:37:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9943D1FE3;
        Fri,  8 Sep 2023 18:37:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE77C433CC;
        Sat,  9 Sep 2023 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220000;
        bh=AljRBhaFoFCacH/8SWMydugkK6rFIWiRGkU6lEB9WYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6TQYChTp/fUowPIO5HnMbhQrdtBQ5F4IgaFSCW47cyMnA8F+BbTzS4Qvk7ReKZHA
         bq1WtITFF/wB8FEQJnU8egyUl6n0/p0XRZcjj0cDDYmgNrNSVt3b+O4oxZbvWc/iWH
         yCA7DqIpUyK5tKWGdk7znKniBJyWvokeb0lUFqBJ2nWejb9Crqy91cg4Y8hajmdNvt
         dfsjiOXdQUMj/gmTsvUtoBdelFdO5AJB/zusesQ6Y1ecU1AgyyodYM5XF52JPP39ED
         Rtc5OiUM4DgxEn3EQjCZfOAfkD+tBCyJ/YGm16M1LTSKaxhjAJ0aEgN2utzPnlU5eD
         gnpatqoA9HLmw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        harperchen1110@gmail.com, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/16] media: pci: cx23885: replace BUG with error return
Date:   Fri,  8 Sep 2023 20:39:34 -0400
Message-Id: <20230909003941.3580631-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003941.3580631-1-sashal@kernel.org>
References: <20230909003941.3580631-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 2e1796fd4904fdd6062a8e4589778ea899ea0c8d ]

It was completely unnecessary to use BUG in buffer_prepare().
Just replace it with an error return. This also fixes a smatch warning:

drivers/media/pci/cx23885/cx23885-video.c:422 buffer_prepare() error: uninitialized symbol 'ret'.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/cx23885-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index a380e0920a21f..86e3bb5903712 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -412,7 +412,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 				dev->height >> 1);
 		break;
 	default:
-		BUG();
+		return -EINVAL; /* should not happen */
 	}
 	dprintk(2, "[%p/%d] buffer_init - %dx%d %dbpp 0x%08x - dma=0x%08lx\n",
 		buf, buf->vb.vb2_buf.index,
-- 
2.40.1

