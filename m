Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A15C4332F
	for <linux-media@archiver.kernel.org>; Mon, 21 Nov 2022 08:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKUI4Q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Nov 2022 03:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiKUIz5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Nov 2022 03:55:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF7D10E
        for <linux-media@vger.kernel.org>; Mon, 21 Nov 2022 00:55:03 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="293218160"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="293218160"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 00:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="640947292"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="640947292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2022 00:54:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1ox2Zt-00FBjt-2k;
        Mon, 21 Nov 2022 10:54:57 +0200
Date:   Mon, 21 Nov 2022 10:54:57 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Yury Luneff <yury.lunev@gmail.com>,
        Nable <nable.maininbox@googlemail.com>,
        andrey.i.trufanov@gmail.com, Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 01/20] media: atomisp: Silence:
 'atomisp_q_one_s3a_buffer: drop one s3a stat which has exp_id xx' log
 messages
Message-ID: <Y3s84dzxX3ARSZPb@smile.fi.intel.com>
References: <20221120224101.746199-1-hdegoede@redhat.com>
 <20221120224101.746199-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120224101.746199-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Sun, Nov 20, 2022 at 11:40:42PM +0100, Hans de Goede wrote:
> Standard v4l2 userspace apps do not consume the s3a statistics block
> data. Until we have a userspace consumer for this (libcamera), which
> might also involve changing the API for this, lower the log level
> of these messages to dev_dbg() to avoid them filling up the logs.

...

> -			dev_warn(asd->isp->dev, "%s: drop one s3a stat which has exp_id %d!\n",
> -				 __func__, exp_id);
> +			dev_dbg(asd->isp->dev, "%s: drop one s3a stat which has exp_id %d!\n",
> +				__func__, exp_id);

Please, drop __func__ as well. Most probably this can be run on the systems
with Dynamic Debug enabled, meaning that __func__ and __LINE__ can be enabled
at runtime.

-- 
With Best Regards,
Andy Shevchenko


