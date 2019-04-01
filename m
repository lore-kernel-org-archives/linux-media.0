Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945B3C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 07:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F37B20896
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 07:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RbqeTNoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfDAHZh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:25:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39872 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAHZh (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 03:25:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so49636otb.6
        for <linux-media@vger.kernel.org>; Mon, 01 Apr 2019 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrZdN9cAYDctsf0SmRhjAgK1SGM4CUTaKrLHqJt/9yg=;
        b=RbqeTNojv4+znZL2H5+TgG7USAZrB/II2b+HBWzd/deMxMBjoBf9Xyd0Kjk2UwWAMh
         acvv24ET/EJ5ZZdkx60BjiLqpfkIYiFP5f5i8/XYIx59C60K9MxpZa7qpKGhNxi/EAOl
         rNfNJoefVwfuQXUy3uMHs3mM/Fhkuwfwrajao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrZdN9cAYDctsf0SmRhjAgK1SGM4CUTaKrLHqJt/9yg=;
        b=ChTiwm6ncppPl/S1RlJEomyRLJ9UAVXPSpCPKAeH0d4+KOWv2TAEsyI/3/kU18xg/w
         TTJP/tD6yiuP+3zu2IFyO+3rMq3QYTwbTvDg9v9cO0GWd7ph51TqDzppuEVW/TXk/9zk
         LdVhEviHYyAUM5pmg9QEDgvHaPKDSGVYSOS5qTDbTd6tRezWYv81qk9X/d1S6FnUXxd0
         O7WOejAABhRiIfT9GnUl34/puEkwrAqIaXZTRb2wlI8ye9xh2njrOnnAHSm5W3Y9ZCDB
         K8s9B/aZGbQjnzp69uB2ONPRudSUjqH1QpM0LfJjXAJg1oc9+bnkyj9MvJcWLqlIrQGH
         Idlw==
X-Gm-Message-State: APjAAAVCKVeMk1tpg8p3TIV7ZpNOwuyIwZzckM7coffdJ6NxBytbqceS
        pW5aBo5G36eSG71g143GXcH4AnZj7MA=
X-Google-Smtp-Source: APXvYqwlWNjCffk9PaoBOZeLgbLYilOOrgjdf3RRyervfNXn4/LmFmf42A/XmPTRbZqopPMiIVAV/Q==
X-Received: by 2002:a9d:51d2:: with SMTP id d18mr16048736oth.61.1554103536579;
        Mon, 01 Apr 2019 00:25:36 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id e81sm3665087oih.40.2019.04.01.00.25.35
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 00:25:35 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id x188so6381972oia.13
        for <linux-media@vger.kernel.org>; Mon, 01 Apr 2019 00:25:35 -0700 (PDT)
X-Received: by 2002:aca:31cb:: with SMTP id x194mr12069205oix.71.1554103535586;
 Mon, 01 Apr 2019 00:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190328180704.24761-1-ezequiel@collabora.com>
In-Reply-To: <20190328180704.24761-1-ezequiel@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 1 Apr 2019 16:25:23 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWPLurnLgD5VD42yWzPD2ZcuL339-OoSz=q1K4sFOfewg@mail.gmail.com>
Message-ID: <CAPBb6MWPLurnLgD5VD42yWzPD2ZcuL339-OoSz=q1K4sFOfewg@mail.gmail.com>
Subject: Re: [PATCH 0/2] media: Introduce pixel format helpers
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Mar 29, 2019 at 3:08 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Following the "Add MPEG-2 decoding to Rockchip VPU"[1], and given we want to start
> using the pixel format helpers rather soon, I've decided to submit them separatedly.
>
> Aside from documenting the block_w and block_h, as suggested by Emil Velikov, these
> two patches are unmodified compared to v2 [1].
>
> This series contains the minimum patches to introduce the pixel format
> helpers, it currently will have no users, but we expect users to start
> popping-up soon.
> very shortly [2].

Is there anything that prevents you from moving the Rockchip drivers
to using these right after patch 2/2? IIRC that's what your MPEG-2
series did initially, and that would introduce a user immediately.
