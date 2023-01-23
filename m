Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F6C05027
	for <linux-media@archiver.kernel.org>; Mon, 23 Jan 2023 18:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjAWSP1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjAWSP1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Jan 2023 13:15:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6853659F7
        for <linux-media@vger.kernel.org>; Mon, 23 Jan 2023 10:15:26 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328197732"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328197732"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="725166245"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="725166245"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jan 2023 10:15:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pK1Ll-00Drt9-0g;
        Mon, 23 Jan 2023 20:15:21 +0200
Date:   Mon, 23 Jan 2023 20:15:20 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Yury Luneff <yury.lunev@gmail.com>,
        Nable <nable.maininbox@googlemail.com>,
        andrey.i.trufanov@gmail.com, Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 28/57] media: Add ovxxxx_16bit_addr_reg_helpers.h
Message-ID: <Y87OuHf8iZwUY9FK@smile.fi.intel.com>
References: <20230123125205.622152-1-hdegoede@redhat.com>
 <20230123125205.622152-29-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123125205.622152-29-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Jan 23, 2023 at 01:51:36PM +0100, Hans de Goede wrote:
> The following drivers under drivers/media/i2c: ov08x40.c, ov13858.c,
> ov13b10.c, ov2680.c, ov2685.c, ov2740.c, ov4689.c, ov5670.c,
> ov5675.c, ov5695.c, ov8856.c, ov9282.c and ov9734.c,
> 
> as well as various "atomisp" sensor drivers in drivers/staging, *all*
> use register access helpers with the following function prototypes:
> 
> int ovxxxx_read_reg(struct ovxxxx_dev *sensor, u16 reg,
>                     unsigned int len, u32 *val);
> 
> int ovxxxx_write_reg(struct ovxxxx_dev *sensor, u16 reg,
>                      unsigned int len, u32 val);
> 

While reviewing the following patch, I realize that we actually don't need
these long names.

int ov_read_reg(struct ovxxxx_dev *sensor, u16 reg, unsigned int len, u32 *val);

int ov_write_reg(struct ovxxxx_dev *sensor, u16 reg, unsigned int len, u32 val);

will work fine and fit one line (80 limit).

-- 
With Best Regards,
Andy Shevchenko


