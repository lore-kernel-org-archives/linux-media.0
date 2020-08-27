Return-Path: <SRS0=AfPA=CF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F90C433E1
	for <linux-media@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE22D2054F
	for <linux-media@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="SxZqeJxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgH0Ow1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:52:27 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:21105 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgH0OwV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 27 Aug 2020 10:52:21 -0400
Date:   Thu, 27 Aug 2020 14:52:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1598539937;
        bh=yE3GsZ9y/3e4AfJhkux+xTs/8FeXnCPJxbneuzKe2ss=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=SxZqeJxI8EU0Yvda+Tk1Iy7j1b4cDNLCzY6tNk5UrElCIry8+0vNTfFqej5zyXR1S
         tm4O+7uOCQeYweD2KzDhqQculZDXGkgqREJDSzI9buvDy7jDFoWVfvaRR3knMJA0H5
         SnXa/DxgLg3Ie6NQybMJCzTKBMEAhUS5rkqaUdqBPtanvuzff1w/FpG7WPbAT5lkBj
         M0zhYsYIjqTLKcvGzxmNPwwf0IUNzt5d1Aag4Znl2yb2T8A2QoJOU4z0i6eqDetMT9
         lNXf1nfGM4rj6d7NhktMGt6WPrOdksmjSn1wXF8tU/HByBBTskirvZMhJCDpZxaGYQ
         KBVdFAykbJPUg==
To:     Ezequiel Garcia <ezequiel@collabora.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     James Jones <jajones@nvidia.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        "nd@arm.com" <nd@arm.com>, Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Liam Mark <lmark@codeaurora.org>,
        "Andrew F . Davis" <afd@ti.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Laura Abbott <labbott@kernel.org>,
        Daniel Stone <daniels@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [RFC] Experimental DMA-BUF Device Heaps
Message-ID: <RYac-UwqFncGmZCWk713lK86adAOfMQbeT6CF15dhr1H3o-P-_tXJcwNYxM5LYqddtYe7Y7VEmbSrDe5ixtIqtHmxMkH1FfulkO4VppXGKA=@emersion.fr>
In-Reply-To: <746a0bb75bd8388a30b53a5ddc56fb24aea308a8.camel@collabora.com>
References: <20200816172246.69146-1-ezequiel@collabora.com> <20200817151813.wet5faqg4fzlfbsh@DESKTOP-E1NTVVP.localdomain> <c2450755-91fd-da72-bf1e-c015ad9d6b25@nvidia.com> <746a0bb75bd8388a30b53a5ddc56fb24aea308a8.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thursday, August 20, 2020 10:15 AM, Ezequiel Garcia <ezequiel@collabora.=
com> wrote:

> > I'm rather interested on where this goes, as I was toying with using
> > some sort of heap ID as a basis for a "device-local" constraint in the
> > memory constraints proposals Simon and I will be discussing at XDC this
> > year. It would be rather elegant if there was one type of heap ID used
> > universally throughout the kernel that could provide a unique handle fo=
r
> > the shared system memory heap(s), as well as accelerator-local heaps on
> > fancy NICs, GPUs, NN accelerators, capture devices, etc. so apps could
> > negotiate a location among themselves. This patch seems to be a step
> > towards that in a way, but I agree it would be counterproductive if a
> > bunch of devices that were using the same underlying system memory ende=
d
> > up each getting their own heap ID just because they used some SW
> > framework that worked that way.
> > Would appreciate it if you could send along a pointer to your BoF if it
> > happens!
>
> Here is it:
>
> https://linuxplumbersconf.org/event/7/contributions/818/
>
> It would be great to see you there and discuss this,
> given I was hoping we could talk about how to meet a
> userspace allocator library expectations as well.

Unfortunately there's no livestream for BoFs. Would be very interested
in having a summary of the discussions once the BoF is over!
