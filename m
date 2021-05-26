Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1158AC2B9F7
	for <linux-media@archiver.kernel.org>; Wed, 26 May 2021 07:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD37C613D3
	for <linux-media@archiver.kernel.org>; Wed, 26 May 2021 07:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhEZH7a (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 May 2021 03:59:30 -0400
Received: from m12-13.163.com ([220.181.12.13]:52035 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231185AbhEZH73 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 May 2021 03:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uaw5g
        +wV9uOebNcejYAGl//FWT4yk1Vj1JQfPQ9inVw=; b=opUBz1K1dossLbnnzHMEg
        eDzSLFyY4tcHUPCeg0ch8E+l9ObGTxb/p/HhoZ8Hz+mOirl2P3zZgY1+VZS/SANy
        iSiJHDMA/ehZ2p9vWNjqXt688/EAsoKSsYP2WRgojFTvtZreeDifyhtPTw1l6Dbf
        2ZNpsUZr2Pk4Q3bxnbLZRw=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowABnPeqC_61g0BMSCw--.3944S2;
        Wed, 26 May 2021 15:57:55 +0800 (CST)
From:   13145886936@163.com
To:     gushengxian@yulong.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: the definition should be standardized
Date:   Wed, 26 May 2021 00:57:45 -0700
Message-Id: <20210526075745.302959-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABnPeqC_61g0BMSCw--.3944S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1ktF4rZFy7Ww4xur13twb_yoW3XrbEyF
        Z7t3W0gayrX39Yvr1rGrZxXr95ta4rur17Z3WkXryYqa98Zr45AanxXr43Jry2q3yIkFZ7
        WFWDKr1UGw40kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeylkDUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBRxueg1PAC2Nb5wAAsG
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

'struct pcb_struct * pcb_va' should be 'struct pcb_struct *pcb_va'.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 arch/alpha/boot/bootp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/boot/bootp.c b/arch/alpha/boot/bootp.c
index 00266e6e1b71..b4faba2432d5 100644
--- a/arch/alpha/boot/bootp.c
+++ b/arch/alpha/boot/bootp.c
@@ -23,7 +23,7 @@
 #include "ksize.h"
 
 extern unsigned long switch_to_osf_pal(unsigned long nr,
-	struct pcb_struct * pcb_va, struct pcb_struct * pcb_pa,
+	struct pcb_struct *pcb_va, struct pcb_struct *pcb_pa,
 	unsigned long *vptb);
 
 extern void move_stack(unsigned long new_stack);
-- 
2.25.1


