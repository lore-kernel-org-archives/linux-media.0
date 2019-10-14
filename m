Return-Path: <SRS0=P/UY=YH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF1C4CECE
	for <linux-media@archiver.kernel.org>; Mon, 14 Oct 2019 08:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFE420673
	for <linux-media@archiver.kernel.org>; Mon, 14 Oct 2019 08:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfJNIyx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbfJNIyx (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Oct 2019 04:54:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F254F800DF4;
        Mon, 14 Oct 2019 08:54:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2CC819C58;
        Mon, 14 Oct 2019 08:54:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EDE1D16E2D; Mon, 14 Oct 2019 10:54:51 +0200 (CEST)
Date:   Mon, 14 Oct 2019 10:54:51 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        chris@chris-wilson.co.uk, sumit.semwal@linaro.org
Subject: Re: [PATCH 1/3] dma-buf: add dma_resv_ctx for deadlock handling
Message-ID: <20191014085451.jsdxfbp4oq7fikmj@sirius.home.kraxel.org>
References: <20190918175525.49441-1-christian.koenig@amd.com>
 <20191008151639.GP16989@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008151639.GP16989@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Mon, 14 Oct 2019 08:54:53 +0000 (UTC)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

  Hi,

> - doing this over dma-buf means we can only use this for the ww_mutx
>   dance, not for anything else. Which means we need another layer on top
>   for shared execbuf utils (which Gerd has started looking into, but I
>   felt like not quite the right approach yet in his first draft series).

FYI: this is in virtio-gpu for now, see virtio_gpu_array_*
in drivers/gpu/drm/virtio/virtgpu_gem.c

cheers,
  Gerd

