Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CbNnMD4o"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225ACD40;
	Wed,  6 Dec 2023 10:53:28 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6IrEVV057757;
	Wed, 6 Dec 2023 12:53:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1701888794;
	bh=K1KWedNJcvVp5thdYC7ZqsG88KraphWllYULHvlTvpY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CbNnMD4oeXVTTXAmonax5l5F7wrIO00HOXSkLwFV+JoZT3QJTrraAfugvB9NkATig
	 xiMiIJ/9WiALjglRmjzRHcRj5XMLNH4ZWYVQyY2hqbIjSgVN4xMOCsv8uSSvhY/J+O
	 wpnK4zWZXo49VpM0KBN5NEygCxcqSNwbjVaQdTuw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6IrEvr089248
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Dec 2023 12:53:14 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 12:53:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 12:53:13 -0600
Received: from udba0500997.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6IrBNF020337;
	Wed, 6 Dec 2023 12:53:13 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas
 Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sebastian Fricke
	<sebastian.fricke@collabora.com>,
        Dafna Hirschfeld
	<dafna.hirschfeld@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Nishanth Menon <nm@ti.com>, Darren Etheridge <detheridge@ti.com>,
        Brandon
 Brnich <b-brnich@ti.com>
Subject: [PATCH v2 2/2] media: chips-media: wave5: Remove K3 References
Date: Wed, 6 Dec 2023 12:52:54 -0600
Message-ID: <20231206185254.1748473-3-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206185254.1748473-1-b-brnich@ti.com>
References: <20231206185254.1748473-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Change compatible string to match dt bindings for TI devices. K3 family
prefix should not be included as it deviates from naming convention.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdUYOq=q1j=d+Eac28hthOUAaNUkuvxmRu-mUN1pLKq69g@mail.gmail.com/
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 V1 -> V2: Fix style issues in commit message

 drivers/media/platform/chips-media/wave5/wave5-vpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index bfe4caa79cc9..0d90b5820bef 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -272,7 +272,7 @@ static const struct wave5_match_data ti_wave521c_data = {
 };
 
 static const struct of_device_id wave5_dt_ids[] = {
-	{ .compatible = "ti,k3-j721s2-wave521c", .data = &ti_wave521c_data },
+	{ .compatible = "ti,j721s2-wave521c", .data = &ti_wave521c_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, wave5_dt_ids);
-- 
2.34.1

