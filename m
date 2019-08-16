Return-Path: <SRS0=dofk=WM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A19CC3A589
	for <linux-media@archiver.kernel.org>; Fri, 16 Aug 2019 01:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79AD2064A
	for <linux-media@archiver.kernel.org>; Fri, 16 Aug 2019 01:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565917699;
	bh=JSQR+pqH9SPHgtg3POaWrX0Vw9wrlK9Vful9nIZlYNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VnDkFKd+QFwKBf/TZLSuchOPLzFGqa6ctbieNLuQiMyQkBu92/JiiNo801wfr2c+g
	 SnYcJwK+GYu5XI2MB3MDPTctFZJgzk1POJlCEOE8+oBKJ2cUQHGqmwq4IE6j/gJYHI
	 +yNe/9RR0HJhhvmRIISOsEZnEFn+G210k1Ir/Z0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfHPBIT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:08:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHPBIT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 15 Aug 2019 21:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hVrsT6oGqT3YT5sjdBuNAt2sA64wlJWRRoAI/+PAT4E=; b=QeSV/n4qWXAAchos60v5zZFWe
        OAKVoaOKB2VZet+Z8ESU1OMBDNf6HadNM7dLUTLUDJ/8dWPSp11FnyPMDH6SdWtnyQf2KaOPSsg6J
        H/fo5wkPs0K9ZoEKXvMsb6Hr1sxfzWu8vqRmbmkt0erbJ3AwCsV0szqdFmFLKtRogNL79ej70pLm+
        GwDvEI9jeWR1bpC59Kxfri3AKQOAkkgF1BfH5bPKjrz8WSyYMW9T8t90t8BHfZuPoM9KzTscXATz2
        IeUqqEE+MwIVgFZMe4O8tLQh2ELazxdwDBuYFHe+2eeuJY1rW0AT2fKYMV8FolwHDpWhB5yVKvX9R
        kqnDjM/KA==;
Received: from 177.41.136.115.dynamic.adsl.gvt.net.br ([177.41.136.115] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyQj2-0003KG-Hb; Fri, 16 Aug 2019 01:08:16 +0000
Date:   Thu, 15 Aug 2019 22:08:11 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akihiro TSUKADA <tskd08@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Antti Palosaari <crope@iki.fi>, Sean Young <sean@mess.org>
Subject: Re: [PATCH] dvb-usb-v2/gl861: fix wrong memcpy
Message-ID: <20190815220811.6ba32749@coco.lan>
In-Reply-To: <6c2806fe-f104-84bf-21b8-21df9b3112cf@gmail.com>
References: <98cb0a1c-0db8-951b-80e1-12756678db9a@xs4all.nl>
        <6c2806fe-f104-84bf-21b8-21df9b3112cf@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Akihiro-san,

Em Fri, 16 Aug 2019 10:04:59 +0900
Akihiro TSUKADA <tskd08@gmail.com> escreveu:

> > Does anyone have this hardware? This device must have been dead for about
> > a year, ever since commit b30cc07de8a9 was merged.  
> 
> I have one. (and I wrote the patch).
> Since I do not use it regularly and
> my app did not use the return value meaningfully,
> I have not noticed.

Could you please test the patch and check if the return results are
now consistent and that it won't break anything?

Also, please send us a Reviewed-by and/or Tested-by.


Thanks,
Mauro
