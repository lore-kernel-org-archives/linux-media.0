Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB547CE7A8B
	for <linux-media@archiver.kernel.org>; Mon, 25 Sep 2023 00:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjIYAl3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 24 Sep 2023 20:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjIYAlP (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF1510A
        for <linux-media@vger.kernel.org>; Sun, 24 Sep 2023 17:41:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95CD3842;
        Mon, 25 Sep 2023 02:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695602363;
        bh=laEefnxjMh2UpaIdGxB5tTY7Z0R+cQ3cKGIWvbQ8Jxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeFjlpaLyFtP4fNaKlvIBqszUhPgHzNy72uamgvVJmZZvsSXYN64oBUe6wrmQHMpN
         xH68G96dVFlG2buW3AqrLqkRTM+yG1O3rxXerEb2VhVLaqrM1VRwNubjD7kkfhNr2e
         i4I4p88S7eWQmkdN0O7OMH/cSqH7QU9zUQT0zzfY=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 01/14] MAINTAINERS: Add co-maintainer for the rkisp1 driver
Date:   Mon, 25 Sep 2023 03:40:59 +0300
Message-ID: <20230925004112.22797-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925004112.22797-1-laurent.pinchart@ideasonboard.com>
References: <20230925004112.22797-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

As I'm actively working on the rkisp1 driver, I would like to volunteer
as a co-maintainer, mostly to make sure I get CC on patches.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..9ce0d128410c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18512,6 +18512,7 @@ F:	sound/soc/rockchip/rockchip_i2s_tdm.*
 
 ROCKCHIP ISP V1 DRIVER
 M:	Dafna Hirschfeld <dafna@fastmail.com>
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
-- 
Regards,

Laurent Pinchart

