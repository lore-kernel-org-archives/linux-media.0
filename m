Return-Path: <SRS0=pJLX=BG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177ACC433E0
	for <linux-media@archiver.kernel.org>; Mon, 27 Jul 2020 21:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E719E20809
	for <linux-media@archiver.kernel.org>; Mon, 27 Jul 2020 21:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="UgJXL5Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgG0Vbe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0Vbd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 27 Jul 2020 17:31:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91456C0619D2
        for <linux-media@vger.kernel.org>; Mon, 27 Jul 2020 14:31:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so8840397pld.12
        for <linux-media@vger.kernel.org>; Mon, 27 Jul 2020 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0aKrJE9Py1tsJLs5WZM0aY5vQOQN0nZ3c2moryg/s6o=;
        b=UgJXL5ZgUVlcqiIEkxepKVs7siRXuEAQdZK3nO34UmuoDyh33PscEtdV8jnjyxR5Xl
         rbtTymcJriw6nqg1prpC573d9FF3ZgqYtUML7+vytvQ2vbsBD6KKzJNt+MIddP/38g7c
         m6GaRX0usUd2RjdnUjH+OP10x3SoqJvLpdmoluaPGcOI1SMSoUC18RXmTW/LzUHh+y6l
         Kmq9UrcC/rMnQJ1QAfVz3HMHBMO5/+uECyH1epHXCniYlhX7XxcbyCpzAovIbHYjnm6u
         FfowA/MIEYqK+4ec1SIFicgzRktBaB5Og+4OYlJ6Wp+mwCFUqMLRuKG9pAVBwqno84Si
         xbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aKrJE9Py1tsJLs5WZM0aY5vQOQN0nZ3c2moryg/s6o=;
        b=s4HKG7oTDgUpDeoQTwGg8Srm6y7ppTIfQ+eqlEIwUeuVrU7NQL2oD5095eIw69g4CH
         qUAOf4w/jhNQWP+2B3G8w9wI4gBrbkL6aigEB/qVb/nBPruWYQ5NjuG9Ol56BpzB+uzZ
         3dT1nw7MATN+T+WjAdjmOU43B8qKbVuALddSRxRu1YrOxLbLP8IHLkEU24RYSf5TCgDV
         FBo510JMtjYTIy4I1KT9trWA8RK2WSUKljk6e2dlYDXrQEzuGHed8OZz9dXyH7mWp8Wk
         YzLQ4kcU7GrDk/xt+teAbHH5/nQ30vRcmtpX2Zqt+7Fzh6Kj8KXuh+woOyQJjqb30i1R
         Cn7g==
X-Gm-Message-State: AOAM530wJAKOrwfg19skfrqPNb2BTKzH5UlG14e+g+CCInSJcmtbqHhA
        7q5E8eaLcmeqHAYrif2kTn7p4wM3W/zNwNoF
X-Google-Smtp-Source: ABdhPJz63MIxkCOChRI5KihUD89x8PkNKnFigexIckawruEH/R2dRkrMBNIQ2D4mBnhl+TcPwiamwQ==
X-Received: by 2002:a17:90b:488:: with SMTP id bh8mr1189823pjb.49.1595885492110;
        Mon, 27 Jul 2020 14:31:32 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id n24sm5880865pfa.125.2020.07.27.14.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:31:31 -0700 (PDT)
From:   Ankit <b18007@students.iitmandi.ac.in>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, b18007@students.iitmandi.ac.in
Subject: [PATCH] Staging : media : atomisp : fixed a brace coding sytle issue
Date:   Tue, 28 Jul 2020 03:00:10 +0530
Message-Id: <20200727213010.15156-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727121635.GT3703480@smile.fi.intel.com>
References: <20200727121635.GT3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Ankit Baluni<b18007@students.iitmandi.ac.in>

Fixed a coding style issue.

Signed-off-by: Ankit Baluni<b18007@students.iitmandi.ac.in>

---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 8ea65bef35d2..28b96b66f4f3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -4981,9 +4981,8 @@ enum mipi_port_id __get_mipi_port(struct atomisp_device *isp,
 	case ATOMISP_CAMERA_PORT_SECONDARY:
 		return MIPI_PORT1_ID;
 	case ATOMISP_CAMERA_PORT_TERTIARY:
-		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID) {
+		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID)
 			return MIPI_PORT1_ID + 1;
-		}
 	/* fall through */
 	default:
 		dev_err(isp->dev, "unsupported port: %d\n", port);
-- 
2.25.1

