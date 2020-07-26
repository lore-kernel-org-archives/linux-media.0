Return-Path: <SRS0=cC6z=BF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5692C433EB
	for <linux-media@archiver.kernel.org>; Sun, 26 Jul 2020 12:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EFF2076A
	for <linux-media@archiver.kernel.org>; Sun, 26 Jul 2020 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUxu9+Wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGZMsB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 26 Jul 2020 08:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZMsA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 26 Jul 2020 08:48:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46766C0619D5
        for <linux-media@vger.kernel.org>; Sun, 26 Jul 2020 05:48:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 3so5201464wmi.1
        for <linux-media@vger.kernel.org>; Sun, 26 Jul 2020 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ls/bxGHWKOsSWND3CuCCnbnDhwt7VUsal24v9OVekgM=;
        b=HUxu9+WbE2jY14ERvhESXBh6vufUqFLI7Ymt8EB0lBqwQosBtDDd7wITlrAmLfK71W
         Lj9/7AiC7pcGnuSbRSkUJciFd86yGUFvq0T9awfMxJsCfDxJo9ecS8ChNiFMcgq4sm4a
         vcfkc6NQjH6qEhgJ8CRbczHNSN20Iep5sx1vxSW9kzVCbWuGzgKR0usHGntUGnjBwyV+
         Or6tvqVFtDAiqgl57mgUUkhaHIxg/VR4CH6A76DX7iKFonjltFLxKtK+jThAAzGAR5fG
         O4LTHPugRwxtB+ujQz239Aq1EnUk3Pf3cgUrG1ReoLbM7OUuTU1MztgTHKF5NEkCCasD
         Buhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ls/bxGHWKOsSWND3CuCCnbnDhwt7VUsal24v9OVekgM=;
        b=IlaY5niiJUW/FkAIfIlJMu6iCkfim+1CJ46bBui5LT9xFD+Fx+fklH8TEmQznACQsd
         L9NcNbQg/VyBaMXt+iLSbfT+jexuM2NaRitiuS2p8HGeoGcMIETxVmB8pqbeCKI8IPCd
         00oLtRZHMxrR3oueMpKc+mrklU52r6ok96FsQU2EjP9rWBpjrYhKLaCEAyM0l0ZKpwuw
         g+Kc+MF+xVS5Hfrq/XKiPA4HT9Qkv5BHKv6J2InKJZvvQrANNPZKZF0pxxDRj2VrWL6z
         pLcYyZbYm/u22K1iTYjxjIs3/r9M6XJP2QebCElBsCalqJboiqLQQQqAiQf4V5eFpiRR
         TJ+g==
X-Gm-Message-State: AOAM533LlryiKyi5jVaGPC9C05R8iPvwLxOMGT1qmuVIVrFVgAxEYvL2
        ukE6b8AHv5GOh2jwXg1yZtz1HA==
X-Google-Smtp-Source: ABdhPJwyLUi8eTNwe8h23tZ30h5NPEBzjshMo97UQvtYCZS6mAkwfjUFNPDwjeCU2HfvehL0+M/x0g==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr14008434wml.181.1595767678843;
        Sun, 26 Jul 2020 05:47:58 -0700 (PDT)
Received: from [192.168.1.4] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id z12sm8232338wrp.20.2020.07.26.05.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 05:47:58 -0700 (PDT)
Subject: Re: [PATCH v4 3/5] media: venus: core: Add support for opp
 tables/perf voting
To:     Rajendra Nayak <rnayak@codeaurora.org>, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org
References: <1595503612-2901-1-git-send-email-rnayak@codeaurora.org>
 <1595503612-2901-4-git-send-email-rnayak@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <24975bc8-58ed-4633-8f67-ed85f67fc497@linaro.org>
Date:   Sun, 26 Jul 2020 15:47:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595503612-2901-4-git-send-email-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Rajendra,

On 7/23/20 2:26 PM, Rajendra Nayak wrote:
> Add support to add OPP tables and perf voting on the OPP powerdomain.
> This is needed so venus votes on the corresponding performance state
> for the OPP powerdomain along with setting the core clock rate.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       |  2 +
>  drivers/media/platform/qcom/venus/core.h       |  5 ++
>  drivers/media/platform/qcom/venus/pm_helpers.c | 92 ++++++++++++++++++++++++--
>  3 files changed, 92 insertions(+), 7 deletions(-)

Once we have a fix in opp-table (patch 4/5) to avoid -ERANGE from
dev_pm_opp_set_rate:

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

<cut>

-- 
regards,
Stan
