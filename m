Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8087C63777
	for <linux-media@archiver.kernel.org>; Fri, 13 Nov 2020 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3E921D7F
	for <linux-media@archiver.kernel.org>; Fri, 13 Nov 2020 15:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mess.org header.i=@mess.org header.b="DtR/ePnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKMPg0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 13 Nov 2020 10:36:26 -0500
Received: from gofer.mess.org ([88.97.38.141]:54933 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgKMPg0 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 13 Nov 2020 10:36:26 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id D1BD1C6357; Fri, 13 Nov 2020 15:36:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1605281784; bh=lSyVjOKYdsYc38nmn7ZMKVOmsoQlnmoMNpAj+SsL/qI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtR/ePnDvQdeGKhKi92b8H7KdeJYhFxngR7Zd7DaH1wlhulBzp+UBp8Lzim3QTclG
         dnKvtdr1zrhY5ArXLa0tOMrQJJd907fIPRlJ2dar6t3fojhu2svbAF8JkukYQiSugA
         eP6PWYzPD0rnhFSex4jfMr2ToK1DhyJG4r5dAgPWL4bcsL+C1nh/BWmCLSbBLYcUTI
         8WOAMtu6h+taEvqjzhsXA353EBiZh0UUMqQ/yPxI3mRw9ABjc0I9v6VmdihBveKMqR
         BsjPzNB7Svro+tZhyoHehia7waQHa7ARoCTMtFOHBaFmj1awl1NQeo+PbUdN0yZIne
         ugemlH2xa3+hw==
Date:   Fri, 13 Nov 2020 15:36:24 +0000
From:   Sean Young <sean@mess.org>
To:     maxime@cerno.tech
Cc:     linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] media: sunxi-cir: allow timeout to be set at runtime
Message-ID: <20201113153624.GA4735@gofer.mess.org>
References: <20201110091557.25680-1-sean@mess.org>
 <20201110091557.25680-2-sean@mess.org>
 <20201110121122.uulmlemsc562n4ot@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110121122.uulmlemsc562n4ot@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Nov 10, 2020 at 01:11:22PM +0100, maxime@cerno.tech wrote:
> On Tue, Nov 10, 2020 at 09:15:57AM +0000, Sean Young wrote:
> > This allows the timeout to be set with the LIRC_SET_REC_TIMEOUT ioctl.
> > 
> > The timeout was hardcoded at just over 20ms, but returned 120ms when
> > queried with the LIRC_GET_REC_TIMEOUT ioctl.
> > 
> > This also ensures the idle threshold is set correctly with a base clock
> > other than 8000000Mhz.
> 
> That's some pretty hardcore overclocking :)
> 
> I guess you meant 8MHz?

Yes, I did.

> Other than that, for both patches
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!

Sean
