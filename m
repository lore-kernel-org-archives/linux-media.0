Return-Path: <SRS0=xuIN=SV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E249C282DD
	for <linux-media@archiver.kernel.org>; Fri, 19 Apr 2019 00:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AAA2183F
	for <linux-media@archiver.kernel.org>; Fri, 19 Apr 2019 00:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="eJU0cEGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfDSAaq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:30:46 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:35776 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfDSAaq (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 20:30:46 -0400
Received: by mail-qk1-f170.google.com with SMTP id a71so2213651qkg.2
        for <linux-media@vger.kernel.org>; Thu, 18 Apr 2019 17:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XiYxJUvYztTXlO3krAojjt8++G0UvGCETISRSwzsE+s=;
        b=eJU0cEGzzWURhbN0YgUg5FqLZ6mMIFUjXntpBgTDvdT0tRGxP1UKmiaeFEHGsajq35
         Wfnz6/Klprgfp996o0qJlQ4TZBuCprpyqyTYa51kJxgpc03S20pzFKZMJC/VIuVOmjZS
         p1ZItnYfegIDo9PZTiofXKSUvIbGwLqW8ASa24WzsTW0C+Za6iOP1EWMF0bVC0wcpqzJ
         2CQJdWqoTBjULbw1DaSU78mvoX/f88H8wkaJWtdEOmyz1/tuDEIibddFR8YWpsaA/U/7
         EBpBuCLXQhYD05kvceongEE0sBQTFmRLB7wHbTidN8iAIhptlcwXwyFaZfOg2lYb3Veo
         ePew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XiYxJUvYztTXlO3krAojjt8++G0UvGCETISRSwzsE+s=;
        b=DM6ceT3gbJ+RjnsK50AFMsdCk1nzX5uHDTRvyV+AuvrRbDfg5FdC13pD9AtL1duw8a
         q+7TjWHa+DbYsTATgk3FjlPCVfJK89v7jTTQExGSfSWv0UTmYbf5Yp5HWkgEo3arYHLZ
         JGBvSJhxrkT1VdWpsb20hz55ivTEg4kigiYaMBiDvvfRQalC4uKZzVoxBDXQmTa9tX0E
         xwO7y8hRFHy1HQQW+lKwV4TpdXmPGg2yCOGfNeZraf3+lNtlPdLG+Z2yIge65Jgts7Wt
         MFZg9nopsXk7g/aqvWe6NSHADoJLMnbxj9PKfi9HGWAyk2lWlzf2qK1vgw3wPqeRiPpl
         TjTg==
X-Gm-Message-State: APjAAAVM8x2WNrk8yJrievrsEOioG5GtZEAmN/DyV7NwtB5rYqfM4aF8
        5O/xwIlR94TpyA4JHfL6vMFoCw==
X-Google-Smtp-Source: APXvYqztkYCmj7ITzQ3FCIAHkBldAyLkSgBcUgMNxnlgqa/t45PcRHpuvb/zf7AJTav1SAdCToImwg==
X-Received: by 2002:a37:59c5:: with SMTP id n188mr910201qkb.208.1555633844991;
        Thu, 18 Apr 2019 17:30:44 -0700 (PDT)
Received: from skullcanyon ([2002:c0de:c115:0:481e:e17e:2f68:43f8])
        by smtp.gmail.com with ESMTPSA id u15sm2242131qth.54.2019.04.18.17.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 17:30:43 -0700 (PDT)
Message-ID: <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date:   Thu, 18 Apr 2019 20:30:41 -0400
In-Reply-To: <20190418081816.GO13337@phenom.ffwll.local>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 (3.32.0-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Le jeudi 18 avril 2019 à 10:18 +0200, Daniel Vetter a écrit :
> > It would be cool if both could be used concurrently and not just return
> > -EBUSY when the device is used with the other subsystem.
> 
> We live in this world already :-) I think there's even patches (or merged
> already) to add fences to v4l, for Android.

This work is currently suspended. It will require some feature on DRM
display to really make this useful, but there is also a lot of
challanges in V4L2. In GFX space, most of the use case are about
rendering as soon as possible. Though, in multimedia we have two
problems, we need to synchronize the frame rendering with the audio,
and output buffers may comes out of order due to how video CODECs are
made.

In the first, we'd need a mechanism where we can schedule a render at a
specific time or vblank. We can of course already implement this in
software, but with fences, the scheduling would need to be done in the
driver. Then if the fence is signalled earlier, the driver should hold
on until the delay is met. If the fence got signalled late, we also
need to think of a workflow. As we can't schedule more then one render
in DRM at one time, I don't really see yet how to make that work.

For the second, it's complicated on V4L2 side. Currently we signal
buffers when they are ready in the display order. With fences, we
receive early pairs buffer and fence (in decoding order). There exist
cases where reordering is done by the driver (stateful CODEC). We
cannot schedule these immediately we would need a new mechanism to know
which one come next. If we just reuse current mechnism, it would void
the fence usage since the fence will always be signalled by the time it
reaches DRM or other v4l2 component.

There also other issues, for video capture pipeline, if you are not
rendering ASAP, you need the HW timestamp in order to schedule. Again,
we'd get the fence early, but the actual timestamp will be signalled at
the very last minutes, so we also risk of turning the fence into pure
overhead. Note that as we speak, I have colleagues who are
experimenting with frame timestamp prediction that slaves to the
effective timestamp (catching up over time). But we still have issues
when the capture driver skipped a frame (missed a capture window).


I hope this is useful reflection data,
Nicolas

