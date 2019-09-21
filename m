Return-Path: <SRS0=/udS=XQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DFAC4360D
	for <linux-media@archiver.kernel.org>; Sat, 21 Sep 2019 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3909E2184C
	for <linux-media@archiver.kernel.org>; Sat, 21 Sep 2019 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569086281;
	bh=X0UJ2hiTToFYlnE2aE8TajGLH3Ae2zPFumEzyo1FUfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=J2InJ5FT42wlcFyyDBL7gl17gUc7T4CTOW7dEE74NhUqRDNlX9WHH/fOjgQUJGj2h
	 ex/zINX4lW26hki9D4lkpoO4nw14V9NBd21zZ7NHyyhlSReX8c08BRZjy3h8yDKwuw
	 gFFQWLwbP6ciIQgb22q1g2uWdjJB9aPBQdPgbHh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfIURR5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:17:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfIURR5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 21 Sep 2019 13:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=npyIJ4oToPFwwAoSLl7eEajl0gPXRwoTouB58DzCRGQ=; b=hNI/MfVNYzfEi84RDy1At19Zo
        V+5ZYbYYZwtcSf64eVEDRE+ju7B0ruNN/SG6AUjDrP1dPeE/SRmQUMhK1OPP926DbYT6l9kWQUjwu
        OMMSSm9HRcOPus3tg4Vd3QUdDT+KORmpqwV9tb3N0jsItX2kK0NDyoYnqz1cu5X0UcBOHQRlE5eYd
        gVSXIcNt94elgV4VOhqpfoPmr1B/BthcB9PoL+N9f1oVs2KhBS90iwwrB8qmXG1W9QOX1blB9rykT
        +rwxguDr+ellBQf5SgQNwLQ0A7CxE43IJYzl6ycCvdmtF2G5fu2eyXkt64zzT4R2rC094Suf+16CI
        VUhvuOL2Q==;
Received: from 177.206.132.221.dynamic.adsl.gvt.net.br ([177.206.132.221] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBj19-0008MP-4N; Sat, 21 Sep 2019 17:17:55 +0000
Date:   Sat, 21 Sep 2019 14:17:49 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Subject: Re: bringing back media/zoran driver
Message-ID: <20190921141749.03ebb25f@coco.lan>
In-Reply-To: <20190921170357.GA26626@Red>
References: <20190921170357.GA26626@Red>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Sat, 21 Sep 2019 19:03:57 +0200
Corentin Labbe <clabbe.montjoie@gmail.com> escreveu:

> hello
> 
> I am the owner of a zoran based DC10+ card.
> I am in the need of using it since yesterday and I found that its driver was removed.
> 
> Reverting the removing patch made to a temporary working situation.
> 
> If I understand correctly, it was removed due to lack of vb2 convertion.
> If I am able to do this vb2 conversion, does bring it back in mainline will be posssible ?

Yes.

> In that case I am ready to assume to be the maintainer if needed.

Yeah, if we're willing to re-add it, the best is if you can also
maintain it.

Thanks,
Mauro
