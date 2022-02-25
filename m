Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6064C433FE
	for <linux-media@archiver.kernel.org>; Fri, 25 Feb 2022 22:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiBYXAT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbiBYXAS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 25 Feb 2022 18:00:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891CA1B84F0;
        Fri, 25 Feb 2022 14:59:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 100231F46808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645829984;
        bh=qY7g+EkArzTfdSMsa9x3xIBuajRepERJP4O9V2Lj82Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDi+OJ5/TIg5zuBS22T/Vv9UsG1dEkQNLnps4DxdHeiWpgWxZkuNOF8f72+kWb/7g
         GZNQNlYCtIsRXnJG87wUTktx8ycjFyX2fdV0hELqwKuZYV8gbPvHlPOIfX3T4F4+Xi
         PX13JZoH1aAeLLmVfL8Wh/8MViGfXcWYlN0tPX1d20eoJD3LzHe2E/MGPIWYKDOnLT
         YzE3pE+aykhxV57oKreGBBZZa0UT/8JTSaA+ChMNVHsR6FGGoNtrv6UYGIGVYOtbxN
         a6XEksawKVcl+qc7TBEhiDVGoQjW/vVZhQxzt8txAgDW0WvS2p7pJn6nHbbipFKR1F
         cCt8z3UCYpJZw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 3/3] media: dt-bindings: mtk-vcodec-encoder: Add power-domains property
Date:   Fri, 25 Feb 2022 17:58:54 -0500
Message-Id: <20220225225854.81038-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225225854.81038-1-nfraprado@collabora.com>
References: <20220225225854.81038-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The encoder node may be dependent on a power-domain. Add a property for
it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index e7b65a91c92c..c288913e5666 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -65,6 +65,9 @@ properties:
     description:
       Describes point to scp.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.35.1

