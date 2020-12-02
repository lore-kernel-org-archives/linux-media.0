Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6C1C64E7B
	for <linux-media@archiver.kernel.org>; Wed,  2 Dec 2020 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D50122201
	for <linux-media@archiver.kernel.org>; Wed,  2 Dec 2020 18:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbgLBSEd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:04:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:35984 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbgLBSEd (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 2 Dec 2020 13:04:33 -0500
IronPort-SDR: OzCcX7hhUTKwVWOA+IxO7U6xn7nHMBf9594+tQPQo28163ZVm390WfiyfQmF4ROJ17qINFKxU7
 WY00uG8BHhCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="160830409"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="160830409"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 10:02:34 -0800
IronPort-SDR: clMUlx3/CpLOHU1zDdExJgaBC0Otth6BS5XMHSQoHBUf6rRrqFCmNDSSOJDCgk7le+wSU5f0MP
 6VYgMQ2M4gSg==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="405603553"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 10:02:33 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 9179D20884; Wed,  2 Dec 2020 20:02:31 +0200 (EET)
Date:   Wed, 2 Dec 2020 20:02:31 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCH v2 063/106] ccs-pll: Document the structs in the header
 as well as the function
Message-ID: <20201202180231.GI852@paasikivi.fi.intel.com>
References: <20201007084505.25761-1-sakari.ailus@linux.intel.com>
 <20201007084557.25843-1-sakari.ailus@linux.intel.com>
 <20201007084557.25843-54-sakari.ailus@linux.intel.com>
 <20201105131845.0b5b29b0@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105131845.0b5b29b0@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

On Thu, Nov 05, 2020 at 01:18:45PM +0100, Mauro Carvalho Chehab wrote:
> Em Wed,  7 Oct 2020 11:45:14 +0300
> Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:
> 
> > The CCS pll is used by the CCS driver at the moment, but documenting the
> > interface makes sense. It's non-trivial and the calculator could be used
> > elsewhere.
> 
> LFTM.
> 
> It could make sense to add a .. kernel-doc:: markup at the documentation
> somewhere.

Thanks for the comments.

I've added additional patch later in the set to add this to the
documentation build.

-- 
Sakari Ailus
