Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B3EB64D9
	for <linux-media@archiver.kernel.org>; Tue, 27 Jun 2023 20:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjF0Uzq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Jun 2023 16:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF0Uzo (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Jun 2023 16:55:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944AE10D2
        for <linux-media@vger.kernel.org>; Tue, 27 Jun 2023 13:55:43 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448064609"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="448064609"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 13:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="861242456"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="861242456"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2023 13:55:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qEFis-000QF1-30;
        Tue, 27 Jun 2023 23:55:38 +0300
Date:   Tue, 27 Jun 2023 23:55:38 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH 09/12] media: ipu3-cio2: Move cio2_bridge_init() code
 into a new shared intel-cio2-bridge.ko
Message-ID: <ZJtMysrWwpKb7woL@smile.fi.intel.com>
References: <20230627175643.114778-1-hdegoede@redhat.com>
 <20230627175643.114778-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627175643.114778-10-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Jun 27, 2023 at 07:56:39PM +0200, Hans de Goede wrote:
> Move all the code implementing cio2_bridge_init() into a new shared
> intel-cio2-bridge.ko, so that it can be reused by the atomisp driver
> (and maybe also by the future IPU6 CSI2 driver).
> 
> Note this just moves a bunch of stuff around prefixes some symbols /
> defines with intel_ / INTEL_ no functional changes.

...

> +EXPORT_SYMBOL(intel_cio2_bridge_init);

Why not GPL?
Perhaps namespace?

...

Seems to me that name CIO2 in AtomISP case sounds a bit weird.
Maybe ipu/isp should be used instead?

-- 
With Best Regards,
Andy Shevchenko


