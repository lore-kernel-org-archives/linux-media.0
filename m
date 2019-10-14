Return-Path: <SRS0=P/UY=YH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F58C4CECE
	for <linux-media@archiver.kernel.org>; Mon, 14 Oct 2019 12:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB2E2089C
	for <linux-media@archiver.kernel.org>; Mon, 14 Oct 2019 12:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfJNMeq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNMeq (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Oct 2019 08:34:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13F521108;
        Mon, 14 Oct 2019 12:34:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 797835C890;
        Mon, 14 Oct 2019 12:34:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EA30E16E2D; Mon, 14 Oct 2019 14:34:43 +0200 (CEST)
Date:   Mon, 14 Oct 2019 14:34:43 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dmitry Morozov <dmitry.morozov@opensynergy.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, stevensd@chromium.org,
        virtio-dev@lists.oasis-open.org,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        alexlau@chromium.org, dgreid@chromium.org,
        =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
        Pawel Osciak <posciak@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
Message-ID: <20191014123443.ey3yfdnr43kplqaq@sirius.home.kraxel.org>
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <4037801.MZecyecTDs@os-lin-dmo>
 <CAAFQd5CfNK1oisDaOWaW+9NTQOLn1EHPrPzvxMPcSxLkBgv3Ww@mail.gmail.com>
 <15135216.K0K410U5qv@os-lin-dmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15135216.K0K410U5qv@os-lin-dmo>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 14 Oct 2019 12:34:46 +0000 (UTC)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

  Hi,

> My take on this (for a decoder) would be to allocate memory for output buffers 
> from a secure ION heap, import in the v4l2 driver, and then to provide those 
> to the device using virtio. The device side then uses the dmabuf framework to 
> make the buffers accessible for the hardware. I'm not sure about that, it's 
> just an idea.

Virtualization aside, how does the complete video decoding workflow
work?  I assume along the lines of ...

  (1) allocate buffer for decoded video frames (from ion).
  (2) export those buffers as dma-buf.
  (3) import dma-buf to video decoder.
  (4) import dma-buf to gpu.

... to establish buffers shared between video decoder and gpu?

Then feed the video stream into the decoder, which decodes into the ion
buffers?  Ask the gpu to scanout the ion buffers to show the video?

cheers,
  Gerd

