Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E322C64E7C
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 10:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EDA20708
	for <linux-media@archiver.kernel.org>; Tue, 24 Nov 2020 10:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdMmPcjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbgKXKUs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbgKXKUg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:36 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E471C0613D6
        for <linux-media@vger.kernel.org>; Tue, 24 Nov 2020 02:20:36 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t8so18041037pfg.8
        for <linux-media@vger.kernel.org>; Tue, 24 Nov 2020 02:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aa9wVaM8Q5G5htOYE8QAYbIy5Fdksi5AaGTsBR4y4oA=;
        b=cdMmPcjltFHlpI6gksl2/fIsFh/bq+VaUHcbdhE/devIEAQmawCgLno2bE6iZ7pIce
         5cIF64CvU29pPHCIGXWjf6jAa7fPaV9sl1tES5Zb5qQrsQ8Xm+HDvr2OhbE0lveavydv
         6xhsUSzwQLPbbIesaT90J5mN0Dj/SVpeghm9DCXXtzrr85HvMF2vyDQAqURubBqr9eo0
         9Q+UjnYOinXTRh5JM0BR4NmMlfZBHbHhOvfWfuJas3glKPaJ6peSQXvdtvl4AwkteVZ2
         XRKYYnujZvkWcQKfD7U/G1siM1Op+vGF5ZePDaGyXwnO++V7NlcAYHf3w7tebfffIgOE
         T1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aa9wVaM8Q5G5htOYE8QAYbIy5Fdksi5AaGTsBR4y4oA=;
        b=mb0TVJrCIwWV06Bmr2yyI1L33uKFnvgPMVeosZ0xmDnX764N1AfTA/lOMmLl2u9z2k
         W95l7aCctEA2zh3N5RqXGY0YUg/xsM2dCrf2mCMwnKySM+S+M6+W2qBm4igQrN5B+azb
         C4NNPYpi7LUH8euvtlOanYvEFjh/XyjYpFBel5JBw2V2nuz/etHuaARipjG2ghteCJSQ
         UhfCuLxGxvbPsz9EfQr0CQjlVK7a/V+/WHzcOhjHkvhc9CZQFR8z7BHw4aAlK0ZfiG+i
         aqVFIzGQR7RO5H06LfKUSC6E02dHjOSr53hwHIldXNIpbqRfmghgyqky2uDpsgzrC8VF
         lWCA==
X-Gm-Message-State: AOAM5326obkCcCssMY86Qme0K9xGysDfD4oI+EEVCq5y4NTkDHlOGbzs
        fjjOUcO43uew+PUvSj6tUvGU3oLco1l3BP1nmNlbXw==
X-Google-Smtp-Source: ABdhPJxHor7IGuJelK1d4M+d7EIxn6vn8x+okbkfDnW+bIIWQwIOXtmWu92du9sRke6kFN6MNd/ZNf4uAIV6Li8N/8c=
X-Received: by 2002:a17:90a:e604:: with SMTP id j4mr4166491pjy.19.1606213236082;
 Tue, 24 Nov 2020 02:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20201116155008.118124-1-robert.foss@linaro.org> <cf0b935d-3ccd-8360-1b52-89fab0b181eb@linux.intel.com>
In-Reply-To: <cf0b935d-3ccd-8360-1b52-89fab0b181eb@linux.intel.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 24 Nov 2020 11:20:25 +0100
Message-ID: <CAG3jFyssMMHpi4WgWmeDjuVYKz12UwJoBT0WoOsdB4PZxnuqSw@mail.gmail.com>
Subject: Re: [PATCH] media: ov8856: Remove 3280x2464 mode
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ben Kao <ben.kao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 24 Nov 2020 at 10:42, Bingbu Cao <bingbu.cao@linux.intel.com> wrote:
>
> Hi, Robert
>
> I remember that the full size of ov8856 image sensor is 3296x2480 and we can get the 3280x2464
> frames based on current settings.
>
> Do you have any issues with this mode?

As far as I can tell using the 3280x2464 mode actually yields an
output resolution that is 3264x2448.

What does your hardware setup look like? And which revision of the
sensor are you using?
