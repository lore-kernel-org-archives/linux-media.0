Return-Path: <SRS0=/yKV=XG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5FBECDE20
	for <linux-media@archiver.kernel.org>; Wed, 11 Sep 2019 08:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818202168B
	for <linux-media@archiver.kernel.org>; Wed, 11 Sep 2019 08:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfIKI1W (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:27:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52926 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfIKI1W (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 11 Sep 2019 04:27:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 47C1428DCE0
Message-ID: <6e493142690d48ee7e65c1cb2a4d6aec1e3b671b.camel@collabora.com>
Subject: Re: [PATCH 0/4] Enable Hantro G1 post-processor
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        kernel@collabora.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chris Healy <cphealy@gmail.com>
Date:   Wed, 11 Sep 2019 09:27:16 +0100
In-Reply-To: <CAAFQd5AdikoN+7TG=0ZGFkSzaK2UFHM4VG7SYtfUtmjQgD61zA@mail.gmail.com>
References: <20190903181711.7559-1-ezequiel@collabora.com>
         <CAAFQd5AdikoN+7TG=0ZGFkSzaK2UFHM4VG7SYtfUtmjQgD61zA@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 2019-09-09 at 16:07 +0900, Tomasz Figa wrote:
> Hi Ezequiel,
> 
> On Wed, Sep 4, 2019 at 3:17 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > Hi all,
> > 
> > This series enables the post-processor support available
> > on the Hantro G1 VPU. The post-processor block can be
> > pipelined with the decoder hardware, allowing to perform
> > operations such as color conversion, scaling, rotation,
> > cropping, among others.
> > 
> > The decoder hardware needs its own set of NV12 buffers
> > (the native decoder format), and the post-processor is the
> > owner of the CAPTURE buffers. This allows the application
> > get processed (scaled, converted, etc) buffers, completely
> > transparently.
> > 
> > This feature is implemented by exposing other CAPTURE pixel
> > formats to the application (ENUM_FMT). When the application
> > sets a pixel format other than NV12, the driver will enable
> > and use the post-processor transparently.
> 
> I'll try to review the series a bit later, but a general comment here
> is that the userspace wouldn't have a way to distinguish between the
> native and post-processed formats. I'm pretty much sure that
> post-processing at least imposes some power penalty, so it would be
> good if the userspace could avoid it if unnecessary.
> 

Hm, that's true, good catch.

So, it would be desirable to retain the current behavior of allowing
the application to just set a different pixel format and get
a post-processed frame, transparently.

But at the same time, it would be nice if the application is somehow
aware of the post-processing happening. Maybe we can expose a more
accurate media controller topology, have applications enable
the post-processing pipeline explicitly.

Thanks for the feedback,
Ezequiel

