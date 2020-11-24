Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514FEC2D0E4
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 11:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E149620708
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 11:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yuJB3W4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgKXLHM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732503AbgKXLGg (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 06:06:36 -0500
Received: from mail.kernel.org (ip5f5ad5c3.dynamic.kabel-deutschland.de [95.90.213.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C92C2173E;
        Tue, 24 Nov 2020 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606215991;
        bh=4YnewVN7bNoLlhyR+BQPLCFKx8h9yzavzh1UVPtHLVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuJB3W4RV62J0JVoiSF9DsTJXJicv46yxB3LddU9yDUC99XPj8bkBUNXFDeiARZBn
         ONEq251+GSOBAB+HAiOrpZ82itU3x68osh8Q8BQlCtup9zG2VRKVt0BGrhwR4lDv0Z
         AD+a+ezBHMrYyg4vniL2isxr6W0Nuon/mZrB+YI8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1khW9V-000FaN-77; Tue, 24 Nov 2020 12:06:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 23/31] media: vidtv: cleanup PSI table header function
Date:   Tue, 24 Nov 2020 12:06:19 +0100
Message-Id: <2169ee8f40e97b70fab8efe920db9eda16ae1b73.1606215584.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606215584.git.mchehab+huawei@kernel.org>
References: <cover.1606215584.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

- Pass struct header_write_args as a pointer, instead of
  passing as a var;

- Initialize the psi_args struct only once.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.c | 42 +++++++++-----------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index 754c32353ac2..1bc13b0d5fc6 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -754,26 +754,22 @@ static u32 vidtv_psi_desc_write_into(struct desc_write_args *args)
 }
 
 static u32
-vidtv_psi_table_header_write_into(struct header_write_args args)
+vidtv_psi_table_header_write_into(struct header_write_args *args)
 {
-	struct psi_write_args psi_args = {};
-	/* the number of bytes written by this function */
-	u32 nbytes = 0;
+	struct psi_write_args psi_args = {
+		.dest_buf           = args->dest_buf,
+		.from               = args->h,
+		.len                = sizeof(struct vidtv_psi_table_header),
+		.dest_offset        = args->dest_offset,
+		.pid                = args->pid,
+		.new_psi_section    = true,
+		.continuity_counter = args->continuity_counter,
+		.is_crc             = false,
+		.dest_buf_sz        = args->dest_buf_sz,
+		.crc                = args->crc,
+	};
 
-	psi_args.dest_buf           = args.dest_buf;
-	psi_args.from               = args.h;
-	psi_args.len                = sizeof(struct vidtv_psi_table_header);
-	psi_args.dest_offset        = args.dest_offset;
-	psi_args.pid                = args.pid;
-	psi_args.new_psi_section    = true;
-	psi_args.continuity_counter = args.continuity_counter;
-	psi_args.is_crc             = false;
-	psi_args.dest_buf_sz        = args.dest_buf_sz;
-	psi_args.crc                = args.crc;
-
-	nbytes += vidtv_psi_ts_psi_write_into(&psi_args);
-
-	return nbytes;
+	return vidtv_psi_ts_psi_write_into(&psi_args);
 }
 
 void
@@ -985,7 +981,7 @@ u32 vidtv_psi_pat_write_into(struct vidtv_psi_pat_write_args args)
 	h_args.dest_buf_sz        = args.buf_sz;
 	h_args.crc = &crc;
 
-	nbytes += vidtv_psi_table_header_write_into(h_args);
+	nbytes += vidtv_psi_table_header_write_into(&h_args);
 
 	/* note that the field 'u16 programs' is not really part of the PAT */
 
@@ -1182,7 +1178,7 @@ u32 vidtv_psi_pmt_write_into(struct vidtv_psi_pmt_write_args args)
 	h_args.dest_buf_sz        = args.buf_sz;
 	h_args.crc                = &crc;
 
-	nbytes += vidtv_psi_table_header_write_into(h_args);
+	nbytes += vidtv_psi_table_header_write_into(&h_args);
 
 	/* write the two bitfields */
 	psi_args.dest_buf = args.buf;
@@ -1334,7 +1330,7 @@ u32 vidtv_psi_sdt_write_into(struct vidtv_psi_sdt_write_args args)
 	h_args.dest_buf_sz        = args.buf_sz;
 	h_args.crc                = &crc;
 
-	nbytes += vidtv_psi_table_header_write_into(h_args);
+	nbytes += vidtv_psi_table_header_write_into(&h_args);
 
 	psi_args.dest_buf = args.buf;
 	psi_args.from     = &args.sdt->network_id;
@@ -1670,7 +1666,7 @@ u32 vidtv_psi_nit_write_into(struct vidtv_psi_nit_write_args args)
 	h_args.dest_buf_sz        = args.buf_sz;
 	h_args.crc                = &crc;
 
-	nbytes += vidtv_psi_table_header_write_into(h_args);
+	nbytes += vidtv_psi_table_header_write_into(&h_args);
 
 	/* write the bitfield */
 	psi_args.dest_buf = args.buf;
@@ -1880,7 +1876,7 @@ u32 vidtv_psi_eit_write_into(struct vidtv_psi_eit_write_args args)
 	h_args.dest_buf_sz        = args.buf_sz;
 	h_args.crc                = &crc;
 
-	nbytes += vidtv_psi_table_header_write_into(h_args);
+	nbytes += vidtv_psi_table_header_write_into(&h_args);
 
 	psi_args.dest_buf = args.buf;
 	psi_args.from     = &args.eit->transport_id;
-- 
2.28.0

