Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C673C64E75
	for <linux-media@archiver.kernel.org>; Tue, 17 Nov 2020 13:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FDD221F8
	for <linux-media@archiver.kernel.org>; Tue, 17 Nov 2020 13:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/BQRmHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbgKQNso (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 Nov 2020 08:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733157AbgKQNsl (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 Nov 2020 08:48:41 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1911A20853;
        Tue, 17 Nov 2020 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605620921;
        bh=O2dnG9MiYeM/Tg9r7aTUgzcNxnGnD8rgt5XwMutv310=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X/BQRmHMwViSIUDerXyiM3IWfwDMuAnr/wzK0lItcnIszWWdKbyGph7CXC9OH6Rr9
         9QAvspMAtZhWaCHqDaM4cinvf4Cx+3flutQSH4LJJ7XkveGeC1igyGj0p2014STO5u
         vQDWu5QqiCfxT01VC5w2TKNmmUPL0kNFHzDWhE1k=
Received: by mail-ot1-f53.google.com with SMTP id n11so19447092ota.2;
        Tue, 17 Nov 2020 05:48:41 -0800 (PST)
X-Gm-Message-State: AOAM530j6KzbwpgqkXXB1TLlqCr3S9hB9qYM3TUZ/wE+hIVnE8h5TRii
        Cevvvn7lRPp7TlwhNgcHsdummmhQmQKNtHeeWg==
X-Google-Smtp-Source: ABdhPJxLBPAQDbx83muySou//9cjTS37IimWLv3evqJKFYtBVh8RbOJ+wvGO/xFFeOyAc3mRb/Pb4PxPIOuQGti66n0=
X-Received: by 2002:a05:6830:2f8:: with SMTP id r24mr3075214ote.129.1605620920401;
 Tue, 17 Nov 2020 05:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20201112224917.165544-1-robh@kernel.org>
In-Reply-To: <20201112224917.165544-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 17 Nov 2020 07:48:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+L4TOYWLgk=_xihtw_Jxfjigbn=h3J0LLXiPrMy0gjMA@mail.gmail.com>
Message-ID: <CAL_Jsq+L4TOYWLgk=_xihtw_Jxfjigbn=h3J0LLXiPrMy0gjMA@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: coda: Add missing 'additionalProperties'
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Nov 12, 2020 at 4:49 PM Rob Herring <robh@kernel.org> wrote:
>
> 'additionalProperties' is now required by the meta-schema. Add it for
> coda.
>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/media/coda.yaml | 2 ++
>  1 file changed, 2 insertions(+)

I missed an error this introduces:

/home/rob/proj/git/linux-dt/.build-arm/Documentation/devicetree/bindings/media/coda.example.dt.yaml:
video-codec@63ff4000: 'interrupts' does not match any of the regexes:
'pinctrl-[0-9]+'
        From schema:
/home/rob/proj/git/linux-dt/Documentation/devicetree/bindings/media/coda.yaml
