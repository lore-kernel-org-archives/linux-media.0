Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB873D3307;
	Wed, 21 Jan 2026 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991480; cv=none; b=ez2j36LyuzeXOkm3EqGdD/yWZ4fUHBtM9AQtey6xdlO8SomGi/VwAi3YTH1m8SBnFlNlZZgcln7av6I0q/nH8tujP9o0zFfW6w9JUnGorOXGNgyvHimXUFhDOSNIWVu27lDkRLW/LyPlIE4IKdGTfapBdzm1Yc7P1fsFIAoq5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991480; c=relaxed/simple;
	bh=ktJjYiJZb1HIGWFRxHzP1S+rxzcyHIkrThbcKjDlUng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fnKHfn8HnBy1kewmIhfnKP7huJI0lbJx7+4B8efdxEIOdG1J/8E8wZzrI9mx+l7uIjBRaRUxO4kJ4GsottFiY9vJ0fJI0tgL71qp2xa2OJSvg5MRNyWQ8zAOFBLppUt4U6p/nO/eVK0YiQXnvCQReVEjIG5nyrqQj0kxD6H9jms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eivTrjmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eivTrjmC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2F1FC16AAE;
	Wed, 21 Jan 2026 10:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768991478;
	bh=ktJjYiJZb1HIGWFRxHzP1S+rxzcyHIkrThbcKjDlUng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eivTrjmCt4PeQYw+N7FblAX/K+3zovf2BhYFTJ4DWHC4bY8x3msJ57a05Dw2OCW8q
	 2iPgCO8ikASaKdqcvzih+9Vie1TFC+e4NWVmdgtwXSzQujOYPkr/B2sYE2LsB7HO5U
	 JPKDSOeACSvSGuCCuPHC7OmK85ptXz1eDJlEMCiU62qtiyUKHe97nTyi1WT8KRozi8
	 00hEbiqm7JJlF4YbnH72XcBV5GP4DiZfvZwuTUEmLFaKAKm5oMivCQPuLHh1G4eRNM
	 whnP5uuPYZbi2KNFMatAiXe45YeFhjju/Jeyw6H7i/K6IIizs4evLgcRKl0u/06UWp
	 wW+7LUXI/vNnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A1DC44503;
	Wed, 21 Jan 2026 10:31:18 +0000 (UTC)
From: Zhentao Guo via B4 Relay <devnull+zhentao.guo.amlogic.com@kernel.org>
Date: Wed, 21 Jan 2026 18:30:42 +0800
Subject: [PATCH RFC v3 4/4] arm64: defconfig: Enable VDEC driver for
 Amlogic SoCs
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-s4-vdec-upstream-v3-4-4496aec3d79e@amlogic.com>
References: <20260121-b4-s4-vdec-upstream-v3-0-4496aec3d79e@amlogic.com>
In-Reply-To: <20260121-b4-s4-vdec-upstream-v3-0-4496aec3d79e@amlogic.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Zhentao Guo <zhentao.guo@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768991475; l=650;
 i=zhentao.guo@amlogic.com; s=20251024; h=from:subject:message-id;
 bh=/Xlp3fNnkZZdZMhr2a18FNe8nGeN4JqqPDgMB8hAANM=;
 b=K+4paB1rPUspGyUu/1OETF9afMaVejfVTVDj8RBXrZzlVhhpdos/BnD7H6gTG9mQYVbeVAUou
 SEKbdncolWcDpRDiiYcIHHY8Fv2KzXuhTneysBb6jF+axM1ygDcCjBK
X-Developer-Key: i=zhentao.guo@amlogic.com; a=ed25519;
 pk=5yfDKrjreXwcAoEUsdtWafy6YN500upXp/CgtnXjLVU=
X-Endpoint-Received: by B4 Relay for zhentao.guo@amlogic.com/20251024 with
 auth_id=555
X-Original-From: Zhentao Guo <zhentao.guo@amlogic.com>
Reply-To: zhentao.guo@amlogic.com

From: Zhentao Guo <zhentao.guo@amlogic.com>

Enable the driver for Amlogic's stateless decoder.

Signed-off-by: Zhentao Guo <zhentao.guo@amlogic.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c43dcadabec4..7c89837f683c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -903,6 +903,7 @@ CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SDR_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_AMLOGIC_VDEC=m
 CONFIG_VIDEO_AMPHION_VPU=m
 CONFIG_VIDEO_CADENCE_CSI2RX=m
 CONFIG_VIDEO_MEDIATEK_JPEG=m

-- 
2.42.0


