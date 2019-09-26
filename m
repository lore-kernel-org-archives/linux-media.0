Return-Path: <SRS0=2jbk=XV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ADFC4360C
	for <linux-media@archiver.kernel.org>; Thu, 26 Sep 2019 23:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34F520835
	for <linux-media@archiver.kernel.org>; Thu, 26 Sep 2019 23:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKbAmujY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfIZXoZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:44:25 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46994 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfIZXoY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Sep 2019 19:44:24 -0400
Received: by mail-pf1-f178.google.com with SMTP id q5so411778pfg.13
        for <linux-media@vger.kernel.org>; Thu, 26 Sep 2019 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FvKMV/bxKsoYkz7CSWQIzwNFI/HMU0WxaCrL8r7AeEI=;
        b=qKbAmujYxC8AKBNKcfSpZRQvZDHYey3xNzovKJpmWohF+U4r2G5xaHJaTB0DguCzyu
         oaUvKVBmYTdvWYKHvGLtpwbUUgaoTJTtzTwsJebr2mONRKKNPvIFlqK9GUvgu3n9bmIX
         jQ3sfWsE1wdB49JI39MGZC3maPMlRgJtU1jEEd9716RaqD4358b/2Itv/XAopGyxvour
         tg9SdktbZ+RE1lLrgM027hHBA+JJcurRrUhy26NfV/KBDbAxmtIajt2w/CvnA3UKd4Lk
         zQN6+R3Zdx3XVpTKNFm/pNTnoIIqYuqw5DCBIFJwYqZudy+X2brYep0kYKqR+7srXfSC
         OFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FvKMV/bxKsoYkz7CSWQIzwNFI/HMU0WxaCrL8r7AeEI=;
        b=jJQgbCKsO4PuQrpyUw1WfxDogwFP6wjSol5PNQSiceWq29dsdfqZgr+gnTIqYRzRHf
         AfLIeU7QrUZN8cahA6wG5p/B8Wwj6X8WCPzkrhkxRTlCk/2iJSrt7aZZPZAen3sARph8
         wh9Kh0iryJevP6KVHNUV91q4Ew+eOTgWTd354qi/OStbqf1dGbIToTz/D+g7rNDB2QRw
         ZYczWBFPjsp2uiZzMD749IFXiiMGgi/6lHjDPP2nkRk/bKWsX2LqjHDLMHxtWaVW01E6
         +sf76iB7Sn31lxwa3mDKmpM995TytEKpQj03gC1j45OZLJttt/9QFaRRwjyxINaJVAEE
         G/Ug==
X-Gm-Message-State: APjAAAVi/r6LH5b5nosNF3wMXS24dsxJGV7Gykd2WNDQrMHBvsc/z1Zp
        SXEvE3KWmogxQCzBcP4MTMmtdJsYkAGuSTTfk61yctowr4I=
X-Google-Smtp-Source: APXvYqzGBjxn+MYyMfFylgBUJ0OH6VO2XYLMxDNcvlKYgIvHJ0/D5e2zkikKqHZdieboyYiT8m3nsB7i/6tTmjjanz0=
X-Received: by 2002:a63:b95a:: with SMTP id v26mr5972458pgo.244.1569541462234;
 Thu, 26 Sep 2019 16:44:22 -0700 (PDT)
MIME-Version: 1.0
From:   Dito Windyaksa <morpig2@gmail.com>
Date:   Fri, 27 Sep 2019 06:44:10 +0700
Message-ID: <CAGN+7qj4MWhm7Da2eWM+wiN+14p1To7gsbYavfbS2TkKTRO2Ag@mail.gmail.com>
Subject: Elgato EyeTV Hybrid not detected
To:     linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi there,

I recently bought an Elgato eyetv hybrid and found out that after
hours of researching it has a different product id, thus not being
detected.

Is there any guide/steps on how I can add my device to support it
without waiting a kernel release?

The result from lsusb shows that it is a YUANRD STK7700D. lsusb result is below:

https://pastebin.com/H65xn17h

Thanks!
