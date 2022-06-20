Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71565C433EF
	for <linux-media@archiver.kernel.org>; Mon, 20 Jun 2022 09:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbiFTJw6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbiFTJww (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 20 Jun 2022 05:52:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9ABD0;
        Mon, 20 Jun 2022 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655718771; x=1687254771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bbKxKH/SYPWm+cxwUF5Vsfm6/HyWDbMqK/8UZOAOmFs=;
  b=cExCMGfslYwOpLdl/BqDNtvSMIwzwliE1u/domUMOpBndXW3c07zfc4x
   54ItBHXGPLHfQdlHx6wCcILFkAHCIP4imTwt8ZcQu1nhLh/6yYwz/xJRU
   FvjKbZEpF+PMtLDxUElNL7HEerTCmRkGL/sGIWbuV+60hzFnWwx6OozAl
   ljRQJ6BrnrCpZNJmUv97tRwKRCSqJ+6LBx3XyDuoqCxWF/hhrLIw1g0eR
   M/XfLxr0F+k2r5fP+IAsF7kdg00sN6f8yR5o5mO0ZelzLEHtw9h6MOPmq
   F/SMbFbSbGZagW1T7fAgQ7LET5oNKvgLO2kSb5Ptno/btkhl77mjuqkFt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277402178"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277402178"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:52:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="833039628"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:52:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3E5O-000h48-Ro;
        Mon, 20 Jun 2022 12:52:46 +0300
Date:   Mon, 20 Jun 2022 12:52:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, djrscally@gmail.com,
        sakari.ailus@linux.intel.com
Subject: Re: [PATCH] media: ov7251: add missing clk_disable_unprepare() on
 error in ov7251_set_power_on()
Message-ID: <YrBDbjS8rAGM4t4u@smile.fi.intel.com>
References: <20220617013943.851327-1-yangyingliang@huawei.com>
 <YqxVWg21PsdkMz2Y@smile.fi.intel.com>
 <a6731874-1c72-898e-fe8f-8d08d4a4d74e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6731874-1c72-898e-fe8f-8d08d4a4d74e@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Jun 20, 2022 at 04:48:46PM +0800, Yang Yingliang wrote:
> On 2022/6/17 18:20, Andy Shevchenko wrote:
> > On Fri, Jun 17, 2022 at 09:39:43AM +0800, Yang Yingliang wrote:

...

> > >   	if (ret < 0) {
> > >   		dev_err(ov7251->dev, "error during global init\n");
> > > +		clk_disable_unprepare(ov7251->xclk);
> > >   		ov7251_regulators_disable(ov7251);
> > Logically it should go here. Please, read a code above this check.
> Do you mean print the error code on error path ?

The new code, you added, should be in correct order (reversed in comparison to
resource allocation / registration).

> > >   		return ret;
> > >   	}

-- 
With Best Regards,
Andy Shevchenko


