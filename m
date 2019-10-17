Return-Path: <SRS0=c9eX=YK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5604EFA372A
	for <linux-media@archiver.kernel.org>; Thu, 17 Oct 2019 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3289421835
	for <linux-media@archiver.kernel.org>; Thu, 17 Oct 2019 10:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408745AbfJQKNG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfJQKNG (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Oct 2019 06:13:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6CDB44BD1;
        Thu, 17 Oct 2019 10:13:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36A535D712;
        Thu, 17 Oct 2019 10:13:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 66EC811AAA; Thu, 17 Oct 2019 12:13:04 +0200 (CEST)
Date:   Thu, 17 Oct 2019 12:13:04 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Dmitry Morozov <dmitry.morozov@opensynergy.com>,
        David Stevens <stevensd@chromium.org>,
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
Message-ID: <20191017101304.pbjoj3knyveuacqm@sirius.home.kraxel.org>
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <4037801.MZecyecTDs@os-lin-dmo>
 <CAAFQd5CfNK1oisDaOWaW+9NTQOLn1EHPrPzvxMPcSxLkBgv3Ww@mail.gmail.com>
 <15135216.K0K410U5qv@os-lin-dmo>
 <CAAFQd5DuChujakwmhtQ8v2CSLFqVYjLz9eGHuqrQnJ7apft+3Q@mail.gmail.com>
 <20191017071952.s3dq2oxdiy3khp5w@sirius.home.kraxel.org>
 <CAAFQd5ByuyTDqwiBeT7U7cVA8omOPGRRxb2tB8=J-u7WYU-urQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5ByuyTDqwiBeT7U7cVA8omOPGRRxb2tB8=J-u7WYU-urQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 17 Oct 2019 10:13:06 +0000 (UTC)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

  Hi,

> That could be still a guest physical address. Like on a bare metal
> system with TrustZone, there could be physical memory that is not
> accessible to the CPU.

Hmm.  Yes, maybe.  We could use the dma address of the (first page of
the) guest buffer.  In case of a secure buffer the guest has no access
to the guest buffer would be unused, but it would at least make sure
that things don't crash in case someone tries to map & access the
buffer.

The host should be able to figure the corresponding host buffer from the
guest buffer address.

When running drm-misc-next you should be able to test whenever that'll
actually work without any virtio-gpu driver changes.

cheers,
  Gerd

