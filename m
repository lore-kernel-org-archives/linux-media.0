Return-Path: <SRS0=nxNx=DG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16216C4727D
	for <linux-media@archiver.kernel.org>; Tue, 29 Sep 2020 14:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A731E2075A
	for <linux-media@archiver.kernel.org>; Tue, 29 Sep 2020 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601391069;
	bh=awysxynaEavNiWkrMGoJ+3iohFJphxuf/7dxcqFCIyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1gEIWKNk5DMxGvh5xBGCPIopxzhVs5rp1xXmteGtUifIK3kkILNZHHvXtyWL6YY8O
	 7y/W8uWSR4LE2FSxP73433RZsu7TcHpY+vzNo8DV4gbx6NuFRldYhk2/XgcbylXpsc
	 VWYpy1tNFzWpphEDDsCKR55b17jwxVVgjgif1Tfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgI2OvG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 29 Sep 2020 10:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgI2OvF (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 29 Sep 2020 10:51:05 -0400
Received: from coco.lan (ip5f5ad5bc.dynamic.kabel-deutschland.de [95.90.213.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8986220757;
        Tue, 29 Sep 2020 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601391065;
        bh=awysxynaEavNiWkrMGoJ+3iohFJphxuf/7dxcqFCIyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f4hRlWNYxTccQq+r+tsxPYLadqK1OIVMbsyRxTAK3G0ejuwPPAPb/V7VqZxgvajDj
         9TsgJdxgGMGQrp1Ilx+8MLgnawlEa+I+shZiggODhd4LxWwrc9fj8CKBxbrVDsyxtp
         UFUBuO4paZX+zwwiqf4MVl3xmX6w2zXHM7jk4KTs=
Date:   Tue, 29 Sep 2020 16:51:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     "r.verdejo@samsung.com" <r.verdejo@samsung.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH WIP 1/6] media: vidtv: extract the initial CRC value to
 into a #define
Message-ID: <20200929165100.4483625c@coco.lan>
In-Reply-To: <8397580E-7905-4B02-B9F5-C3B09794A742@getmailspring.com>
References: <20200929071918.15c018ac@coco.lan>
        <8397580E-7905-4B02-B9F5-C3B09794A742@getmailspring.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue, 29 Sep 2020 06:30:56 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> escreveu:

> Hi Mauro!
> 
> > Next time, please add a patch 0, specially when you tag something as
> > WIP, or RFC.  
> 
> Sorry about that :)
> 
> These are almost good but I came across some weird kasan output.
> 
> Can you test this series in a kernel with kasan instrumentation turned on?
> 
> Should apply just fine on top of your latest changes in mchehab-experimental/vidtv

I'm currently focusing preparing some things for the merge window.

I can try to test them after it.

Btw, before testing those patches, you should test with KASAN and
with the memory leak detector if everything is being de-allocated
when the drivers are removed from the memory.

If you find something wrong there, I suggest you to fix the
found issues before applying the new NIT and EDT tables support,
as it may help to check what it could be happening after the
patches.

Thanks,
Mauro
