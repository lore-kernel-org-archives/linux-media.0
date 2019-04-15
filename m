Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B49C10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3B620848
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 09:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fleTutgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfDOJ3F (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:29:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34483 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOJ3F (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 05:29:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id v10so13190846oib.1
        for <linux-media@vger.kernel.org>; Mon, 15 Apr 2019 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRJTvngmKVDUl4ZyXiSa1t4KkndLQwEm0Ftc9clgVwQ=;
        b=fleTutgjZszjTPxUQU0Llnb6Kqj0N9/O4x2tUXxhAmWu3QJEvlUD7q0AtxHDKde/oq
         dNSvwsPuMNwI8N4qKRu/n9nSFmzjeUrqUeaD5lOGJRXcEFtLHsP+oPgbMkW8clKumu5n
         wUT0YF9ZG3pT1XSQ6M2vr1Ok/0yye9YRDjQrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRJTvngmKVDUl4ZyXiSa1t4KkndLQwEm0Ftc9clgVwQ=;
        b=e/VsZ2nmzEcJcSpfn7DKoCSIt2oUcNfik6ti0OT0FxG/8bxlXi6Dw83SWTmJ+Kri4o
         ZlkUl0tDQcjek8Gu+z2ueJTihqYdvSzs8J8h8RdouufqekY6eS1Uiox7c2W0P5x+xMrt
         djJhey5n/Mc+br8vxLzd+8qCvI7iBm/Lls+9i18oPgETAzTkWimOA/Oq/aRu2eYQKOf+
         99hW+lRwYC0QCUaU5sdZCrVa3uscGwX+Ia9CEUaAKI1Da/Qpd3zGkKeQZe+GAQ5LrE4+
         qPvxm4CryocSNKs60ivIdb9Jzj7NHtXatxCaF9SQ50L57PtgCm9fQuHmLg6V92Tlkvco
         tUqA==
X-Gm-Message-State: APjAAAUeV5zcj0ZTUqnHLEgDyoGneekCBenwJabmAAKgiAyNXE50ehKe
        aQUuMdQNtZzBIoyb5wNz47QXKXxZkBWtpw==
X-Google-Smtp-Source: APXvYqyVKe24FWlp7TtpagXrjW2dkgL9OyNGELobO5gPIwtxBAtmf4XXoCI7DlkxAag/EhpX/1EUHw==
X-Received: by 2002:aca:e186:: with SMTP id y128mr11392399oig.9.1555320543819;
        Mon, 15 Apr 2019 02:29:03 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id y129sm18455756oig.27.2019.04.15.02.29.02
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 02:29:03 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 103so13799443otd.9
        for <linux-media@vger.kernel.org>; Mon, 15 Apr 2019 02:29:02 -0700 (PDT)
X-Received: by 2002:a9d:6206:: with SMTP id g6mr45965501otj.7.1555320542425;
 Mon, 15 Apr 2019 02:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <1553252826-15830-1-git-send-email-bingbu.cao@intel.com>
In-Reply-To: <1553252826-15830-1-git-send-email-bingbu.cao@intel.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 15 Apr 2019 18:28:51 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BJXBYZDc58M=-OMQs5=m2QpiYJ3dnpoNW_-hEz1J5_7g@mail.gmail.com>
Message-ID: <CAAFQd5BJXBYZDc58M=-OMQs5=m2QpiYJ3dnpoNW_-hEz1J5_7g@mail.gmail.com>
Subject: Re: [PATCH v2] media:staging/intel-ipu3: parameter buffer refactoring
To:     Cao Bing Bu <bingbu.cao@intel.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@linux.intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Bingbu,

On Fri, Mar 22, 2019 at 8:00 PM <bingbu.cao@intel.com> wrote:
>
> From: Bingbu Cao <bingbu.cao@intel.com>
>
> Current ImgU driver processes and releases the parameter buffer
> immediately after queued from user. This does not align with other
> image buffers which are grouped in sets and used for the same frame.
> If user queues multiple parameter buffers continuously, only the last
> one will take effect.
> To make consistent buffers usage, this patch changes the parameter
> buffer handling and group parameter buffer with other image buffers
> for each frame.
> Each time driver will queue one more group of buffers when previous
> frame processed and buffers consumed by css.
>
> Signed-off-by: Tianshu Qiu <tian.shu.qiu@intel.com>
> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> ---
>  drivers/staging/media/ipu3/ipu3-css.c  |  5 ----
>  drivers/staging/media/ipu3/ipu3-v4l2.c | 46 ++++++++++++----------------------
>  drivers/staging/media/ipu3/ipu3.c      | 30 ++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 35 deletions(-)
>
> ---
> changes since v1:
> - add payload check for parameter buffer
> - queue buffer only when previous buffer consumed
> ---

Thanks for the patch. With the issues pointed by Sakari fixed (+/-
those for follow up patches):

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

By the way, has this been tested on an applicable platform with
applicable platform (e.g. Pixel Slate with Chrome OS) and found no
performance or functional regressions?

Best regards,
Tomasz
