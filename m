Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520D3C433E0
	for <linux-media@archiver.kernel.org>; Thu, 18 Mar 2021 10:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D98564F3B
	for <linux-media@archiver.kernel.org>; Thu, 18 Mar 2021 10:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhCRKVr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Mar 2021 06:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCRKVr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Mar 2021 06:21:47 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592B0C06174A;
        Thu, 18 Mar 2021 03:21:47 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f124so1406459qkj.5;
        Thu, 18 Mar 2021 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Xr7Q5W0mf+yiUAVixOuldC+FC1OKy7M7Vy31w+xy1Y=;
        b=TEtG4SdAnzFyy/M2rKDKRnqAVekeFrgpAB2iHD5DbcokIKv4I1qcJq6kttnmIaFOPG
         FA9XdKTGR191nxkB/ni54K5QALdJR2VrdcDuOMVEeqqjUdHLd6ag5k9tQ0UfoyWAyicU
         2+XaSdblLbp6au25IshXW5b5JgmOK7MWgbLsuIECUC8WBa+6rP/0Y2bndmwmzBJBfglU
         Zyy/TRO2ga/nkQkmmXBnXCezg9UEB3VLARDsYcpMlhXvP2Am9qvPbN2bKIBUPCZPaHmQ
         KrWVzK/dYiFcKm4TOl6n+l34Pz44dhj5abexVwtedQ+ZikXrjKVYMwUDqNGEwPVenyMK
         H5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Xr7Q5W0mf+yiUAVixOuldC+FC1OKy7M7Vy31w+xy1Y=;
        b=en06t8tcCK2q2Hq66xsZ9IlMuX1WMjtslJYMHGCP0Q1K1t0b5nFnGEvHT0PUcfVyCr
         gjli2Fb6g5qJEmFqJvi9vaEtr3XucfBueHnhY47gtUsqerSvqOxenm7w2h8E2CF29fJH
         S9COtC4ernIo52rRYpKZFhqko5lZ4wsuDQISW6/ajfM3rFdXbfsGYRh3NGiczluHhTY3
         Pl/wzkxaHdJ4nDbZtnMhEmGaU+qa/nTc0MmTZU7dKR+xY16UnEQMg9SG6FtvkqfTkBwT
         CAYnve0JQ+v4VNOJGOUkKJAgAbc1FldXdgPE9+SHFUgg5MCF9YFEbOAY4mjtBZT5GpY9
         DhUg==
X-Gm-Message-State: AOAM530vun08Bvk7dt3nrkKdm5FRBH8teH33oz6PUKPYMZN7Y8WvKZFI
        mjb/T4XP8ZFB01nr5T3mmMo=
X-Google-Smtp-Source: ABdhPJzDRs+L/5k4egcTCwL/J4AHYZ9kwMa0q9V42HhyhSCgubQPEP3sb7Y0pb0+6jOA69PKKwYxsg==
X-Received: by 2002:a37:6294:: with SMTP id w142mr3528165qkb.255.1616062906647;
        Thu, 18 Mar 2021 03:21:46 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.246])
        by smtp.gmail.com with ESMTPSA id r3sm1364387qkm.129.2021.03.18.03.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:21:46 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        chris@chris-wilson.co.uk, tvrtko.ursulin@intel.com,
        mika.kuoppala@linux.intel.com, unixbhaskar@gmail.com,
        maarten.lankhorst@linux.intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] drm/i915/gt: A typo fix
Date:   Thu, 18 Mar 2021 15:49:32 +0530
Message-Id: <20210318101932.19894-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


s/bariers/barriers/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_timeline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_timeline.c b/drivers/gpu/drm/i915/gt/intel_timeline.c
index 037b0e3ccbed..25fc7f44fee0 100644
--- a/drivers/gpu/drm/i915/gt/intel_timeline.c
+++ b/drivers/gpu/drm/i915/gt/intel_timeline.c
@@ -435,7 +435,7 @@ void intel_timeline_exit(struct intel_timeline *tl)
 	spin_unlock(&timelines->lock);

 	/*
-	 * Since this timeline is idle, all bariers upon which we were waiting
+	 * Since this timeline is idle, all barriers upon which we were waiting
 	 * must also be complete and so we can discard the last used barriers
 	 * without loss of information.
 	 */
--
2.26.2

