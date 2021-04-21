Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E67C433ED
	for <linux-media@archiver.kernel.org>; Wed, 21 Apr 2021 12:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD49861447
	for <linux-media@archiver.kernel.org>; Wed, 21 Apr 2021 12:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbhDUMJb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 21 Apr 2021 08:09:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:5295 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234099AbhDUMJa (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 21 Apr 2021 08:09:30 -0400
IronPort-SDR: Oj5NOCIHA7N2FeWQSh4btIBCrKnJNxf70iZj3QaYwOBXciYs7VaHHNnAmt5cHAJH9WRdtBfYa5
 YVmjHkXTUafQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195799981"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="195799981"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 05:08:57 -0700
IronPort-SDR: uxWdUOa0RV10CsBmPi9G5BcBZAvOUImIe7CBIJkK1+U+hR/ocnnPL1/y+gNRaAQVQCRx/SWSpv
 aklvLv3mZPsA==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="391460305"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 05:08:55 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 297AC203BC;
        Wed, 21 Apr 2021 15:08:51 +0300 (EEST)
Date:   Wed, 21 Apr 2021 15:08:51 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: omap3isp: drop graph mutex on error path
Message-ID: <20210421120851.GC3@paasikivi.fi.intel.com>
References: <YHV0WJWNQv5I6yqO@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHV0WJWNQv5I6yqO@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dan,

On Tue, Apr 13, 2021 at 01:37:12PM +0300, Dan Carpenter wrote:
> Drop the "&isp->media_dev.graph_mutex" if media_entity_enum_init() fails.
> 
> Fixes: ba689d933361 ("media: omap3isp: Acquire graph mutex for graph traversal")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for the fix.

I got another patch here earlier to fix the same bug so I've taken that
instead:

<URL:https://patchwork.linuxtv.org/project/linux-media/patch/20210407143733.1608806-1-weiyongjun1@huawei.com/>

-- 
Kind regards,

Sakari Ailus
