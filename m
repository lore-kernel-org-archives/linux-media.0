Return-Path: <SRS0=i92q=25=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7056BC282DD
	for <linux-media@archiver.kernel.org>; Wed,  8 Jan 2020 13:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439E420692
	for <linux-media@archiver.kernel.org>; Wed,  8 Jan 2020 13:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgAHNhc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:37:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:60598 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgAHNhc (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 8 Jan 2020 08:37:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 05:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="395746729"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2020 05:37:30 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipBWd-0003OI-9k; Wed, 08 Jan 2020 15:37:31 +0200
Date:   Wed, 8 Jan 2020 15:37:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1] media: venus: firmware: Use %pR to print IO resource
Message-ID: <20200108133731.GT32742@smile.fi.intel.com>
References: <20191115143044.55512-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115143044.55512-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Nov 15, 2019 at 04:30:44PM +0200, Andy Shevchenko wrote:
> Replace explicit use of members of struct resource by %pR to print
> the resource.

Any comment on this?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index d3d1748a7ef6..de6812fb55f4 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -100,8 +100,7 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  
>  	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
>  	if (!mem_va) {
> -		dev_err(dev, "unable to map memory region: %pa+%zx\n",
> -			&r.start, *mem_size);
> +		dev_err(dev, "unable to map memory region: %pR\n", &r);
>  		ret = -ENOMEM;
>  		goto err_release_fw;
>  	}
> -- 
> 2.24.0
> 

-- 
With Best Regards,
Andy Shevchenko


