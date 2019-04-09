Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B980C10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D7420818
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 09:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDIJTO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:19:14 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:37691 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDIJTO (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 05:19:14 -0400
X-IronPort-AV: E=Sophos;i="5.60,328,1549929600"; 
   d="scan'208";a="83088170"
Date:   Tue, 9 Apr 2019 10:19:11 +0100
From:   Wei Liu <wei.liu2@citrix.com>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <jgross@suse.com>, <hverkuil@xs4all.nl>,
        <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen/cameraif: add ABI for para-virtual camera
Message-ID: <20190409091911.GJ1986@zion.uk.xensource.com>
References: <20190409091546.9606-1-andr2000@gmail.com>
 <20190409091832.GA2164@zion.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190409091832.GA2164@zion.uk.xensource.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Apr 09, 2019 at 10:18:32AM +0100, Wei Liu wrote:
> On Tue, Apr 09, 2019 at 12:15:46PM +0300, Oleksandr Andrushchenko wrote:
> > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > 
> > This is the ABI for the two halves of a para-virtualized
> > camera driver which extends Xen's reach multimedia capabilities even
> > further enabling it for video conferencing, In-Vehicle Infotainment,
> > high definition maps etc.
> > 
> > The initial goal is to support most needed functionality with the
> > final idea to make it possible to extend the protocol if need be:
> > 
> > 1. Provide means for base virtual device configuration:
> >  - pixel formats
> >  - resolutions
> >  - frame rates
> > 2. Support basic camera controls:
> >  - contrast
> >  - brightness
> >  - hue
> >  - saturation
> > 3. Support streaming control
> > 
> > Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> v6 was pushed yesterday. Is there anything new in this version?

Oh my bad. This is a patch to Linux. Ignore that question.

Wei.
