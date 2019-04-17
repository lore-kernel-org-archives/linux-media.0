Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD5C10F12
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B132173C
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbfDQKlw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:41:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:9722 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbfDQKlv (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 06:41:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 03:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="132120109"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007.jf.intel.com with ESMTP; 17 Apr 2019 03:41:49 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 96729204DA; Wed, 17 Apr 2019 13:41:48 +0300 (EEST)
Date:   Wed, 17 Apr 2019 13:41:48 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org
Subject: Route lifetime in SUBDEV_[GS]_ROUTING
Message-ID: <20190417104147.zlmbw32dr46vmtrq@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

I promised to write a bit about the routing problem I attempted to write on
#v4l. It's a bit late, but here it is. Let me know if you share my
understanding (and especially do so if you don't :)).

A route is identified by the source and sink pads as well as the stream ID
on the source and the sink pads. Its flags allow enabling or disabling a
route.

Most devices that function as transmitters (such as sensors) have a fixed
number of routes they can support. These's no need to change them; enabling
and disabling them will be enough for the user.

For receivers this is different. What needs to be supported on the receiver
side is directing any incoming stream (a 32-bit unsigned integer) to any
source pad.

This is because pads are not alike --- one may be connected to a block that
further processes the image whereas the others may be connected to a DMA
engine, just writing the data to memory.

The receivers also may not make assumptions beyond the sub-device API: the
stream is a 32-bit unsigned integer, there is currently no API requirement
to have the stream IDs on a particular low integer range. In principle we
could define that range, but I'd rather try to find better solutions than
that: it's hard to come up with a number as it depends on the hardware.
Some kind of an upper limit could be the number of CSI-2 channels
multiplied by CSI-2 data types. That would be enough for CSI-2. 16 or 32
virtual channels and up to 64 data types would mean up to 2048 routes
between a demultiplexer's sink pad and *each* of its source pads. And this
comes with an assumption that the source pads only support a single
stream...

CSI-2 receivers support a number of simultaneous streams, and as the stream
is demultiplexed there, this means there will be as many source pads as
there are supported simultaneous streams. This heavily depends on the
hardware, but the number could be e.g. 1, 4 or 8. Much smaller than 2048 in
any case.

Another option could be creating no routes at all at device init time, and
letting the user create them. We could add a new flag for routes telling
that a route is dynamic: disabling a dynamic route would simply delete it.
Likewise, a SUBDEV_G_ROUTING returning no routes (but no error either)
would also tell the user only dynamic routes are supported.

We should document this and change the driver implementation accordingly.
No API changes are needed (apart from adding the dynamic flag --- or rather
call it "volatile", to avoid confusing with routes that can be enabled or
disabled while streaming).

-- 
Best regards,

Sakari Ailus
sakari.ailus@linux.intel.com
