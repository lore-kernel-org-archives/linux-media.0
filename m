Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDC1C433E0
	for <linux-media@archiver.kernel.org>; Sun, 14 Feb 2021 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7593164E12
	for <linux-media@archiver.kernel.org>; Sun, 14 Feb 2021 21:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBNVfR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Feb 2021 16:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhBNVfO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Feb 2021 16:35:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C08C061574
        for <linux-media@vger.kernel.org>; Sun, 14 Feb 2021 13:34:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z11so7344646lfb.9
        for <linux-media@vger.kernel.org>; Sun, 14 Feb 2021 13:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iPtze6FmhbcdVdAPT6QONzh4sS5usExY2cycsOaMmIw=;
        b=cKycaOtQTY41AeqIErFCMpOVHbHVj2kDU4FU6JHI7NYZ4sfBA8sg4hiBLcvxJwUHOh
         RPkPO0IujkWqOL5YE/MB24dGIQl5EZbXOdexxpz9jHBU7haNMahjqU1YNz5jZAfo6t1A
         plL7nYA6jGwVDAPObTXxivUuDK0XgkUgGW02OrKpxEdJdMkTuki1lA/ryvSbsSmQhnCN
         prvkdz3pR64FEffxFHgHkiqn096RY0S3JWSJuPEnE5Jj472qz1mNEtLaswzIrSGadIOI
         +dBbtkn98ypD02/xWi3H3oTUWFG4WiURIm9yMrFCWcPZFficFZdGIYl7S1xLsYttBsaQ
         XiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iPtze6FmhbcdVdAPT6QONzh4sS5usExY2cycsOaMmIw=;
        b=eYObUw2JvCfAtgT+puk4p5PmquL6b0eSzBNuyIbXgTb1hOaSMmDccApcgKLDs+mttO
         dBuEDCTDCD90np6b0fZVnGnmP+3dDIe3QcYeQkhx0+bnCagKHuo8BvMN8WdTQBJRPACk
         oZ5SMZxR2LNPF9zgwmVCvhP0CCqubuz12ImmMOlBYvjIGHntvxm2gIPSZOe/G0EqxTte
         l0Ba8M+J0l8LESad5gElMke0bXPJ2iECsvVcCK8c1R9jkIOpdHO8hl6/DCasfpRpbeh+
         8Q6qSZ0b6TrxpGsxGcX/jLBjom/ZTrI2kCWzD62c0FWzNVa+XP5LUBaOMVsiDCdx3lSX
         gyVg==
X-Gm-Message-State: AOAM530sG5GreqGQ8tKBcp7hXrZClot6HVK9lL7z+2ciB3ZAB2j2g+iQ
        TbRDV40LwMq5qU9rtLJb1xBj9A==
X-Google-Smtp-Source: ABdhPJyp3+ibejlV5sLro6YrM2yNvuWuPDO128if+t2CK6kgXSbev1DbSxFXmpLcoOiIzE59kx37rg==
X-Received: by 2002:a05:6512:2148:: with SMTP id s8mr7475046lfr.305.1613338472898;
        Sun, 14 Feb 2021 13:34:32 -0800 (PST)
Received: from localhost.localdomain ([85.249.43.69])
        by smtp.googlemail.com with ESMTPSA id h11sm2500066lfd.243.2021.02.14.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 13:34:32 -0800 (PST)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     junak.pub@gmail.com, robert.foss@linaro.org,
        sakari.ailus@linux.intel.com
Cc:     todor.too@gmail.com, agross@kernel.org, bjorn.andersson@linaro.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        jacopo@jmondi.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] media: qcom: camss: V4L2_CID_PIXEL_RATE/LINK_FREQ fixes
Date:   Mon, 15 Feb 2021 00:34:02 +0300
Message-Id: <20210214213404.8373-1-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The first patch is the start of the work discussed in the "[RFC] Repurpose
V4L2_CID_PIXEL_RATE for the sampling rate in the pixel array" thread [1].
I plan to send a few other similar patches for other CSI receiver drivers,
and if the current patchset needs to wait for those before it can be merged,
that's fine for me.

The reason I decided to post the camss patch first is the patch [2] by
Vladimir Lypak. The second patch in this series is the Vladimir's patch
rebased onto the changes done by the first patch. By replacing getting
the pixel clock with v4l2_get_link_freq() my first patch also fixes the
integer overflow which Vladimir's patch addresses. So the second patch
only needs to fix drivers/media/platform/qcom/camss/camss-vfe.c which
the first patch doesn't touch.

The resulting patchset is free from the "undefined reference to `__udivdi3'"
issue [3] as the u64 value is only divided by a power of 2, which doesn't
need do_div().

Vladimir, please confirm if this patchset fixes the integer overflow
for you, and if you are OK with your patch going on top of mine like is
done in this patchset.

[1] https://www.spinics.net/lists/linux-media/msg183183.html
[2] https://www.spinics.net/lists/linux-media/msg186875.html
[3] https://www.spinics.net/lists/linux-media/msg186918.html


