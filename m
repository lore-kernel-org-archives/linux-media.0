Return-Path: <SRS0=mWeH=W6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E60CC3A5A5
	for <linux-media@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A7A2077B
	for <linux-media@archiver.kernel.org>; Tue,  3 Sep 2019 15:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfICPnf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:43:35 -0400
Received: from mailoutvs57.siol.net ([185.57.226.248]:59705 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727107AbfICPne (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 3 Sep 2019 11:43:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 2FD25521175;
        Tue,  3 Sep 2019 17:43:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JV1Olpn-CGr8; Tue,  3 Sep 2019 17:43:31 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id CCFEA520E82;
        Tue,  3 Sep 2019 17:43:31 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 8A94D520C20;
        Tue,  3 Sep 2019 17:43:31 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH 3/3] cedrus: fix various format-related compliance issues
Date:   Tue, 03 Sep 2019 17:43:31 +0200
Message-ID: <3724097.viA1KGSQxa@jernej-laptop>
In-Reply-To: <20190830092624.18228-4-hverkuil-cisco@xs4all.nl>
References: <20190830092624.18228-1-hverkuil-cisco@xs4all.nl> <20190830092624.18228-4-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi!

Dne petek, 30. avgust 2019 ob 11:26:24 CEST je Hans Verkuil napisal(a):
> Initialize the context on open() with valid capture and output
> formats. It is good practice to always have valid formats internally.
> 
> This solves one vb2 warning in the kernel log where the sizeimage
> value of the output format was 0 when requesting buffers, which is
> not allowed.
> 
> It also simplifies the g_fmt ioctl implementations since they no longer
> have to check if a valid format was ever set.
> 
> cedrus_prepare_format() now also validates sizeimage for the output
> formats, ensuring userspace can't set it to 0 since that would cause
> the same vb2 warning.
> 
> Finally remove the sizeimage == 0 check in cedrus_try_fmt_vid_out()
> since cedrus_prepare_format() will now adjust this value.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c   | 10 +++++++
>  .../staging/media/sunxi/cedrus/cedrus_video.c | 28 ++-----------------
>  .../staging/media/sunxi/cedrus/cedrus_video.h |  1 +
>  3 files changed, 14 insertions(+), 25 deletions(-)

Selecting default format needs to be expanded to select default format based 
on compatible. SoCs with Display Engine 2 and 3 don't know how to display 
tiled formats directly. But that's out of scope for this series.

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


