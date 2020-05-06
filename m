Return-Path: <SRS0=xY1j=6U=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971ABC28CBC
	for <linux-media@archiver.kernel.org>; Wed,  6 May 2020 10:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F15320663
	for <linux-media@archiver.kernel.org>; Wed,  6 May 2020 10:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgEFKmY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 May 2020 06:42:24 -0400
Received: from gofer.mess.org ([88.97.38.141]:54013 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgEFKmX (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 6 May 2020 06:42:23 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id A1BD0C63F1; Wed,  6 May 2020 11:42:22 +0100 (BST)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Subject: [PATCH 2/2] media: gpio-ir-tx: allow transmission without carrier
Date:   Wed,  6 May 2020 11:42:22 +0100
Message-Id: <20200506104222.16188-2-sean@mess.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506104222.16188-1-sean@mess.org>
References: <20200506104222.16188-1-sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Some IR protocols do not use a carrier.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/gpio-ir-tx.c | 56 +++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/gpio-ir-tx.c b/drivers/media/rc/gpio-ir-tx.c
index 66703989ae185..cd3f284b2f6d6 100644
--- a/drivers/media/rc/gpio-ir-tx.c
+++ b/drivers/media/rc/gpio-ir-tx.c
@@ -42,18 +42,51 @@ static int gpio_ir_tx_set_carrier(struct rc_dev *dev, u32 carrier)
 {
 	struct gpio_ir *gpio_ir = dev->priv;
 
-	if (!carrier)
-		return -EINVAL;
-
 	gpio_ir->carrier = carrier;
 
 	return 0;
 }
 
-static int gpio_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
-		      unsigned int count)
+static void gpio_ir_tx_unmodulated(struct gpio_ir *gpio_ir, uint *txbuf,
+				   uint count)
+{
+	unsigned long flags;
+	ktime_t edge;
+	/*
+	 * delta should never exceed 0.5 seconds (IR_MAX_DURATION) and on
+	 * m68k ndelay(s64) does not compile; so use s32 rather than s64.
+	 */
+	s32 delta;
+	int i;
+
+	spin_lock_irqsave(&gpio_ir->lock, flags);
+
+	edge = ktime_get();
+
+	for (i = 0; i < count; i++) {
+		if (i % 2) {
+			// space
+			edge = ktime_add_us(edge, txbuf[i]);
+			delta = ktime_us_delta(edge, ktime_get());
+			if (delta > 0)
+				udelay(delta);
+		} else {
+			// pulse
+			gpiod_set_value(gpio_ir->gpio, 1);
+			edge = ktime_add_us(edge, txbuf[i]);
+			delta = ktime_us_delta(edge, ktime_get());
+			if (delta > 0)
+				udelay(delta);
+			gpiod_set_value(gpio_ir->gpio, 0);
+		}
+	}
+
+	spin_unlock_irqrestore(&gpio_ir->lock, flags);
+}
+
+static void gpio_ir_tx_modulated(struct gpio_ir *gpio_ir, uint *txbuf,
+				 uint count)
 {
-	struct gpio_ir *gpio_ir = dev->priv;
 	unsigned long flags;
 	ktime_t edge;
 	/*
@@ -105,6 +138,17 @@ static int gpio_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 	}
 
 	spin_unlock_irqrestore(&gpio_ir->lock, flags);
+}
+
+static int gpio_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
+		      unsigned int count)
+{
+	struct gpio_ir *gpio_ir = dev->priv;
+
+	if (gpio_ir->carrier)
+		gpio_ir_tx_modulated(gpio_ir, txbuf, count);
+	else
+		gpio_ir_tx_unmodulated(gpio_ir, txbuf, count);
 
 	return count;
 }
-- 
2.26.2

