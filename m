Return-Path: <SRS0=V90Q=X7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA0ECE58D
	for <linux-media@archiver.kernel.org>; Sun,  6 Oct 2019 12:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22E120867
	for <linux-media@archiver.kernel.org>; Sun,  6 Oct 2019 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570366072;
	bh=d1EEiZ5DKRzsrZdwq20fUnz8f3Aho3s2F8Zl48GWsNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pAm6wqNEY7Yz8c+y9ivd3jAx/xbfGeDJSIfra9lfy5b7xWKRUj48kaIQmP20Oh2P9
	 biitz2FGyVnDjJW3/S2DxWv7kS8Aml12vIJ1UJHMjxZ4em64Oi2cLPS928FVJWBd3j
	 bIvEhUfz7z56p+wpEZYRH8mzQ0dQvDriLg1azV4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfJFMrv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 6 Oct 2019 08:47:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJFMrv (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 6 Oct 2019 08:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EQxs7UAr4CnzUomLs1YiJG7nRToLAEt56G43OwRcCEE=; b=h+a5SoiPbtN3xBYjVpQ3l3Wvd
        XJ+tXaLbuHPQPMBGGpiV7Mv4T1gWgpGiUjTDqZsWyfoJmt5FEXsWPigNNSC+NgSyxdzbRwQeiNCmR
        ERtXCr7+k88uYHOaIORDBTdOEV+hC+q/9fppduYMg/FhfILmyF6ZOpEewVCzXLZLwzOBmVCsyawAA
        rb+lfl70wOlmWb5MfAlgfilfoPswhf6WUOXIPdoWnMPJbg6P/OlySoY1CfCT3fxIS2BJGFQyfvRKW
        0IBWE02ECBybu/GVn87gbd+ZuWs5fxf/awDQuINCvnw0fNOdI9TGAGCugVDvdBKnlG3MgmZqix2BI
        z1gdWk9SQ==;
Received: from 179.187.109.114.dynamic.adsl.gvt.net.br ([179.187.109.114] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iH5wz-0006uq-F8; Sun, 06 Oct 2019 12:47:49 +0000
Date:   Sun, 6 Oct 2019 09:47:43 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Daniel Scheller <d.scheller.oss@gmail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] media: cxd2841er: avoid too many status inquires
Message-ID: <20191006094743.494555bc@coco.lan>
In-Reply-To: <20191005100205.01459123@lt530>
References: <deda32250ad32078b98eb41eb09d6d20050a6f9c.1570113429.git.mchehab+samsung@kernel.org>
        <483cecc9f65b03ad3cd54aea09ecd9819c3dc6db.1570197700.git.mchehab+samsung@kernel.org>
        <20191005100205.01459123@lt530>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Sat, 5 Oct 2019 10:02:05 +0200
Daniel Scheller <d.scheller.oss@gmail.com> escreveu:

> Am Fri,  4 Oct 2019 11:02:28 -0300
> schrieb Mauro Carvalho Chehab <mchehab+samsung@kernel.org>:
> 
> > As reported at:
> > 	https://tvheadend.org/issues/5625
> > 
> > Retrieving certain status can cause discontinuity issues.
> > 
> > Prevent that by adding a timeout to each status logic.
> > 
> > Currently, the timeout is estimated based at the channel
> > bandwidth. There are other parameters that may also affect
> > the timeout, but that would require a per-delivery system
> > calculus and probably more information about how cxd2481er
> > works, with we don't have.
> > 
> > So, do a poor man's best guess.  
> 
> Such hardware quirk hack should clearly be enabled by a (new) config
> flag (see the bits at the top of cxd2841er.h) which consumer drivers
> can set if there are known issues with them. The reported issue is
> nothing every piece of hardware with a cxd28xx demod soldered on has -
> I believe the JokerTV devices which Abylay originally made this driver
> for suffers from this and at least the Digital Devices C/C2/T/T2/I
> boards (cxd2837/43/54) definitely don't have any issues (and I use them
> regularily in my TVheadend server which is frequently used).
> 
> So please hide this behind a flag named ie. "CXD2841ER_STAT_TIMEOUT"
> and enable that in the USB drivers which the affected USB sticks use.

I see your point.

There are a few things to consider here, though:

1) I2C bus calls are expensive, as the bus speed is typically 100kbps.
   Doing such ops too fast is known to have caused issues in the past
   with other frontends.

   So, a good practice, followed by almost all frontends, is to have 
   some logic that would prevent calling stats too fast;

2) Obtaining stats like BER, UCB, block error count and even S/N ratio takes
   time, as the frontend need to wait for enough data to arrive, in order to
   update the internal registers. At best, calling stats too fast will
   just make the frontend return a previously cached value, just spending
   I2C bus bandwidth for nothing.

3) If you look at the cxd2880 driver, wrote by Sony developers, you'll
   see that it has a complex logic to estimate the time where the
   next stats value is available. I bet that the timings calculated there
   would be similar to the minimal time to obtain a reliable measure also
   on cxd2841er.

4) The cxd2841er can't do any real estimation right now, as it tunes
   into a channel using auto mode and it misses the code that would
   retrieve the tuning parameters and would allow to properly estimate
   the bit rate of the received stream.

5) With regards to the tvheadend issue, I've been talking with the
   reporter at the IRC channel, sending him some patches to test.
   After some tests, I'm pretty sure that the issue is not Kernel
   related, but, instead, there's something broken at tvheadend
   (at least at the version he is using) that it is causing troubles
   when using the DVBv5 stats API.

With all the above considerations, I agree with you that this patch
should not be applied. Yet, we should at least apply a patch that would
prevent retrieving the stats registers too fast.

I'm sending a new version in a few.

Thanks,
Mauro
