Return-Path: <SRS0=mWeH=W6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05FDC3A5A2
	for <linux-media@archiver.kernel.org>; Tue,  3 Sep 2019 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C694D2077B
	for <linux-media@archiver.kernel.org>; Tue,  3 Sep 2019 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfICPjj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:39:39 -0400
Received: from mailoutvs5.siol.net ([185.57.226.196]:52854 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727667AbfICPjj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 3 Sep 2019 11:39:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id ECE62521F6D;
        Tue,  3 Sep 2019 17:39:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rdB4gloqy96g; Tue,  3 Sep 2019 17:39:35 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 9F264521D68;
        Tue,  3 Sep 2019 17:39:35 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 3713F521CC8;
        Tue,  3 Sep 2019 17:39:35 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH 1/3] cedrus: fill in bus_info for media device
Date:   Tue, 03 Sep 2019 17:39:34 +0200
Message-ID: <4505141.GLqKN8naU8@jernej-laptop>
In-Reply-To: <20190830092624.18228-2-hverkuil-cisco@xs4all.nl>
References: <20190830092624.18228-1-hverkuil-cisco@xs4all.nl> <20190830092624.18228-2-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi!

Dne petek, 30. avgust 2019 ob 11:26:22 CEST je Hans Verkuil napisal(a):
> Fixes this compliance warning:
> 
> $ v4l2-compliance -m0
> v4l2-compliance SHA: b514d615166bdc0901a4c71261b87db31e89f464, 32 bits
> 
> Compliance test for cedrus device /dev/media0:
> 
> Media Driver Info:
>         Driver name      : cedrus
>         Model            : cedrus
>         Serial           :
>         Bus info         :
>         Media version    : 5.3.0
>         Hardware revision: 0x00000000 (0)
>         Driver version   : 5.3.0
> 
> Required ioctls:
>                 warn: v4l2-test-media.cpp(51): empty bus_info
>         test MEDIA_IOC_DEVICE_INFO: OK
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


