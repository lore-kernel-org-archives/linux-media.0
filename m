Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E681C43464
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 11:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E433F2145D
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600688666;
	bh=EAore+QxDEBUejI54DaVjV5SP07aG8rc/ZXRwv8IbO4=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=hhuuRw929xUXj9L6aVpLtlOOpFcwVJlsledCFQ+bU4ebkZNcwmnCo/rx3kwcnDr50
	 iN66jYXIj3okidsGwB/OtDBCR3PdxCEczpYFJkG7CS3Rcw6GnxYqltgedtQuxGLo1s
	 hAZJDd6QUQho6CwaBKHD1YRfjTY8dr7Dt0QgP/5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIULoW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 07:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgIULnv (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 07:43:51 -0400
Received: from mail.kernel.org (ip5f5ad5b1.dynamic.kabel-deutschland.de [95.90.213.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5583A218AC;
        Mon, 21 Sep 2020 11:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600688630;
        bh=EAore+QxDEBUejI54DaVjV5SP07aG8rc/ZXRwv8IbO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErYWPhgUs+LYmm7DBK8t8EplNgHC+tMub/GMltDWPk19gCxkADeMuolw+Y3PK3V6a
         N8P7lgCW6HM7wqj9ekYQWGAEAz/fQZK9WJnJ9CHOVrZmWudQCwSQ3mi3+JUjts6UVH
         VgGeedup47jAtJaVejbv39qT7kX+5PCeHiAqMWl4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kKKEW-0004VI-5m; Mon, 21 Sep 2020 13:43:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 6/9] media: vidtv: fix a typo
Date:   Mon, 21 Sep 2020 13:43:43 +0200
Message-Id: <737c73358c489d9bac52101ad3fdfda47b446ce8.1600688419.git.mchehab+huawei@kernel.org>
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

optinal -> optional

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/test-drivers/vidtv/vidtv_pes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_pes.h b/drivers/media/test-drivers/vidtv/vidtv_pes.h
index 36443a6e30d3..84628780d8c6 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_pes.h
+++ b/drivers/media/test-drivers/vidtv/vidtv_pes.h
@@ -44,7 +44,7 @@ struct vidtv_pes_optional_pts_dts {
 struct vidtv_pes_optional {
 	/*
 	 * These flags show which components are actually
-	 * present in the "optinal fields" in the optinal PES
+	 * present in the "optional fields" in the optional PES
 	 * header and which are not
 	 *
 	 * u16 two:2;  //0x2
-- 
2.26.2

