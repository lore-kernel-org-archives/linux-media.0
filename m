Return-Path: <SRS0=lOn+=T7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37952C04AB6
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A651218D1
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559317257;
	bh=z8vZr4Q7p2bIxfOk5ic5VD7lwTYCHApDOFYErrX36qo=;
	h=Date:From:To:Subject:List-ID:From;
	b=a6YDjSLv5beWkMg2BrbYyaNy/NS8qOhYveHWJ0qYDC6LPYoPOmLbuEjIG38+AbZUL
	 bBogN0azOiPXJhpH/k/XZQ8xYnur8vY9XRExO29Zap1kl0Ojb/Cie26VPFUbCJKMwQ
	 zyA5k0W+su0ZmBr5Ltuw8LKPzNybVzrmbgzt1JbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEaPk4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 31 May 2019 11:40:56 -0400
Received: from casper.infradead.org ([85.118.1.10]:42224 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaPk4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 31 May 2019 11:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+L1ltC7tZNchBYV8ICbjwLZqA11cGO6LpErySt3xmJ4=; b=taO3pdcyjb07gwD5tKuFOazUnv
        ia0GGfRFn3w+o5dlF98eSPbVY0yS0eBbLz+hoVIL2jMdAa/lsufcE1O0UCTxFozGiapyDVS7K1E0b
        i2IzEK0XGZSYLw1zWMQL+QV6EcDAXCeReclTELmpP8Hb8R8HdkwPEu4Mo+tzt56Vecs0a43NVgLyC
        65eKlgEdbLBn4YM6tOT2Pyqxm/I+9u5OYYsN8uV/XHVSpVhg2xt5RpIV7R0TavbBSH2jaxPZ8qucU
        YaFQOlF9GcD2gpyuBZhAt5X4ZgVPsPN8Mat2fHbhjR+WRIwuSzGXHxuZmALY+4qhK9QQgLhcevbJ7
        c/CXBUEg==;
Received: from 179.187.96.185.dynamic.adsl.gvt.net.br ([179.187.96.185] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWjeI-000088-7h
        for linux-media@vger.kernel.org; Fri, 31 May 2019 15:40:54 +0000
Date:   Fri, 31 May 2019 12:40:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     linux-media@vger.kernel.org
Subject: [ANN] Patchwork version upgrade
Message-ID: <20190531124050.3f06e1b8@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi all,

For a long time, we were running an old Patchwork version. The thing is that
we had applied some patches on the top of it, and the upgrade was not
trivial.

Today, we upgraded it to its latest stable version. Just like before,
you can access it via:

	https://patchwork.linuxtv.org

As this is a new version, please report if you find any issues on it.

Thanks,
Mauro
