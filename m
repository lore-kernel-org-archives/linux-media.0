Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E842C433E0
	for <linux-media@archiver.kernel.org>; Thu, 28 Jan 2021 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E718564DFB
	for <linux-media@archiver.kernel.org>; Thu, 28 Jan 2021 15:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhA1PBi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:01:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:27999 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhA1PB3 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Jan 2021 10:01:29 -0500
IronPort-SDR: liIKv9x5+iY27GfigMB6o3UP71hWoTxaTLKBihYdDdadzuD2gHZF3b4NHXG00GDEIcdxR9x+/u
 FgOLhAfxmM8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="176737577"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="176737577"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 07:00:44 -0800
IronPort-SDR: JiRPmPzgAq84O04eJNU1hqAyw06hXPTrqyTNU4eQ7b/oEcF0+S0tk9qF7v8Jb0XMIifjfkBV4w
 tCH1/uzzzoiA==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="473819783"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 07:00:41 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1l58mk-0004cV-If; Thu, 28 Jan 2021 17:00:38 +0200
Date:   Mon, 25 Jan 2021 14:03:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] media: atomisp: Remove unused header
Message-ID: <YA6zm3DI6b92CcgK@smile.fi.intel.com>
References: <20210122123303.41190-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122123303.41190-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Jan 22, 2021 at 02:33:03PM +0200, Andy Shevchenko wrote:
> sfi.h is not anyhow used by the driver. Remove it.

Mauro, can you give your Ack to be able to merge this via other tree?

-- 
With Best Regards,
Andy Shevchenko


