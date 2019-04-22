Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62400C10F11
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 19:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2819A21738
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 19:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIfVVvqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfDVTKg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:10:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39920 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfDVTKg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 15:10:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id d12so9760606lfk.6
        for <linux-media@vger.kernel.org>; Mon, 22 Apr 2019 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qs2o98ss5o6XrY64SaJ7MettNwzG/Ooy3LAq+IrzKKQ=;
        b=pIfVVvqRSrAEMtQgLTEN6ieaPwW7mDYg5xFD2frOrHc8ymTzx/McxQa7Awvu8gvFRx
         ckHnIpXISXQ/grR0w3HAjuFSTabJ2OteXNJnZnxbx+CztT3FTWZUCDknkeWYf0wunxoY
         lxp5iPyckLGmEz63sV9QPvJhuU2WEhXvbodxfLJY5RSBsSubbH5Ei+x0/+LQPF32TNY8
         q4NF2HvO8KbUCsH4Hpw5mibk/xXozh9EjNaFfay6GvL6MLUbcmcKfVjjq+D4k3uWgo8M
         LlUyDMiJZFEPcP2cWpEt7pVLH8piBJ/hXpjhSZjXdmGzZVp6hWp2XfSa4h+2SmGealBZ
         fXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qs2o98ss5o6XrY64SaJ7MettNwzG/Ooy3LAq+IrzKKQ=;
        b=kqS6e2Td8IsFG6TndxSoB5uScOL4MNLHfD33e9TSrtZu4Ox/857nIdsovJpD/on3sy
         iNsujAkMNjYN4g8WpLiZIWI7PZ7D2bNawmPS9N8GIrmxP3C6Fi3mfpuIWO7EwpxEE7Og
         6TiDCqsQp45YHqsd6tLhYZbIwaTx7bD/Fs5CRhZU6XFK4UloA8dyZhYsLEEsq1+FYTI0
         /H3GXml8lns8nENKcFkePxKHsUXf9+xykhdT/blas7uclM3tF2HQY+2Y0inWWPBFLL+V
         Jtp8Ag7wDhSv45EBb6U3FZW6AGqQ1kfIj1WYcyGE9dMSqF4y2vBNpsMzSku6G5aH9Cxw
         zQ2Q==
X-Gm-Message-State: APjAAAXNdI8H/ZxT3HwqXkmXypTbtTM6vwqNAu3Fiv3tbF96bCsJyLrf
        1mnVWUY+UuXatMmYWzE0oQ0=
X-Google-Smtp-Source: APXvYqw+rg8zkU24847xx6TQZ/FhL0gb3wYmjT7fwzgzK2gV+QNkV6gglhTalzWXIBeGZWOICl9vfg==
X-Received: by 2002:a19:c301:: with SMTP id t1mr10873304lff.167.1555960234313;
        Mon, 22 Apr 2019 12:10:34 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id n9sm3137813lfl.35.2019.04.22.12.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 12:10:33 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, dagmcr@gmail.com, javier@dowhile0.org
Subject: [PATCH] spi: IR LED: add missing of table registration
Date:   Mon, 22 Apr 2019 21:10:20 +0200
Message-Id: <1555960220-8720-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo drivers/media/rc/ir-spi.ko  | grep alias

After this patch:
modinfo drivers/media/rc/ir-spi.ko  | grep alias
alias:          of:N*T*Cir-spi-ledC*
alias:          of:N*T*Cir-spi-led

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/media/rc/ir-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index 66334e8..c58f2d3 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -161,6 +161,7 @@ static const struct of_device_id ir_spi_of_match[] = {
 	{ .compatible = "ir-spi-led" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ir_spi_of_match);
 
 static struct spi_driver ir_spi_driver = {
 	.probe = ir_spi_probe,
-- 
2.7.4

