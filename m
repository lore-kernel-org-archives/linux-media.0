Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A77C28E82
	for <linux-media@archiver.kernel.org>; Fri, 12 Mar 2021 17:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD8665030
	for <linux-media@archiver.kernel.org>; Fri, 12 Mar 2021 17:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhCLRaB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Mar 2021 12:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhCLR3d (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Mar 2021 12:29:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34926C061574
        for <linux-media@vger.kernel.org>; Fri, 12 Mar 2021 09:29:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso16268826wme.0
        for <linux-media@vger.kernel.org>; Fri, 12 Mar 2021 09:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKTuRup8dPa/K5+GFpnvDSVBJYngatFOEgMROjY7gcc=;
        b=b0JTfx0uO5qWWjVtsMhOMtSGVIQd2mJGlrzHR4wEgCXwmZvtORgoCayl11gDTbN9ph
         1WKmSG8KMO8NG8BiBCphPPLXMiQFIohDpPI7s72ybCQFrcLAkDw0PDNBGE4xVSqHSeBQ
         YHmIxnxRz9wmhd6iPml/0u1HM/lhfXlOuLYIKWn1OEMfPNTERbAa62NqZqVCJ4tb32wH
         URF0yQq3IoCDsdSNs11BYkAhNCzUWo3nTOr2JLPjSyjGwBXF7HHAdrGlw88Vhh5x17xE
         ZGMAjKKy7KZv5tTtDCl712ol3c6ct/1QuxCSH8HmpsF5GjTrbcZ8W8SVkk7FohWxph5y
         koaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKTuRup8dPa/K5+GFpnvDSVBJYngatFOEgMROjY7gcc=;
        b=pNkEiMdZRS0kKM1NKUKKGZKLEt6PdKbxKLpDx9cjm5Jf/dcTLLFjuvpHodYWQr7eVv
         w2N8w2wIQ6FRQ1fdAvbLTnTxCDHGeQ08tI0QGR80r1cLDpUFdcl8l0NncPxUgkLqVf4r
         PGR8G2OENQwPabFnz9uQ7yuoVaA9j6i9ZrXURVDIZKijzTj3oCaP7Vpzc3IUGdb7XBpt
         keTP4mCLnsabRPzlg6S6nMo13MsX7DGf7ma7MbagguJSl8n9rp8RB61Fy4kjo17rSM8W
         K25vLL3Lp/Uf1n2M6vkly2imdd/ZUZ6daLA4SsdUnic/+zqwot/vWJNP1DzmYoZfqHum
         oMvw==
X-Gm-Message-State: AOAM5324VhtywNYZmreQrJ47sW56vGptiIyW2wcSLI24vD8fwAdCGyRA
        69ez9zZ4ixLM6XyCY5B8i7EnSA==
X-Google-Smtp-Source: ABdhPJw5k2nNX7HyV5ZXMpGjwg9SGHPAAzHuioH00kVzr3qv9+O2NKDdLdS0XK0TCefPQx9z8WREpA==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr14274777wma.148.1615570171959;
        Fri, 12 Mar 2021 09:29:31 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 18sm2876375wmj.21.2021.03.12.09.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:29:31 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     stanimir.varbanov@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, dikshita@codeaurora.org,
        jonathan@marek.ca, vgarodia@codeaurora.org
Subject: [PATCH v2 20/25] media: venus: firmware: Do not toggle WRAPPER_A9SS_SW_RESET on 6xx
Date:   Fri, 12 Mar 2021 17:30:34 +0000
Message-Id: <20210312173039.1387617-21-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312173039.1387617-1-bryan.odonoghue@linaro.org>
References: <20210312173039.1387617-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dikshita Agarwal <dikshita@codeaurora.org>

Do not toggle the WRAPPER_A9SS_SW_RESET on 6xx.

Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 8c2c68114bbd..227bd3b3f84c 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -53,10 +53,12 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 		return ret;
 	}
 
-	if (resume)
+	if (resume) {
 		venus_reset_cpu(core);
-	else
-		writel(1, core->wrapper_base + WRAPPER_A9SS_SW_RESET);
+	} else {
+		if (!IS_V6(core))
+			writel(1, core->wrapper_base + WRAPPER_A9SS_SW_RESET);
+	}
 
 	return 0;
 }
-- 
2.30.1

