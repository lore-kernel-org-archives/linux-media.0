Return-Path: <SRS0=XjDO=3K=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036F3C2D0CE
	for <linux-media@archiver.kernel.org>; Tue, 21 Jan 2020 13:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFB021569
	for <linux-media@archiver.kernel.org>; Tue, 21 Jan 2020 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579612469;
	bh=NcSgJ3FahJxYZBWqgbFgRPVK7Wmw+mlBF9p+zYpvkQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tlnob//VaenwlRZmEOL09jxGoNrMduH33CeJd86loV2Fs4O2Z8Jf1B/Zdi9gib2zq
	 /z1S1v1/RxAca9fIeDdJIOaT1U8InhR808dGCNuqkZsJAwyoehWYW+XnBxiOlT9DnJ
	 bBoPLp64o92AaNBuDe1gdyEUFfvXUqdk0DzsnrIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgAUNO3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:14:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgAUNO3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 21 Jan 2020 08:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qQIiJFYvKC8/5bR1pUcSpTMPwroc+QDscNJP4PCnwPA=; b=Fjpdl9W6BEFVoNq3lqibasmHU
        xp3uLwMbfarvkIZ047W8EGobJiC8yc0Xiv2C43dyj18wzjeBZDCt8T2+7dHwx1+r7E00L8eGD4QQs
        okrU2Q3ieFDbk1/DDNg4Dub6Rf1Uavm2LSz2F+4NPaGVc/2Y7E9N4w+HDEbrz/AatLBTu4UeN+3YT
        Qzwk9+OJ7MkJ01IsfGKHQJ/JR+zKrdzHXhMQHJ0M40+mivREk1CCGCyDbia5JQd9lT9ynjr2t7bRo
        xsDyoxIoUSU/5FUsDVvzWiG/KS3+SY6BwTxZKZ3dIjVN+8yzmKNofs/ohLFO9W/pHMxKFo4ErLcTO
        M1iqgooKA==;
Received: from [179.179.33.167] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ittMQ-00067c-Bs; Tue, 21 Jan 2020 13:14:27 +0000
Date:   Tue, 21 Jan 2020 14:14:14 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Jenkins Builder Robot <jenkins@linuxtv.org>,
        linux-media@vger.kernel.org,
        LibCamera Devel <libcamera-devel@lists.libcamera.org>
Subject: Re: Build failed in Jenkins: libcamera #72
Message-ID: <20200121141414.7f8e9c89@kernel.org>
In-Reply-To: <263aa6e2-9b6c-5939-687d-005ae8fc2059@ideasonboard.com>
References: <659134945.14.1579046596894.JavaMail.jenkins@builder.linuxtv.org>
        <263aa6e2-9b6c-5939-687d-005ae8fc2059@ideasonboard.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Sun, 19 Jan 2020 21:16:31 +0000
Kieran Bingham <kieran.bingham@ideasonboard.com> escreveu:

> Hi Mauro,
> 
> As a side note, is it possible (or desirable?) to cc
> <libcamera-devel@lists.libcamera.org> on these failures to make sure we
> see them?

Added.

Cheers,
Mauro
