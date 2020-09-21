Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8C7C43463
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 11:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D8F20EDD
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600688648;
	bh=VaE4tWXufOp7oxEs2ZEserdffhxIbjWsWcM033VCLe0=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=jTb/GFxEn2i59C3IjPSd9O0rlBbA4idft2MgajxfOUDk3iooE+h5x1OV63jKV2FoT
	 2nkPpS+WQtmXsNjt1KH9nI2OmIC+nevDskuiSYkXY6UqL4BsucpjDEMCHmsYehhZZw
	 APdaVkH/uKUdHeFMFhbqYc8IHF0EGJL5Uxj4m+XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIULoB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 07:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgIULnw (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 07:43:52 -0400
Received: from mail.kernel.org (ip5f5ad5b1.dynamic.kabel-deutschland.de [95.90.213.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38EDA20EDD;
        Mon, 21 Sep 2020 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600688631;
        bh=VaE4tWXufOp7oxEs2ZEserdffhxIbjWsWcM033VCLe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gq2r1qm7fNdV/La/t+adrJ1EgJ8BG43remzDFbnz2Zuy7k0wp7FaRsnpQB2D+TDe3
         30hQca1/KAy355zkJtxuMARC4DfW3um1LvYS5QFHxBk4arL0hRhXr2s4ho7ARhBXEu
         5gopHtXk7NiiTBwfdThnIH2BcowaJRkV4rfbyn9s=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kKKEW-0004VA-2N; Mon, 21 Sep 2020 13:43:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 3/9] media: vidtv: fix initialization of the network_id field at SDT
Date:   Mon, 21 Sep 2020 13:43:40 +0200
Message-Id: <81d9bf38ccf2a5ad014772261b2169aedce22280.1600688419.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600688419.git.mchehab+huawei@kernel.org>
References: <cover.1600688419.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This field should point to the network ID, and has different
ranges for cable, terrestrial or satellite. It also has
an special range for temporary private usage.

For now, let's use the temporary private one. Once the
Network Information Table (NIT) gets added, this should be
reviewed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index 8cdf645b4fdd..5fe3fbb765b8 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -1107,7 +1107,14 @@ struct vidtv_psi_table_sdt *vidtv_psi_sdt_table_init(u16 transport_stream_id)
 	sdt->header.section_id   = 0;
 	sdt->header.last_section = 0;
 
-	sdt->network_id = cpu_to_be16(transport_stream_id);
+	/*
+	 * FIXME: The network_id range from 0xFF01 to 0xFFFF is used to
+	 * indicate temporary private use. For now, let's use the first
+	 * value.
+	 * This can be changed to something more useful, when support for
+	 * NIT gets added
+	 */
+	sdt->network_id = cpu_to_be16(0xff01);
 	sdt->reserved = RESERVED;
 
 	vidtv_psi_sdt_table_update_sec_len(sdt);
-- 
2.26.2

