Return-Path: <SRS0=BPg3=W7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3701C3A5A9
	for <linux-media@archiver.kernel.org>; Wed,  4 Sep 2019 18:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAE72168B
	for <linux-media@archiver.kernel.org>; Wed,  4 Sep 2019 18:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567622411;
	bh=1w/obuE2IzOsDFcQu1xlo39m7340U12EIFCpCmgHfB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hOQeVzaP/1C9r4YhvkOyGqdP1yhj+6xfHAhJUZDSUeoFOIE73YTf9Lf1GOSMX8vG9
	 58NDxeh7xHNM72KijfSEOY9cPgVpB0r5xWYfDfIxlZcm0kak1LOX38+7pIlOMB3B5P
	 /5Tl1Y18XVHgmkyLB6tZgpFYDqX8auBzI/E+PnGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfIDSkI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:40:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfIDSkI (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 4 Sep 2019 14:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fGM6us+2JkS7sDI0jAgv3k4v1Yw2t6Y6mbRflx4MxRE=; b=GDEopKvmoZ47P1RgodDy4T4xa
        xQy8TWAy8vVLiEjwm1aoKqmBzQZOaUDDUkM9jiF61GVLfYecwPZud0PjOT/Xnt63X/pK4ArJy0ozm
        lc09hUOtL/STLblqFR7s9hu1s/lJk9WBVxv13yffkS1Rcm0/JQHki17ws7YIX/uMj6Jm9O8gea2TZ
        uUv0NfnRAGUJJWJkmPf76oZcFUysLn+YQePP6ecZJIXbPzVTSkJ1Bvz2mO6SNuaHp5Slm0+6F1QuA
        UQ+/GI8st+2atiXTWqEnknR+/9ZEctTVFDFbZWB873zkjQ2VWfHHwPIgKvkXbstTfW/3XDjhX9L2z
        A9giaxsMQ==;
Received: from 177.17.137.173.dynamic.adsl.gvt.net.br ([177.17.137.173] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5aCK-0000hA-NA; Wed, 04 Sep 2019 18:40:05 +0000
Date:   Wed, 4 Sep 2019 15:40:01 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Scott Doty <scott@ponzo.net>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: hdpvr.ko kernel 5.3-rc6
Message-ID: <20190904154001.6a6109f9@coco.lan>
In-Reply-To: <75f04282-7625-4c7e-7e94-c45195a152b5@ponzo.net>
References: <7530b881-c7d0-74fd-dfeb-5e001d8b2266@ponzo.net>
        <5a6ab1fe-9776-961d-970b-5b3dbea12da1@xs4all.nl>
        <839e8ded-dfe5-9fc9-1573-2d64aa547e1c@ponzo.net>
        <00b89589-5558-f8a1-3fb7-c631002e11bd@xs4all.nl>
        <152b2b02-67be-a5ba-6283-1b81d59c145f@xs4all.nl>
        <75f04282-7625-4c7e-7e94-c45195a152b5@ponzo.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Wed, 4 Sep 2019 11:13:36 -0700
Scott Doty <scott@ponzo.net> escreveu:

> On 9/3/19 1:34 AM, Hans Verkuil wrote:
> >
> > Never mind, hdpvr uses read(), not streaming I/O. Of course this
> > doesn't work...
> >
> > Just plain 'cat /dev/videoX >x.mpg' will do.
> >
> >  
> 
> Okay, tried that, it produces data that vlc can then play back.
> 
> So I think I'm running into a problem with vlc instead of hdpvr. It's 
> just weird that mplayer, vlc, and ffplay would all three be unable to 
> use it.

You can use any of them, provided that it is opened as if it were a
normal file, using the read() interface. For example, this should work:

	cat /dev/videoX | mplayer -cache 8000 -

The thing is that most apps assume that a V4L2 device supports mmap().

This is true for almost all devices, being hdpvr - and pvrusb - two
exceptions.


Thanks,
Mauro
