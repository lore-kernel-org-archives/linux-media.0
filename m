Return-Path: <SRS0=VxL7=D3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD9C388F2
	for <linux-media@archiver.kernel.org>; Tue, 20 Oct 2020 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8C022404
	for <linux-media@archiver.kernel.org>; Tue, 20 Oct 2020 19:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409026AbgJTTjP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409016AbgJTTjM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 20 Oct 2020 15:39:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886E1C0613CE;
        Tue, 20 Oct 2020 12:39:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 71A3B1F44DBC
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        robh+dt@kernel.org, heiko@sntech.de, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, dafna.hirschfeld@collabora.com,
        mark.rutland@arm.com, karthik.poduval@gmail.com,
        eddie.cai.linux@gmail.com, jbx6244@gmail.com,
        zhengsq@rock-chips.com, robin.murphy@arm.com
Subject: [PATCH v6 2/9] media: staging: dt-bindings: rkisp1: drop i2c unit address
Date:   Tue, 20 Oct 2020 16:38:43 -0300
Message-Id: <20201020193850.1460644-3-helen.koike@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020193850.1460644-1-helen.koike@collabora.com>
References: <20201020193850.1460644-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add missing required items in Rockchip ISP1 dt-bindings example for
a complete i2c node.
Drop unit address to Fix error:
/example-0/parent/i2c@ff160000: node has a unit name, but no reg or ranges property
Remove unecessary fields for the example.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 .../Documentation/devicetree/bindings/media/rockchip-isp1.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.yaml b/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
index a77b6ec500c95..4c31cfaee2709 100644
--- a/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
+++ b/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
@@ -168,8 +168,7 @@ examples:
             };
         };
 
-        i2c7: i2c@ff160000 {
-            clock-frequency = <400000>;
+        i2c7: i2c {
             #address-cells = <1>;
             #size-cells = <0>;
 
-- 
2.28.0

