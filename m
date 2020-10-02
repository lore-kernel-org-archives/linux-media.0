Return-Path: <SRS0=i6Q9=DJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBEFC4363D
	for <linux-media@archiver.kernel.org>; Fri,  2 Oct 2020 09:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B434620644
	for <linux-media@archiver.kernel.org>; Fri,  2 Oct 2020 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601629536;
	bh=B5ydxcI0C7Q3whs4Y3vR8dN5tdcr247DfpB2Z8S9NRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PaOzJBMy9ACyLQH7pNjhSeJAhcZmLYWk8Ml3w6uM3++NUxJiTVl28Mi8nVsM+XySO
	 4qNYpKPCPO3H8FjQNqT/A3rj9F88FrBR8/wLF8ywKUB2yJtTA+AkrvC5yRKgJE37GX
	 QNctSS2vuz21u4M49+M901GpngwcVwpLM10tsX8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgJBJFg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 2 Oct 2020 05:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgJBJFf (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 2 Oct 2020 05:05:35 -0400
Received: from coco.lan (ip5f5ad59f.dynamic.kabel-deutschland.de [95.90.213.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64030205F4;
        Fri,  2 Oct 2020 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601629535;
        bh=B5ydxcI0C7Q3whs4Y3vR8dN5tdcr247DfpB2Z8S9NRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ca8htCYTK1Ypgmjk5OxhEv4lRWqiYofL6whXQLAFUygSrvjNC9kSrrTKPkGcmBTct
         tY085WfhIWUK6QoYPT8Ub0hBMpH/UAeBQ4ahsr4URL3jdFh0LGL5SEupambZv4JcfC
         yv2MvhARS+EMQF+FtrbRqRbl/TP9qkUa8ohc2aaE=
Date:   Fri, 2 Oct 2020 11:05:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 2/2] zoran: fix sparse warnings
Message-ID: <20201002110531.62774d96@coco.lan>
In-Reply-To: <20201002072909.GD15586@Red>
References: <20200928132831.1587872-1-hverkuil-cisco@xs4all.nl>
        <20200928132831.1587872-3-hverkuil-cisco@xs4all.nl>
        <20201002072909.GD15586@Red>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Fri, 2 Oct 2020 09:29:09 +0200
LABBE Corentin <clabbe@baylibre.com> escreveu:

> On Mon, Sep 28, 2020 at 03:28:31PM +0200, Hans Verkuil wrote:
> > The output is not fully supported yet, so some ops are
> > commented out. Also comment out the corresponding callbacks to prevent
> > these sparse warnings:
> > 
> > drivers/staging/media/zoran/zoran_driver.c:656:12: warning: 'zoran_s_output' defined but not used [-Wunused-function]
> >   656 | static int zoran_s_output(struct file *file, void *__fh, unsigned int output)
> >       |            ^~~~~~~~~~~~~~
> > drivers/staging/media/zoran/zoran_driver.c:649:12: warning: 'zoran_g_output' defined but not used [-Wunused-function]
> >   649 | static int zoran_g_output(struct file *file, void *__fh, unsigned int *output)
> >       |            ^~~~~~~~~~~~~~
> > drivers/staging/media/zoran/zoran_driver.c:635:12: warning: 'zoran_enum_output' defined but not used [-Wunused-function]
> >   635 | static int zoran_enum_output(struct file *file, void *__fh,
> >       |            ^~~~~~~~~~~~~~~~~
> > drivers/staging/media/zoran/zoran_driver.c:302:12: warning: 'zoran_enum_fmt_vid_overlay' defined but not used [-Wunused-function]
> >   302 | static int zoran_enum_fmt_vid_overlay(struct file *file, void *__fh,
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/staging/media/zoran/zoran_driver.c:294:12: warning: 'zoran_enum_fmt_vid_out' defined but not used [-Wunused-function]
> >   294 | static int zoran_enum_fmt_vid_out(struct file *file, void *__fh,
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > 
> > Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > ---  
> 
> Hello
> 
> What about using "ifdef CONFIG_ZORAN_OUTPUT" instead of "ifdef 0"
> Otherwise:
> Acked-by: Corentin Labbe <clabbe@baylibre.com>

No. Better to keep #ifdef 0, a this has a higher chance of being
noticed when the driver moves out of staging.

Thanks,
Mauro
