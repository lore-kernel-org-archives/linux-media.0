Return-Path: <SRS0=xuIN=SV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE5C282DA
	for <linux-media@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B3020643
	for <linux-media@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWLF/zTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfDSTEw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:52 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40003 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfDSTEu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 19 Apr 2019 15:04:50 -0400
Received: by mail-oi1-f176.google.com with SMTP id f196so4598669oib.7
        for <linux-media@vger.kernel.org>; Fri, 19 Apr 2019 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=clo+kiAhMVtl/eXKgiPzSD53WQkhiMDT1nX2jh5dhLg=;
        b=JWLF/zTSOG3UTQfuwm4tf+fo9Z+oPu/GOCm+KykhNMfrnav0ThzdWKqtu47jK+qUyL
         NLcyYXL2YHXwx54wNOYo9MJRGbOv5lrDAZNYxTc/d5lw2lokla3/lIhiQCgDdMeykcOb
         WiuXHcn6KgN9NvaN30qIOzhXDCy89Nl7CeMLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=clo+kiAhMVtl/eXKgiPzSD53WQkhiMDT1nX2jh5dhLg=;
        b=kZgj0bDmDSCwECxKqDIDX7YWl9kmd3VkRUY44mllEgpQ0i24ty/INvIZOIleuL5LMU
         Q9yPJW6NOF+iSdeTMcXHpVuK7aTNyWjqodu46fqjJJjBLwpAdrjsZoRyN6uPwDRlOeZz
         1/S9bRfgcp7E+uRMDzT1ZNK7dI90aJEpxgr686MKf7lEfmXXu5zgSdc253+Vw5fDLxBt
         xQhRyPC4krQ2KDVgw5FaLQ9IqLcl02onfZSySBdrEgL0a8PGm3DSZZ7gcRsdl3UR/wdA
         x/XGOscu6/BGYJ6PUVN9IrubLywt/toUk7EGF8eAi/KJtouIdHBO4m5CSzqDqLsxW1oO
         ZuQw==
X-Gm-Message-State: APjAAAU7KSWpdmCAv/ZhKJhM9+CEQEA0AYoTPX19y+7AeccmX091ROKB
        adP7WUbDmIzWRqlyUx8U3aL1vOViSXk=
X-Google-Smtp-Source: APXvYqzWk2dxlDHEMQO2Gk23TMo0NMZOI9Kw8OWFI5fvdU7XzOV4LGtLatIFd3efrjrYuu7eX5xEuQ==
X-Received: by 2002:aca:6c47:: with SMTP id h68mr849269oic.57.1555648049571;
        Thu, 18 Apr 2019 21:27:29 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id o16sm1612590ota.15.2019.04.18.21.27.28
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 21:27:28 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id f10so3489566otb.6
        for <linux-media@vger.kernel.org>; Thu, 18 Apr 2019 21:27:28 -0700 (PDT)
X-Received: by 2002:a05:6830:15d4:: with SMTP id j20mr902735otr.367.1555648047603;
 Thu, 18 Apr 2019 21:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
 <20190418081816.GO13337@phenom.ffwll.local> <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
In-Reply-To: <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 19 Apr 2019 13:27:15 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CojNuiJ09gXEjnOorfDnRP1Bk436yaffHFKmmsfoUiQQ@mail.gmail.com>
Message-ID: <CAAFQd5CojNuiJ09gXEjnOorfDnRP1Bk436yaffHFKmmsfoUiQQ@mail.gmail.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Apr 19, 2019 at 9:30 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le jeudi 18 avril 2019 =C3=A0 10:18 +0200, Daniel Vetter a =C3=A9crit :
> > > It would be cool if both could be used concurrently and not just retu=
rn
> > > -EBUSY when the device is used with the other subsystem.
> >
> > We live in this world already :-) I think there's even patches (or merg=
ed
> > already) to add fences to v4l, for Android.
>
> This work is currently suspended. It will require some feature on DRM
> display to really make this useful, but there is also a lot of
> challanges in V4L2. In GFX space, most of the use case are about
> rendering as soon as possible. Though, in multimedia we have two
> problems, we need to synchronize the frame rendering with the audio,
> and output buffers may comes out of order due to how video CODECs are
> made.
>
> In the first, we'd need a mechanism where we can schedule a render at a
> specific time or vblank. We can of course already implement this in
> software, but with fences, the scheduling would need to be done in the
> driver. Then if the fence is signalled earlier, the driver should hold
> on until the delay is met. If the fence got signalled late, we also
> need to think of a workflow. As we can't schedule more then one render
> in DRM at one time, I don't really see yet how to make that work.
>
> For the second, it's complicated on V4L2 side. Currently we signal
> buffers when they are ready in the display order. With fences, we
> receive early pairs buffer and fence (in decoding order). There exist
> cases where reordering is done by the driver (stateful CODEC). We
> cannot schedule these immediately we would need a new mechanism to know
> which one come next. If we just reuse current mechnism, it would void
> the fence usage since the fence will always be signalled by the time it
> reaches DRM or other v4l2 component.
>
> There also other issues, for video capture pipeline, if you are not
> rendering ASAP, you need the HW timestamp in order to schedule. Again,
> we'd get the fence early, but the actual timestamp will be signalled at
> the very last minutes, so we also risk of turning the fence into pure
> overhead. Note that as we speak, I have colleagues who are
> experimenting with frame timestamp prediction that slaves to the
> effective timestamp (catching up over time). But we still have issues
> when the capture driver skipped a frame (missed a capture window).

Note that a fence has a timestamp internally and it can be queried for
it from the user space if exposed as a sync file:
https://elixir.bootlin.com/linux/v5.1-rc5/source/drivers/dma-buf/sync_file.=
c#L386

Fences in V4L2 would be also useful for stateless decoders and any
mem-to-mem processors that operate in order, like the blitters
mentioned here or actually camera ISPs, which can be often chained
into relatively sophisticated pipelines.

Best regards,
Tomasz
