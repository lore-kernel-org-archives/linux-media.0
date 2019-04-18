Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E59C10F0E
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 22:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C932321479
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 22:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mh5N2WMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfDRWf3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:35:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46650 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfDRWf3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 18:35:29 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA2B8333;
        Fri, 19 Apr 2019 00:35:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555626926;
        bh=I24opBjybx4xXIZm7kWMtOvlyW8PM93XLEpTLtqKDR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mh5N2WMKkjW4CYwrhOLPi8sJQpmM7zFnhZ1dBgUHjCzwE13qYUsGU7CEj4DM1h+Cl
         yrKmrBoiHuSgVbWljcJ+rAnkn51eQCpsK8mv85OKqI95hl85CrBsVpnB1Onxcsiy9s
         wqUEM+X5uHDVKkCGvR/TQ5QoO1uqjSfH8hDe1zeU=
Date:   Fri, 19 Apr 2019 01:35:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: Re: [PATCH v3 1/2] media: exynos4-is: Properly report _MPLANE caps
Message-ID: <20190418223518.GI4794@pendragon.ideasonboard.com>
References: <CGME20190412092035epcas1p43412936a0fba75b1c548904e785fe23d@epcas1p4.samsung.com>
 <20190412092027.20410-1-boris.brezillon@collabora.com>
 <c1faa661-6631-00ae-836b-4f24b1ee408e@samsung.com>
 <1c4fc9c3-4c9e-475a-262a-1479f77e267b@xs4all.nl>
 <512d5fd1-e4d3-c074-1b13-886747e8db97@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <512d5fd1-e4d3-c074-1b13-886747e8db97@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sylwester,

On Fri, Apr 12, 2019 at 01:14:38PM +0200, Sylwester Nawrocki wrote:
> On 4/12/19 12:32, Hans Verkuil wrote:
> > On 4/12/19 12:16 PM, Sylwester Nawrocki wrote:
> >> On 4/12/19 11:20, Boris Brezillon wrote:
> >>> The fimc-isp-video.c and fimc-lite.c were missing the
> >>> V4L2_CAP_VIDEO_CAPTURE_MPLANE flag when reporting device caps.
> >>
> >> Th omission was intentional, as these video nodes cannot be used
> >> by "standard" V4L2 capture applications. Some sub-devices need to 
> >> be configured first in order to use these video nodes. It was 
> >> agreed to not set these capabilities in the driver, instead user
> >> space library, e.g. libv4l2 with driver-specific plugin handling
> >> the media controller and v4l2 subdev calls would set the capability
> >> for the applications. Has something changed?
> > 
> > I remember that this was discussed, but nobody actually followed that
> > guideline. Just do:
> >
> > git grep -l V4L2_CAP_VIDEO_CAPTURE drivers/media/platform
> > 
> > It really doesn't make sense to leave it out since userspace has to know if
> > it is single or multiplanar, and if you don't set this capability, then how
> > can it tell?
> 
> Presumably you can't by only querying the video device, this would require 
> MC and driver-specific user space. 
> 
> > I always thought we need a separate CAP or some other way of signaling this,
> > but the few times I proposed something it was always shot down.
> > 
> > So to be consistent with the other MC drivers you should set this MPLANE cap
> > as well in the fimc driver.
> 
> I'm not against the $subject patch, rather the opposite. Especially if 
> it is a part of reasonable API updates. But removing the capabilities was 
> actually a requirement to get the driver merged, not a guideline.
> And was rather painful then, now the driver is probably not in use any more
> so I don't really mind.

As this driver is quite old I assume there's little interest in
investing in it, but is there any chance Samsung would be interested in
contributing to libcamera for newer generations ? :-)

-- 
Regards,

Laurent Pinchart
