Return-Path: <SRS0=s/rb=VV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178B0C7618B
	for <linux-media@archiver.kernel.org>; Wed, 24 Jul 2019 12:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD65F229F3
	for <linux-media@archiver.kernel.org>; Wed, 24 Jul 2019 12:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG5D0M3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfGXMsZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:48:25 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:41102 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfGXMsZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Jul 2019 08:48:25 -0400
Received: by mail-pg1-f181.google.com with SMTP id x15so10845590pgg.8
        for <linux-media@vger.kernel.org>; Wed, 24 Jul 2019 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zgX6IF/28FzU6zRIbCot5RMeZIH0cBCyz47LfCACdF4=;
        b=AG5D0M3i3L0weJea2rrsZhNAYfMIX23qau5aE+/bexZDiKRiPnwohzTCRRWtiUrAK/
         j5JEjrdicZN1aHJT19EsRWekmAsD0YrOz3vPhN50kZOrkEd+iaSbO7oijTH8EIQCO1Yh
         +/IcrywMmVXsAyQNDhULgZX0J3VsINP78arL32zd6ik+NHEPQaB5BG3/dC55u7oLmM5u
         43/YrBAOVJsiln5NiQ77nYXFQKgFiQgWaL0HAnfzk2BvpJQx56weoEa77Ok8XFK4fzPP
         i3KMu+Neq6+k35fvRc5r3VU9qRjczjV6TYxRZlVW1RmqVbe3THYC0FOLMRLjBclw6TSA
         E8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zgX6IF/28FzU6zRIbCot5RMeZIH0cBCyz47LfCACdF4=;
        b=b0hs6dKRguEYbHBZ4hz90pugxV79TI9428w73m6Oc1b9EaF91rhNrKts27M1XCJhYQ
         OmHzOqD49uC5OE2KFXBPH1gZ2IIh/bzwPRuCbrmWqAx5X5oXkbd1zStQTQDm3Ajee2jv
         LpvPNP6RBvguRZMdmH3bSV5EsyVTF32BBlJaeuhZ5HNb0G20wIUEQmdEelc2mP1+rs4P
         hS+t7UL4SkYtMmW4znU1DCJiNLHsW8tJ2DhkvK4coN94CgtvgLZOiqLnm/6OAAwk8PNf
         ff+4QNFrOrxUIOExurCDEF2UDo8wrkXlxmOLhnBieEjXwrM4HrwgUGfFpptlHFXcEhTz
         dzpQ==
X-Gm-Message-State: APjAAAW53S2n8nys21aLapmTL5YpSkASdCSHIJnIInFRwtE2Fm48FYCf
        JwTgZHqKiIuU8cOWigixtgI=
X-Google-Smtp-Source: APXvYqx7IxUb2/o/pLcXLFKkejRX340ibhHw0zf2xM1Ak3uPu8YDJ7X5DAHajzXsn4Og8+A4gLegVw==
X-Received: by 2002:a17:90a:1904:: with SMTP id 4mr89875496pjg.116.1563972504682;
        Wed, 24 Jul 2019 05:48:24 -0700 (PDT)
Received: from [192.168.1.4] (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id g1sm82517145pgg.27.2019.07.24.05.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 05:48:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: tw686x driver (continued)
From:   =?utf-8?Q?Mark_Balan=C3=A7ian?= <mbalant3@gmail.com>
In-Reply-To: <35ebabef-46cc-f4d0-3e88-3d8f4243c685@gmail.com>
Date:   Wed, 24 Jul 2019 05:48:20 -0700
Cc:     linux-media@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7BAE3CA-CBD2-48F9-AD49-7C0DB7A18A76@gmail.com>
References: <84ab52c4-9ea7-c526-c628-47d678ccf926@gmail.com>
 <CAAEAJfDgEVMWbYkEaVp0mp4hQXbhZq8xJQM8xqCXGmyq7OaP9w@mail.gmail.com>
 <2586e6ca-da28-ac87-35dc-dfa6ae66f67d@gmail.com>
 <35ebabef-46cc-f4d0-3e88-3d8f4243c685@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

TBH though, I=E2=80=99m not sure about the tw686x_init  going to the =
error: label though, so am curious as to your thoughts on this as well. =
It was just something I thought might be occurring due to the fact that =
the error trace in our tool ends in tw686x_memcpy_dma_free (i.e. =
dma_ops->free).

Please see the other indications I made toward the codes of =
tw686x-core.c and tw686x-audio.c in the message below.

Thank you,
Mark

> On Jul 24, 2019, at 5:25 AM, Mark Balan=C3=A7ian <mbalant3@gmail.com> =
wrote:
>=20
> Hi Ezequiel,
>=20
> (sorry didn't include linux-media in first email)
> I'm not sure yet if I have my supervisor's permission to declare our =
tool as open source, but I'll tell you the possible code paths that I =
think may be leading our tool to think what it's thinking.
>=20
> First off, it detects a write access to desc->virt without locks =
inside tw686x_memcpy_data_free, after it is called in the calling chain =
tw686x_probe -> allocate an interrupt line -> tw686x_video_init -> =
tw686x_set_format -> tw686x_memcpy_dma_free. Further, =
spin_lock_init(&dev->lock) (line 319 of tw686x-core.c) isn't =
correspondingly closed in the function. Is this intended?
>=20
> Second, there is a possibility according to how I have traced a call =
chain that tw686x_init is going to the error: label since =
tw686x_memcpy_dma_free is getting called inside another possible calling =
chain, going tw686x_init -> tw686x_video_free (error: label) -> =
dma_ops->free (i.e. tw686x_memcpy_dma_free). I would assume this would =
not be intended either.
>=20
> In addition, our tool detects a read access without locks to =
desc->virt inside tw686x_audio_irq (line 72 of tw686x-audio.c). Not sure =
what you make of that, but I'd be keen on hearing about that as well =
from you.
>=20
> Thank you in advance,
>=20
> Mark

