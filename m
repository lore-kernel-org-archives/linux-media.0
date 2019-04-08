Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB07C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 10:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A71208E3
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554719343;
	bh=zffrcPcfxupeU2BoPyUfCytUly4SlVdovbBPRPLfzPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=L/q/xo9sLBOBM/oV6MdHsGdKKgCr71u2fCgYOzPAXET8wID+i7hrEiBquzoDAmWKx
	 HA8wAk8wGADoQe7PZPM+ny1CmsNvx2gKrWNIP38ouQzc8U/AFrTb7MbIMBFWQrcSjs
	 aQAB7sPv5wIvXjQJ3enPBThuDrQXOOMAhHZea2Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfDHK3C (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:29:02 -0400
Received: from casper.infradead.org ([85.118.1.10]:33730 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfDHK3C (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 06:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ySHLIfVqFrzzUSXIwSSylrL9+99Wf4ZgJEwvwE/RchA=; b=GVO748OCuBrrbPdPo7mN725TDs
        MCpBuY4zXLWKFJjDQRNivMATpR+9W1b/qE72olkHbQNN34xwCJ73hZsOCk+Q7wAAKQ4iXU0empgHA
        ozk8vOEgce5MxAuLlaOP1VEqGAGlW2jzBFg3zBJyAWGUaa+YanTrUgwGDkDtSo8yHlXqlOdbazBkf
        R9JQCmASHtK620TJqFRvQqoy/aleZLiTkd2c46C4mqdqNZboB/W1i2kppo/mjDgoKb0uHapt1jdJP
        l76OmFul3JZ/rtd2zrVsZjBOFf8OhmcUT2+yO/7XNqfNf5mA7YtSyGegxyRxl65gjcbG9OJvZqfXi
        HNR+Md8A==;
Received: from [177.159.248.23] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDRWM-0007eW-Nt; Mon, 08 Apr 2019 10:28:59 +0000
Date:   Mon, 8 Apr 2019 07:28:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Subject: Re: [PATCH v4l-utils 0/2] v4l2-compliance colors
Message-ID: <20190408072854.13077345@coco.lan>
In-Reply-To: <3aaaa269-191f-678c-df60-69500042c875@xs4all.nl>
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
        <3aaaa269-191f-678c-df60-69500042c875@xs4all.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Mon, 8 Apr 2019 11:05:20 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> Hi Philipp,
> 
> On 4/8/19 10:45 AM, Philipp Zabel wrote:
> > Hi,
> > 
> > not sure if anybody finds this as useful as I do to spot compliance
> > failures and warnings in a sea of OKs more easily, but this patch adds
> > some color escape codes to the output of v4l2-compliance. It marks "OK"
> > green, "warn" bold, and "fail" / "FAIL" bright red if the output is a
> > terminal. I would have preferred to mark warnings yellow, but that
> > doesn't work well on black-on-white terminals.  
> 
> Hmm, I hate colors myself :-)
> 
> So I would prefer if an option is added to explicitly enable colors. And the
> check for stdout can be replaced by a check for this new option.
> 
> Also, the same option and behavior should be added to cec-compliance as well.
> 
> I propose the option -C, --show-colors.

Just my two cents here: I guess most people love colors for warnings
(I do), and this has becoming more popular on gcc - and it is already
a default for dvb tools, with is part of v4l2-utils.

So, IMHO, it would make more sense to have colors enabled by default,
and provide, instead, either an option to disable or to have an env
var that would control it.

> 
> And don't forget to update the man pages for both utils!
> 
> Regards,
> 
> 	Hans
> 
> > 
> > regards
> > Philipp
> > 
> > Philipp Zabel (2):
> >   v4l2-compliance: use warn() in warn_once()
> >   v4l2-compliance: add colors
> > 
> >  utils/v4l2-compliance/v4l2-compliance.cpp | 11 ++++++++---
> >  utils/v4l2-compliance/v4l2-compliance.h   | 22 +++++++++++++---------
> >  2 files changed, 21 insertions(+), 12 deletions(-)
> >   
> 



Thanks,
Mauro
