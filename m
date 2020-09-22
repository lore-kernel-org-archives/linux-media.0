Return-Path: <SRS0=5+7B=C7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF15C2D0E2
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 05:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0113D23A9B
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 05:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sB+9OqHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgIVFQG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Sep 2020 01:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgIVFQG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Sep 2020 01:16:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2EFC061755;
        Mon, 21 Sep 2020 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LgW/YF5Ztkdzq3adTbHOjaSFzEYTO+0+PY5NA7uj2qA=; b=sB+9OqHzhRmNVLq0ceVZ7U+62B
        5vxR90KtbyGJVWx6BNRjhtsDXAwgfOSK476akdPG7BbIAdhLzwK21QmyrB6CPnaNQPLJeU5gjCAs8
        3terFVLA3SibfBOtEnthm0Na4urlUUVqD5QKYC0IYefBZVHnYaJHAU4AAG/QWNeZZKe0fEPl/nqOU
        wle057PmvVLXbkbxA8mtgbBu0AFoLQrIC4aHPcPhtCkWXW6Eu5XRnvcZe1cwgjt/lSyTWuuwp+lh3
        bN/sIGOXABZl08BUhlU+iEU+klce1pt+eWN6X/LC7fTDVDbEHMf6tGSgaWJNSNitWrACUcwH6pj5X
        Bn7C/V6g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKaeo-000871-0t; Tue, 22 Sep 2020 05:16:02 +0000
Date:   Tue, 22 Sep 2020 06:16:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH RFT/RFC 01/49] staging: media: Revert "media: zoran:
 remove deprecated driver"
Message-ID: <20200922051601.GC29480@infradead.org>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
 <1600683624-5863-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600683624-5863-2-git-send-email-clabbe@baylibre.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

> +		fh->buffers.buffer[i].v4l.fbuffer = mem;
> +		fh->buffers.buffer[i].v4l.fbuffer_phys = virt_to_phys(mem);
> +		fh->buffers.buffer[i].v4l.fbuffer_bus = virt_to_bus(mem);
> +		for (off = 0; off < fh->buffers.buffer_size;
> +		     off += PAGE_SIZE)
> +			SetPageReserved(virt_to_page(mem + off));

This messing with SetPageReserved needs to go away before we bring
back the driver, even for staging.
