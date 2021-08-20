Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE2C4338F
	for <linux-media@archiver.kernel.org>; Fri, 20 Aug 2021 13:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F199610D2
	for <linux-media@archiver.kernel.org>; Fri, 20 Aug 2021 13:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbhHTNMz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 20 Aug 2021 09:12:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:27742 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240677AbhHTNMy (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 20 Aug 2021 09:12:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="277789663"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="277789663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 06:12:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="595669162"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 06:12:09 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id BEDF72011F;
        Fri, 20 Aug 2021 16:12:07 +0300 (EEST)
Date:   Fri, 20 Aug 2021 16:12:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Fabian =?iso-8859-1?Q?W=FCthrich?= <me@fabwu.ch>
Cc:     linux-media@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dan Scally <djrscally@gmail.com>
Subject: Re: [PATCH v4] ipu3-cio2: Parse sensor orientation and rotation
Message-ID: <20210820131207.GB3@paasikivi.fi.intel.com>
References: <20210414083022.25453-3-me@fabwu.ch>
 <20210712090326.7064-1-me@fabwu.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210712090326.7064-1-me@fabwu.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Jul 12, 2021 at 11:03:26AM +0200, Fabian Wüthrich wrote:
> The sensor orientation is read from the _PLC ACPI buffer and converted to a v4l2
> format.
> 
> The sensor rotation is read from the SSDB ACPI buffer and converted into
> degrees.
> 
> Signed-off-by: Fabian Wüthrich <me@fabwu.ch>
> Reviewed-by: Daniel Scally <djrscally@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

It's in my tree now.

-- 
Sakari Ailus
