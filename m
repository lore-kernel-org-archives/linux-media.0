Return-Path: <SRS0=Ori4=Z2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E6FC43603
	for <linux-media@archiver.kernel.org>; Wed,  4 Dec 2019 21:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6C920675
	for <linux-media@archiver.kernel.org>; Wed,  4 Dec 2019 21:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E/Dc2fcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfLDVvN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:51:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34726 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDVvN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 4 Dec 2019 16:51:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id f4so5808907wmj.1
        for <linux-media@vger.kernel.org>; Wed, 04 Dec 2019 13:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DineaCUxtXZyF5eVfdeaHcVkj+3QG5rCu+T6TpNdzNc=;
        b=E/Dc2fcBEXg9O7rrLFl+CUNHdg6nwQObKTEeRjxJi0gerdcWN17OB1Ea/dURi+sIk8
         cmVlL3k2XKlvc+zkDeFbX1RK2rL500+re+kpty16NiyRNlWneVCjOVkguelrsDMleGQj
         EmkRXniI8+E4N6dlRuEeklPKwPuyRkHSlio40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DineaCUxtXZyF5eVfdeaHcVkj+3QG5rCu+T6TpNdzNc=;
        b=A3u4BL9XC9w8rQc+1jntslvR7jCapOmr5lYAGHIdhf/TQulVK3Qbmih42lR//+N5sk
         7b4gLUIbDEb2u4rIq4I5ijNM0iT5M3VxPk9ecwTk2HITCjzR+VCZeg1OyF4or6jENcq+
         TPinKy4JkofKsdC7fL2sEfJq1+SR7YOmBIqUB+fP3zvb7KM06rO/DF9M1z/dGRRQXVxT
         lkvEN3NXMOcJHFeYHDlzz0b2gl3urGOmKO2PJvHyovarLJWauy+Fv99/wp382JyFcWCK
         HVOowuqQqf75FSdS9+Nx1Huhy3UOk17uOWvZprqM8pb2iTNgBVd5nAzObfMpYVUmmUtC
         yPMQ==
X-Gm-Message-State: APjAAAVV4D0PmH6DaTeOY4AtCRKPlYUXf/oiDXsadN23JlIWMdO3vVYZ
        3+8LfPLplbO9L3SnPnD8BlLuOA==
X-Google-Smtp-Source: APXvYqyveN/NM/BqCSvK0XZhdEBxg9tIPSZ8AR1TcT/KyNPk7ZmH1z0FdS7gJAgyQXflfUm0wgxS1A==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr1816299wmi.0.1575496271035;
        Wed, 04 Dec 2019 13:51:11 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id q6sm10409464wrx.72.2019.12.04.13.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:51:10 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH] MAINTAINERS: Match on dma_buf|fence|resv anywhere
Date:   Wed,  4 Dec 2019 22:51:05 +0100
Message-Id: <20191204215105.874074-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

I've spent a bit too much time reviewing all kinds of users all over
the kernel for this buffer sharing infrastructure. And some of it is
at least questionable.

Make sure we at least see when this stuff flies by.

Acked-by: Dave Airlie <airlied@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 375dbea8bc88..c1e3da2c1947 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4941,6 +4941,7 @@ F:	include/linux/dma-buf*
 F:	include/linux/reservation.h
 F:	include/linux/*fence.h
 F:	Documentation/driver-api/dma-buf.rst
+K:	dma_(buf|fence|resv)
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
-- 
2.24.0

