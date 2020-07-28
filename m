Return-Path: <SRS0=EguH=BH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A00C433E0
	for <linux-media@archiver.kernel.org>; Tue, 28 Jul 2020 23:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C218207FC
	for <linux-media@archiver.kernel.org>; Tue, 28 Jul 2020 23:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="wSiJJlaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgG1XAV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbgG1XAU (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 Jul 2020 19:00:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E582C061794
        for <linux-media@vger.kernel.org>; Tue, 28 Jul 2020 16:00:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so1769616pgf.7
        for <linux-media@vger.kernel.org>; Tue, 28 Jul 2020 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+AGKaODfQyJlnmbVWmu1S2WmuwIYu+1OBfVfzl9nDbI=;
        b=wSiJJlaW4Nf3Z4qC1BYYeErvnyAaxGazqwv+5vS8Ohoi9wIoC5ShcWVwNvmUC4fxN9
         N+kZt5l9fJ7JOsJYXZGVugPArIg8ZmjE2d/llMs/V0sSE0l4mom3QlwPQ/ZbDkGmWydr
         k0T6JKoYyjCvMkeYYmWzZTg2PX4VYFkTPN4AqpVIzU0JEhpCnzUlhqYMV/ANpxjqESNU
         kig9iezcgZMt6WtqUq97RLf/AL6UjD8QAfNNDGs9uAv0yB/jpuoQieNXfjTLY5FFKXND
         VzNrllBYEWkJLjT0Glw4gp2Sd2kye9ezjm3PPrxhoSpHco5rEjFNhcV4IIWn5fNOxpy8
         f0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+AGKaODfQyJlnmbVWmu1S2WmuwIYu+1OBfVfzl9nDbI=;
        b=aX59ggfJg2uFNUfQeZslz7LtPTuFQeSfFE0wwmfVxKJX/ZIEIqcXtWArVbVn/2tbzR
         bItpodelZWLRA2myzQRqNB0UMiuBp4ifuBLaBoE68ieYtaCQR212zbytrOPeeghlcKXc
         MfxSLk3DLlPR+yXiNnPT87l+oUfl3f3+MsFdBe94Mm9aN1r2O/gCmGAvqRd9skXyLX9U
         LllV/cKuAUzW9XBVWeUNtHh+uatRz73G2Bck5vx0mTpFKrHvwWg0kSXFXh96hkkdpTXn
         bngqvoH5eaHM2YcaEFm+EkhkGFekkhG+btOUljvQUcDsjQ+XIKqizZgGzdbnCAQSsrnE
         2DOA==
X-Gm-Message-State: AOAM530sNSa3RtIKI9n4uMLeUBmiq8nzF0bYjigJLSHwexKh2dUqitTn
        kL+Ov45BaQteoKgGTNWGmbFuFA==
X-Google-Smtp-Source: ABdhPJzGVY0Wek05CSIAilbGSc/iC2BNuIxuZVqGpgfu+wb+W8o+Sa5WL16MSEaBgLGfrxfyolhdAA==
X-Received: by 2002:a63:444b:: with SMTP id t11mr27226150pgk.134.1595977219750;
        Tue, 28 Jul 2020 16:00:19 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id 76sm105516pfu.139.2020.07.28.16.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:00:19 -0700 (PDT)
From:   Ankit <b18007@students.iitmandi.ac.in>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, b18007@students.iitmandi.ac.in
Subject: [PATCH v2] Staging : media : atomisp : fixed a brace coding sytle issue
Date:   Wed, 29 Jul 2020 04:29:35 +0530
Message-Id: <20200728225935.28880-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728084341.GA1795795@kroah.com>
References: <20200728084341.GA1795795@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Ankit Baluni <b18007@students.iitmandi.ac.in>

Removed braces for a 'if' condition as it contain only single line & 
there is no need for braces for such case according to coding style
rules.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>

---
Changes in v2:
	-Added more description about the patch.
	-Added space before the symobol '<' in 'From'
	 and 'Signed-off-by' line.

 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 8ea65bef35d2..28b96b66f4f3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -4981,9 +4981,8 @@ enum mipi_port_id __get_mipi_port(struct atomisp_device *isp,
 	case ATOMISP_CAMERA_PORT_SECONDARY:
 		return MIPI_PORT1_ID;
 	case ATOMISP_CAMERA_PORT_TERTIARY:
-		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID) {
+		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID)
 			return MIPI_PORT1_ID + 1;
-		}
 	/* fall through */
 	default:
 		dev_err(isp->dev, "unsupported port: %d\n", port);
-- 
2.25.1

