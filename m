Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD06C47092
	for <linux-media@archiver.kernel.org>; Tue,  1 Jun 2021 08:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE266128A
	for <linux-media@archiver.kernel.org>; Tue,  1 Jun 2021 08:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFAIaQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 1 Jun 2021 04:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232963AbhFAIaQ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 1 Jun 2021 04:30:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 818CA61003;
        Tue,  1 Jun 2021 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622536115;
        bh=bedRNk8wKv9NNSArocmrL5fhZW3QrCccbA4cX/dEOdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tgWxKFb46eJYPD/PnkAXyI8LDCApIWd3GHG/fyhfFfyFiSbjUSNuWjDj5ShGwFONM
         RZgzn7tu17i4WOx4ZtuDZxDbbROuULhzo/S8oktQHERFhrx+rkytFudN72++fK98Nc
         894NSiCoXzQDYXcNdyZAKV+P/4gsK7DsE2zF15SL5tcqZ3EDhKHb9gMbUst9Kkbhon
         vIFo4DZsRrI3qh68zkhvkPx6t0BzavOufxg3wxtXJoQfOOrBxu1VjI/M1EPoxw6Yg9
         izZigHWQxDKLWPC0UKUMNHSudlbdvYUjaptZPC0J8y0fPHkx7R4brhcwIukny8knac
         voSA9ZWr/Mbkg==
Date:   Tue, 1 Jun 2021 10:28:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Alaa Emad <alaaemadhossney.ae@gmail.com>,
        Brad Love <brad@nextdimension.cc>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxim Plotnikov <wgh@torlan.ru>, Sean Young <sean@mess.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] media: sp8870: move it to staging
Message-ID: <20210601102829.37d9447a@coco.lan>
In-Reply-To: <YLW8rkDRNp1TdWqY@kroah.com>
References: <5e694bc1b0670b58b93a9fea5712ed0f306e6050.1622493461.git.mchehab+huawei@kernel.org>
        <YLW8rkDRNp1TdWqY@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue, 1 Jun 2021 06:50:54 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, May 31, 2021 at 10:37:54PM +0200, Mauro Carvalho Chehab wrote:
> > This driver is used only ba av7110, which is preparing for
> > its retirement. So, move this ancillary driver to stay together
> > with av7110.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/media/dvb-frontends/Kconfig           | 12 -----------
> >  drivers/media/dvb-frontends/Makefile          |  1 -
> >  drivers/staging/media/av7110/Kconfig          | 20 +++++++++++++++++++
> >  drivers/staging/media/av7110/Makefile         |  2 ++
> >  .../media/av7110}/sp8870.c                    |  0
> >  .../media/av7110}/sp8870.h                    |  0
> >  6 files changed, 22 insertions(+), 13 deletions(-)
> >  rename drivers/{media/dvb-frontends => staging/media/av7110}/sp8870.c (100%)
> >  rename drivers/{media/dvb-frontends => staging/media/av7110}/sp8870.h (100%)  
> 
> Don't you need a TODO file for these moves that says what is wrong with
> the driver and when it will be removed and to not send cleanups for it?

Yes, but it was added on the previous patch that moved the master driver
(av7110):

	https://lore.kernel.org/linux-media/4e7136434c68eabcdb66d25f44946ab794f4af0b.1622476959.git.mchehab+huawei@kernel.org/T/#u

The TODO is just saying:

	This driver is too old and relies on a different API.
	Drop it from Kernel on a couple of versions.

(there was a typo there, I'll fix at the next version)

Thanks,
Mauro
