Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C4BC433FE
	for <linux-media@archiver.kernel.org>; Mon, 28 Nov 2022 11:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiK1L4l (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 28 Nov 2022 06:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiK1L4k (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 28 Nov 2022 06:56:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C5183B3
        for <linux-media@vger.kernel.org>; Mon, 28 Nov 2022 03:56:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CFAFB80D62
        for <linux-media@vger.kernel.org>; Mon, 28 Nov 2022 11:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B61C433D6;
        Mon, 28 Nov 2022 11:56:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fyB1KXnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669636593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eoB4MNqfSM1r/Bjb/EmPzrKjzdyVGu61+Oo3gln6+QI=;
        b=fyB1KXnPXGvUS5p0oDyUOUAENKP/c99F1MkmfAz/2MtUt7NpRT6m4dQCnLNHw+Ae93buny
        s3qX/YzYo+7MuGCkS6nYrB5/Xg2uGGwCBN12cEE7ruGI1r077W/EgXusu43OrokQLyecaG
        lFuvKaKYPlRvZPC9wPnEnCz5MXzU+fY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b00457f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 11:56:33 +0000 (UTC)
Date:   Mon, 28 Nov 2022 12:56:29 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL FOR v6.2] Various fixes and enhancements
Message-ID: <Y4Sh7W1qlljoD7vf@zx2c4.com>
References: <ac74fda5-4160-1cd7-4ce1-bb8ad64aed51@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac74fda5-4160-1cd7-4ce1-bb8ad64aed51@xs4all.nl>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Nov 28, 2022 at 11:04:51AM +0100, Hans Verkuil wrote:
> The following changes since commit 3ab848bea7790583674a0e08eb5f8c1553d07751:
> 
>   media: dt-bindings: s5p-mfc: Add new compatible string for Exynos3250 SoC (2022-11-25 11:33:17 +0000)
> 
> are available in the Git repository at:
> 
>   git://linuxtv.org/hverkuil/media_tree.git tags/br-v6.2i

> Jason A. Donenfeld (1):
>       media: stv0288: use explicitly signed char

If this is for 6.2, rather than as a bug fix for 6.1, then please drop
it from this pull, and I'll include it as part of the pull of all of
these -funsigned-char fixes for 6.2, per Linus' request.

Note that I sent this for 6.1 and followed up on it several times, but
my emails went entirely ignored, and then today I found this in my inbox,
not because I was CC'd but because my lore search matches on my last
name. During that time, I regularly checked the linux-media tree to see
if you had applied it silently, but that also wasn't the case. So I'm
pretty sure the "confusion" here is entirely on you for ignoring emails
and not communicating.

So, anyway, please remove this patch from your pull.

Thanks,
Jason
