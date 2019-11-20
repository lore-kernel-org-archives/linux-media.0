Return-Path: <SRS0=gOGT=ZM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C50C432C0
	for <linux-media@archiver.kernel.org>; Wed, 20 Nov 2019 10:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0F622429
	for <linux-media@archiver.kernel.org>; Wed, 20 Nov 2019 10:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SInIyLuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfKTKlf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:41:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfKTKlf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 20 Nov 2019 05:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:
        Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dDQU7Z8pqeLG5AASj6Zr1W7/iyiFMdMea+6NmCKvu30=; b=SInIyLuOd0gSzMZF1ZtbaMvdQ
        wXIpAtx0UrjTGQwWnQPDyjKh+bd3N9xlgS0Uhzhtc/D4dZwJpNwKBazphUxkplEZSpGJRG6MzSsk9
        tL/AI02y74ganZIQ1hHMDsaRbnNyM7wNyIsL33TEXD/nmsslDpKhn3y+/oNZ17L5wpT73SRYC8JmI
        Fekv1zAkpKT7rVNADfBg70u6fPE3P1v1IzquZVTcfTTbyo4vpWorBYa7sPbC4rqcBVJqal9gzuFvi
        YxHd0U6Josb/SPmpDX75VjOWv6Pvy6H4Nu4e5ZZx3N3nPBwLDVJUWJUacIoHLXFiBHcOopkZ73OE0
        RyFNdJeCQ==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXNQU-0003LS-E3
        for linux-media@vger.kernel.org; Wed, 20 Nov 2019 10:41:34 +0000
Date:   Wed, 20 Nov 2019 11:41:31 +0100
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     linux-media@vger.kernel.org
Subject: [ANN] possible LinuxTV.org maintenance on Wednesday (2019-11-20)
Message-ID: <20191120114131.4000bb1b@infradead.org>
In-Reply-To: <20191118111323.5ccd8f27@infradead.org>
References: <20191118111323.5ccd8f27@infradead.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Mon, 18 Nov 2019 11:13:23 +0100
Mauro Carvalho Chehab <mchehab@infradead.org> escreveu:

> Hi all,
> 
> Just to let you know, we'll be doing a preventive maintenance tomorrow by
> 1pm-3pm (UTC). 
> 
> During that time, we'll be stopping the services (wiki, web, patchwork, git)
> at *.linuxtv.org.

It ends that the upgrade didn't happen yesterday. So, we are trying to
re-schedule it for today.

In principle, the maintenance will happen between 1pm-3pm (UTC).

Cheers,
Mauro
