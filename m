Return-Path: <SRS0=OUaH=ZD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18450C43331
	for <linux-media@archiver.kernel.org>; Mon, 11 Nov 2019 03:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E2F2075C
	for <linux-media@archiver.kernel.org>; Mon, 11 Nov 2019 03:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHIHI7p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfKKDEh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:04:37 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:38767 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfKKDEh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 10 Nov 2019 22:04:37 -0500
Received: by mail-qt1-f182.google.com with SMTP id p20so14165735qtq.5
        for <linux-media@vger.kernel.org>; Sun, 10 Nov 2019 19:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s21XsScROhu9BPmbzGcegcYHTdkPFhp5GNL2cd4PxbQ=;
        b=lHIHI7p/r0giqXhBuGIZTt9zqLjVH/cm3hvX6R3JDUCmIvBCXP4RL/iU0REkYn+lJg
         VBwHj5196iFxzjLkbOlRgKQXcgu2EnT1sM8txIrRx6rt+5ofNp8ntZm9xXoA0UlKAUmz
         plhdmv76n5zJLHDJ+LnpkSGmmuBrxhE8jOyww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s21XsScROhu9BPmbzGcegcYHTdkPFhp5GNL2cd4PxbQ=;
        b=cGIXK6OhSIA5uYiV9bmD2f+t0lZWLEB1T5vd/2FG+02JWxJ6jTu2XY8FW+VyVpNf3O
         LAL2JuJlpIQG8HaB9ZLd8g/BYhcvrUwLKDhHlvVoCuuh+ifLBQvLJuwQNycDSe+8g0Ec
         sQu5KWXNHjpVsEFMws+OzBFSawqS6unZxHa45qxN2Fegfh586PbmfBFrULV3kxQLSK5Q
         PbNhbKrYlOAC8reJUEv/XtESWb/gZs167E4AVfAiXxEFlfCR6phfz5T5NsORFEruBid1
         isDEKcfzCsVlwYnZlL9JICaY3h0gwoPmy8HtOODJOwnGGsO+yuIl/GxXk2MMlacxW103
         sS3w==
X-Gm-Message-State: APjAAAVubDNu+cl4Y2Er5C8L+MZIVaY1zadpSEx3CAtDm/daHpZ6kMxx
        s6pUdlpn/t56TsmJ13amf/4wp5vrOGIzmyA1bPmaug==
X-Google-Smtp-Source: APXvYqzEgRqM2b1k3cEN4mloUeEOhrf8cOZLFKV98ttWSKpDVQ51Q/jYgDxVozA4BQjDVb9G2TwgPcL03Ye994sE63s=
X-Received: by 2002:ac8:7216:: with SMTP id a22mr23844828qtp.187.1573441476623;
 Sun, 10 Nov 2019 19:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org> <20191106084344.GB189998@stefanha-x1.localdomain>
In-Reply-To: <20191106084344.GB189998@stefanha-x1.localdomain>
From:   David Stevens <stevensd@chromium.org>
Date:   Mon, 11 Nov 2019 12:04:25 +0900
Message-ID: <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
        Alex Lau <alexlau@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Dmitry Morozov <dmitry.morozov@opensynergy.com>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

> My question would be "what is the actual problem you are trying to
> solve?".

One problem that needs to be solved is sharing buffers between
devices. With the out-of-tree Wayland device, to share virtio-gpu
buffers we've been using the virtio resource id. However, that
approach isn't necessarily the right approach, especially once there
are more devices allocating/sharing buffers. Specifically, this issue
came up in the recent RFC about adding a virtio video decoder device.

Having a centralized buffer allocator device is one way to deal with
sharing buffers, since it gives a definitive buffer identifier that
can be used by all drivers/devices to refer to the buffer. That being
said, I think the device as proposed is insufficient, as such a
centralized buffer allocator should probably be responsible for
allocating all shared buffers, not just linear guest ram buffers.

-David
