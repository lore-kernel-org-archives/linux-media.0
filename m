Return-Path: <SRS0=xFXP=BY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39FDC433E1
	for <linux-media@archiver.kernel.org>; Fri, 14 Aug 2020 20:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8851220774
	for <linux-media@archiver.kernel.org>; Fri, 14 Aug 2020 20:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHNUQ1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:16:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:46685 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgHNUQ1 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 14 Aug 2020 16:16:27 -0400
IronPort-SDR: xv9KMRGTcgtol3q724039xz7F+ptNvcrG9c6mhm+leH5IP/dTGAUcr1MVHXHPGUfTA2ELw2NNy
 7hQHLeSj/Tiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="154460751"
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; 
   d="scan'208";a="154460751"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 13:16:23 -0700
IronPort-SDR: FyxXv90Yxa+VWW11mxSwBk95ZDWcoPGGfqZZ/TWK0roapqUhQmhiTJ8yVf540YsjwGG70Vmpp2
 +lwaULi1tn5g==
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; 
   d="scan'208";a="277190337"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 13:16:19 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id B64EC20488; Fri, 14 Aug 2020 23:16:17 +0300 (EEST)
Date:   Fri, 14 Aug 2020 23:16:17 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/7] media: ipu3-cio2: Simplify cleanup code
Message-ID: <20200814201617.GE24582@paasikivi.fi.intel.com>
References: <20200814163017.35001-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814163017.35001-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Andy,

Thanks for the patchset.

On Fri, Aug 14, 2020 at 07:30:11PM +0300, Andy Shevchenko wrote:
> The code looks more nicer if we use:
> 	while (i--)
> instead:
> 	for (i = i - 1; i >= 0; i--)
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> index 92f5eadf2c99..c7c3692a6e72 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> @@ -887,7 +887,7 @@ static int cio2_vb2_buf_init(struct vb2_buffer *vb)
>  	b->lop[i][j] = cio2->dummy_page_bus_addr >> PAGE_SHIFT;
>  	return 0;
>  fail:
> -	for (i--; i >= 0; i--)
> +	while (i--)

Nice! This would also allow making i unsigned again.

>  		dma_free_coherent(dev, CIO2_PAGE_SIZE,
>  				  b->lop[i], b->lop_bus_addr[i]);
>  	return -ENOMEM;

-- 
Sakari Ailus
