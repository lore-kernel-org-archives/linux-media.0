Return-Path: <SRS0=CnRj=T5=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05AC28CC0
	for <linux-media@archiver.kernel.org>; Wed, 29 May 2019 11:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B252070D
	for <linux-media@archiver.kernel.org>; Wed, 29 May 2019 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559128040;
	bh=6BHvEx3Nr8j3nvznivkCPRdyu1+A7GfLk6fF7vnwNQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VW8LqZrYivNfJWbb/a4SWowWxFf/p+NoEaFE9/NsghW+KdGmprEf3zNpStlJx/Qxm
	 k8X4I5teGT5cEG0mXO6rhYwwGbaQqge7JtTCR1/0JZpjb3H7tVxTS1G2EXaxfsjk74
	 NQoxKg2QkTfXGT7GR1+UhnGCMLTpjO3IsxmNJpnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfE2LHU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 29 May 2019 07:07:20 -0400
Received: from casper.infradead.org ([85.118.1.10]:35988 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2LHT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 29 May 2019 07:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HkFBSmupr9y9ILDnimHwzyv7dN9zGnDvbzn4LnpMajQ=; b=WQUoWw7T59LYwBCqpPLlpD5OJU
        V1u6XF7uj3unm6J6kwR2fU7lbnfdToZfgT510Ab42u6qPeNSh+xbQJFPd9zjgMpmH83tV8V5xFhY7
        RI/V6lzzlhD9km9pu0Kf+Xl4ORIRSKssxFrnvCYCJPF5x0ToHPmn4n4+zGv0ft++4J7coEJTk1rz7
        Y/upe/CTFu0v21S7QdLw16EsY1TGlnibGKRQsWWzcQX6iVTCYK2388holS9b1WO4+XRDsRc/zO0QU
        yh51yEqUM2jFiG1Nh6MQu/NajkUva1PxTjlXfzZS2negcZDAm0rFpRKFxCDAJzMwp3AxvTPYGBWm8
        p8G2b/vw==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVwQO-0003ll-PJ; Wed, 29 May 2019 11:07:17 +0000
Date:   Wed, 29 May 2019 08:07:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: Re: [GIT PULL FOR v5.3] Add ZynqMP VCU/Allegro DVT H.264 encoder
 driver
Message-ID: <20190529080713.03f47ab8@coco.lan>
In-Reply-To: <4d45c05b-8b24-6f35-a891-4646c8e1e1f5@xs4all.nl>
References: <4d45c05b-8b24-6f35-a891-4646c8e1e1f5@xs4all.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue, 28 May 2019 20:10:27 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> The following changes since commit 9bec226d8c79fcbc95817b082557f72a79d182f5:
> 
>   media: v4l2-pci-skeleton.c: fix doc warning (2019-05-28 13:14:28 -0400)
> 
> are available in the Git repository at:
> 
>   git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.3f
> 
> for you to fetch changes up to 75e52767fa3d58a783dd6862a7fb686e5de67fc6:
> 
>   allegro: add SPS/PPS nal unit writer (2019-05-28 20:00:26 +0200)
> 
> ----------------------------------------------------------------
> Tag branch
> 
> ----------------------------------------------------------------
> Hans Verkuil (1):
>       videobuf2-v4l2: set last_buffer_dequeued in dqbuf
> 
> Michael Tretter (4):
>       media: dt-bindings: media: document allegro-dvt bindings
>       media: dt-bindings: media: Add vendor prefix for allegro
>       allegro: add Allegro DVT video IP core driver
>       allegro: add SPS/PPS nal unit writer

As this is staging, merged, but there's something wrong with DT here:

WARNING: DT compatible string vendor "allegro" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#3013: FILE: drivers/staging/media/allegro-dvt/allegro-core.c:3013:
+	{ .compatible = "allegro,al5e-1.1" },

Please send a followup patch addressing it.

Thanks,
Mauro
