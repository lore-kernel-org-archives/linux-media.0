Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47486EB64D9
	for <linux-media@archiver.kernel.org>; Mon, 19 Jun 2023 11:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjFSLM1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 19 Jun 2023 07:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjFSLM0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 19 Jun 2023 07:12:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53619F9
        for <linux-media@vger.kernel.org>; Mon, 19 Jun 2023 04:12:20 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="358478004"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="358478004"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 04:12:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="716836133"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716836133"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2023 04:12:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qBCns-004yVt-0W;
        Mon, 19 Jun 2023 14:12:12 +0300
Date:   Mon, 19 Jun 2023 14:12:11 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Yury Luneff <yury.lunev@gmail.com>,
        Nable <nable.maininbox@googlemail.com>,
        andrey.i.trufanov@gmail.com, Fabio Aiuto <fabioaiuto83@gmail.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 6/7] media: atomisp: Remove support for custom run-mode
 v4l2-ctrl on sensors
Message-ID: <ZJA4C9ip/n9YQoDE@smile.fi.intel.com>
References: <20230619105212.303653-1-hdegoede@redhat.com>
 <20230619105212.303653-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619105212.303653-6-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Jun 19, 2023 at 12:52:11PM +0200, Hans de Goede wrote:
> Remove the support to update a V4L2_CID_RUN_MODE run-mode control
> on sensors when changing the atomisp run-mode or directly by calling
> the custom ATOMISP_IOC_S_SENSOR_RUNMODE IOCTL.
> 
> No sensor drivers implement this and having custom controls / IOCTLs
> is undesirable.
> 
> Even if there was such a control on sensors then userspace should directly
> talk to the sensor v4l2-subdev, rather than relying on a custom ioctl-s

IOCTLs ?

> on the output /dev/video# node to pass this through to the senor.

-- 
With Best Regards,
Andy Shevchenko


