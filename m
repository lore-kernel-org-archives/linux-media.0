Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F9CC4741F
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 09:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF19C20789
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 09:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgI3JTn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 05:19:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:61395 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3JTn (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 05:19:43 -0400
IronPort-SDR: v1O0Ihvz33VpWyq0QDUN26KFPyQcYglfaCRd3qG6lLq/AcBgXV0sSQvX7XlJm+m6KcgcjjS193
 pzhlTiXkjhCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="223998569"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="223998569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 02:19:43 -0700
IronPort-SDR: N0wxtRIrsYh7JUP122jH8jNujP+WbSyqGfmd2plI8rSGPkEL0S1uATIKUzTzfrf1V5ZtCAdAn3
 xetQiPtvKhOQ==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="293979425"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 02:19:38 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id CFFB0203E2; Wed, 30 Sep 2020 12:19:34 +0300 (EEST)
Date:   Wed, 30 Sep 2020 12:19:34 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] media: docs: ipu3.rst: rely at automarkup extension
Message-ID: <20200930091934.GL26842@paasikivi.fi.intel.com>
References: <cover.1601447236.git.mchehab+huawei@kernel.org>
 <b9d4cdf89bafb131dab4030c3e8789f5e1c14193.1601447236.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d4cdf89bafb131dab4030c3e8789f5e1c14193.1601447236.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Sep 30, 2020 at 08:35:56AM +0200, Mauro Carvalho Chehab wrote:
> There are several :c:type: definitions there, in order to
> do cross-references with the driver's documentation.
> 
> Those are broken when docs are built with Sphinx 3.x, as
> it would require :c:struct: instead.
> 
> For Sphinx < 3.x, the automarkup.py extension is able to do the
> replacement already, and a future improvement on it should make
> it also work with Sphinx 3.x.
> 
> So, get rid of the usage of the :c:type: macro there.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
