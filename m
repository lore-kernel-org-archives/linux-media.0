Return-Path: <SRS0=Kl5h=Y6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D046C5DF63
	for <linux-media@archiver.kernel.org>; Wed,  6 Nov 2019 18:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ABC21848
	for <linux-media@archiver.kernel.org>; Wed,  6 Nov 2019 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573066372;
	bh=fjKtNnyNz+S6JoMlVQcHXx7cLqb0ybRjImKny3mhM6Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=L3t0soEPsdAMAS+IYcy2ZUEA7YeDgzCZOY/Tf6N5523xpBUFKbbG/YRrGlunfGaBH
	 KHRHLtpuf/ruJDGnjuLhh6LWCUqE15N+MubGaf9hOm4ukStqOJwavBM7MlNrZaST25
	 Joxz9us6uYPUX7NIxLwQ1aa75PpdXPI52xjcFQ24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfKFSwp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:52:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44127 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfKFSwp (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 6 Nov 2019 13:52:45 -0500
Received: by mail-io1-f65.google.com with SMTP id w12so28130737iol.11
        for <linux-media@vger.kernel.org>; Wed, 06 Nov 2019 10:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ZzLR2F6tfjOhdzyMma7tGcYKCX8XKZyirBptOmBxKs=;
        b=GA1ySZuvdUORrM1Qq8tw6QmDRnjqEHfhR/MoQ94qfNvEfKgoSJCgMWeTYHca5LQxCg
         5Bntq3f4KZ2Iwq3L75238zCqZjZM9EDpXCJSmvSkSdpG0hZD1DOzVaczwRwVDYV9jxlU
         46PJZhKEV20NdekLqEhWcVIbahBVAbmRwH2+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ZzLR2F6tfjOhdzyMma7tGcYKCX8XKZyirBptOmBxKs=;
        b=t52gGx3g++8gqmuMP0bE0DAO+mRpqmBYg0RcENZG2rFp+Cmq2zGTOc8dWc6jzMaS9f
         B+RfF4HqrY7PZe0t+D+gBI8FGcvluBidgmnB/ZURTs4m/mvIl+aqiNQZYiQcR8SXyslO
         NV5E7i15V7pPx3XibEfVwCwLlJh1DoSRfwQ9KEEp2Lf0DlUH3PNmFgiQAQrTgWgMTdwk
         W1BYk5tURtvx5TbGlgBGYL312Z2OaljIeKVkGa44CYyyqZhfC1Cn6XjPNDjiNbt0OPHs
         /+9mJV/wTyJvIQUCzur+a5rb9hdgkxXRy3abc8VqSQFQ8kOrm/T4FAq8aLLW7ZzsgNry
         0zPQ==
X-Gm-Message-State: APjAAAXSzjHj9cktkh0gfOr31ylmRwHn4vunjH2BFKsOW98sfOZZFj80
        7/TB/h78/rkmfLODprdqAintNg==
X-Google-Smtp-Source: APXvYqy30aHLB5dpLSN1yJ4la5hl9Fe1NLhLQ35UtpfuJel5YqdqGeLM4v5Xep72MPPY0QG18Oo8Yw==
X-Received: by 2002:a6b:39d5:: with SMTP id g204mr34340025ioa.279.1573066364331;
        Wed, 06 Nov 2019 10:52:44 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h14sm348153ilc.87.2019.11.06.10.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:52:43 -0800 (PST)
Subject: Re: [PATCH] media: dvb_dummy_fe: place EXPORT_SYMBOL below
 corresponding function
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, mchehab@kernel.org,
        rfontana@redhat.com, gregkh@linuxfoundation.org,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        tglx@linutronix.de
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191106183716.29170-1-dwlsalmeida@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <543fdbda-22ca-617a-952c-3707e0b288b4@linuxfoundation.org>
Date:   Wed, 6 Nov 2019 11:52:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106183716.29170-1-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 11/6/19 11:37 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 

You are missing the commit message. :)

> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>   drivers/media/dvb-frontends/dvb_dummy_fe.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/dvb_dummy_fe.c b/drivers/media/dvb-frontends/dvb_dummy_fe.c
> index 4db679cb70ad..909dac2345c4 100644
> --- a/drivers/media/dvb-frontends/dvb_dummy_fe.c
> +++ b/drivers/media/dvb-frontends/dvb_dummy_fe.c
> @@ -121,6 +121,7 @@ struct dvb_frontend* dvb_dummy_fe_ofdm_attach(void)
>   	state->frontend.demodulator_priv = state;
>   	return &state->frontend;
>   }
> +EXPORT_SYMBOL(dvb_dummy_fe_ofdm_attach);
>   
>   static const struct dvb_frontend_ops dvb_dummy_fe_qpsk_ops;
>   
> @@ -138,6 +139,7 @@ struct dvb_frontend *dvb_dummy_fe_qpsk_attach(void)
>   	state->frontend.demodulator_priv = state;
>   	return &state->frontend;
>   }
> +EXPORT_SYMBOL(dvb_dummy_fe_qpsk_attach);
>   
>   static const struct dvb_frontend_ops dvb_dummy_fe_qam_ops;
>   
> @@ -155,6 +157,7 @@ struct dvb_frontend *dvb_dummy_fe_qam_attach(void)
>   	state->frontend.demodulator_priv = state;
>   	return &state->frontend;
>   }
> +EXPORT_SYMBOL(dvb_dummy_fe_qam_attach);
>   
>   static const struct dvb_frontend_ops dvb_dummy_fe_ofdm_ops = {
>   	.delsys = { SYS_DVBT },
> @@ -253,7 +256,3 @@ static const struct dvb_frontend_ops dvb_dummy_fe_qpsk_ops = {
>   MODULE_DESCRIPTION("DVB DUMMY Frontend");
>   MODULE_AUTHOR("Emard");
>   MODULE_LICENSE("GPL");
> -
> -EXPORT_SYMBOL(dvb_dummy_fe_ofdm_attach);
> -EXPORT_SYMBOL(dvb_dummy_fe_qam_attach);
> -EXPORT_SYMBOL(dvb_dummy_fe_qpsk_attach);
> 

