Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F7FC433FE
	for <linux-media@archiver.kernel.org>; Mon, 14 Nov 2022 12:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiKNMTI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Nov 2022 07:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiKNMTH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Nov 2022 07:19:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF921E
        for <linux-media@vger.kernel.org>; Mon, 14 Nov 2022 04:19:06 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313101238"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313101238"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 04:19:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="763458850"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="763458850"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 14 Nov 2022 04:19:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1ouYQV-00CA0l-1Z;
        Mon, 14 Nov 2022 14:18:59 +0200
Date:   Mon, 14 Nov 2022 14:18:59 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Yury Luneff <yury.lunev@gmail.com>,
        Nable <nable.maininbox@googlemail.com>,
        andrey.i.trufanov@gmail.com, Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 15/17] media: atomisp: Make atomisp_g_fmt_cap()
 default to YUV420
Message-ID: <Y3IyM/C0mOoQmd96@smile.fi.intel.com>
References: <20221020195533.114049-1-hdegoede@redhat.com>
 <20221020195533.114049-16-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020195533.114049-16-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Oct 20, 2022 at 09:55:31PM +0200, Hans de Goede wrote:
> Make atomisp_g_fmt_cap() default to YUV420 so that it matches with what
> atomisp_try_fmt_cap() and atomisp_queue_setup() do when they need to
> pick a default pixelformat.

...

>  	f->fmt.pix.width = 10000;
>  	f->fmt.pix.height = 10000;

Side note: Same as before, perhaps better to use limits.h instead.
Unless it's defined by hardware limitations, in such case perhaps
define them with explanatory naming.

-- 
With Best Regards,
Andy Shevchenko


