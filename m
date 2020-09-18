Return-Path: <SRS0=ldJM=C3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CCFC43464
	for <linux-media@archiver.kernel.org>; Fri, 18 Sep 2020 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260AE21D24
	for <linux-media@archiver.kernel.org>; Fri, 18 Sep 2020 07:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="D0KzKjsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIRHqT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 18 Sep 2020 03:46:19 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:48594 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbgIRHqT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 18 Sep 2020 03:46:19 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 03:46:18 EDT
Received: from mxback12j.mail.yandex.net (mxback12j.mail.yandex.net [IPv6:2a02:6b8:0:1619::87])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 770821C821C5;
        Fri, 18 Sep 2020 10:40:03 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback12j.mail.yandex.net (mxback/Yandex) with ESMTP id GyoS9c0agh-e2qeRdkc;
        Fri, 18 Sep 2020 10:40:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1600414802;
        bh=Vhr6q6HOSl0PHzL+p9MmuaAOwrGDiHBQhBqvVspML0w=;
        h=Date:Message-Id:Cc:Subject:To:From;
        b=D0KzKjsbfThLPHxnvr/v8orPaXXwhPfnupxx3qjRVPCNnx6tK/3lpRTCSFH95nv4I
         lo3smjcecB4Qj85/NokXEiLwnI4edUhIjx+ssYoo3zF0kgIxHCCQqXzRfd2mvGSF9m
         xsa7ALplOpI1XRsp1hKPrUmeGGJGvijXiWADtwo8=
Authentication-Results: mxback12j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-5cb23de04cc6.qloud-c.yandex.net with HTTP;
        Fri, 18 Sep 2020 10:40:02 +0300
From:   Evgeny Novikov <novikov@ispras.ru>
Envelope-From: eugenenovikov@yandex.ru
To:     Jean-Christophe Trotin <jean-christophe.trotin@st.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ldv-project-org <ldv-project@linuxtesting.org>
Subject: [media] st-hva: potential null pointer dereference in hva_hw_its_irq_thread()
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 18 Sep 2020 10:40:02 +0300
Message-Id: <688931600414652@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If ctx_id >= HVA_MAX_INSTANCES in hva_hw_its_irq_thread(), it dereferences
ctx that is initialized to NULL.

I can not provide the patch since I do not know the logic of the driver
and I have not a capability to test it.

Found by Linux Driver Verification project (linuxtesting.org).

-- 
Best regards,
Evgeny Novikov
