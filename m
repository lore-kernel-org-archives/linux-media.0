Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OvAq1wOK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676D1AC;
	Tue, 12 Dec 2023 23:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702451900;
	bh=R0EPnnH2lUhpKxCiD3hGDPCbdnJBTlqcqNHVynAmqLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OvAq1wOKGgOh7++SoiiENu0BjinGn1BRI26s7WjWQBMEcuh3QvARtx2xkguobCvUS
	 /pRVpvHY94tVveDOJ+PHFQS/YUS1QnzUwjgJg9cmtifvRyV3FL1F2YRWYq+e4ZXRNT
	 6U48Vt8bUleEx/A/LC3rNKJviQrZKsk7tMoPhK4lu+XpQWeWTiPOteWkV2IHLEW5xO
	 rwnLfCL8qw7aSbI33BL2WLoLdueVuvXcKCx7w44fmqWzPSOTy28JOw/tQlq3WQox9X
	 ifCCb5Kmkn+RPRMiuRBJXN8RkTxKwYUD+MI40c780Y4IHiXvgmrsuL9E7qiFfPTisu
	 Ac/w3ScHWdG9w==
Received: from stla-brain-8255-1.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8C8013781419;
	Wed, 13 Dec 2023 07:18:19 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
To: benjamin.mugnier@foss.st.com,
	sylvain.petinot@foss.st.com,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	Julien Massot <julien.massot@collabora.com>
Subject: [PATCH] media: dt-bindings: st-vgxy61: relax data-lanes restriction
Date: Wed, 13 Dec 2023 08:17:37 +0100
Message-ID: <20231213071737.1070162-1-julien.massot@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ST VGXY61 sensors support multiple lane number, as
well as lane mapping.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 .../devicetree/bindings/media/i2c/st,st-vgxy61.yaml        | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/st,st-vgxy61.yaml b/Documentation/devicetree/bindings/media/i2c/st,st-vgxy61.yaml
index 8c28848b226a..733fac85a20f 100644
--- a/Documentation/devicetree/bindings/media/i2c/st,st-vgxy61.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/st,st-vgxy61.yaml
@@ -67,11 +67,8 @@ properties:
           data-lanes:
             description:
               CSI lanes to use
-            items:
-              - const: 1
-              - const: 2
-              - const: 3
-              - const: 4
+            minItems: 1
+            maxItems: 4
 
           remote-endpoint: true
 
-- 
2.43.0

