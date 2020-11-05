Return-Path: <SRS0=XB3O=EL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084AC4742C
	for <linux-media@archiver.kernel.org>; Thu,  5 Nov 2020 12:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6E5206DB
	for <linux-media@archiver.kernel.org>; Thu,  5 Nov 2020 12:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgKEM6b (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:58:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:58714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgKEM6b (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 5 Nov 2020 07:58:31 -0500
IronPort-SDR: 7J/8b7NAtNvFj8pp7F94jMlY9W7Zm+UvJrSXn7NY3UdzUKrNBvGR5hy4v68wvBJm4z5Rluc8ad
 xfVmfLPXrWyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="254082198"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="254082198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 04:58:31 -0800
IronPort-SDR: JOIy50hxA0eDjLE7kfO0qWVKnXwU+pruQuLUB5NQHuLHzWEHVFXXXRcnW2CHLJxIHuBi/S6LFn
 frgGug74NgqQ==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="527953307"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 04:58:30 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 263A220901; Thu,  5 Nov 2020 14:58:29 +0200 (EET)
Date:   Thu, 5 Nov 2020 14:58:29 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCH v2 099/106] v4l: uapi: ccs: Add controls for analogue
 gain constants
Message-ID: <20201105125828.GH26150@paasikivi.fi.intel.com>
References: <20201007084505.25761-1-sakari.ailus@linux.intel.com>
 <20201007084557.25843-1-sakari.ailus@linux.intel.com>
 <20201007084557.25843-90-sakari.ailus@linux.intel.com>
 <8dd2be66-e253-e535-ecfc-f51747204424@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd2be66-e253-e535-ecfc-f51747204424@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

On Thu, Nov 05, 2020 at 01:56:02PM +0100, Hans Verkuil wrote:
> On 07/10/2020 10:45, Sakari Ailus wrote:
> > Add a V4L2 controls for analogue gai constants required to control
> > analogue gain. The values are device specific and thus need to be obtained
> > from the driver.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  MAINTAINERS              |  1 +
> >  include/uapi/linux/ccs.h | 14 ++++++++++++++
> >  2 files changed, 15 insertions(+)
> >  create mode 100644 include/uapi/linux/ccs.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b72f666b8b60..c173e503b0b7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11569,6 +11569,7 @@ F:	drivers/media/i2c/ccs/
> >  F:	drivers/media/i2c/ccs-pll.c
> >  F:	drivers/media/i2c/ccs-pll.h
> >  F:	include/uapi/linux/smiapp.h
> > +F:	include/uapi/linux/ccs.h
> >  
> >  MIPS
> >  M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > diff --git a/include/uapi/linux/ccs.h b/include/uapi/linux/ccs.h
> > new file mode 100644
> > index 000000000000..bcdce95955b0
> > --- /dev/null
> > +++ b/include/uapi/linux/ccs.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only AND BSD-3-Clause */
> > +/* Copyright (C) 2020 Intel Corporation */
> > +
> > +#ifndef __UAPI_CCS_H__
> > +#define __UAPI_CCS_H__
> 
> What does CCS stand for? Provide a reference to the standard as well.
> 
> Just looking at this header doesn't give you any clue as to what it
> related to.

I'll add references to driver documentation I'm about to write to address
Mauro's review comments. CCS stands for Camera Command Set.

The spec can be found here:

<URL:https://www.mipi.org/specifications/camera-command-set>

-- 
Regards,

Sakari Ailus
