Return-Path: <SRS0=xnAv=7D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79B6C433E0
	for <linux-media@archiver.kernel.org>; Thu, 21 May 2020 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9707D206BE
	for <linux-media@archiver.kernel.org>; Thu, 21 May 2020 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMD0EIe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgEUN2w (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 21 May 2020 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbgEUN2u (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 21 May 2020 09:28:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F8BC08C5C2
        for <linux-media@vger.kernel.org>; Thu, 21 May 2020 06:28:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id se13so8780494ejb.9
        for <linux-media@vger.kernel.org>; Thu, 21 May 2020 06:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oemz0y6Halgxd9K+njjbf/y07mF1lR81JfjGGt4j8Io=;
        b=nMD0EIe5pwuwbaGtt+YKylaDfXVeuM3SSMz35IkwGeZ3RzPyukApV97BYrsygvYGrI
         Qeag6fiiSxZD0rcFZ1y3l8o6xADyUNjthcSVHwceGTi17XxVN119y+j7Q5ZJIofycdwB
         vm9tB2ISdX+2kiNihCQhIL+bTIuuUvVPny85PtKbRoXFGMX9jSCt856joZMsoCBw3DAT
         f/l2c8vVYP9Qbr12YDpzKbgIq2WE9hAbFISv3Qyt4sREanHeGsm5ZhsdcNnJ77LfdXnz
         8+3fvpgKHAiZxdXsvwh0sBsWn0h9xpatuoi1o7Ei9BlHkLCvRxZdP7f2L7gHrxLel/fb
         dJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oemz0y6Halgxd9K+njjbf/y07mF1lR81JfjGGt4j8Io=;
        b=D6cjwCNZvoVT6Wn/4ub15pvpjBra30FuKUbp4jPUOX3BsmkIihG3THoSvNabi+vtrN
         gfe2qkdVBCT59o01D3vKsxjQXUHwSlM9jyzAIDqZG5EQ08lhE8gPl+MokAVTl6oVFGUp
         EWt+bbzneVROvYXSYGRzqZh1uvZ+XjHqXB81xS3foCKKPVnRoBX3K6xpWEG4p+sv9Xs5
         YmG+kuy8QvBzxucc/1nJCbKH5JQafnBU6uozXUWe+oEvSL1fOvDCqfS2UvXslbDAbW1q
         jt9VT9TP46j3xcgpz3pyjStn55iVA0QeloG7PXKpZfcFOcG/t3YNY20Kd8y7HzQ3Aaon
         PjJA==
X-Gm-Message-State: AOAM5314aCpWh1wPnSYGyuo7uFda7xXE6ixVMGjudOgaskEgZnhyGGoU
        aBkNyVyf4NWoosXjkPdkp2gryyktr7QYsg==
X-Google-Smtp-Source: ABdhPJzqPpehc4EJbiEYVJOb9tCKG1eBQrdNEZwZIjNyPU0CCPxG3RCXYMfPpZ4UgqkchHuv6iCQKw==
X-Received: by 2002:a17:906:c785:: with SMTP id cw5mr3399668ejb.543.1590067727620;
        Thu, 21 May 2020 06:28:47 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-12.ip.btc-net.bg. [212.5.158.12])
        by smtp.gmail.com with ESMTPSA id lr21sm4980580ejb.117.2020.05.21.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:28:47 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 3/3] venus: Add a debugfs file for SSR trigger
Date:   Thu, 21 May 2020 16:28:16 +0300
Message-Id: <20200521132816.31111-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521132816.31111-1-stanimir.varbanov@linaro.org>
References: <20200521132816.31111-1-stanimir.varbanov@linaro.org>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The SSR (SubSystem Restart) is used to simulate an error on FW
side of Venus. We support following type of triggers - fatal error,
div by zero and watchdog IRQ.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/dbgfs.c | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/dbgfs.c b/drivers/media/platform/qcom/venus/dbgfs.c
index a2465fe8e20b..59d52e5af64a 100644
--- a/drivers/media/platform/qcom/venus/dbgfs.c
+++ b/drivers/media/platform/qcom/venus/dbgfs.c
@@ -9,6 +9,35 @@
 
 extern int venus_fw_debug;
 
+static int trigger_ssr_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t trigger_ssr_write(struct file *filp, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct venus_core *core = filp->private_data;
+	u32 ssr_type;
+	int ret;
+
+	ret = kstrtou32_from_user(buf, count, 4, &ssr_type);
+	if (ret)
+		return ret;
+
+	ret = hfi_core_trigger_ssr(core, ssr_type);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations ssr_fops = {
+	.open = trigger_ssr_open,
+	.write = trigger_ssr_write,
+};
+
 int venus_dbgfs_init(struct venus_core *core)
 {
 	core->root = debugfs_create_dir("venus", NULL);
@@ -17,6 +46,8 @@ int venus_dbgfs_init(struct venus_core *core)
 
 	debugfs_create_x32("fw_level", 0644, core->root, &venus_fw_debug);
 
+	debugfs_create_file("trigger_ssr", 0200, core->root, core, &ssr_fops);
+
 	return 0;
 }
 
-- 
2.17.1

