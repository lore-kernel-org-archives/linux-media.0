Return-Path: <SRS0=ut6f=SS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F75AC10F13
	for <linux-media@archiver.kernel.org>; Tue, 16 Apr 2019 06:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7392086A
	for <linux-media@archiver.kernel.org>; Tue, 16 Apr 2019 06:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AaxtvKZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfDPGQZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:16:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38999 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfDPGQZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Apr 2019 02:16:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id n187so15963444oih.6
        for <linux-media@vger.kernel.org>; Mon, 15 Apr 2019 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKcp/46Q/R2PusFyNkynbEWu3w7HiHX23DadCOawPE0=;
        b=AaxtvKZREmU81NxrGuen73mCPjghPDpBbrHUgGH71zBSXNvduBXBO8n2ed2K7Zhbpp
         sWamdPbs9q3wc8ixUxEmyxYw7sE9XoKlpFqIQp49ZmKYHfpFrUv5cx1tqCg2CO/9bZPy
         2q945RxQ3Pza0d4zCjE3+6lR6ToHeGIinb9W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKcp/46Q/R2PusFyNkynbEWu3w7HiHX23DadCOawPE0=;
        b=Kxqv/Tsia1tYQsOWC4nMwER9sAHfth0dBL1NGsWVq2Zg6zj3AaonFFznSEx+Nrl8sF
         n0Tn/DD3MegEDhGYsOTr4Tj8J7MiFDMFAL+nrL/P+9dpCHQJROLep2+YwVxfCoh1LwW3
         5jpjEoQ/GOZb6BU9lD0u9iAiymYzXLf7x7zD0tRjZyPvAXzkjTr901qcjcwtyxcby9f4
         PNDQHJ9MVuoQYWMqTtFjqrx43gQAr9JJl2GCWAZuVThfcO/HKgZjdxqMaATPmInYgSFV
         EWzeYi8vqZ2+vjJbHSlooRqqXSG13iLCsKNTSWl5jJRgx1Vnc9hN+VRjQAuUadPyXvZp
         93Vg==
X-Gm-Message-State: APjAAAUoAkWv8MI50IfFrcrP7j5uLw0I8WC2WTGc7MwH9JB7cPy7vw0a
        BeBoeBOW6ZIjOyvJ8MHt/u50vatayIg=
X-Google-Smtp-Source: APXvYqygTXBk2RKFEsQ2l8FcxqsyS1Gd2N8KImxfeEoSbp/Xp9OXGB2RdanBGeUA7wp05sXl6JP3qw==
X-Received: by 2002:aca:ac84:: with SMTP id v126mr20880938oie.87.1555395383995;
        Mon, 15 Apr 2019 23:16:23 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id k25sm21092674otj.72.2019.04.15.23.16.20
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 23:16:21 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id s24so16605136otk.13
        for <linux-media@vger.kernel.org>; Mon, 15 Apr 2019 23:16:20 -0700 (PDT)
X-Received: by 2002:a9d:6e88:: with SMTP id a8mr353309otr.117.1555395379771;
 Mon, 15 Apr 2019 23:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <1553252826-15830-1-git-send-email-bingbu.cao@intel.com>
 <CAAFQd5BJXBYZDc58M=-OMQs5=m2QpiYJ3dnpoNW_-hEz1J5_7g@mail.gmail.com> <cc5ebfff-4999-78a4-8bd7-8475dfa15ed6@linux.intel.com>
In-Reply-To: <cc5ebfff-4999-78a4-8bd7-8475dfa15ed6@linux.intel.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 16 Apr 2019 15:16:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AjT3k_vpWCv6ARmFnF4OGtdPn3Nt_6o7J8y+aXYp706A@mail.gmail.com>
Message-ID: <CAAFQd5AjT3k_vpWCv6ARmFnF4OGtdPn3Nt_6o7J8y+aXYp706A@mail.gmail.com>
Subject: Re: [PATCH v2] media:staging/intel-ipu3: parameter buffer refactoring
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Cao Bing Bu <bingbu.cao@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Bingbu,

On Mon, Apr 15, 2019 at 6:42 PM Bingbu Cao <bingbu.cao@linux.intel.com> wrote:
>
>
>
> On 4/15/19 5:28 PM, Tomasz Figa wrote:
> > Hi Bingbu,
> >
> > On Fri, Mar 22, 2019 at 8:00 PM <bingbu.cao@intel.com> wrote:
> >>
> >> From: Bingbu Cao <bingbu.cao@intel.com>
> >>
> >> Current ImgU driver processes and releases the parameter buffer
> >> immediately after queued from user. This does not align with other
> >> image buffers which are grouped in sets and used for the same frame.
> >> If user queues multiple parameter buffers continuously, only the last
> >> one will take effect.
> >> To make consistent buffers usage, this patch changes the parameter
> >> buffer handling and group parameter buffer with other image buffers
> >> for each frame.
> >> Each time driver will queue one more group of buffers when previous
> >> frame processed and buffers consumed by css.
> >>
> >> Signed-off-by: Tianshu Qiu <tian.shu.qiu@intel.com>
> >> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> >> ---
> >>  drivers/staging/media/ipu3/ipu3-css.c  |  5 ----
> >>  drivers/staging/media/ipu3/ipu3-v4l2.c | 46 ++++++++++++----------------------
> >>  drivers/staging/media/ipu3/ipu3.c      | 30 ++++++++++++++++++++++
> >>  3 files changed, 46 insertions(+), 35 deletions(-)
> >>
> >> ---
> >> changes since v1:
> >> - add payload check for parameter buffer
> >> - queue buffer only when previous buffer consumed
> >> ---
> >
> > Thanks for the patch. With the issues pointed by Sakari fixed (+/-
> > those for follow up patches):
> >
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >
> > By the way, has this been tested on an applicable platform with
> > applicable platform (e.g. Pixel Slate with Chrome OS) and found no
> > performance or functional regressions?
> Hi, Tomasz
>
> Yes, same change was verified in our own integration process with full
> test, validation team did not find functional regressions.
> However, if you have some extra tests which can check the performance, I
> will add them into the test cases list.

For example, the camera_HAL3Perf test on Chrome OS could be used to
measure various latencies, with a side note that some of them depend
on environment lighting, so should be run in good lighting conditions.

Best regards,
Tomasz
