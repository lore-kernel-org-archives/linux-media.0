Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43606C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 19:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124312087F
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 19:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a4qXK+JO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDHTFD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:05:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38553 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHTFD (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 15:05:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so17731874wro.5
        for <linux-media@vger.kernel.org>; Mon, 08 Apr 2019 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EsMbL9Tg5cG6wiy+N2FRZhbzEGbbMI1PVopZiJtZmug=;
        b=a4qXK+JOgjh8yqBqBRkYapQsLCSnAY+upibAZaX040XO5x/kmgGYM2e3y5IXGzxDvD
         fODXu7TCQjFdY6yjWWREtI4Px1mc0ZRlf0oXPpc3aAaavAq7Af8OiTNaXG+BrLFaEe88
         Bu5zFFZMEBY6/2NGwEDU0zvPJZD3hSbSuIjPhNvumpf7huw8RaKjMhnzYGA2pczMTcwv
         9JhSA0MZlvBqgygaNn7f3n8dLa0kQl4xLT4jZxqbqCh19a7vSwGXBa2seSnUB0y7nWRp
         X+olkOYv/F56VBkChgDI9qYM8HlMPNsGIFcarXpSL7edpzibpg4cRZTVMsQMUAXp7G62
         ERqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EsMbL9Tg5cG6wiy+N2FRZhbzEGbbMI1PVopZiJtZmug=;
        b=oYK/GQI+JymcSvhR81BUWiOFaNvoQhje5TnlQ1FujbUn8X8M/ZRprx5WQbxNmlwld7
         ie00RIrI61SDJ2nfq49i6TBFtwTjVYHNOs4ZhaF1osz/SmeE78ASLhhA3l8Ddi1+nGwL
         kNSmxXMNEChGTbm254M7W1D6Cw8+3B9/GstqynRb4EL1uga7Fwj6c4khzyK70NGM5O5m
         w4sDjLN46vUlQLyLpuDrKY1nEcoFXZ9/oHsPO3KTT/c78fATEMeLz1YTm96ftCcmtjuM
         J1cranMvvw0m4MgZvjc1plbfJhfVA6WkXr0RGnfrQd2DKAbuppcpHYSrZfMi5NF86S+z
         dJ/w==
X-Gm-Message-State: APjAAAXZDHoDiM6zO0pv9K/DWtCP07XjXEqAahKtHAeW35jPm4AF5k24
        W5cHQVpoxSRNarRLsg9VsNC/lu/e
X-Google-Smtp-Source: APXvYqyd3sFGhM1wJvDo+kte5ERfvgUSbnTH3jxNhn+Gy66smCjoteQiXjVZqR+Cp9ZHncE6pbuEzA==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr32455wrj.16.1554750298466;
        Mon, 08 Apr 2019 12:04:58 -0700 (PDT)
Received: from ?IPv6:2a02:810a:8340:5f04:9cb:e3c8:5407:b730? ([2a02:810a:8340:5f04:9cb:e3c8:5407:b730])
        by smtp.gmail.com with ESMTPSA id f15sm36960729wru.21.2019.04.08.12.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:04:57 -0700 (PDT)
Subject: Re: missing patch on v4l-utils-1.14 / 1.16
From:   Gregor Jasny <gjasny@googlemail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <24ef8046-1b38-6c87-4437-fe0187f98a0a@googlemail.com>
Message-ID: <cc7fce0b-8db0-ce2c-e7f0-c6d39f7690c9@googlemail.com>
Date:   Mon, 8 Apr 2019 21:04:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <24ef8046-1b38-6c87-4437-fe0187f98a0a@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

It seems that commit 6e21f6f34c1d7c3a7a059062e1ddd9705c984e2c is also 
missing on 1.16 (in addition to 1.14). Otherwise the return paths are 
still messed up:

> 	ret = dvb_fe_open_fname(parms, dvb_dev->path, flags);
> 	if (ret < 0) {
> 		free(parms);   <--- double free if returned via FE_GET_INFO error path
> 		return NULL;
> 	}
> 
> 	return &parms->p;
> }
> 
> int dvb_fe_open_fname(struct dvb_v5_fe_parms_priv *parms, char *fname,
> 		      int flags)
> {
> 	...
> 
> 	if (xioctl(fd, FE_GET_INFO, &parms->p.info) == -1) {
> 		dvb_perror("FE_GET_INFO");
> 		dvb_v5_free(parms);
> 		close(fd);
> 		free(fname);
> 		return -errno;
> 	}

For 1.16 I was first fooled by the commit date of August 7th which 
should be before 1.16 branch off. But the commit was only applied in 
November and missed 1.16.

If you agree that the pathc is missing, please cherry-pick it to the two 
branches.

Thanks,
Gregor
