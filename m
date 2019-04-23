Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6DEC10F03
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6045E21738
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 14:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbWflisp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfDWOyF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:54:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33104 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfDWOyE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 10:54:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so13836436ljc.0
        for <linux-media@vger.kernel.org>; Tue, 23 Apr 2019 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S148436qoCoeK0FQGD1ySRqulS61+al7UnTKDQroX5A=;
        b=KbWflispIckU5NwQWpM+AyeKsq79+WLke7js4xDk3H3TH1alUObppwZDa2H/IOCBfk
         egrPh77z3niIctOg5AbNM2mms+XOYRjB7FSdwZX2/CbtaubAEuZb0Kwqj0YSJGTnCWL2
         KBfeWD8b8IQscdtGSwDK2Obw32QT+6YOjP0Sf7LezTfVMwcv+QwuyWYGnz++DyH8svhP
         B81JW4dk8s33lv/B39+hb3EXhL3IxFbGYD595nZse40vt1tPJyn9Fx590iUq7gnLHmcW
         rqgT1zUtyLUlpdwbiTBBJhSpi6TzeH8Om4FmsqDA2lurOVKczy4IQOXwTs1ZMnC8SdXw
         wt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S148436qoCoeK0FQGD1ySRqulS61+al7UnTKDQroX5A=;
        b=mfVPz7tDBfG2+wccnWA4tU2M4scEDJTvJahL7RE7rkIpOOaqPKBgBUrlODIsic9FMh
         p5MykV1QjswtjU+BBjPoESntgryukuM7cZpwjk5kozNPm3nPGb52YqqvIxL6ZqXGl+EB
         vUTohaGiJXV5jfIQJnpKq+XEeMcvdhd0r0HPb9W0StSluRpoEQm88muqiJhib3VO8rJW
         LtVMtmBSgCWtpAfZL53tkH/728IdqG0TVwGxutWoUIebyfjDy/PjzGzF4FabcgEFYePG
         NXwSb9vGuC+9JruY0gMZ167X3zKRX7d1PfVT1P7FZvK1aDFIdC1/VErkKfN2cr3ZZkYn
         W/bQ==
X-Gm-Message-State: APjAAAWs61FmIWtgMyWMWgVwsy2ORj2IOUOVz3JTZITipRcjRypS+XTS
        IsXurW1inW4mTXefSAcscdtjUA==
X-Google-Smtp-Source: APXvYqwtE3Xbck7VgPloCq2cjRfm2LbU/XlN4Qa84xaPHbSvg8xfBdXo/v0ThbjVrpcOi/c8dtlQZg==
X-Received: by 2002:a2e:4ca:: with SMTP id a71mr12513937ljf.39.1556031242626;
        Tue, 23 Apr 2019 07:54:02 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id b5sm3771719lfo.16.2019.04.23.07.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:54:01 -0700 (PDT)
Subject: Re: [PATCH] v4l: Add source event change for bit-depth
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190415152723.2481-1-stanimir.varbanov@linaro.org>
 <20190423064326.lbi3gfprfegqecu4@kekkonen.localdomain>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <01bc9ad3-6e62-2b24-1238-60e65ea14610@linaro.org>
Date:   Tue, 23 Apr 2019 17:54:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423064326.lbi3gfprfegqecu4@kekkonen.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sakari,

Thanks for the comments!

On 4/23/19 9:43 AM, Sakari Ailus wrote:
> Hi Stan,
> 
> On Mon, Apr 15, 2019 at 06:27:23PM +0300, Stanimir Varbanov wrote:
>> This event indicate that the source bit-depth is changed during
>> run-time. The client must get the new format and re-allocate buffers
>> for it. This can usually happens with video decoder (encoders) when
>> the bit-stream depth is changed from 8 to 10bits or vice versa.
> 
> Thanks for the patch.
> 
> How about adding an event for pixelformat change, instead of bit depth? The
> application presumably knows the formats it can work with, and can adapt to
> that as well as a change to the bit depth.

Well, I'd like to hear more opinions but in principle I'd agree with you.

<cut>

-- 
regards,
Stan
