Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD5C282DA
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FF9206BA
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 14:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ8RBtlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbfDQOGz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:06:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46286 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQOGz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 10:06:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id q1so12044173pgv.13
        for <linux-media@vger.kernel.org>; Wed, 17 Apr 2019 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KCBzxtRf/YWlnx6I+Hs8R7BCJsYH7aySN2f5lrG+4Zs=;
        b=mQ8RBtlp1H0znA+hiDsceB3d58cyp7S/JIqq+yqge7/uQxTlF76HskRVyZxfC+eC7K
         Ogm2MVuCqwilbyLMS8CtjNfogDBZk6/1KEjVJcTtz+7p1IHuYR+x+ym/yo60fKALHRTm
         0b0uTqwOu9oJCLLp5bU7oNd99Kdeo2xMbS9B9nyXEojIA1XKD3+J+RRy04pwTWMKJ3aW
         ZiX1rK4mFBaTM1rQ/e3PkU3t8oMKBdgojAedtySqQE0qos3EIxHXR3OA105HvBcy8IEn
         r9zB9GTzQeOrd4KW22YrFdIkV7P80VjMd4a/QqiQfg4M8coTo321KQuw/z5n1knO9PqB
         mT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KCBzxtRf/YWlnx6I+Hs8R7BCJsYH7aySN2f5lrG+4Zs=;
        b=M/I5bAIoN7c4nURJjeqK3ZfS+XXdku+XdgAaJXk2TRgoG3OHeN7E/8CBcRuE52mS5h
         HD2VpW9jWgv9SAbyMDKZZ4fPAMWFVIVxNKQL7hWsiU71ztNl2OgEQl4iipsZb+EA2Yh8
         i5ciZKgpLlhfgUoWhPKs5phJy1sOBvCeUvwsdP+otovLTyM2G0VfdqPGujAsXH2ffR7Y
         jTch8+U4r1IhouJ6r5hMWTGbZfCMfAr7ur5GfP0W7QyAbGO9tMhHHptOpKRr0ef5pS3Q
         YRX9D7m6FKYl2K9XuvYgSZishBtbueLfwyzTAB1s1PoMntdqj5vrpUa1t8mQsPueDdHw
         Altg==
X-Gm-Message-State: APjAAAV+60hZTX/xDwC9iZLMT3IIspkgqC9hEQeAyUOCAArG+0vb7x1o
        r8DU5kjl7jR5w6qO/HMYg/+JyOYe
X-Google-Smtp-Source: APXvYqzHh+tAsJec4ltXWR5LNmbyMOMsxjtvFe3//ZS1uWLT2IZZOFU4BvAUUz9ZTpBzvgklD3IFOQ==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr84621433pgh.263.1555510014632;
        Wed, 17 Apr 2019 07:06:54 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id t82sm144498222pfa.153.2019.04.17.07.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 07:06:53 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 0/4] media: ov7740: several bug fixes and cleanup
Date:   Wed, 17 Apr 2019 23:06:37 +0900
Message-Id: <1555510001-23922-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patchset includes three bug fixes and a cleanup for ov7740 driver.

Akinobu Mita (4):
  media: ov7740: fix unbalanced pm_runtime_get/put
  media: ov7740: avoid invalid framesize setting
  media: ov7740: fix vertical flip control
  media: ov7740: remove redundant V4L2_CTRL_FLAG_VOLATILE set

 drivers/media/i2c/ov7740.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

Cc: Wenyou Yang <wenyou.yang@microchip.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
-- 
2.7.4

