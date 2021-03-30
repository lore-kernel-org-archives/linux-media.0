Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54174C433DB
	for <linux-media@archiver.kernel.org>; Tue, 30 Mar 2021 00:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F2761985
	for <linux-media@archiver.kernel.org>; Tue, 30 Mar 2021 00:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhC3AXD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhC3AWd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 29 Mar 2021 20:22:33 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0727DC061762
        for <linux-media@vger.kernel.org>; Mon, 29 Mar 2021 17:22:33 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x9so10695947qto.8
        for <linux-media@vger.kernel.org>; Mon, 29 Mar 2021 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=dYlG4UVbGn1WMIdMD5HLWMIl5KF7aYBXkTgYwMl2Xlc=;
        b=Pf65YCFn3lB1TuK6qAsmVjic8F64LzHZUBpOvm22tsj+pqhmm+nGx3G15DeaDdHXvD
         M5fZcT49CfAUI53/dMiEg5Kecb7rteyJ547CxAuEGXizUCO1AvOLesD2A98nTB0T16J6
         d3EKas8fR04HFze3bGPQhtfafzi/LAb0j8uguGlJFCygugDjSAYstPHqAD76aRSKu8ik
         S/5u85SKIRurEbg1kNKReIGMbZnibKHI5kXycTyWNQuusJRUYJxp4h4XomcGAFm5OfFs
         akzWuEbKyxecqEi7AgaXD59yyNiCB9c+9nrvjPgPIztyDCNhr25ye7K341Nk0bYcv9kl
         PbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=dYlG4UVbGn1WMIdMD5HLWMIl5KF7aYBXkTgYwMl2Xlc=;
        b=m4tHvrORRPHMmeIFvDMxyWpNdOX2W+3tTsEio2V7YeVo/EsmI45MKrRRa54IDWt5wD
         Yfhm+M/lAKtRtUmAvNlvKYtl6MYbpKfbMl/FTMsUlQUw/XqgVDKzCiTCUZuFPAOzQKjc
         q9JAR4BVOaPktWVt6FoR6TFs6BXzyvaeDGK44ZY6pft7sw2oLKLE2HOIsCMwiSfNNlqD
         76g0X+zNbwfdgdTH9jozeOLEIgnSqgelwWN4+kQ4hxBIQ9vk5Lf1H70amj0JHWo9LgEa
         TQDleweqbJZQOWadsvGVBXJJCYagG3eGu3ul59r6PpbgRXMkIS+NKzxPcj4jyqnylrwe
         AiMA==
X-Gm-Message-State: AOAM5305iJ1MoaaIAlrh/INgE61yLccCmR527iWFIR0DqnzCWAZGFPU6
        RV9+M8gUy79p0bHqHotLetk5y2UZIi2uYA==
X-Google-Smtp-Source: ABdhPJy4Xq4JaDB/pq2MuiuwNryPagFPemwxrL6ob2wG6L6z9k+Fe9VuEY5un9nBIvD9q1THJ9DH8Q==
X-Received: by 2002:ac8:708:: with SMTP id g8mr24884162qth.316.1617063752099;
        Mon, 29 Mar 2021 17:22:32 -0700 (PDT)
Received: from [192.168.80.12] ([24.105.64.120])
        by smtp.gmail.com with ESMTPSA id 131sm15453860qkl.74.2021.03.29.17.22.31
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 17:22:31 -0700 (PDT)
To:     linux-media@vger.kernel.org
From:   Vincent Fortier <th0ma7@gmail.com>
Subject: Media backport: linuxtv backport driver snapshot file date missing
Message-ID: <bd4a68be-6eea-3876-6b3e-8067014bfa09@gmail.com>
Date:   Mon, 29 Mar 2021 20:22:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi all,

I may be mistaking but I thought there always was a file with a 
timestamp (YYYY-mm-dd-gitHASH) matching the LATEST backport. Currently 
the "LATEST" file dates from March 24th but there is no file with with 
matching timestamp I can associate to.

- vin

