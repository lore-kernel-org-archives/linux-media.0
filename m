Return-Path: <SRS0=oIBZ=4N=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D2FC35DF5
	for <linux-media@archiver.kernel.org>; Tue, 25 Feb 2020 06:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7F320656
	for <linux-media@archiver.kernel.org>; Tue, 25 Feb 2020 06:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6IBxZge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgBYGKT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:10:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729003AbgBYGKT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 25 Feb 2020 01:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582611018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cQNaTh1HwhNOEGJ51j3glAMwSw4Nt/oACsQTPYH5feA=;
        b=F6IBxZgeKFRzU7Gg6j43ovR8/WNlwMWPm5i4z2xtmmwnf0xKJTdUIOi2lsjD/1bT0wWZ4h
        43m6VKuwxLAHeYTdE61qC/ql2qIa3QCjkA6XzyPpHELum5xlJpyjQOILAPWqwcsjE2BDIz
        uW8qZ+DBQScbUsGHOlKdUK/MetxL7V4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-DYyKaKDLN3CegtXVUSCMDQ-1; Tue, 25 Feb 2020 01:10:14 -0500
X-MC-Unique: DYyKaKDLN3CegtXVUSCMDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DBCF107ACC4;
        Tue, 25 Feb 2020 06:10:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-87.ams2.redhat.com [10.36.116.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10680385;
        Tue, 25 Feb 2020 06:10:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2C95F1747F; Tue, 25 Feb 2020 07:10:08 +0100 (CET)
Date:   Tue, 25 Feb 2020 07:10:08 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH 1/2] virtio: add dma-buf support for exported objects
Message-ID: <20200225061008.wqxqppfglzmwvtid@sirius.home.kraxel.org>
References: <20200219080637.61312-1-stevensd@chromium.org>
 <20200219080637.61312-2-stevensd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219080637.61312-2-stevensd@chromium.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Feb 19, 2020 at 05:06:36PM +0900, David Stevens wrote:
> This change adds a new flavor of dma-bufs that can be used by virtio
> drivers to share exported objects. A virtio dma-buf can be queried by
> virtio drivers to obtain the UUID which identifies the underlying
> exported object.

That duplicates a bunch of code from dma-buf.c in virtio_dma_buf.c.

How about dma_buf_{get,set}_uuid, simliar to dma_buf_set_name?

cheers,
  Gerd

