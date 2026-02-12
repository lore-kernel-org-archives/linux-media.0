Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD395357A43
	for <linux-media@vger.kernel.org>; Thu, 12 Feb 2026 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770899013; cv=none; b=eouNSeeq3SuOPt5kVpcQ6xnUCwvErrGqL8V0AkbRuTRN2iONA3HARzPIWajm+0U0o9teX8U6cbWGdOZTmREpnhxzD3YAWKrN4NjCvMI7k7QKmWgXNbDpSMjub6Vkg5a1ZQFylnFRwDgCX6VJiQ1D/DoL0SD6iORTNNd5fpv6gQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770899013; c=relaxed/simple;
	bh=CoeSUcu5JKP2vlIyuq71hLdki8LZeHARqdF+DbG35Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqxiyufX47FuMQ9pRI1RY/6xnzUzHz+bSyAINtiDSdV9XKsmiNCQSyp1ZH1AFNry9C23TfpOd9tLnB5MP0hAQ/ord+sSgZZ3V9QwRmDKo9tx+ZI3tPn+5dwAy+GyLqjY8tWAK8EUGS3ihtfgFJsauvch7BVBCtPux3EKvNI4Ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMmwb6qw; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMmwb6qw"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so10849124a12.3
        for <linux-media@vger.kernel.org>; Thu, 12 Feb 2026 04:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770899010; x=1771503810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcDfVsxOaZtMJ1kOTr1x0s4TukCtP+zyp2wxcrrzJwc=;
        b=dMmwb6qw1QgWBYOoFlRckOseeXiIgjvfS62Pj8IMLs4oXZZQVLrbh0FvKcIUxc9I/L
         PRBWFRLFNeITe6j8s3Os2xE+330lfVpGYQSntwVDf9c/KQby9EE3T+C3UXDDXGQoqAtL
         vSgoClyc888c5sK/5RmFr6OZfPoWSg+sx3DuR8x1lOXUxfwYPeD5JrewfDotPQ/lR/hW
         hvrfweMMREAB2hVfTgj/pcETW/rLafoIcw2TQKo9oyEHp9X0SMVCxeJTEpeR26pHOMBo
         HCE7yRqAGMJ/UlFz3B6oucTfmldGjGoPi9RuWldxLPCy6woIg5a/v4w3rAyWJlS3RZMT
         Lv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770899010; x=1771503810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcDfVsxOaZtMJ1kOTr1x0s4TukCtP+zyp2wxcrrzJwc=;
        b=rduaOy4uiVVyJ00raMYgGaxgKFZCYZ9jXec/moULLGvqbcvHYShDl3nTavx0p/+Q7W
         R9S2LxQiWnTyzNTSvv4dhDr1E3W9UKwvZsLVgKWE5yQ4Ei2h67giZ2lxbpXBlLFv+3SS
         oVNoGUpYhxFwvlYTWAWe/svWZKlF/z22VhVsl7nvIQhmzacbkgO2kt79PB9nttmD0mXY
         1kMb8SWTVUz+Xzgc7sdGpWp7zVaeQXjeJ5/tcJgvxffsRJaFm9H/7+3HGAlC04/cA0Xi
         6F3rHOw3QTtidhIPiMRk66FTsEuT3viKv4vAJrxizrtCHHoyjO2P8jGm8cjL5sQ3QNzt
         q8uA==
X-Gm-Message-State: AOJu0YzyxF4pokDJ2GsA41NyMpSd3/hLrt3AVjSS1MzwGUrs1NP+C4Pc
	Pc0bd0xj5eL3wkWxwM1l3w8jKLVaP+Rmm9CRKLxpnPVB9HfPmNucYI75
X-Gm-Gg: AZuq6aJZ5Efj+2WAg70wGdw11J3kEayH3ydb6v55Q9IoRT00/ehSHBymAFg4soOFrno
	o9mC+jNi3bF/yJAUYdPTD6c90zPnzhR8r9tqppPOcCstlA/yvOpGrbi0jbwrZb/w/j41KCj7RM5
	dp7uOR+ZqE2WuaymGIhCMnNJCwhLu5pYQe5ZgYCGE1p/tXDBDZI+Dg+xbhfCaJsFsIsv9dWuEld
	8FZ/SRWhqe1dAmVGx6Epvvi4TGfLDmdAFFAEazE/WbONegab+gyj1l/SJNENRXOKLclE80Kn5+x
	nbQnKdn74obts7YbjXbyrtPoOQFNK5ofmA5yJ5A4sMiA4zRsx4a4KYg5q0TrxayUpCFxwFtUTEp
	xErDEL5UAivPjepbJbrmnMpqJ8i5nS2FnXp8UkBcr672BFyi7HYfK4KvJzpQfKMG6nVR3y6RDNR
	Bh5BntYwthYlgy
X-Received: by 2002:a17:907:3cd2:b0:b88:463e:b55f with SMTP id a640c23a62f3a-b8f8f3d85a9mr142911166b.6.1770899009817;
        Thu, 12 Feb 2026 04:23:29 -0800 (PST)
Received: from xeon ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6ec1c753sm155603466b.45.2026.02.12.04.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 04:23:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: media: mt9m114: document MI1040 sensor
Date: Thu, 12 Feb 2026 14:23:01 +0200
Message-ID: <20260212122302.29211-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260212122302.29211-1-clamor95@gmail.com>
References: <20260212122302.29211-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Aptina MI1040 is a slightly different version of the MT9M114 camera
module. It is used in several devices, such as the ASUS Nexus 7 (2012) and
the ASUS Transformer Prime TF201. The compatible "onnn,mt9m114" is placed
first in the enum, as it is considered the default compatible value.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/media/i2c/onnn,mt9m114.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/onnn,mt9m114.yaml b/Documentation/devicetree/bindings/media/i2c/onnn,mt9m114.yaml
index dffd23ca4839..e896f4db2421 100644
--- a/Documentation/devicetree/bindings/media/i2c/onnn,mt9m114.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/onnn,mt9m114.yaml
@@ -17,7 +17,9 @@ description: |-
 
 properties:
   compatible:
-    const: onnn,mt9m114
+    enum:
+      - onnn,mt9m114
+      - aptina,mi1040
 
   reg:
     description: I2C device address
-- 
2.51.0

