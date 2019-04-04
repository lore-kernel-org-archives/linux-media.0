Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C378C4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 15:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCD22147C
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZTMw2wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfDDPTq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:19:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45921 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfDDPTq (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 11:19:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so2645186otk.12
        for <linux-media@vger.kernel.org>; Thu, 04 Apr 2019 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9wNri0HbV+hhStT4ZUvxxFYKpQ98Y0qveQ4O/Xlaxw=;
        b=LZTMw2wmA5zGms3gBu+Y1VjabU/PfiR4uLx5en5HXqN0V634KwHgnMn2IZSJQFT7w7
         9TcWg+QPOjevlhwe4sSlpmwO/+vpmLY0Wma146a7GZxSntOgnIta2Lzv7zQ8abgra+0I
         zkOzoqI05xM3u95S3CdVzEPINfkqkkTPxbreeAlH20oS2mx8TiaC9dktoIcG/7MPqUUr
         L4hkDP0OcuJu+g8vtpyv5xdVl3pZuxQA3PTHNxwEo1DzK60/pdlnimyFvLJqXlrzHfK6
         /jvT3z6DkRZ4TwF109UiJ0PHddIHsjZFidQazBpvSgjsC5vw9oIrvhqbSGyP/CqprKBN
         O4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9wNri0HbV+hhStT4ZUvxxFYKpQ98Y0qveQ4O/Xlaxw=;
        b=GanpQMArdy1xD3/lt/LUquL+3fBVVyQ7sIrOuKfmXGC9FpTn3ItECFEkHAb6eR4D7t
         OPXz6u88hrm9bQ2oi7GTGiZepcZo8kAOg04JqQaDakJr7z8x/Dx1OsTAfQ90PAjloKPo
         tZihNmHUE5YC4ZJG6KXOof3TVyfuJjeAZadC31rI+l/D7lbNH2Hnkukjd1Dt679VH38w
         SLKQaTsfioL+YK7G/0GPnuHWRWPX+MY5qGtf6UAcldccja26T7k2PqFwkRbg5zfBuxnA
         Tecrxe8Jv4X5f61FyTnV8nByjRh3cDa8KHCcF7CkcJaJtL/2bTfFgKEDwgJyjrKev2Gy
         ByAA==
X-Gm-Message-State: APjAAAVhiybo87FoUn6+u0sh0+WwEu4S0OjBYDRY4xBkGcNjcIQPJW/R
        HFuxrT5dc/Tcv5aWHke0ictQAGr5Hitd1q9jNnZ8neCB
X-Google-Smtp-Source: APXvYqwSJX84Xqm0NXjKe8tGFn/L/2HrBx/ZtRQL5TNtA4SihXGxKdcMfC8nZSFKHpPKOYXUWh9kSNurNGDXwkNmAfo=
X-Received: by 2002:a9d:7f90:: with SMTP id t16mr4856953otp.9.1554391185790;
 Thu, 04 Apr 2019 08:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <1553954492-24982-1-git-send-email-akinobu.mita@gmail.com> <1553954492-24982-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1553954492-24982-3-git-send-email-akinobu.mita@gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 4 Apr 2019 16:19:19 +0100
Message-ID: <CA+V-a8sSXCKwm-B2p0gwDuph1T869ZrM120Pf-w5Bhh4FBMJbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: ov2659: fix unbalanced mutex_lock/unlock
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Akinobu,

Thanks for the patch.

On Sat, Mar 30, 2019 at 2:01 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> Avoid returning with mutex locked.
>
> Fixes: fa8cb6444c32 ("[media] ov2659: Don't depend on subdev API")
> Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/media/i2c/ov2659.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad

> diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
> index a1e9a98..5ed2413 100644
> --- a/drivers/media/i2c/ov2659.c
> +++ b/drivers/media/i2c/ov2659.c
> @@ -1132,7 +1132,7 @@ static int ov2659_set_fmt(struct v4l2_subdev *sd,
>                 mf = v4l2_subdev_get_try_format(sd, cfg, fmt->pad);
>                 *mf = fmt->format;
>  #else
> -               return -ENOTTY;
> +               ret = -ENOTTY;
>  #endif
>         } else {
>                 s64 val;
> --
> 2.7.4
>
