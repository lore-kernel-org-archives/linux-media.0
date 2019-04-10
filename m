Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A406C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6320818
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 12:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfDJMmu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:42:50 -0400
Received: from kozue.soulik.info ([108.61.200.231]:43948 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbfDJMmt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 08:42:49 -0400
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:401])
        by kozue.soulik.info (Postfix) with ESMTPA id 4E2481014EA;
        Wed, 10 Apr 2019 21:43:36 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     Randy Li <randy.li@rock-chips.com>, hverkuil@xs4all.nl,
        maxime.ripard@bootlin.com, joro@8bytes.org, nicolas@ndufresne.ca,
        jernej.skrabec@gmail.com, paul.kocialkowski@bootlin.com,
        thomas.petazzoni@bootlin.com, mchehab@kernel.org,
        ezequiel@collabora.com, posciak@chromium.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 2/9] rockchip: mpp: rkvdec: rbsp
Date:   Wed, 10 Apr 2019 20:42:19 +0800
Message-Id: <20190410124226.8612-3-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410124226.8612-1-ayaka@soulik.info>
References: <20190410124226.8612-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Randy Li <randy.li@rock-chips.com>

It is a bit writer.

Signed-off-by: Randy Li <randy.li@rock-chips.com>
---
 drivers/staging/rockchip-mpp/rkvdec/rbsp.c | 96 ++++++++++++++++++++++
 drivers/staging/rockchip-mpp/rkvdec/rbsp.h | 30 +++++++
 2 files changed, 126 insertions(+)
 create mode 100644 drivers/staging/rockchip-mpp/rkvdec/rbsp.c
 create mode 100644 drivers/staging/rockchip-mpp/rkvdec/rbsp.h

diff --git a/drivers/staging/rockchip-mpp/rkvdec/rbsp.c b/drivers/staging/rockchip-mpp/rkvdec/rbsp.c
new file mode 100644
index 000000000000..3fbc50e9bca1
--- /dev/null
+++ b/drivers/staging/rockchip-mpp/rkvdec/rbsp.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012 Vista Silicon S.L.
+ * Copyright (C) 2019 Randy Li <ayaka@soulik.info>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <asm-generic/errno-base.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "rbsp.h"
+
+int rbsp_init(struct rbsp *rbsp, void *buf, int size, int bit_pos)
+{
+	if (!buf)
+		return -EINVAL;
+	if (DIV_ROUND_UP(bit_pos, 32) >= size)
+		return -EINVAL;
+
+	rbsp->buf = buf;
+	rbsp->size = size >> 2;
+	rbsp->pos = bit_pos;
+
+	return 0;
+}
+
+static inline int rbsp_read_bit(struct rbsp *rbsp)
+{
+	int shift = rbsp->pos % 32;
+	int ofs = rbsp->pos++ / 32;
+
+	if (ofs >= rbsp->size)
+		return -EINVAL;
+
+	return (rbsp->buf[ofs] >> shift) & 1;
+}
+
+static inline int rbsp_write_bit(struct rbsp *rbsp, int bit)
+{
+	int shift = rbsp->pos % 32;
+	int ofs = rbsp->pos++ / 32;
+
+	if (ofs >= rbsp->size)
+		return -EINVAL;
+
+	rbsp->buf[ofs] &= ~(1 << shift);
+	rbsp->buf[ofs] |= bit << shift;
+
+	return 0;
+}
+
+int rbsp_write_bits(struct rbsp *rbsp, int num, int value)
+{
+	int shift = rbsp->pos % 32;
+	int ofs = rbsp->pos / 32;
+
+	if (ofs >= rbsp->size)
+		return -EINVAL;
+
+	if (num + shift >= 32) {
+		u32 lbits = 32 - shift;
+		u32 hbits = num + shift - 32;
+
+		rbsp->buf[ofs] &= ~(((1 << lbits) - 1) << shift);
+		rbsp->buf[ofs] |= value << shift;
+
+		value >>= (32 - shift);
+		rbsp->buf[ofs + 1] &= ~(((1 << hbits) - 1));
+		rbsp->buf[ofs + 1] |= value;
+	} else {
+		rbsp->buf[ofs] &= ~(((1 << num) - 1) << shift);
+		rbsp->buf[ofs] |= value << shift;
+	}
+
+	rbsp->pos += num;
+
+	return 0;
+}
+
+int rbsp_write_flag(struct rbsp *rbsp, int value)
+{
+	if (value)
+		return rbsp_write_bit(rbsp, BIT(0));
+	else
+		return rbsp_write_bit(rbsp, 0);
+}
diff --git a/drivers/staging/rockchip-mpp/rkvdec/rbsp.h b/drivers/staging/rockchip-mpp/rkvdec/rbsp.h
new file mode 100644
index 000000000000..d87c582bfd41
--- /dev/null
+++ b/drivers/staging/rockchip-mpp/rkvdec/rbsp.h
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012 Vista Silicon S.L.
+ * Copyright (C) 2019 Randy Li <ayaka@soulik.info>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _RBSP_H_
+#define _RBSP_H_
+
+struct rbsp {
+	u32 *buf;
+	int size;
+	int pos;
+};
+
+int rbsp_init(struct rbsp *rbsp, void *buf, int size, int bit_pos);
+int rbsp_write_flag(struct rbsp *rbsp, int bit);
+int rbsp_write_bits(struct rbsp *rbsp, int num, int value);
+
+#endif
-- 
2.20.1

