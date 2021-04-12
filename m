Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E8C43461
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 11:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917436134F
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 11:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhDLLfc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:35:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52586 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbhDLLfb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Apr 2021 07:35:31 -0400
Received: from deskari.lan (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C56BE0A;
        Mon, 12 Apr 2021 13:35:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1618227313;
        bh=nobMiH5gzVho69+4AVRtvcvLVnUU8mzgPep4s5fM9yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtw/lfOt6NcSWGyLXXbxSSqlCjxGeYteujVoDpIsBS9PLK5gJ8lAjk4QVeTjgZG2e
         aay/sNJhkBXuROhdQ/8gpe3KFkUUojrA8L8wxSh6CNnAhnWgz4uwkOGZh/tPXZG9Hq
         XZ6rvfTnMdrM8rLmEbC/yWbB+lsVfWjdbv8TpQY8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Benoit Parrot <bparrot@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-media@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 03/28] media: ti-vpe: cal: remove unused cal_camerarx->dev field
Date:   Mon, 12 Apr 2021 14:34:32 +0300
Message-Id: <20210412113457.328012-4-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412113457.328012-1-tomi.valkeinen@ideasonboard.com>
References: <20210412113457.328012-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

cal_camerarx->dev field is not used, remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/ti-vpe/cal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/cal.h b/drivers/media/platform/ti-vpe/cal.h
index db0e408eaa94..e079c6a9f93f 100644
--- a/drivers/media/platform/ti-vpe/cal.h
+++ b/drivers/media/platform/ti-vpe/cal.h
@@ -149,7 +149,6 @@ struct cal_data {
 struct cal_camerarx {
 	void __iomem		*base;
 	struct resource		*res;
-	struct device		*dev;
 	struct regmap_field	*fields[F_MAX_FIELDS];
 
 	struct cal_dev		*cal;
-- 
2.25.1

