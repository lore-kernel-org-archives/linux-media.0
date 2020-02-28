Return-Path: <SRS0=r8kb=4Q=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD9C3F2CD
	for <linux-media@archiver.kernel.org>; Fri, 28 Feb 2020 23:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21EF2469C
	for <linux-media@archiver.kernel.org>; Fri, 28 Feb 2020 23:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH/hJIsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgB1X1G (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:27:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43945 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1X1G (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 28 Feb 2020 18:27:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so2466506pfh.10
        for <linux-media@vger.kernel.org>; Fri, 28 Feb 2020 15:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BbYfEYBoBSP3LeAASJDn3pKKlp6Q3BiIp2TYYxkiAic=;
        b=mH/hJIsAdclUHJcJ2Y5NoKd7EKWm9a0yi+QFgm/7irqs+k0CgRWe961xXnz7FwCHAU
         wCI8eNXc6EDJxCpfqUxyoOM3mHhYN4eAKl49aQ49ZZ6dLQCnixm/7JqVntqpPbzISxWz
         6ToHwhFw2IKYI7vHkp6XMbhKT4sNnZ62bYASu580JguUSsSjrjA4C7RFyIwQw1onBCEh
         3s9ygSrE8jUEhckQFOwA+3KyxvtuR2Or5ECGL9t30cA+/qL9wI/acIKAG5gaHkwPQ9YN
         piyZIQAjSamD8SuTKVdPMrSYEr2JIqs/75KXO6ly6JfOcHniv4IJ7cllQzCU+lSjyPCg
         mFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BbYfEYBoBSP3LeAASJDn3pKKlp6Q3BiIp2TYYxkiAic=;
        b=PkR2OW7+4J9H1eDHTXAytVKSJSw2I4rvRODY+6UcmvzfvcpWUGIHlLfOz+qqs4cBgp
         B5fyNWuvagtsLudsgNuxOchHiqxN1lJSXGsMpInZzssRMUdg7BYsr9uWJp5bX7cpv4mz
         Cnu8oNerJ0ZVSr9iVOxNg57QiO1llXI76GBKpIwsn/FoB2+fHL2Qgbufco7NpNRBFrVQ
         mLV7HG8kcSx8WH8VOKD9u/4TF8Qh2JZ9TVf24PzjCMKw+9tW1qGSy7x7HHeX16TTHbdk
         u/DsBvZ424FM4OiEqoWy2NyNPhEKWgzQCB8ecSWa08wKkuDX2tY1AKJlngMxHW50DqDP
         8Cpg==
X-Gm-Message-State: APjAAAXRJo+TpZdhfH1DYeA0lqfCEYmBHlaEU1kG4Qa47aAGlr86FmEX
        U6Q2fRC3fomrJl6zVKMESC5wgaeGSoM=
X-Google-Smtp-Source: APXvYqwR0hlYPIpd6J0rPCgvsg4Xd4c0YIqQWU0CKjz+kZUlN755zGacnUKx8TnyE4oXYnDl6ltOGg==
X-Received: by 2002:aa7:8755:: with SMTP id g21mr6762066pfo.36.1582932423432;
        Fri, 28 Feb 2020 15:27:03 -0800 (PST)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id s7sm11465243pgp.44.2020.02.28.15.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:27:02 -0800 (PST)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Longerbeam <slongerbeam@gmail.com>
Subject: [PATCH] media: imx: Propagate quantization and encoding in CSI
Date:   Fri, 28 Feb 2020 15:26:57 -0800
Message-Id: <20200228232657.27028-1-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Unlike the PRPENC and PRPVF subdevices, the CSI's cannot convert
quantization from sink to source, or do any kind of Y'CbCr <-> RGB
encoding. So the CSI's cannot allow quantization and ycbcr_enc to be
selectable by the user and must be propagated from sink to source.

Fixes: 4791bd7d6adc4 ("media: imx: Try colorimetry at both sink and source pads")
Reported-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-media-csi.c  | 2 ++
 drivers/staging/media/imx/imx7-media-csi.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index b60ed4f22f6d..ac15b1e78f18 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1459,6 +1459,8 @@ static void csi_try_fmt(struct csi_priv *priv,
 		/* propagate colorimetry from sink */
 		sdformat->format.colorspace = infmt->colorspace;
 		sdformat->format.xfer_func = infmt->xfer_func;
+		sdformat->format.quantization = infmt->quantization;
+		sdformat->format.ycbcr_enc = infmt->ycbcr_enc;
 
 		break;
 	case CSI_SINK_PAD:
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index db30e2c70f2f..4692a3a77515 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1013,6 +1013,8 @@ static int imx7_csi_try_fmt(struct imx7_csi *csi,
 
 		sdformat->format.colorspace = in_fmt->colorspace;
 		sdformat->format.xfer_func = in_fmt->xfer_func;
+		sdformat->format.quantization = in_fmt->quantization;
+		sdformat->format.ycbcr_enc = in_fmt->ycbcr_enc;
 		break;
 	case IMX7_CSI_PAD_SINK:
 		*cc = imx_media_find_mbus_format(sdformat->format.code,
-- 
2.17.1

