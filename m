Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AD5C433B4
	for <linux-media@archiver.kernel.org>; Wed,  5 May 2021 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A5F61076
	for <linux-media@archiver.kernel.org>; Wed,  5 May 2021 15:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhEEPzU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 5 May 2021 11:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhEEPzT (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 5 May 2021 11:55:19 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DF2C06174A
        for <linux-media@vger.kernel.org>; Wed,  5 May 2021 08:54:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a2so1939944qkh.11
        for <linux-media@vger.kernel.org>; Wed, 05 May 2021 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sT5gh+1EXZtOxYM3WBIR7U/7xjEHkvX592kGUagqFYc=;
        b=aRbgNk1AAtCgn3aq1pldMwpcsbLLO0vsA9yDCYjTSKGDjhuIZGtGBhKlW5hu2kUzU2
         VyxCj0mryiV8DsfB5b12qFz7DnauvSNwG5QkejFlCxMOzJcV9Og+67chd5p/plYHT+Z+
         mL6Yh1T/OFD98MRBkPTueajHVg9CJBxWMeMSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sT5gh+1EXZtOxYM3WBIR7U/7xjEHkvX592kGUagqFYc=;
        b=VHRusChnldvDkL70pdAtj7ZHIEK29uVu/LBT2QxRNvIvP0Zzg7PPpXHDMt/FtVUdiu
         Ns+s1AEhJD0aA6Npj0iCdTkow8Z8HuVqS+SPRQmoTwNtO/7HW9+L6i0WYtNM/kTK0sGc
         7yd1BOqKH2Ae/hWOeLWBiOhv4dItphwCeLyrdMgMFqMnNr+Y0tpDnbFa5Alcm2s1zuQu
         p/P6xoOPGGXHJ63k8EYIYnFX+I3gUVP8bB0WuWVGMZYWgeX3D7eotUKkVew9SjqHtR/D
         b8YGahCJXbk+ilne6MeuXfn73as24SqgD328bAxBnppxeNILxPJ2gUKhkgYsNitDV6na
         SN2A==
X-Gm-Message-State: AOAM532x/9z/EPvBZsgc9JRWxagcMfVmrf2rq73Qscv0S51HEcJpIphu
        /WIA0ShzXVWy/+2LFPWzsmdVoA==
X-Google-Smtp-Source: ABdhPJya3vgRQ++iqwOA71h8RVcWf478k1iK9HmfiaeS+ST9LB9GXXDX5dCIG8VVdfCIZL4c5M4X7w==
X-Received: by 2002:a05:620a:15ca:: with SMTP id o10mr2987351qkm.448.1620230062521;
        Wed, 05 May 2021 08:54:22 -0700 (PDT)
Received: from [192.168.151.33] (50-232-25-43-static.hfc.comcastbusiness.net. [50.232.25.43])
        by smtp.gmail.com with ESMTPSA id k126sm7664937qkb.30.2021.05.05.08.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 08:54:22 -0700 (PDT)
Subject: Re: [PATCH v2] media: em28xx: Fix possible memory leak of em28xx
 struct
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210504183249.6307-1-igormtorrente@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <21f59c86-f1ae-5913-cde9-078fe4f6f752@linuxfoundation.org>
Date:   Wed, 5 May 2021 11:54:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210504183249.6307-1-igormtorrente@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 5/4/21 2:32 PM, Igor Matheus Andrade Torrente wrote:
> The em28xx struct kref isn't being decreased after an error in the
> em28xx_ir_init, leading to a possible memory leak.
> 
> A kref_put and em28xx_shutdown_buttons is added to the error handler code.
> 
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---

Hi Igor,

Please look at Hans's response and comments to your v1 patch. v4l core
addresses the lifetime issues now and this driver could be updated to
use them instead if fixing the problems in this driver's resource
lifetime mgmt code.

Please follow his review comments to address the issue based on his 
suggestions.

thanks,
-- Shuah
