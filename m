Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A75C4338F
	for <linux-media@archiver.kernel.org>; Mon, 23 Aug 2021 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642CC61371
	for <linux-media@archiver.kernel.org>; Mon, 23 Aug 2021 08:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhHWINR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Aug 2021 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbhHWINM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Aug 2021 04:13:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3C9C061575;
        Mon, 23 Aug 2021 01:12:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n5so11418069pjt.4;
        Mon, 23 Aug 2021 01:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L9MnmP9lqjKYjSK35iS1XxtFkuuKbK9tvWBNkGmf6Ww=;
        b=rZ8fAi/Kx2pEbxPY+ZCB1VBeoagOib2zTRoSdkaP4GEEiNCWF7yyWubEO8cAGbLNtK
         A0ApAnr+yaRZZIrxSLUEyw6Dhf4Si4KA4IvN7eGlpdnqde1nPZIRc50bbcpG/JZm95bf
         MHjVLWrQ9FX9kEDdoUq6LdB0TqPEBTNOgoiPqMXD209vOv5Ur9B66BynOc/P3dVuzQkv
         Q3lOTehsiiminT5ArXDebUvKzQJmLuCFx/eRmGgIJWhOyOWbxj5FysofGfYLO7rjdCkJ
         eE6V/UFfEPv6Zvc1Q8CwWMQANNZkEtCwTWFh7sYhKR/bH+x8w6NC/+DUwwcrTN1O49UC
         N52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L9MnmP9lqjKYjSK35iS1XxtFkuuKbK9tvWBNkGmf6Ww=;
        b=tUnJrT4FKx7Rpz8Aw+imnvBmMnA0c2IXqnjKwsTMuJ80fMvqrXkDGyIyQtijcDFVNf
         U8iG3bSSaEfEWVay85h9hx3Masr/zweCjJ/1GRlqtEDE7DIb3QEwI3jo+BuFiHIvwDqB
         W06VTRs33wL4lssIoAJRBoa3Bp+W/eLLRlp/Rm0i7/VBudV+7Mtde9MppHdoeay8R40c
         Wz3UIqxZz3AlAkxlMU8bbf/QKHOUZkF5MbnIzxHEeRsWXJx6wti1WKJbs73sG7t+sN8X
         2L3WbmMYktvIS6iDBx86BEjiewdVsX1D/4WVLDnkuo0zFKPmvY4YzEcj/FiPD0W5vVW1
         igBA==
X-Gm-Message-State: AOAM532kpRfM/7IyCk7NfVPT9Kq3QrcCgfXT8zLSKZWsg8pJm5BYvraO
        E3vTKrZyLFROFKgpdYYcBcM=
X-Google-Smtp-Source: ABdhPJzNetVcNSWtA60OCrlEq2x4IfxPEX6lbisSeHQSDv1MAwzCFsYx2QMBgQXVSW0zCkDuszTNNA==
X-Received: by 2002:a17:90b:1c8e:: with SMTP id oo14mr18939192pjb.108.1629706350363;
        Mon, 23 Aug 2021 01:12:30 -0700 (PDT)
Received: from [192.168.3.7] (softbank219203027033.bbtec.net. [219.203.27.33])
        by smtp.gmail.com with ESMTPSA id y21sm1693754pfm.52.2021.08.23.01.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 01:12:30 -0700 (PDT)
Subject: Re: [PATCH v2] media: pt3: Switch to using functions pcim_* and
 devm_*
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <20210814155742.11392-1-novikov@ispras.ru>
From:   Akihiro TSUKADA <tskd08@gmail.com>
Message-ID: <b4069b42-7ce9-126c-0d0c-7ff6fb2b9631@gmail.com>
Date:   Mon, 23 Aug 2021 17:12:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210814155742.11392-1-novikov@ispras.ru>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Tested-by: Akihiro Tsukada <tskd08@gmail.com>

--
tsukada
