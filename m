Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001DCC10F14
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 07:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E68206BA
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 07:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgSyAW4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfDWHLy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:11:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33183 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHLy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 03:11:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so12527682ljc.0
        for <linux-media@vger.kernel.org>; Tue, 23 Apr 2019 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LqJHpog146UJnxkhSPf1jgqBDrO45RdshtMURFP/4Bg=;
        b=VgSyAW4VPltQ9MJ8iCGm/NRq93lWrkP9wO5BWxvuKVR4AC+hu/5ckA+d3xstiXfeAc
         s7p3vhQWb3pcZSjpQNIlFVcNW2aJro47wSjzwM5cTXZodrWokGsA82cfUheBMYf52Y/Q
         xxeyzAqWcK+Bz7XCripXt9gSdOgZ1Id5iMu0WLvrnoATQ6SoHyPzGIKH9AGOhXK3Bzs3
         YGbmVGi32CAutrktcyVBoKP22doFdxl0LsenKXfKMM+e7OQNb4aLxm+NrMSgNxQRJxRz
         pJQEgG6iSmUUiCiX7dX+F1TF9rIogdD4urc/uR6RYxlh5k6sFFGoEasayYiUklqTUBFm
         idQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LqJHpog146UJnxkhSPf1jgqBDrO45RdshtMURFP/4Bg=;
        b=QiYbRyXEo6hPlrggFLT9S3LVFt+vlwF7Px32v0PKW0mwj8xmz3MjbSNd+16zK/nijY
         2Z55Zo3CEkzr+E99KEY0nvky+ev83Gm0BSdLPWk3pg0bc1p+okexj9ezj7CCy2c7ICzv
         g8Wdl6zEeldI98L0RmpPkjdxJneBNmx0ekRdbIsSB9DDmPGFpqYDyqQjOoydZ0R7YHqb
         ew+osbB9Ev22nLx7rNjhwx29lW20jsjM02JnVSrYWu0v9PKBdKXFjPXjnUFdp7QNAarw
         rvUhprVxazkAj5z3q3AzpN7cV3BoF2gMr9PSLWMEGW/zoJNEWonlJXbvG5Q4TFi6agk9
         EtjQ==
X-Gm-Message-State: APjAAAX6f3xcVPeIBnsPMIlDya35CJCxi+hxZs4UXHgAJeJm0DkD9L3z
        bjQFVVSH2YzJWC0Xy2MprGbNVfxU9IY=
X-Google-Smtp-Source: APXvYqwqRMscSa8vvPFmYpYldN8gOjsYhK3n5jrtcCTehYkrASTsgqbzqX3cIE46nNI4ENmoKg2feg==
X-Received: by 2002:a2e:8018:: with SMTP id j24mr1100975ljg.149.1556003511490;
        Tue, 23 Apr 2019 00:11:51 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id z15sm3144457ljz.55.2019.04.23.00.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 00:11:50 -0700 (PDT)
Subject: Re: [GIT PULL for v5.2] Venus updates
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-media@vger.kernel.org
References: <20190401081817.14386-1-stanimir.varbanov@linaro.org>
 <20190422143551.6d29231e@coco.lan>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6160de59-bc55-39b8-06fd-92e5f0b98255@linaro.org>
Date:   Tue, 23 Apr 2019 10:11:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422143551.6d29231e@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

On 4/22/19 8:35 PM, Mauro Carvalho Chehab wrote:
> Hi Stanimir,
> 
> 
> Em Mon,  1 Apr 2019 11:18:17 +0300
> Stanimir Varbanov <stanimir.varbanov@linaro.org> escreveu:
> 
>> Hi Mauro,
>>
>> Here are two patches, one fix and one which makes gstreamer happy with h265.
>>
>> Please pull.
>>
>>
>> The following changes since commit 3e11851d16ea7eff1cfa66b1cb7b35967876dd1e:
>>
>>   media: venus: Add support for H265 controls required by gstreamer V4L2 H265 module. (2019-04-01 10:44:05 +0300)
>>
>> are available in the Git repository at:
>>
>>   git://linuxtv.org/svarbanov/media_tree.git tags/venus-for-5.2
>>
>> for you to fetch changes up to 3e11851d16ea7eff1cfa66b1cb7b35967876dd1e:
>>
>>   media: venus: Add support for H265 controls required by gstreamer V4L2 H265 module. (2019-04-01 10:44:05 +0300)
>>
>> ----------------------------------------------------------------
>> venus for 5.2
>>
>> ----------------------------------------------------------------
> 
> Not sure why, but I'm not able to pull from it. It complains about some
> issues with your gpg key, and the diffstat is not there...
> 
> I suspect that the e-mail was only partially sent.

I haven't published my public key on any server, just sent it to you via
email - could that be the issue?

-- 
regards,
Stan
