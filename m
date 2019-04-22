Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0075FC10F11
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D119920881
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 15:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfDVPM3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:12:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47794 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfDVPM3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 11:12:29 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A9988260C42;
        Mon, 22 Apr 2019 16:12:26 +0100 (BST)
Date:   Mon, 22 Apr 2019 17:12:23 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 14/15] rockchip/vpu: Add support for MPEG-2 decoding
Message-ID: <20190422171223.48cd51fc@collabora.com>
In-Reply-To: <DB8PR03MB5898C649C628B6FDEF4E2C80AC220@DB8PR03MB5898.eurprd03.prod.outlook.com>
References: <20190422080818.29130-1-boris.brezillon@collabora.com>
        <20190422080818.29130-15-boris.brezillon@collabora.com>
        <DB8PR03MB5898C649C628B6FDEF4E2C80AC220@DB8PR03MB5898.eurprd03.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 22 Apr 2019 14:59:17 +0000
Jonas Karlman <jonas@kwiboo.se> wrote:

> On 2019-04-22 10:08, Boris Brezillon wrote:
> > From: Ezequiel Garcia <ezequiel@collabora.com>  
> 
> Please restore my commit authorship, it seems to have changed in v3.

Oops, sorry about that, it was not intentional.

> 
> I would appreciate if you can pick the fixups from [1] and [2] to sync rk3288/rk3399 code.

Sure, I'll have a look.

> Please also squash both MPEG-2 commits, that is closer to the original commit at [4].

Hm, okay. I thought it'd be preferable to split that in 2 or even 3
commits (one adding the core infra and one per platform), but if
everyone is okay with having things squashed in a single commit I'll do
that.

> 
> This module seems to crash after repeated rmmod / insmod, calls to video_device_release
> seems to be the culprit for crash. There is also an issue with uneven pm runtime autosuspend calls
> leaving clocks enabled when module is unloaded.
> 
> Feel free to pick/squash any of the changes at [3], they fixes the crash and uneven autosuspend for me.

Will do.

> 
> MPEG-2 decoding is working on my RK3288 and RK3399 devices.
> 
> Fixup commits:
> [1] https://github.com/Kwiboo/linux-rockchip/commit/8d8b5aca522176d17b6a0f13da57fd9b8e7d1e9a
> [2] https://github.com/Kwiboo/linux-rockchip/commit/75de5f322ffe889154832f6ebfb08e48257af526
> [3] https://github.com/Kwiboo/linux-rockchip/commit/0729b53c825a630c9040d28541d2635a42177361
> 
> Original MPEG-2 commit:
> [4] https://github.com/Kwiboo/linux-rockchip/commit/25d9502927540c6f17c65d52a350b28c664cbf5a
> 
> Thanks,

Thanks for reviewing/testing/debugging.

Boris
