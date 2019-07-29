Return-Path: <SRS0=yEzF=V2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39F5C7618B
	for <linux-media@archiver.kernel.org>; Mon, 29 Jul 2019 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E7E214AE
	for <linux-media@archiver.kernel.org>; Mon, 29 Jul 2019 07:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfG2HsI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:48:08 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:33506 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2HsI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 29 Jul 2019 03:48:08 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8DA5025AEB1;
        Mon, 29 Jul 2019 17:48:05 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 6C8B49403F0; Mon, 29 Jul 2019 09:48:03 +0200 (CEST)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] dt-bindings: rcar-imr: Rename bindings documentation file
Date:   Mon, 29 Jul 2019 09:47:57 +0200
Message-Id: <20190729074757.9581-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Renesas media binding documentation files uses a naming schema of
'renesas,<module>.txt'. Rename IMR file to match this pattern.

Cc: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/media/{rcar_imr.txt => renesas,imr.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/media/{rcar_imr.txt => renesas,imr.txt} (100%)

diff --git a/Documentation/devicetree/bindings/media/rcar_imr.txt b/Documentation/devicetree/bindings/media/renesas,imr.txt
similarity index 100%
rename from Documentation/devicetree/bindings/media/rcar_imr.txt
rename to Documentation/devicetree/bindings/media/renesas,imr.txt
-- 
2.11.0

