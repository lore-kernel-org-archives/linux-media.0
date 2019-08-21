Return-Path: <SRS0=4cU9=WR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F62BC3A59E
	for <linux-media@archiver.kernel.org>; Wed, 21 Aug 2019 12:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE70F206BA
	for <linux-media@archiver.kernel.org>; Wed, 21 Aug 2019 12:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcsqht3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfHUMbv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:31:51 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55130 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfHUMbv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 21 Aug 2019 08:31:51 -0400
Received: by mail-wm1-f54.google.com with SMTP id p74so1923319wme.4
        for <linux-media@vger.kernel.org>; Wed, 21 Aug 2019 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3S5TS4XBx1mfIFrnN6gmTUYzjNlq08rA3aAzZmGTXEQ=;
        b=tcsqht3pngKKEk8n1K8A0y0PcYxWSB/hYGI7R+q48OM+kK+cZthSoXERhldmFEee/b
         7yINAr2ifF3OPw+h6sAKnGjN7Zv+Zedc7JW2huPtytXMY/9j7mTFmwbmAxWjNkg5FK/j
         e50bAoyw6eRACZ4HgaEv5RKKABKIRpNYX9KfMEgQZfpfy3KtXCBnlBPRlJ3ByVuXVzq/
         Ft5khJpeZZR4+Vl0xk2YknpIQmU9uiJmfGvKNC8poQ3dMOWsONoOs8rT0T/Egqvaanyl
         toC6SlJjTLhhf3TkL79no9OaPYAAsgr6NkgA2OwOVC/mpTpnqMBABkqBxjVDhE3U0HZ6
         UtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3S5TS4XBx1mfIFrnN6gmTUYzjNlq08rA3aAzZmGTXEQ=;
        b=RlurdCJbDRr9pe7OD4TgfX5JZPpix1NRtd4UGd0lFeUATcHaYo2wRfFALOL9RtBClg
         LJHvenrfnGkm6i+uRYKUWGcaAnlfMWoOAlxi2GcYxSsgE2WfqlrsHmIuMWEDulnocYSq
         LW8ZJi8AdYPHgKC8U6grX8aNYhGIAfYtTBZngvNbzdx79KZjm4azVQ+f4TmQdCrvfYR/
         2ZpkHS0Nf0j0pV2m/1NrCxzhWpxVx1f1Dn+zNCq5bx0Ndb2e1uf5TbPrAo+F4Iq3k9sH
         shuOsfdVyEEM0Q/ScBiZftrVnpdJBFwWu6NH7+CZTu+m8uSxuBhhZlJDVWS6SulXyj7J
         eUHw==
X-Gm-Message-State: APjAAAWBGs2B1SDG5N3mHLsnJzB/FS3z48pd5AL1Lxrd2QdqSKl4zyc+
        LpgyMGKEJaSV1AS1Wl9r126N5Usg
X-Google-Smtp-Source: APXvYqwi9lBmQWxnD8F63h+EmsrmrZ/1OYywUasQane7UOn3NIneCxEUK9tkCqql5egIVLWNpvtq6Q==
X-Received: by 2002:a1c:1d08:: with SMTP id d8mr5751122wmd.22.1566390709459;
        Wed, 21 Aug 2019 05:31:49 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:8189:dd33:a934:c4fa])
        by smtp.gmail.com with ESMTPSA id v3sm23084571wrq.34.2019.08.21.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 05:31:49 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
        daniel.vetter@ffwll.ch, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [RFC] replacing dma_resv API
Date:   Wed, 21 Aug 2019 14:31:37 +0200
Message-Id: <20190821123147.110736-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi everyone,

In previous discussion it surfaced that different drivers use the shared and explicit fences in the dma_resv object with different meanings.

This is problematic when we share buffers between those drivers and requirements for implicit and explicit synchronization leaded to quite a number of workarounds related to this.

So I started an effort to get all drivers back to a common understanding of what the fences in the dma_resv object mean and be able to use the object for different kind of workloads independent of the classic DRM command submission interface.

The result is this patch set which modifies the dma_resv API to get away from a single explicit fence and multiple shared fences, towards a notation where we have explicit categories for writers, readers and others.

To do this I came up with a new container called dma_resv_fences which can store both a single fence as well as multiple fences in a dma_fence_array.

This turned out to actually be even be quite a bit simpler, since we don't need any complicated dance between RCU and sequence count protected updates any more.

Instead we can just grab a reference to the dma_fence_array under RCU and so keep the current state of synchronization alive until we are done with it.

This results in both a small performance improvement since we don't need so many barriers any more, as well as fewer lines of code in the actual implementation.

Please review and/or comment,
Christian. 


