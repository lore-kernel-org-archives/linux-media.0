Return-Path: <SRS0=Kl5h=Y6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D63C5DF62
	for <linux-media@archiver.kernel.org>; Wed,  6 Nov 2019 11:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57CC2173E
	for <linux-media@archiver.kernel.org>; Wed,  6 Nov 2019 11:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3Y5/K4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKFLqU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:46:20 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:44544 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfKFLqU (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 6 Nov 2019 06:46:20 -0500
Received: by mail-qv1-f51.google.com with SMTP id h3so1253927qvu.11
        for <linux-media@vger.kernel.org>; Wed, 06 Nov 2019 03:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ff4rTf71EaaA6mDalMOvcUyB0YnCYPZvyXrWDdkjzLY=;
        b=R3Y5/K4FpSGl/JBDa6luAfZN1wJEVODtQQYIXXVMud/7MFhzUyi1wNTd4CXXvspyXA
         Np1QSYFRTIpakGlS3B+TXTCXmFzGhj3QgyTrhSU19TPOsWeKjjhHhLJQlMmwWjQvg/Oa
         NlA+bQe2LTa4aSuBh+VFONS721EwkfA8b+4NJMCDozfMGD+hPkt+O6kOmiKlOio9ZrdC
         31TD57/2Qk4hA5cQxf/QaM6Csg9rP49Godm2fe+CwynOD17JK7eEigA0QrFowsgQvLgx
         DiRNcH6M7viFHn93SlGe4ireJbhRDBjy37FSiqLOoN/S8Qo40w/Puia7T+lfX/atu72z
         u1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ff4rTf71EaaA6mDalMOvcUyB0YnCYPZvyXrWDdkjzLY=;
        b=jAyYlsCMlnodhAFprOnpm1t64zw3kEAL9W8gA4CvUPBg2yYUcp/K4NBqGiH6Rk6v93
         KMxpYuyCCH89nM/m9PAHm70PwjVqsh+AAXHt8NOhzEwSl59wW9f2Bnj+rDb52m3zMu1a
         3WpfKr1sOkQ4YEE1wilEQSK9MTGq4urfmOrxDHGRQ5QcXr9jAgfUZulEgIhKjcXEXURR
         qMzOTcZNayVNGU1ZwdBL65lblgYtbInAP8WjmEkWpipHtDdpGr7hZ4l1uWM7byjH9sJP
         +XP4B+8TGj9r5KmPWEen65X6tW5DVxdPfaSjnpHu4frjNm6b8VWGBL4zMO1h46mPA9c5
         A2Kw==
X-Gm-Message-State: APjAAAU9zReuNDIp1rGUKIgz8h0fW6vRViS+q96juxN5E8RZjMELmpX5
        JMrEQnFM7CUsmqRYictDasDFeq1HviRby7DCL20=
X-Google-Smtp-Source: APXvYqxiW7m5BcPoYQedl9pTBVFzRV+opTQ9XBEb+aAhdBe/1UuZKWWxX6FmvT5qwm+9kfhdgNYpP1vfa3BNI+Y7U6I=
X-Received: by 2002:a0c:c70a:: with SMTP id w10mr1805353qvi.218.1573040779005;
 Wed, 06 Nov 2019 03:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain> <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
In-Reply-To: <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Wed, 6 Nov 2019 12:46:07 +0100
Message-ID: <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
        Alex Lau <alexlau@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Courbot <acourbot@chromium.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        David Stevens <stevensd@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
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

On Wed, Nov 6, 2019 at 10:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
> > > resources" is really a good answer for all the different use cases
> > > we have collected over time.  Maybe it is better to have a dedicated
> > > buffer sharing virtio device?  Here is the rough idea:
> >
> > My concern is that buffer sharing isn't a "device".  It's a primitive
> > used in building other devices.  When someone asks for just buffer
> > sharing it's often because they do not intend to upstream a
> > specification for their device.
>
> Well, "vsock" isn't a classic device (aka nic/storage/gpu/...) either.
> It is more a service to allow communication between host and guest

There are existing applications and network protocols that can be
easily run over virtio-vsock, virtio-net, and virtio-serial to do
useful things.

If a new device has no use except for writing a custom code, then it's
a clue that we're missing the actual use case.

In the graphics buffer sharing use case, how does the other side
determine how to interpret this data?  Shouldn't there be a VIRTIO
device spec for the messaging so compatible implementations can be
written by others?

Stefan
