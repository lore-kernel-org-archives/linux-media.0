Return-Path: <SRS0=AJrZ=SI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CDCC10F06
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 11:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800182087F
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 11:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554549610;
	bh=h1ctkwSPdjXhWKWs7p1LK9H54mE/3X2zJFNDoBltTSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=j2OrsyKVY3C0pNBTL5szuW0BFxRcDi6jk4m3CiswKd/lLU6DTUI9UZ7xCpdEll+ai
	 N631FP/0tjj5SHnmc1ZYTHOnpnoIn6d64x8I7L+LRsRBHf5l3c5W+bZiJhEIAvbIJK
	 0hgQogjcmpwy/lUHy4O6PZZ2gqLMvgPCGAVlDLrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDFLTy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 6 Apr 2019 07:19:54 -0400
Received: from casper.infradead.org ([85.118.1.10]:47378 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLTy (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 6 Apr 2019 07:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=36cobv9y3uv8Few4hBPfsUncA8FBHMA9GDSnn52RCUI=; b=iAn9QryNMr25xxLHZJ8lSQEksG
        z/YuzmKMNHmzLmFqWsCgwbcig8Ae8G1mSRB4Fk8ypyLklljzxHo4w6Ql7tpVBR8sw4HmyRFN7TKo/
        KPlLbztsMOTL9V1EpBKEuURn69zqastxyi8V3PNz49E3nvNJgyeuK82qry2kZ6wvSWbVz8CervSEL
        Pel+CvfkBSE2T1XaDZ3x4GzqwwaiJZVxRxTKFfpV5DcUAZQY6eZLsovQwEm2yRDcLNBN/FewnT+fs
        nc6qjHLHGRjkrVLpjaV3TeCxyyQSNJsDSJYXIQdcZXsEWk9wRfcmKeMgcxTYhCMo26YNorlzi0CcY
        BfazZoDw==;
Received: from 177.133.5.77.dynamic.adsl.gvt.net.br ([177.133.5.77] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCjMK-0002D5-4l; Sat, 06 Apr 2019 11:19:40 +0000
Date:   Sat, 6 Apr 2019 08:19:33 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>, p.zabel@pengutronix.de,
        javierm@redhat.co, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        jacopo+renesas@jmondi.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v5 00/13] TVP5150 new features
Message-ID: <20190406081933.3cc761e8@coco.lan>
In-Reply-To: <20190405060317.11240-1-m.felsch@pengutronix.de>
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Marco,

Em Fri,  5 Apr 2019 08:03:04 +0200
Marco Felsch <m.felsch@pengutronix.de> escreveu:

> Hi,
> 
> few months ago I send my v4 of this series [1] unfortunately I got no
> feedback from Mauro but Jacopos feedback was quite helpfull =)
> 
> After my v4 I send another series which adds a generic way to parse
> connector endpoints [2]. To make it easier for everyone I squashed both
> series [1,2] into this one.
> 
> I recognized that patch ("media: v4l2-subdev: add stubs for
> v4l2_subdev_get_try_*") was a possible blocker for this series so I
> factored the patch out [3].
> 
> My main goal with the v5 was to simplify the link_setup() code a lot.
> There were also some build-dep issues which I fixed too. Last
> significant improvement is done on patch ("media: tvp5150: add
> support to limit tv norms on connector").
> 
> I've tested it on a custom hardware and compile tested it too.
> 
> @Mauro
> Please let me know how I can help you to speed up the review progress
> since I wanted to get those changes merged in the near future =)

I asked Hans to do the review. I prefer that he would do reviews
on patches from V4L2 drivers. Also, I'm currently OOT.


> 
> @Sakari, Hans
> I've added you to the series since I made some core changes.
> 
> New patches (wasn't part of [1] or [2]):
>   media: dt-bindings: tvp5150: cleanup bindings stlye
>   media: dt-bindings: tvp5150: add optional tvnorms documentation
>   media: tvp5150: make debug output more readable
> 
> New (squashed) patches (was part of [2]):
>   dt-bindings: connector: analog: add tv norms property
>   media: v4l2-fwnode: add v4l2_fwnode_connector
>   media: v4l2-fwnode: add initial connector parsing support
>   media: tvp5150: add support to limit tv norms on connector
> 
> Droped patches:
>   media: v4l2-subdev: add stubs for v4l2_subdev_get_try_*
> 
> [1] https://patchwork.ozlabs.org/cover/1032891/
> [2] https://patchwork.kernel.org/cover/10794703/
> [3] https://www.mail-archive.com/linux-media@vger.kernel.org/msg146065.html
> 
> Regards,
> 	Marco
> 
> Javier Martinez Canillas (1):
>   partial revert of "[media] tvp5150: add HW input connectors support"
> 
> Marco Felsch (11):
>   dt-bindings: connector: analog: add tv norms property
>   media: v4l2-fwnode: add v4l2_fwnode_connector
>   media: v4l2-fwnode: add initial connector parsing support
>   media: tvp5150: add input source selection of_graph support
>   media: dt-bindings: tvp5150: Add input port connectors DT bindings
>   media: tvp5150: add FORMAT_TRY support for get/set selection handlers
>   media: tvp5150: add s_power callback
>   media: dt-bindings: tvp5150: cleanup bindings stlye
>   media: dt-bindings: tvp5150: add optional tvnorms documentation
>   media: tvp5150: add support to limit tv norms on connector
>   media: tvp5150: make debug output more readable
> 
> Michael Tretter (1):
>   media: tvp5150: initialize subdev before parsing device tree
> 
>  .../display/connector/analog-tv-connector.txt |   4 +
>  .../devicetree/bindings/media/i2c/tvp5150.txt | 125 +++-
>  drivers/media/i2c/tvp5150.c                   | 673 +++++++++++++-----
>  drivers/media/v4l2-core/v4l2-fwnode.c         | 113 +++
>  include/dt-bindings/media/tvnorms.h           |  42 ++
>  include/dt-bindings/media/tvp5150.h           |   2 -
>  include/media/v4l2-connector.h                |  34 +
>  include/media/v4l2-fwnode.h                   |  49 ++
>  8 files changed, 850 insertions(+), 192 deletions(-)
>  create mode 100644 include/dt-bindings/media/tvnorms.h
>  create mode 100644 include/media/v4l2-connector.h
> 



Thanks,
Mauro
