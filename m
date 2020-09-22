Return-Path: <SRS0=5+7B=C7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9114C2D0E2
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 05:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE7E23A84
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 05:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f54s+Waj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgIVFNh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Sep 2020 01:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgIVFNh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Sep 2020 01:13:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED12C061755;
        Mon, 21 Sep 2020 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rBWeGhZmUrNKeanvJ2n5CIL5Mb5/1l4+A0gI1q8sdzw=; b=f54s+WajloVM1ZAnA2RXCYO+jf
        egr4+xfrGVTNVDcIW4KlTTXSxcTXpZln++5y1vXY8M+QRmfEShmQiIN6eA9RJ9N7OgMU8YZjQldzd
        kS1n9nI58BbsDq3d9tRI9k8JhvPc2sDZlH1tlBzvUQpLanVDS2yPJLvV02Pvh+yzdWlAg8LFrYq3u
        VxBfutJ9p43ySs7u+5aVIxENbKhVCxY6QfzqOXKoarzeHZUxi/2Jf4u++b8K8e2LYz1+3ilyNAQPP
        ePZ2qqYn9gWnhdB0ECzUhrid2jAvuslZdB5+AAy+lsrS9J3Ok5Aib+ANcXhYRN5tSwOn8dpYpcGcZ
        eKrrJJLw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKacL-0007te-Ex; Tue, 22 Sep 2020 05:13:29 +0000
Date:   Tue, 22 Sep 2020 06:13:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH RFT/RFC 06/49] staging: media: zoran: unsplit lines
Message-ID: <20200922051329.GA29480@infradead.org>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
 <1600683624-5863-7-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600683624-5863-7-git-send-email-clabbe@baylibre.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Sep 21, 2020 at 10:19:41AM +0000, Corentin Labbe wrote:
> This patch un-split some lines.
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Just don't do this.  This is a purious change going over 80 chars for
absolutely no reason, and you'd still need a very good reason for that.
