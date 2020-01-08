Return-Path: <SRS0=i92q=25=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACE4C282DD
	for <linux-media@archiver.kernel.org>; Wed,  8 Jan 2020 12:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53F92077B
	for <linux-media@archiver.kernel.org>; Wed,  8 Jan 2020 12:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLeVYVei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgAHM7s (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:59:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43781 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAHM7s (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 8 Jan 2020 07:59:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so2447722edb.10
        for <linux-media@vger.kernel.org>; Wed, 08 Jan 2020 04:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaemZRWcMq37fip2p7cOsBNJ6/qsTNjchTCq1eUTMrE=;
        b=OLeVYVeiMpzCyt95hwX/CBNv7CSsvpQa+k8fhgTtUUZhaDS6qc5EcVCP0vVsd3+T/f
         WQvlgCX5DfHKkRq7zrUfZc4+IRK5s/DgLIvp9k8k7m2L2DsOr8PKhIF2rLsAQt3NmpCQ
         c1uaK2C/84QmvjPW7tIdEusjIEjt0zpd82h8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaemZRWcMq37fip2p7cOsBNJ6/qsTNjchTCq1eUTMrE=;
        b=C8Ih/cYAoIv+15+4I1daPhJVjBEtf3ipsYw4gmWkAArTJuevx5N4zXk7/n60FQmPjv
         4kqBAFS3+oD/HwaKQJkqEPSXbWcWmw+iz4rbbP0qRLhfqwZAWF+R+tSuIqYrqqfsyaNu
         ggNeAlltV9AuSXm8JjEU7fPaK7LtL3odksucw09q1Qg/+pWV4ILf+sKo04cXHVmVOPcO
         qVEiMIj7ojQJtmrhpyW0efCljH0NSWLd4erKi+pNOmWqlZQPeBf/7uo/1n1dHUPjI0t6
         fam6IvgT9hMX7kdkg5OoYUQIOqFcun9HrmCzvKPGZS1uh9Z1KTuMlTKQ75vT/w/R4RuT
         ZqIg==
X-Gm-Message-State: APjAAAWYzj3n449VEVTgIpZ43Nw4p2BXspvxMc0QDCQWR889rAMpjkVl
        sidlUWIEh6Gqz63KOrSUMgitjfRCPVTx4w==
X-Google-Smtp-Source: APXvYqyn6bSXQHdwzTiqe4RlU8sfdtZw/mD5FvrfwXQ/l3+eqIemS5/4Pqm6ZUefmw1dz6l1/EO6JQ==
X-Received: by 2002:a05:6402:68b:: with SMTP id f11mr5285905edy.61.1578488386191;
        Wed, 08 Jan 2020 04:59:46 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id d22sm66854edp.28.2020.01.08.04.59.45
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 04:59:45 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id p17so2407934wma.1
        for <linux-media@vger.kernel.org>; Wed, 08 Jan 2020 04:59:45 -0800 (PST)
X-Received: by 2002:a1c:2355:: with SMTP id j82mr3863056wmj.135.1578488384818;
 Wed, 08 Jan 2020 04:59:44 -0800 (PST)
MIME-Version: 1.0
References: <HE1PR06MB4011EDD5F2686A05BC35F61CAC790@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20191106223408.2176-1-jonas@kwiboo.se> <HE1PR06MB4011FF930111A869E4645C8CAC790@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <CAAFQd5CSWea=DNjySJxZmVi+2c5U4EKVPa1mf3vHh70+YrAQCA@mail.gmail.com> <7b92111b0c6443653de45f1eeec867645c127f32.camel@collabora.com>
In-Reply-To: <7b92111b0c6443653de45f1eeec867645c127f32.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 8 Jan 2020 21:59:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CZo5g2gtuvU+OuoRj18ZcCH8XEinGyAjRxqUXRfSQhgg@mail.gmail.com>
Message-ID: <CAAFQd5CZo5g2gtuvU+OuoRj18ZcCH8XEinGyAjRxqUXRfSQhgg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] media: hantro: Reduce H264 extra space for motion vectors
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Dec 10, 2019 at 3:11 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> On Wed, 2019-11-20 at 21:44 +0900, Tomasz Figa wrote:
> > Hi Jonas,
> >
> > On Thu, Nov 7, 2019 at 7:34 AM Jonas Karlman <jonas@kwiboo.se> wrote:
> > > A decoded 8-bit 4:2:0 frame need memory for up to 448 bytes per
> > > macroblock with additional 32 bytes on multi-core variants.
> > >
> > > Memory layout is as follow:
> > >
> > > +---------------------------+
> > > > Y-plane   256 bytes x MBs |
> > > +---------------------------+
> > > > UV-plane  128 bytes x MBs |
> > > +---------------------------+
> > > > MV buffer  64 bytes x MBs |
> > > +---------------------------+
> > > > MC sync          32 bytes |
> > > +---------------------------+
> > >
> > > Reduce the extra space allocated now that motion vector buffer offset no
> > > longer is based on the extra space.
> > >
> > > Only allocate extra space for 64 bytes x MBs of motion vector buffer
> > > and 32 bytes for multi-core sync.
> > >
> > > Fixes: a9471e25629b ("media: hantro: Add core bits to support H264 decoding")
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > > Changes in v3:
> > >   - add memory layout to code comment (Boris)
> > > Changes in v2:
> > >   - updated commit message
> > > ---
> > >  drivers/staging/media/hantro/hantro_v4l2.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> >
> > Thanks for the patch!
> >
> > What platform did you test it on and how? Was it tested with IOMMU enabled?
>
> Hello Tomasz,
>
> Please note that this series has been picked-up and is merged
> in v5.5-rc1.
>
> IIRC, we tested these patches on RK3399 and RK3288 (that means
> with an IOMMU). I've just ran some more extensive tests on RK3288,
> on media/master; and I plan to test some more on RK3399 later this week.
>
> Do you have any specific concern in mind?

I specifically want to know whether we're 100% sure that those sizes
are correct. The IOMMU still works on page granularity so it's
possible that the allocation could be just big enough by luck.

Best regards,
Tomasz
