Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C12AC4727D
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 21:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC27C23A61
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 21:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFH4glgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgIUVzS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 17:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgIUVzS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 17:55:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4610C061755;
        Mon, 21 Sep 2020 14:55:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so14557127wrs.5;
        Mon, 21 Sep 2020 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=msyTyBuqg+S9lSfyJBnZ2ellRZt6dmdc0yChx+UPxKo=;
        b=HFH4glgr8zU1oXfraHmc2FYWvCMnmC+sxpTG200tp8l4hHLtC2gqfDvnKD0jX5zr2A
         U5PhRmCeevGoZN4iO/TYhjFAeVRVZuRkZV1ZzuWxTULU9tmZiWKYwonAESXP4h8Q2Qnl
         zSv+jP4GyUUOh5sVzYtwl310G0yLz95w1/stZ0caQqlsdpwhdOrFYK2FnIyKgjsozSg9
         ydKfCEzapSddN3N1jjAv3t+5HuJww9ZdL6qHb7NwUSc2y7jGzORTBRWQZMxPnt+Gk7WK
         L3ToJvGi3Jf2Bt0UrBVMuEcv+M0SlE85eYBk0AcyppjmfhH31CfTvNiLCvi77k8ClwCT
         F6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msyTyBuqg+S9lSfyJBnZ2ellRZt6dmdc0yChx+UPxKo=;
        b=sykyjqugr1bLr3QaM2J2+MPHtWKPkuYH/O5F3CFvx6fsremOsBZOMP7VtU+xFGWfh7
         3o6KIa7Nvn1esKS2lvbR34qzVezmCpWpwELYVKQkJ9acWRBwxMAnKPSPfHxhzSw8dnZQ
         Rur8NwNyMXVrrwX4U4G2ORdtxk7MXCLkhGQgNRyGQJqWSb5p2MddXFTgm7zRcv7MuwYA
         nv84Ur1xW0MLsFP6KeSjLdjwdXLravAFxTkiPM9U83AGtSrHqqqnyKdTQNKQeWsP26nM
         hqaLEtNfJTaAIC5re5F9vzXgxjRHeuUNc2QdneO4mAryvjWyNisw49gjKqPH4GlLMsd9
         ibrQ==
X-Gm-Message-State: AOAM533Va8De6QN4OWRZ6ksUCI8avm1tQhyBd5KXo0ZqRDxr52Iw3Hch
        hAtCirLorcnMMe1TZiKiiXQ=
X-Google-Smtp-Source: ABdhPJzEYvjLv/YYaExP7WY18BaVye8dfGy+D2i4BAk8NEq+a3xw5G6BgT2nLo5IEKUwO4Sea96uEw==
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr1786175wrn.113.1600725316622;
        Mon, 21 Sep 2020 14:55:16 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id t124sm1282200wmg.31.2020.09.21.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:55:16 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alan Cox <alan@linux.intel.com>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 3/5] staging: media: atomisp: Don't do unnecessary zeroing of memory
Date:   Mon, 21 Sep 2020 22:53:55 +0100
Message-Id: <20200921215359.45003-4-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921215359.45003-1-alex.dewar90@gmail.com>
References: <20200921215359.45003-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

In a few places in pci/sh_css_params.c, memset is used to zero memory
immediately before it is freed. As none of these structs appear to
contain sensitive information, just remove the calls to memset.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_params.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/staging/media/atomisp/pci/sh_css_params.c
index 2c67c23b3700..24fc497bd491 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_params.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
@@ -4378,7 +4378,6 @@ ia_css_3a_statistics_free(struct ia_css_3a_statistics *me)
 	if (me) {
 		kvfree(me->rgby_data);
 		kvfree(me->data);
-		memset(me, 0, sizeof(struct ia_css_3a_statistics));
 		kvfree(me);
 	}
 }
@@ -4417,7 +4416,6 @@ ia_css_dvs_statistics_free(struct ia_css_dvs_statistics *me)
 	if (me) {
 		kvfree(me->hor_proj);
 		kvfree(me->ver_proj);
-		memset(me, 0, sizeof(struct ia_css_dvs_statistics));
 		kvfree(me);
 	}
 }
@@ -4459,7 +4457,6 @@ ia_css_dvs_coefficients_free(struct ia_css_dvs_coefficients *me)
 	if (me) {
 		kvfree(me->hor_coefs);
 		kvfree(me->ver_coefs);
-		memset(me, 0, sizeof(struct ia_css_dvs_coefficients));
 		kvfree(me);
 	}
 }
@@ -4551,7 +4548,6 @@ ia_css_dvs2_statistics_free(struct ia_css_dvs2_statistics *me)
 		kvfree(me->ver_prod.odd_imag);
 		kvfree(me->ver_prod.even_real);
 		kvfree(me->ver_prod.even_imag);
-		memset(me, 0, sizeof(struct ia_css_dvs2_statistics));
 		kvfree(me);
 	}
 }
@@ -4635,7 +4631,6 @@ ia_css_dvs2_coefficients_free(struct ia_css_dvs2_coefficients *me)
 		kvfree(me->ver_coefs.odd_imag);
 		kvfree(me->ver_coefs.even_real);
 		kvfree(me->ver_coefs.even_imag);
-		memset(me, 0, sizeof(struct ia_css_dvs2_coefficients));
 		kvfree(me);
 	}
 }
@@ -4710,7 +4705,6 @@ ia_css_dvs2_6axis_config_free(struct ia_css_dvs_6axis_config *dvs_6axis_config)
 		kvfree(dvs_6axis_config->ycoords_y);
 		kvfree(dvs_6axis_config->xcoords_uv);
 		kvfree(dvs_6axis_config->ycoords_uv);
-		memset(dvs_6axis_config, 0, sizeof(struct ia_css_dvs_6axis_config));
 		kvfree(dvs_6axis_config);
 	}
 }
-- 
2.28.0

