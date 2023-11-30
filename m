Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZjEyUVgs"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC410D9;
	Thu, 30 Nov 2023 09:46:52 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB2AAC0002;
	Thu, 30 Nov 2023 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701366411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuOimxQ6DUKmaHvnMFH38TfLPIgQNK2nzmxig1JzDG4=;
	b=ZjEyUVgsPbIg6mMSGhjkkooxc0RDRlw8TFyZL9MneOJAmX3f2EIfNMhUD40mVX/kJ5jonW
	1yE6ZTt0pmO3FbPXnGIMjG6U8/deNVp2qw1ri4tJ+urJKFLfhTliZAUgEsmH22MMglhNj+
	5klo43pwN4GNA2c+iXsSnXt1HlFm91gDgcZeifgbLWYgNXqA80kg0DwVNMXRxF0HYzJeF/
	mDjAB6y7sssKLKr5LUTJKFGsyOae3rKgSicQTWygW0q5oPWOILfaSgek0G+uGtHx6cAWkR
	KQfQy+CA9bfS32mhPvwLz9WH3DAlAVbrZIoUXMYiVjJDzV9yq2nGYoa+qYQAXw==
From: Mehdi Djait <mehdi.djait@bootlin.com>
To: mchehab@kernel.org,
	heiko@sntech.de,
	hverkuil-cisco@xs4all.nl,
	laurent.pinchart@ideasonboard.com,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com,
	paul.kocialkowski@bootlin.com,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V10 1/3] dt-bindings: vendor-prefixes: Add techwell vendor prefix
Date: Thu, 30 Nov 2023 18:46:45 +0100
Message-ID: <158576c17cf260d2509c5ef5475f84b905bfac77.1701366233.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701366233.git.mehdi.djait@bootlin.com>
References: <cover.1701366233.git.mehdi.djait@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com

Add prefix for Techwell, Inc.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..8cad34d81028 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1381,6 +1381,8 @@ patternProperties:
     description: Technologic Systems
   "^techstar,.*":
     description: Shenzhen Techstar Electronics Co., Ltd.
+  "^techwell,.*":
+    description: Techwell, Inc.
   "^teejet,.*":
     description: TeeJet
   "^teltonika,.*":
-- 
2.41.0

