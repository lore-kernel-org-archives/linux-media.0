Return-Path: <SRS0=bEPg=BD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EDAC433E0
	for <linux-media@archiver.kernel.org>; Fri, 24 Jul 2020 12:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFB52074F
	for <linux-media@archiver.kernel.org>; Fri, 24 Jul 2020 12:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JgGBQFcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGXMli (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXMlh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 24 Jul 2020 08:41:37 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128FAC0619D3
        for <linux-media@vger.kernel.org>; Fri, 24 Jul 2020 05:41:37 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id w22so257837vsi.3
        for <linux-media@vger.kernel.org>; Fri, 24 Jul 2020 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Y/hqFtvSIVM16rwYbPUWVppdN1RqdMbSz6G6w4jStg=;
        b=JgGBQFcL9fblo1Ehj0NkTjtkr/P21VDmlXk6wvWbzPbSqNpJHCxXMj94ApqJj9rnP4
         IN4mYv9wJcsU6iWVSC1SuYTe/TbESzsjaDFSRWeM5JqXJCPHonmV3b68IzF9CEjv5sTC
         xwJ7zDOEpQhL7rve7+d5QfvSJXijdLHGbm8r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Y/hqFtvSIVM16rwYbPUWVppdN1RqdMbSz6G6w4jStg=;
        b=fnPvCBsEIAqY38LCWbh/uhd1tRtEY0cqVV0XnbV9aM3gDBx09/1FW/BCfMySJKtLpZ
         BAoMTRzVjJb8WazKNTgoMHcaYyEUbJV57OgWrIDoy20MlunFYdkRFmirBMMFhgHPWYA+
         T3WKZJDxVk3IuQ9L9SeJCwYahhmxqjRFqf4NaarcTPC08cDpsfV6CJqU52acdN4OOGyd
         E/X5g5i86o1uhvoUqAJgMPdcnByzASq1B2PHYbRTBjWamGBawNX9O6F3b6Gu16Qzig4Q
         NOTgYTordE27u+epOv2x8A80Png3o5BpgOHbmdfgM/niA4XZt7jeXIKSqwY7Af0lcW23
         9wXw==
X-Gm-Message-State: AOAM531mEWcEawBJYTqbgQZqwJ3/GLEv+pqnXJYBe1g3VsthebiMIhhS
        vMzAx6ipTAQy+UWTl7CIeIggQ717BfoRF5DoFyzm/A==
X-Google-Smtp-Source: ABdhPJyAlSVayuXDG/mTcs8Rws1rB4Ysra6FB/un27XvYZ4dSbrTFfDoRevDk3+SMuiMsE0LlAfuPpRXgFCKuP7YzUA=
X-Received: by 2002:a67:b448:: with SMTP id c8mr7575072vsm.54.1595594496206;
 Fri, 24 Jul 2020 05:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200710144520.RESEND.1.Id0f52f486e277b5af30babac8ba6b09589962a68@changeid>
 <20200710070332.GA1175842@kroah.com>
In-Reply-To: <20200710070332.GA1175842@kroah.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 24 Jul 2020 20:41:25 +0800
Message-ID: <CANMq1KDcKWgyYYP_m0-WV7602g7zUbU0PPkvwXxbSTF5vFfKGQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: atomisp: Replace trace_printk by pr_info
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Jul 10, 2020 at 3:03 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 10, 2020 at 02:45:29PM +0800, Nicolas Boichat wrote:
> > trace_printk should not be used in production code, replace it
> > call with pr_info.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> > Sent this before as part of a series (whose 4th patch was a
> > change that allows to detect such trace_printk), but maybe it's
> > easier to get individual maintainer attention by splitting it.
>
> Mauro should take this soon:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Mauro: did you get a chance to look at this? (and the other similar
patch "media: camss: vfe: Use trace_printk for debugging only")

Thanks!
