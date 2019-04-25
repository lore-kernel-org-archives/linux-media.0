Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF06CC4321A
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 14:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C29206BF
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556204166;
	bh=HX+eWusx/mBm26p7+EHe9ZmfRepBtVfNdrTRnaDJNng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QCWkt8JaQM73fI+bKEHCQsvPbF7I8bxhsiTlZD9rvS16Ewqb0XZ6D2/A/8PpDVFk5
	 s1LUnrWf5h9JmiAp/3vZFXUtf26I9w2UF+ufIALhGbLPEl4KCZh4e4ieOqtt2lBpnQ
	 LDdxzdbrtEmpve6LIYN8ZMh61AbmU/Thl9WSPOZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfDYO4E (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:56:04 -0400
Received: from casper.infradead.org ([85.118.1.10]:38390 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfDYO4D (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 10:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2RokUCovNQg7xtlifhqh8i1GsJlcZbkjH5T1wLXFZHE=; b=Gonj8eGmE9BXHnRT4A7e/VVG5A
        XjUs1LtayxRVY5k6nfRYt9SgYV3vTR+irgY5uN4X6n/3nOAC1DPbuf9KdAiTmCVvucdmhqR9K76A/
        WMWW/ocXpVJWMoBgVWOzt/pJJGERd+jFjccwnr2FihjZLi9lUsBrt91NMQsdJsa3rA9xKxexleSSX
        osuP34UImjwjcuYfWz6X3ocHiZYzM8GZnHY5IjkOkJ8GYrgQRf7KK1Cf6+BBg/Je73cBSBit+npxn
        tfLDlBYuASdsx+pB6dVvwgtndOTwGQ5ZzZhC3SkJ+XUGm1qfnvyzXZdWoGF+yomxr+8TXGHFEg7pg
        JLtgvW5Q==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJfn8-0005aB-8W; Thu, 25 Apr 2019 14:56:02 +0000
Date:   Thu, 25 Apr 2019 11:55:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org
Subject: Re: [GIT PULL for v5.2] Venus updates - take2
Message-ID: <20190425115558.39a0604a@coco.lan>
In-Reply-To: <20190425114618.1fefb0e8@coco.lan>
References: <20190423140702.26044-1-stanimir.varbanov@linaro.org>
        <20190425114618.1fefb0e8@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Thu, 25 Apr 2019 11:46:18 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> Em Tue, 23 Apr 2019 17:07:02 +0300
> Stanimir Varbanov <stanimir.varbanov@linaro.org> escreveu:
> 
> > Hi Mauro,
> > 
> > Here is the second attempt.
> > 
> > Added two more fixes for Venus v4 properties and dynamic buffer mode.
> > 
> > Please pull.
> > 
> > The following changes since commit 26d5d1fe53e966efe567e9773d1158baef303e3b:
> > 
> >   venus: helpers: fix dynamic buffer mode for v4 (2019-04-23 15:57:17 +0300)
> > 
> > are available in the Git repository at:
> > 
> >   git://linuxtv.org/svarbanov/media_tree.git tags/venus-for-5.2-take2
> > 
> > for you to fetch changes up to 26d5d1fe53e966efe567e9773d1158baef303e3b:
> > 
> >   venus: helpers: fix dynamic buffer mode for v4 (2019-04-23 15:57:17 +0300)
> > 
> > ----------------------------------------------------------------
> > Venus updates for v5.2
> > 
> > ----------------------------------------------------------------
> 
> There's something really weird here... It should be showing above the
> patches applied to your tree, but, instead, it doesn't show any
> patch on the above summary. It is like your tree doesn't contain
> any new patch, just the stuff that were already merged on my
> tree.
> 
> I suspect that you're passing some weird argument to 
> git pull-request, as it is saying:
> 
> > The following changes since commit 26d5d1fe53e966efe567e9773d1158baef303e3b:
> 				     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > for you to fetch changes up to 26d5d1fe53e966efe567e9773d1158baef303e3b:
> 				 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> See?
> 
> It is requesting me to pull an empty set of patches, as the git
> reference is identical! There's not between 26d5d1fe5..26d5d1fe5!!!
> 
> As my import script uses those references, it gets an empty number of
> patches to merge.

FYI, what I use here when sending my stuff upstream patches is:

	ORIGIN=$(git merge-base remotes/origin/master $(git branch|grep '*'|cut -b 3-))
	git request-pull $ORIGIN $URL 

Except if you do some unusual things (like sometimes I do), you can
probably just use:

	git request-pull origin/master $URL

where $URL is the URL for the tree you're sending the pull request - in
this case, the URL for my tree at linuxtv.org, e. g.

URL=git://linuxtv.org/media_tree.git

Thanks,
Mauro
