Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0DC25B47
	for <linux-media@archiver.kernel.org>; Tue, 24 Oct 2023 19:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbjJXTK2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Oct 2023 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJXTKZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Oct 2023 15:10:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8F10C3;
        Tue, 24 Oct 2023 12:10:23 -0700 (PDT)
Received: from arisu.hitronhub.home (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 83524660733F;
        Tue, 24 Oct 2023 20:10:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698174622;
        bh=yF40Xq3h7w8x7LM+PWjWKuBLlfU8AeTqO96Ax5XsgdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wx89WaWSslOyustoDPiV09uboUE5dHipiNiUWBnTQG8C1LDXNIvMvTPMZmAWSiX03
         xHSYl/COlxnH7hE0GjHhCaxv0sm1gmc48oXm1QB06Wp5YcCHt58sNMNgGS2cjMGapo
         MhogDwhidaEvqpwy1soTSHlzdY2CfFQ6qWP4dV/WpHetw9t1DqDCLIza7ol+xKxX8S
         9J7kopjnsCmXK1P1Wuly/pR6rJ3TVz6CqqJnala621o1PymHsRlDmA9zP2n3CEkZMc
         W7vsYvawoEIZZE/mbZakqdrts3ziwUYCTXJelH3Rnm1GCsp8Q82kR95p1/D7Zt87Ix
         riSgceuhGHlHQ==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 3/5] doc: visl: Document stable_output parameter
Date:   Tue, 24 Oct 2023 15:09:48 -0400
Message-ID: <20231024191027.305622-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024191027.305622-1-detlev.casanova@collabora.com>
References: <20231024191027.305622-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/admin-guide/media/visl.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
index 7d2dc78341c9..5b26fd943571 100644
--- a/Documentation/admin-guide/media/visl.rst
+++ b/Documentation/admin-guide/media/visl.rst
@@ -49,6 +49,10 @@ Module parameters
   visl_dprintk_frame_start, visl_dprintk_nframes, but controls the dumping of
   buffer data through debugfs instead.
 
+- stable_output: Limit the information written on each output frame to make
+  sure that, for a given input, the output frames are always exactly the same.
+  This is useful for automated tests to check that output frames are correct.
+
 What is the default use case for this driver?
 ---------------------------------------------
 
-- 
2.41.0

