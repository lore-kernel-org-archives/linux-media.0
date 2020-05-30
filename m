Return-Path: <SRS0=xPKt=7M=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08B6C433E0
	for <linux-media@archiver.kernel.org>; Sat, 30 May 2020 06:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA069207D0
	for <linux-media@archiver.kernel.org>; Sat, 30 May 2020 06:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821922;
	bh=Yzed5rl4o/D6irqsjNtXkVmfnaEzIK5vu99aBE8y0Iw=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=OHSvwKWyfGADzPkEx2z7rLd3Uic186biZHhLPEcKk+1SsjMvlx9CwhGfDfWHQ32ZN
	 sKNAvUcTabgI6mMZ81pJxzBzpKi4BMYvabfBaP6PSG965+5RxL9MCt8P33PHD8S85i
	 uCCbDUtGP2lZbbwpR7bS9uok7A5AUpOTF882Je5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgE3G6k (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 May 2020 02:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgE3G4G (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 May 2020 02:56:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99E14217A0;
        Sat, 30 May 2020 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821763;
        bh=Yzed5rl4o/D6irqsjNtXkVmfnaEzIK5vu99aBE8y0Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AHPmroCKHerW3ZPLKzUT9vOUTB0ghBBHKR7Xx0M9xNC9msNyeQATNbx/S6X51zS9v
         xtoSry+ZKqJXEKmFvhj+8McGXUUA3iTf4sJ9pFNhKXlZYuADJWuHLWYxifsLEGzLgV
         Y7DL+pGJpn7NI19itNKi67M7ReyDEIfWnERHO3qA=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPV-001hpt-GN; Sat, 30 May 2020 08:56:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 23/41] media: atomisp: Remove unnecessary NULL checks in ia_css_pipe_load_extension
Date:   Sat, 30 May 2020 08:55:40 +0200
Message-Id: <9a2bd92d43dc2571c90acffaa1a520af71aef287.1590821410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590821410.git.mchehab+huawei@kernel.org>
References: <cover.1590821410.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

Clang warns:

../drivers/staging/media/atomisp/pci/sh_css.c:8537:14: warning: address
of 'pipe->output_stage' will always evaluate to 'true'
[-Wpointer-bool-conversion]
                if (&pipe->output_stage)
                ~~   ~~~~~~^~~~~~~~~~~~
../drivers/staging/media/atomisp/pci/sh_css.c:8545:14: warning: address
of 'pipe->vf_stage' will always evaluate to 'true'
[-Wpointer-bool-conversion]
                if (&pipe->vf_stage)
                ~~   ~~~~~~^~~~~~~~

output_stage and vf_stage are pointers in the middle of a struct, their
addresses cannot be NULL if pipe is not NULL and pipe is already checked
for NULL in this function. Simplify this if block.

Link: https://github.com/ClangBuiltLinux/linux/issues/1036

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 6e18841db58a..4269c16ad4f1 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -8491,22 +8491,9 @@ ia_css_pipe_load_extension(struct ia_css_pipe *pipe,
 	}
 
 	if (firmware->info.isp.type == IA_CSS_ACC_OUTPUT)
-	{
-		if (&pipe->output_stage)
-			append_firmware(&pipe->output_stage, firmware);
-		else {
-			IA_CSS_LEAVE_ERR_PRIVATE(IA_CSS_ERR_INTERNAL_ERROR);
-			return IA_CSS_ERR_INTERNAL_ERROR;
-		}
-	} else if (firmware->info.isp.type == IA_CSS_ACC_VIEWFINDER)
-	{
-		if (&pipe->vf_stage)
-			append_firmware(&pipe->vf_stage, firmware);
-		else {
-			IA_CSS_LEAVE_ERR_PRIVATE(IA_CSS_ERR_INTERNAL_ERROR);
-			return IA_CSS_ERR_INTERNAL_ERROR;
-		}
-	}
+		append_firmware(&pipe->output_stage, firmware);
+	else if (firmware->info.isp.type == IA_CSS_ACC_VIEWFINDER)
+		append_firmware(&pipe->vf_stage, firmware);
 	err = acc_load_extension(firmware);
 
 	IA_CSS_LEAVE_ERR_PRIVATE(err);
-- 
2.26.2

