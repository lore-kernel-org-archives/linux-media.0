Return-Path: <SRS0=tKnt=Y3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A1ECA9EB0
	for <linux-media@archiver.kernel.org>; Sun,  3 Nov 2019 11:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2533C2080F
	for <linux-media@archiver.kernel.org>; Sun,  3 Nov 2019 11:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfKCLYu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 3 Nov 2019 06:24:50 -0500
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:43603 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727554AbfKCLYt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 3 Nov 2019 06:24:49 -0500
Received: from tschai.fritz.box ([46.9.232.237])
        by smtp-cloud8.xs4all.net with ESMTPA
        id RDzviydbGTzKrRDzzigkLE; Sun, 03 Nov 2019 12:24:47 +0100
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 8/8] mantis: fix two smatch errors
Date:   Sun,  3 Nov 2019 12:23:38 +0100
Message-Id: <20191103112338.22569-9-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103112338.22569-1-hverkuil-cisco@xs4all.nl>
References: <20191103112338.22569-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNNAn3hofzIq14hM2fVcja2yCx3Ix9gAlypF/SDzL7S+scT4oo/G226iEDwO2OgHb1x6yIF1Ox8NT6od6rUkbAc7G/5Ql0B8pO3Z1Io5u88Cs7usu2zZ
 DNZwglDg295YaoMnzl+C4DMXRom4AJb7LTjyw+WQl/F0KDRD4WBW3+9vQkxneaotqEH2qNvwlylKIEL7/q3Od3icsHfSVbLxOCErTT79X/aA9DmbRhiQ10ee
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Drop two dprintk's that relied on a non-NULL mantis pointer
when it was in fact a NULL pointer.

Fixes:

drivers/media/pci/mantis/mantis_cards.c:73 mantis_irq_handler() error: we previously assumed 'mantis' could be null (see line 72)
drivers/media/pci/mantis/hopper_cards.c:64 hopper_irq_handler() error: we previously assumed 'mantis' could be null (see line 63)

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/pci/mantis/hopper_cards.c | 4 +---
 drivers/media/pci/mantis/mantis_cards.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/mantis/hopper_cards.c b/drivers/media/pci/mantis/hopper_cards.c
index 67aebe759232..c0bd5d7e148b 100644
--- a/drivers/media/pci/mantis/hopper_cards.c
+++ b/drivers/media/pci/mantis/hopper_cards.c
@@ -60,10 +60,8 @@ static irqreturn_t hopper_irq_handler(int irq, void *dev_id)
 	struct mantis_ca *ca;
 
 	mantis = (struct mantis_pci *) dev_id;
-	if (unlikely(!mantis)) {
-		dprintk(MANTIS_ERROR, 1, "Mantis == NULL");
+	if (unlikely(!mantis))
 		return IRQ_NONE;
-	}
 	ca = mantis->mantis_ca;
 
 	stat = mmread(MANTIS_INT_STAT);
diff --git a/drivers/media/pci/mantis/mantis_cards.c b/drivers/media/pci/mantis/mantis_cards.c
index deadd0b92233..906e4500d87d 100644
--- a/drivers/media/pci/mantis/mantis_cards.c
+++ b/drivers/media/pci/mantis/mantis_cards.c
@@ -69,10 +69,8 @@ static irqreturn_t mantis_irq_handler(int irq, void *dev_id)
 	struct mantis_ca *ca;
 
 	mantis = (struct mantis_pci *) dev_id;
-	if (unlikely(mantis == NULL)) {
-		dprintk(MANTIS_ERROR, 1, "Mantis == NULL");
+	if (unlikely(!mantis))
 		return IRQ_NONE;
-	}
 	ca = mantis->mantis_ca;
 
 	stat = mmread(MANTIS_INT_STAT);
-- 
2.23.0

