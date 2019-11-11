Return-Path: <SRS0=OUaH=ZD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B817C43331
	for <linux-media@archiver.kernel.org>; Mon, 11 Nov 2019 15:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B0421783
	for <linux-media@archiver.kernel.org>; Mon, 11 Nov 2019 15:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKPgr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:36:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:60068 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfKKPgq (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 11 Nov 2019 10:36:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 07:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="215709477"
Received: from jlahtine-desk.ger.corp.intel.com ([10.252.20.50])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2019 07:36:39 -0800
Message-ID: <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
From:   Liam Girdwood <liam.r.girdwood@linux.intel.com>
To:     David Stevens <stevensd@chromium.org>,
        Stefan Hajnoczi <stefanha@gmail.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
        Alex Lau <alexlau@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Dmitry Morozov <dmitry.morozov@opensynergy.com>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Date:   Mon, 11 Nov 2019 15:36:38 +0000
In-Reply-To: <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
         <20191106084344.GB189998@stefanha-x1.localdomain>
         <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 2019-11-11 at 12:04 +0900, David Stevens wrote:
> Having a centralized buffer allocator device is one way to deal with
> sharing buffers, since it gives a definitive buffer identifier that
> can be used by all drivers/devices to refer to the buffer. That being
> said, I think the device as proposed is insufficient, as such a
> centralized buffer allocator should probably be responsible for
> allocating all shared buffers, not just linear guest ram buffers.

This would work for audio. I need to be able to :-

1) Allocate buffers on guests that I can pass as SG physical pages to
DMA engine (via privileged VM driver) for audio data. Can be any memory
as long as it's DMA-able.

2) Export hardware mailbox memory (in a real device PCI BAR) as RO to
each guest to give guests low latency information on each audio stream.
To support use cases like voice calls, gaming, system notifications and
general audio processing.

Liam

