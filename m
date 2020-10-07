Return-Path: <SRS0=q2TO=DO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BFBC47095
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7CD2176B
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 16:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0aJcimBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgJGQDD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:03:03 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32504 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728968AbgJGQDD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 7 Oct 2020 12:03:03 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097FqHOv002178;
        Wed, 7 Oct 2020 18:02:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=snx0Oa29078S9y9lMCQN0QJqA70oMqn0JX8nnG1uIiA=;
 b=0aJcimBLb8uJkvEtylFHqEekUjiwQDJ1mT0kMku3f3qouIbV+PJ7I3PzXNfouKcqAs6V
 cHqS+Jpy+o+/6DEssPI7nQhTngOf7oQH3LNVpZGGqoMXoqNKtoSs5bQGOxVzU2t8O/rf
 4deaof5EGfPSrsY6QBBxfQLB3iWD46iEshkp//gecM9WFrMmFOyxW5fJBkDXaswxgid8
 AtuUFJOn6ucb6rT5WxXVgHSKSrpGxLoxNRXOwGMa2lpROTeXOBQc4Tml5ytSnih+pXEn
 NoISfkQ/UXSHvyxEZDNWb1Mj0m6MFXLzhg5xylxi9nxaYq3XsJoDrcr6yH6zwOgOH7d9 ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3402tjwktd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 18:02:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A6F4100034;
        Wed,  7 Oct 2020 18:02:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3967C2BA2C6;
        Wed,  7 Oct 2020 18:02:52 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct 2020 18:02:24
 +0200
From:   Hugues Fruchet <hugues.fruchet@st.com>
To:     Etienne Carriere <etienne.carriere@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alain Volmat <alain.volmat@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Hugues Fruchet <hugues.fruchet@st.com>
Subject: [PATCH] media: stm32-dcmi: don't print an error on probe deferral
Date:   Wed, 7 Oct 2020 18:02:10 +0200
Message-ID: <1602086530-24646-1-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-06,2020-10-07 signatures=0
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

Change stm32-dcmi driver to not print an error message when the
device probe operation is deferred.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Acked-by: Hugues Fruchet <hugues.fruchet@st.com>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index fd1c41c..720534e 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1851,7 +1851,9 @@ static int dcmi_probe(struct platform_device *pdev)
 
 	dcmi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(dcmi->rstc)) {
-		dev_err(&pdev->dev, "Could not get reset control\n");
+		if (PTR_ERR(dcmi->rstc) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get reset control\n");
+
 		return PTR_ERR(dcmi->rstc);
 	}
 
-- 
2.7.4

